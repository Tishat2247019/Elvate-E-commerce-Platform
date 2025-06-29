import { Module } from '@nestjs/common';
import { OrderService } from './order.service';
import { OrderController } from './order.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OrderItem } from './entities/order_item.entity';
import { Order, OrderStatus } from './entities/order.entity';
import { ShippingAddress } from './entities/shipping_address.entity';
import { OrderStatusHistory } from './entities/order_status_history.entity';
import { UserCart } from 'src/cart/entities/user_cart.entity';
import { ProductVariant } from 'src/product/entities/product_variant.entity';
import { User } from 'src/user/entities/user.entity';
import { Address } from 'src/address/entities/address.entity';
import { Product } from 'src/product/entities/product.entity';
import { Notification } from 'src/notification/entities/notification.entity';
import { NotificationService } from 'src/notification/notification.service';
import { NotificationsGateway } from 'src/notification/notificatoin.gateway';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      OrderItem,
      OrderStatusHistory,
      Order,
      ShippingAddress,
      UserCart,
      ProductVariant,
      User,
      Address,
      Product,
      Notification,
    ]),
  ],
  controllers: [OrderController],
  providers: [OrderService, NotificationService, NotificationsGateway],
})
export class OrderModule {}
