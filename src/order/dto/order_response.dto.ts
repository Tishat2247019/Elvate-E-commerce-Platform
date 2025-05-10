import { OrderStatus } from '../entities/order.entity';
import { OrderItemDto } from './create_order.dto';

export class OrderResponseDto {
  id: number;
  userId: number;
  items: OrderItemDto[];
  totalAmount: number;
  status: OrderStatus;
  shippingAddress: any;
  createdAt: Date;
  updatedAt: Date;
}
