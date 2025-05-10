import {
  Injectable,
  NotFoundException,
  ConflictException,
  ForbiddenException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

import { Order, OrderStatus } from './entities/order.entity';
import { OrderItem } from './entities/order_item.entity';
import { ShippingAddress } from './entities/shipping_address.entity';
import { OrderStatusHistory } from './entities/order_status_history.entity';
import {
  CreateOrderDto,
  OrderItemDto,
  UpdateOrderDto,
} from './dto/create_order.dto';
import { AddOrderStatusHistoryDto } from './dto/add_ordere_status.dto';
import { UpdateOrderItemDto } from './dto/update_order_item.dto';
import { UpdateShippingAddressDto } from './dto/update_shipping_address.dto';
import { User } from 'src/user/entities/user.entity';
import { UserCart } from 'src/cart/entities/user_cart.entity';
import { ProductVariant } from 'src/product/entities/product_variant.entity';
import { MailerService } from '@nestjs-modules/mailer';
import { join } from 'path';
// import ejs from 'ejs';
import puppeteer from 'puppeteer';
import * as ejs from 'ejs';

@Injectable()
export class OrderService {
  constructor(
    private mailerService: MailerService,
    @InjectRepository(Order)
    private orderRepo: Repository<Order>,

    @InjectRepository(OrderItem)
    private orderItemRepo: Repository<OrderItem>,

    @InjectRepository(ShippingAddress)
    private shippingRepo: Repository<ShippingAddress>,

    @InjectRepository(OrderStatusHistory)
    private statusHistoryRepo: Repository<OrderStatusHistory>,
    @InjectRepository(UserCart)
    private userCartRepository: Repository<UserCart>,
    @InjectRepository(ProductVariant)
    private productVariantRepository: Repository<ProductVariant>,
    @InjectRepository(User)
    private userRepository: Repository<User>,
  ) {}

  // 🟢 Create new order
  // async createOrder(dto: CreateOrderDto, user: User): Promise<Order> {
  //   // 1. Fetch cart items from the database if they're not passed in `dto.items`
  //   const cartItems = await this.userCartRepository.find({
  //     where: { user_id: user.id },
  //     relations: ['variant'],
  //   });

  //   // If `dto.items` are provided, you could prioritize those over cart items (for flexibility).
  //   const itemsToOrder = dto.items?.length ? dto.items : cartItems;

  //   let totalAmount = 0;

  //   // 2. Calculate the total amount for the order
  //   const orderItems = itemsToOrder.map((item) => {
  //     const unitPrice = item.variant ? item.variant.price : item.price; // snapshot price
  //     const cost = unitPrice * item.quantity;
  //     totalAmount += cost;

  //     return this.orderItemRepo.create({
  //       variant: item.variant, // the variant of the product
  //       quantity: item.quantity,
  //       unitPrice: unitPrice,
  //     });
  //   });

  //   // 3. Create the order and set the values (including shipping address)
  //   const order = this.orderRepo.create({
  //     user, // attach the user to the order
  //     items: orderItems, // attach the order items (will cascade to orderItemRepo)
  //     totalAmount,
  //     shippingAddress: dto.shippingAddress, // assuming the shipping info comes from `dto`
  //     status: OrderStatus.PENDING,
  //   });

  //   // 4. Save the order and return the created order object
  //   const savedOrder = await this.orderRepo.save(order);

  //   // Optionally, clear the cart if the order is successfully placed
  //   if (itemsToOrder === cartItems) {
  //     await this.userCartRepository.delete({ user_id: user.id });
  //   }

  //   return savedOrder;
  // }

  async createOrder(user: any): Promise<Order> {
    let totalAmount = 0;

    // STEP 1: Get cart items from user’s cart
    const cartItems = await this.userCartRepository.find({
      where: { user_id: user.userId },
      relations: ['variant'], // load related ProductVariant
    });

    // console.log(cartItems);

    if (!cartItems.length) {
      throw new ForbiddenException('Your cart is empty.');
    }

    // STEP 2: Create the order (initial, without items yet)
    const order = this.orderRepo.create({
      user: { id: user.userId },
      totalAmount: 0, // will update later after calculating
      status: OrderStatus.PENDING,
      shippingAddress: {
        // you need to get shipping details separately, maybe from user profile or a passed DTO
        fullName: 'asdf',
        street: 'asdf',
        city: 'asdf',
        state: 'asdf',
        postalCode: 'asdf',
        country: 'asdf',
        phoneNumber: 'phone',
      }, // adjust if pulling from elsewhere
    });

    const savedOrder = await this.orderRepo.save(order);

    // STEP 3: Prepare order items
    const orderItems: OrderItem[] = [];

    for (const cartItem of cartItems) {
      const variant = cartItem.variant;

      if (!variant) {
        throw new Error(
          `Product variant not found for cart item ${cartItem.id}`,
        );
      }

      const cost = Number(variant.price) * cartItem.quantity;
      totalAmount += cost;

      const orderItem = this.orderItemRepo.create({
        order: savedOrder, // attach order reference here
        productVariant: variant, // link to ProductVariant entity
        quantity: cartItem.quantity,
        price: variant.price, // from DB, not client
      });

      orderItems.push(orderItem);
    }

    // STEP 4: Save order items in bulk
    await this.orderItemRepo.save(orderItems);

    // STEP 5: Update order total amount
    savedOrder.totalAmount = totalAmount;
    const updatedOrder = await this.orderRepo.save(savedOrder);

    // STEP 6: Clear user cart
    // await this.userCartRepository.delete({ user_id: user.id });

    // Return the complete order with items

    const fullUser = await this.userRepository.findOne({
      where: { id: user.userId },
    });
    if (!fullUser) {
      throw new ForbiddenException('User not found.');
    }

    let invoiceTable = `
<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <tr>
    <th>Product</th>
    <th>Quantity</th>
    <th>Unit Price</th>
    <th>Total Price</th>
  </tr>
`;

    for (const item of orderItems) {
      // const productName = item.productVariant.name; // or whatever field your variant has
      const variant = await this.productVariantRepository.findOne({
        where: { id: item.productVariant.id },
        relations: ['product'],
      });

      const productName = variant!.product.title;
      const unitPrice = Number(item.price).toFixed(2);
      const totalPrice = (Number(item.price) * item.quantity).toFixed(2);

      invoiceTable += `
    <tr>
      <td>${productName}</td>
      <td>${item.quantity}</td>
      <td>$${unitPrice}</td>
      <td>$${totalPrice}</td>
    </tr>
  `;
    }

    invoiceTable += `
  <tr>
    <td colspan="3" style="text-align: right;"><strong>Grand Total:</strong></td>
    <td><strong>$${totalAmount.toFixed(2)}</strong></td>
  </tr>
</table>
`;

    const invoiceDownloadUrl = `http://localhost:3000/orders/${savedOrder.id}/invoice`;

    await this.mailerService.sendMail({
      to: fullUser.email,
      subject: `Your Order Invoice (#${savedOrder.id})`,
      html: `
    <h2>Thank you for your order!</h2>
    <p>Here is your invoice:</p>
    ${invoiceTable}
    <p><a href="${invoiceDownloadUrl}" target="_blank" style="padding:10px 15px; background:#007bff; color:white; text-decoration:none; border-radius:5px;">Download Invoice (PDF)</a></p>
    <p>We appreciate your business.</p>
  `,
    });

    return updatedOrder;
  }

  // 🟢 Get all orders
  async getAllOrders(): Promise<any[]> {
    const orders = await this.orderRepo.find({
      relations: ['user', 'items', 'shippingAddress'],
    });

    return orders.map((order) => ({
      ...order,
      user: { id: order.user.id },
    }));
  }

  // 🟢 Get one order by ID
  async getOrderById(id: number): Promise<Order> {
    const order = await this.orderRepo.findOne({
      where: { id },
      relations: ['items', 'shippingAddress'],
    });
    if (!order) throw new NotFoundException('Order not found');
    return order;
  }

  // 🟡 Update basic order info
  async updateOrder(id: number, dto: UpdateOrderDto): Promise<Order> {
    const order = await this.getOrderById(id);
    Object.assign(order, dto);
    return await this.orderRepo.save(order);
  }

  // 🔴 Cancel order
  async cancelOrder(id: number): Promise<Order> {
    const order = await this.getOrderById(id);
    if (order.status === 'cancelled')
      throw new ConflictException('Order already cancelled');
    order.status = OrderStatus.CANCELLED;
    return await this.orderRepo.save(order);
  }

  // ❌ Delete order
  async deleteOrder(id: number): Promise<void> {
    const result = await this.orderRepo.delete(id);
    if (result.affected === 0)
      throw new NotFoundException('Order not found to delete');
  }

  // ➕ Add order item
  async addOrderItem(orderId: number, dto: OrderItemDto): Promise<OrderItem> {
    const order = await this.getOrderById(orderId);
    const item = this.orderItemRepo.create({ ...dto, order });
    return await this.orderItemRepo.save(item);
  }

  // 🛠 Update order item
  async updateOrderItem(
    id: number,
    dto: UpdateOrderItemDto,
  ): Promise<OrderItem> {
    const item = await this.orderItemRepo.findOne({ where: { id } });
    if (!item) throw new NotFoundException('Order item not found');
    Object.assign(item, dto);
    return await this.orderItemRepo.save(item);
  }

  // ❌ Remove order item
  async removeOrderItem(id: number): Promise<void> {
    const result = await this.orderItemRepo.delete(id);
    if (result.affected === 0)
      throw new NotFoundException('Order item not found');
  }

  // 📦 Update shipping address
  async updateShippingAddress(
    orderId: number,
    dto: UpdateShippingAddressDto,
  ): Promise<ShippingAddress> {
    const order = await this.getOrderById(orderId);

    if (!order.shippingAddress) {
      order.shippingAddress = dto as ShippingAddress;
    } else {
      Object.assign(order.shippingAddress, dto);
    }

    await this.orderRepo.save(order);
    return order.shippingAddress;
  }

  // 📝 Add order status history
  async addOrderStatusHistory(
    orderId: number,
    dto: AddOrderStatusHistoryDto,
  ): Promise<OrderStatusHistory[]> {
    const order = await this.getOrderById(orderId);
    const history = this.statusHistoryRepo.create({ ...dto, order });
    await this.statusHistoryRepo.save(history);
    return await this.statusHistoryRepo.find({
      where: { order: { id: orderId } },
    });
  }

  // 📃 Get status history
  async getOrderStatusHistory(orderId: number): Promise<OrderStatusHistory[]> {
    await this.getOrderById(orderId); // ensure order exists
    return await this.statusHistoryRepo.find({
      where: { order: { id: orderId } },
    });
  }

  // 👤 Get orders for a specific user
  async getUserOrders(userId: number): Promise<Order[]> {
    return this.orderRepo.find({
      where: { user: { id: userId } },
      relations: ['items', 'shippingAddress'],
    });
  }

  // 🔍 Track order
  async trackOrder(orderId: number): Promise<OrderStatusHistory[]> {
    return this.getOrderStatusHistory(orderId);
  }

  async generateInvoicePdf(orderId: number): Promise<Buffer> {
    const order = await this.orderRepo.findOne({
      where: { id: orderId },
      relations: [
        'user',
        'items',
        'items.productVariant',
        'items.productVariant.product',
      ],
    });

    if (!order) {
      throw new NotFoundException('Order not found');
    }

    // const templatePath = join(__dirname, '..', 'templates', 'invoice.ejs');
    const templatePath = join(process.cwd(), 'templates', 'invoice.ejs');

    const html = await ejs.renderFile(templatePath, { order });

    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.setContent(html, { waitUntil: 'networkidle0' });

    const pdfBuffer = await page.pdf({ format: 'A4' });

    await browser.close();
    return Buffer.from(pdfBuffer);
  }
}
