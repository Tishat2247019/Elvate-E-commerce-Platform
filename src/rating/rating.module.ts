import { Module } from '@nestjs/common';
import { RatingService } from './rating.service';
import { RatingController } from './rating.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Review } from './entities/review.entity';
import { productReview } from './entities/productReview.entity';
import { Notification } from 'src/notification/entities/notification.entity';
import { NotificationService } from 'src/notification/notification.service';
import { NotificationsGateway } from 'src/notification/notificatoin.gateway';

@Module({
  imports: [TypeOrmModule.forFeature([Review, productReview, Notification])],
  controllers: [RatingController],
  providers: [RatingService, NotificationService, NotificationsGateway],
})
export class RatingModule {}
