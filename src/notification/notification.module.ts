import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { NotificationService } from './notification.service';
import { NotificationController } from './notification.controller';
import { Notification } from './entities/notification.entity';
import { NotificationsGateway } from './notificatoin.gateway';

@Module({
  imports: [TypeOrmModule.forFeature([Notification])],
  controllers: [NotificationController],
  providers: [NotificationService, NotificationsGateway],
  exports: [
    TypeOrmModule.forFeature([Notification]),
    NotificationService,
    NotificationsGateway,
  ],
})
export class NotificationModule {}
