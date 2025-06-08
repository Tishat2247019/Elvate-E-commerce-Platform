import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Review, ReviewStatus } from './entities/review.entity';
import { Repository } from 'typeorm';
import { CreateReviewDto } from './dto/create_review.dto';

@Injectable()
export class RatingService {
  constructor(
    @InjectRepository(Review)
    private reviewRepo: Repository<Review>,
  ) {}

  async createReview(userId: number, dto: CreateReviewDto): Promise<Review> {
    const existingReview = await this.reviewRepo.findOne({
      where: { user: { id: userId }, product: { id: dto.productId } },
    });

    if (existingReview) {
      throw new BadRequestException('You have already reviewed this product.');
    }

    const review = this.reviewRepo.create({
      user: { id: userId },
      product: { id: dto.productId },
      rating: dto.rating,
      comment: dto.comment,
      status: ReviewStatus.PENDING,
    });

    return this.reviewRepo.save(review);
  }

  async moderateReview(id: number, status: ReviewStatus): Promise<Review> {
    const review = await this.reviewRepo.findOne({
      where: { product_id: id },
    });
    if (!review) throw new NotFoundException('Review not found');

    review.status = status;
    return this.reviewRepo.save(review);
  }

  async getAverageRating(productId: number): Promise<number> {
    const result = await this.reviewRepo
      .createQueryBuilder('review')
      .select('AVG(review.rating)', 'avg')
      .where('review.product_id = :productId', { productId })
      .andWhere('review.status = :status', { status: ReviewStatus.APPROVED })
      .getRawOne();

    return parseFloat(result.avg || 0);
  }

  async getAllReviews(): Promise<Review[]> {
    return await this.reviewRepo.find();
  }
}
