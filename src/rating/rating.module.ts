import { Module } from '@nestjs/common';
import { RatingService } from './rating.service';
import { RatingController } from './rating.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Review } from './entities/review.entity';
import { productReview } from './entities/productReview.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Review, productReview])],
  controllers: [RatingController],
  providers: [RatingService],
})
export class RatingModule {}
