import {
  Injectable,
  NotFoundException,
  ConflictException,
  ForbiddenException,
  InternalServerErrorException,
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
import { supabase } from 'src/common/supabase.service';
import { Address } from 'src/address/entities/address.entity';

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
    @InjectRepository(Address)
    private addressRepository: Repository<Address>,
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

  //   async createOrder(user: any): Promise<Order> {
  //     let totalAmount = 0;

  //     // STEP 1: Get cart items from user’s cart
  //     const cartItems = await this.userCartRepository.find({
  //       where: { user_id: user.userId },
  //       relations: ['variant'], // load related ProductVariant
  //     });

  //     // console.log(cartItems);

  //     if (!cartItems.length) {
  //       throw new ForbiddenException('Your cart is empty.');
  //     }

  //     // STEP 2: Create the order (initial, without items yet)
  //     const order = this.orderRepo.create({
  //       user: { id: user.userId },
  //       totalAmount: 0, // will update later after calculating
  //       status: OrderStatus.PENDING,
  //       shippingAddress: {
  //         // you need to get shipping details separately, maybe from user profile or a passed DTO
  //         fullName: 'asdf',
  //         street: 'asdf',
  //         city: 'asdf',
  //         state: 'asdf',
  //         postalCode: 'asdf',
  //         country: 'asdf',
  //         phoneNumber: 'phone',
  //       }, // adjust if pulling from elsewhere
  //     });

  //     const savedOrder = await this.orderRepo.save(order);

  //     // STEP 3: Prepare order items
  //     const orderItems: OrderItem[] = [];

  //     for (const cartItem of cartItems) {
  //       const variant = cartItem.variant;

  //       if (!variant) {
  //         throw new Error(
  //           `Product variant not found for cart item ${cartItem.id}`,
  //         );
  //       }

  //       const cost = Number(variant.price) * cartItem.quantity;
  //       totalAmount += cost;

  //       const orderItem = this.orderItemRepo.create({
  //         order: savedOrder, // attach order reference here
  //         productVariant: variant, // link to ProductVariant entity
  //         quantity: cartItem.quantity,
  //         price: variant.price, // from DB, not client
  //       });

  //       orderItems.push(orderItem);
  //     }

  //     // STEP 4: Save order items in bulk
  //     await this.orderItemRepo.save(orderItems);

  //     // STEP 5: Update order total amount
  //     savedOrder.totalAmount = totalAmount;
  //     const updatedOrder = await this.orderRepo.save(savedOrder);

  //     // STEP 6: Clear user cart
  //     // await this.userCartRepository.delete({ user_id: user.id });

  //     // Return the complete order with items

  //     const fullUser = await this.userRepository.findOne({
  //       where: { id: user.userId },
  //     });
  //     if (!fullUser) {
  //       throw new ForbiddenException('User not found.');
  //     }

  //     let invoiceTable = `
  // <table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  //   <tr>
  //     <th>Product</th>
  //     <th>Product Image</th>
  //     <th>Quantity</th>
  //     <th>Unit Price</th>
  //     <th>Total Price</th>
  //   </tr>
  // `;

  //     for (const item of orderItems) {
  //       // const productName = item.productVariant.name; // or whatever field your variant has
  //       const variant = await this.productVariantRepository.findOne({
  //         where: { id: item.productVariant.id },
  //         relations: ['product', 'images'],
  //       });

  //       const productName = variant?.product.title;
  //       const productImage = variant?.images[0].image_url;
  //       const unitPrice = Number(item.price).toFixed(2);
  //       const totalPrice = (Number(item.price) * item.quantity).toFixed(2);

  //       invoiceTable += `
  //     <tr>
  //       <td>${productName}</td>
  //       <td><img src="${productImage}" style="width: 80px;"></td>
  //       <td>${item.quantity}</td>
  //       <td>$${unitPrice}</td>
  //       <td>$${totalPrice}</td>
  //     </tr>
  //   `;
  //     }

  //     invoiceTable += `
  //   <tr>
  //     <td colspan="3" style="text-align: right;"><strong>Grand Total:</strong></td>
  //     <td><strong>$${totalAmount.toFixed(2)}</strong></td>
  //   </tr>
  // </table>
  // `;

  //     // 1. Generate PDF
  //     const { buffer: pdfBuffer, filename: pdfFilename } =
  //       await this.generateInvoicePdf(savedOrder.id);

  //     // 2. Upload to Supabase
  //     const { data: uploadData, error: uploadError } = await supabase.storage
  //       .from('invoices')
  //       .upload(pdfFilename, pdfBuffer, {
  //         contentType: 'application/pdf',
  //         upsert: true,
  //       });

  //     if (uploadError) {
  //       throw new InternalServerErrorException(
  //         'Failed to upload invoice to Supabase',
  //       );
  //     }

  //     // 3. Get public URL
  //     const { data: publicUrlData } = supabase.storage
  //       .from('invoices')
  //       .getPublicUrl(pdfFilename);

  //     const invoiceDownloadUrl = publicUrlData?.publicUrl;

  //     // const invoiceDownloadUrl = `http://localhost:3000/orders/${savedOrder.id}/invoice`;

  //     await this.mailerService.sendMail({
  //       to: fullUser.email,
  //       subject: `Your Order Invoice (#${savedOrder.id})`,
  //       html: `
  //     <h2>Thank you for your order!</h2>
  //     <p>Here is your invoice:</p>
  //     ${invoiceTable}
  //     <p><a href="${invoiceDownloadUrl}" target="_blank" style="padding:10px 15px; background:#007bff; color:white; text-decoration:none; border-radius:5px;">Download Invoice (PDF)</a></p>
  //     <p>We appreciate your business.</p>
  //   `,
  //     });

  //     return updatedOrder;
  //   }

  async createOrder(user: any): Promise<Order> {
    const order = await this.createOrderFromCart(user);

    const { buffer, filename } = await this.generateInvoicePdf(order.id);

    const invoiceUrl = await this.uploadInvoiceToSupabase(buffer, filename);

    const fullUser = await this.userRepository.findOne({
      where: { id: user.userId },
    });
    if (!fullUser) throw new ForbiddenException('User not found');

    await this.sendInvoiceEmail(fullUser, order, invoiceUrl);

    return order;
  }

  private async createOrderFromCart(user: any): Promise<Order> {
    const cartItems = await this.userCartRepository.find({
      where: { user_id: user.userId },
      relations: ['variant'],
    });

    if (!cartItems.length) {
      throw new ForbiddenException('Your cart is empty.');
    }

    const userAddress = await this.addressRepository.find({
      where: { user: { id: user.userId } },
    });

    // console.log(userAddess);
    if (!userAddress.length) {
      throw new ForbiddenException('No shipping address found for user.');
    }

    let totalAmount = 0;

    const shipping = userAddress[0];

    const order = this.orderRepo.create({
      user: { id: user.userId },
      totalAmount: 0,
      status: OrderStatus.PENDING,
      shippingAddress: {
        fullName: shipping.fullName,
        street: shipping.street,
        city: shipping.city,
        state: shipping.state,
        postalCode: shipping.postalCode,
        country: shipping.country,
        phoneNumber: shipping.phoneNumber,
      },
    });

    const savedOrder = await this.orderRepo.save(order);

    const orderItems: OrderItem[] = [];

    for (const cartItem of cartItems) {
      const variant = cartItem.variant;
      if (!variant)
        throw new Error(`Variant not found for cart item ${cartItem.id}`);

      const cost = Number(variant.price) * cartItem.quantity;
      totalAmount += cost;

      orderItems.push(
        this.orderItemRepo.create({
          order: savedOrder,
          productVariant: variant,
          quantity: cartItem.quantity,
          price: variant.price,
        }),
      );
    }

    await this.orderItemRepo.save(orderItems);

    savedOrder.totalAmount = totalAmount;
    const updatedOrder = await this.orderRepo.save(savedOrder);

    return updatedOrder;
  }

  private async uploadInvoiceToSupabase(
    buffer: Buffer,
    filename: string,
  ): Promise<string> {
    const { data, error } = await supabase.storage
      .from('invoices')
      .upload(filename, buffer, {
        contentType: 'application/pdf',
        upsert: true,
      });

    if (error)
      throw new InternalServerErrorException('Failed to upload invoice');

    const { data: publicData } = supabase.storage
      .from('invoices')
      .getPublicUrl(filename);

    return publicData?.publicUrl;
  }

  private async sendInvoiceEmail(user: any, order: Order, invoiceUrl: string) {
    const items = await this.orderItemRepo.find({
      where: { order: { id: order.id } },
      relations: [
        'productVariant',
        'productVariant.product',
        'productVariant.images',
      ],
    });

    const shipping = order.shippingAddress;
    const shippingHtml = `
  <h3>Shipping Address</h3>
  <div style="border:1px solid #ccc; padding:10px; margin-bottom:20px;">
    <p><strong>${shipping.fullName}</strong></p>
    <p>${shipping.street}</p>
    <p>${shipping.city}, ${shipping.state} - ${shipping.postalCode}</p>
    <p>${shipping.country}</p>
    <p>Phone: ${shipping.phoneNumber}</p>
  </div>
`;

    const invoiceTable = await this.buildInvoiceTable(items, order.totalAmount);

    await this.mailerService.sendMail({
      to: user.email,
      subject: `Your Order Invoice (#${order.id})`,
      html: `
  <h2>Thank you for your order!</h2>
  <p>Here is your invoice:</p>
  ${invoiceTable}
  ${shippingHtml}
  <p><a href="${invoiceUrl}" target="_blank" style="padding:10px 15px; background:#007bff; color:white; text-decoration:none; border-radius:5px;">Download Invoice (PDF)</a></p>
  <p>We appreciate your business.</p>
`,
    });
  }

  private async buildInvoiceTable(
    orderItems: OrderItem[],
    totalAmount: number,
  ): Promise<string> {
    let rows = `
  <table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
    <tr>
      <th>Product</th>
      <th>Product Image</th>
      <th>Quantity</th>
      <th>Unit Price</th>
      <th>Total Price</th>
    </tr>
  `;

    for (const item of orderItems) {
      const variant = item.productVariant;
      const productName = variant?.product?.title;
      const productImage = variant?.images?.[0]?.image_url;
      const unitPrice = Number(item.price).toFixed(2);
      const totalPrice = (Number(item.price) * item.quantity).toFixed(2);

      rows += `
      <tr>
        <td>${productName}</td>
        <td><img src="${productImage}" style="width: 80px;"></td>
        <td>${item.quantity}</td>
        <td>$${unitPrice}</td>
        <td>$${totalPrice}</td>
      </tr>
    `;
    }

    rows += `
    <tr>
      <td colspan="3" style="text-align: right;"><strong>Grand Total:</strong></td>
      <td colspan="2"><strong>$${totalAmount.toFixed(2)}</strong></td>
    </tr>
  </table>
  `;

    return rows;
  }

  // // 🟢 Get all orders
  // async getAllOrders(): Promise<any[]> {
  //   const orders = await this.orderRepo.find({
  //     relations: ['user', 'items', 'shippingAddress'],
  //   });

  //   return orders.map((order) => ({
  //     ...order,
  //     user: { id: order.user.id },
  //   }));
  // }

  async getAllOrders(): Promise<any[]> {
    const orders = await this.orderRepo.find({
      relations: [
        'user',
        'items',
        'items.productVariant',
        'shippingAddress',
        'items.productVariant.images',
      ],
    });

    return orders.map((order) => ({
      ...order,
      user: { id: order.user.id },
      items: order.items.map((item) => ({
        id: item.id,
        quantity: item.quantity,
        price: item.price,
        productVariantId: item.productVariant?.id,
        productImage: item.productVariant.images[0].image_url,
      })),
    }));
  }

  async getOrderById(id: number): Promise<Order> {
    const order = await this.orderRepo.findOne({
      where: { id },
      relations: ['items', 'shippingAddress'],
    });
    if (!order) throw new NotFoundException('Order not found');
    return order;
  }

  async updateOrder(id: number, dto: UpdateOrderDto): Promise<Order> {
    const order = await this.getOrderById(id);
    Object.assign(order, dto);
    return await this.orderRepo.save(order);
  }

  async cancelOrder(id: number): Promise<Order> {
    const order = await this.getOrderById(id);
    if (order.status === 'cancelled')
      throw new ConflictException('Order already cancelled');
    order.status = OrderStatus.CANCELLED;
    return await this.orderRepo.save(order);
  }

  async deleteOrder(id: number): Promise<void> {
    const result = await this.orderRepo.delete(id);
    if (result.affected === 0)
      throw new NotFoundException('Order not found to delete');
  }

  async addOrderItem(orderId: number, dto: OrderItemDto): Promise<OrderItem> {
    const order = await this.getOrderById(orderId);
    const item = this.orderItemRepo.create({ ...dto, order });
    return await this.orderItemRepo.save(item);
  }

  async updateOrderItem(
    id: number,
    dto: UpdateOrderItemDto,
  ): Promise<OrderItem> {
    const item = await this.orderItemRepo.findOne({ where: { id } });
    if (!item) throw new NotFoundException('Order item not found');
    Object.assign(item, dto);
    return await this.orderItemRepo.save(item);
  }

  async removeOrderItem(id: number): Promise<void> {
    const result = await this.orderItemRepo.delete(id);
    if (result.affected === 0)
      throw new NotFoundException('Order item not found');
  }

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

  async getOrderStatusHistory(orderId: number): Promise<OrderStatusHistory[]> {
    await this.getOrderById(orderId); // ensure order exists
    return await this.statusHistoryRepo.find({
      where: { order: { id: orderId } },
    });
  }

  async getUserOrders(userId: number): Promise<Order[]> {
    return this.orderRepo.find({
      where: { user: { id: userId } },
      relations: ['items', 'shippingAddress'],
    });
  }

  async trackOrder(orderId: number): Promise<OrderStatusHistory[]> {
    return this.getOrderStatusHistory(orderId);
  }

  async generateInvoicePdf(
    orderId: number,
  ): Promise<{ buffer: Buffer; filename: string }> {
    const order = await this.orderRepo.findOne({
      where: { id: orderId },
      relations: [
        'user',
        'user.addresses',
        'items',
        'items.productVariant',
        'items.productVariant.product',
        'items.productVariant.images',
      ],
    });

    if (!order) {
      throw new NotFoundException('Order not found');
    }

    const templatePath = join(process.cwd(), 'templates', 'invoice.ejs');
    const html = await ejs.renderFile(templatePath, { order });

    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.setContent(html, { waitUntil: 'networkidle0' });

    const pdfBuffer = await page.pdf({ format: 'A4' });

    await browser.close();

    const timestamp = Date.now();
    const filename = `user-${order.user.id}/invoice-${order.id}-${timestamp}.pdf`;

    return {
      buffer: Buffer.from(pdfBuffer),
      filename,
    };
  }
}
