import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Param,
  Body,
  Req,
  UseGuards,
  Res,
} from '@nestjs/common';
import { OrderService } from './order.service';
import {
  CreateOrderDto,
  OrderItemDto,
  UpdateOrderDto,
} from './dto/create_order.dto';
import { UpdateOrderItemDto } from './dto/update_order_item.dto';
import { UpdateShippingAddressDto } from './dto/update_shipping_address.dto';
import { AddOrderStatusHistoryDto } from './dto/add_ordere_status.dto';
import { AuthGuard } from '@nestjs/passport';
import { Response } from 'express';

@Controller('orders')
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  // 🟢 Create new order
  @Post()
  async createOrder(@Req() req) {
    const user = req.user;

    // If needed, apply any role-based checks here
    // For example:
    // if (user.role !== 'customer') {
    //   throw new ForbiddenException('Only customers can place orders');
    // }

    return this.orderService.createOrder(user);
  }

  // 🟢 Get all orders
  @Get()
  getAllOrders() {
    return this.orderService.getAllOrders();
  }

  // 🟢 Get order by ID
  @Get(':id')
  getOrderById(@Param('id') id: number) {
    return this.orderService.getOrderById(Number(id));
  }

  // 🟡 Update order
  @Patch(':id')
  updateOrder(@Param('id') id: number, @Body() dto: UpdateOrderDto) {
    return this.orderService.updateOrder(Number(id), dto);
  }

  // 🔴 Cancel order
  @Patch(':id/cancel')
  cancelOrder(@Param('id') id: number) {
    return this.orderService.cancelOrder(Number(id));
  }

  // ❌ Delete order
  @Delete(':id')
  deleteOrder(@Param('id') id: number) {
    return this.orderService.deleteOrder(Number(id));
  }

  // ➕ Add item to order
  @Post(':orderId/items')
  addOrderItem(@Param('orderId') orderId: number, @Body() dto: OrderItemDto) {
    return this.orderService.addOrderItem(Number(orderId), dto);
  }

  // 🛠 Update order item
  @Patch('items/:itemId')
  updateOrderItem(
    @Param('itemId') itemId: number,
    @Body() dto: UpdateOrderItemDto,
  ) {
    return this.orderService.updateOrderItem(Number(itemId), dto);
  }

  // ❌ Remove order item
  @Delete('items/:itemId')
  removeOrderItem(@Param('itemId') itemId: number) {
    return this.orderService.removeOrderItem(Number(itemId));
  }

  // 📦 Update shipping address
  @Patch(':orderId/shipping-address')
  updateShippingAddress(
    @Param('orderId') orderId: number,
    @Body() dto: UpdateShippingAddressDto,
  ) {
    return this.orderService.updateShippingAddress(Number(orderId), dto);
  }

  // 📝 Add order status history
  @Post(':orderId/status-history')
  addOrderStatusHistory(
    @Param('orderId') orderId: number,
    @Body() dto: AddOrderStatusHistoryDto,
  ) {
    return this.orderService.addOrderStatusHistory(Number(orderId), dto);
  }

  // 📃 Get order status history
  @Get(':orderId/status-history')
  getOrderStatusHistory(@Param('orderId') orderId: number) {
    return this.orderService.getOrderStatusHistory(Number(orderId));
  }

  // 👤 Get orders for a user
  @Get('user/:userId')
  getUserOrders(@Param('userId') userId: number) {
    return this.orderService.getUserOrders(Number(userId));
  }

  // 🔍 Track order
  @Get(':orderId/track')
  trackOrder(@Param('orderId') orderId: number) {
    return this.orderService.trackOrder(Number(orderId));
  }

  @Get(':orderId/invoice')
  // @UseGuards(AuthGuard) // Ensure only authenticated users can access
  async downloadInvoice(
    @Param('orderId') orderId: number,
    @Res() res: Response,
  ) {
    const pdfBuffer = await this.orderService.generateInvoicePdf(
      Number(orderId),
    );

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=invoice-${orderId}.pdf`,
    });

    res.send(pdfBuffer);
  }
}
