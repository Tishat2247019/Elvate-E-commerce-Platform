import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Review, ReviewStatus } from './entities/review.entity';
import { Repository } from 'typeorm';
import { CreateReviewDto } from './dto/create_review.dto';
import { productReview } from './entities/productReview.entity';
import { CreatereviewDto } from './dto/Create_Revieww.dto';
import { supabase } from 'src/common/supabase.service';

@Injectable()
export class RatingService {
  constructor(
    @InjectRepository(Review)
    private reviewRepo: Repository<Review>,
    @InjectRepository(productReview)
    private productReviewRepo: Repository<productReview>,
  ) {}

  // async createReview(userId: number, dto: CreateReviewDto): Promise<Review> {
  //   const existingReview = await this.reviewRepo.findOne({
  //     where: { user: { id: userId }, product: { id: dto.productId } },
  //   });

  //   if (existingReview) {
  //     throw new BadRequestException('You have already reviewed this product.');
  //   }

  //   const review = this.reviewRepo.create({
  //     user: { id: userId },
  //     product: { id: dto.productId },
  //     rating: dto.rating,
  //     comment: dto.comment,
  //     status: ReviewStatus.PENDING,
  //   });

  //   return this.reviewRepo.save(review);
  // }

  async createReview(
    userId: number,
    dto: any,
    images?: Express.Multer.File[],
  ): Promise<productReview> {
    const existingReview = await this.productReviewRepo.findOne({
      where: { user: { id: userId }, product: { id: dto.productId } },
    });

    if (existingReview) {
      throw new BadRequestException('You have already reviewed this product.');
    }

    let uploadedUrls: string[] = [];
    if (images && images.length > 0) {
      uploadedUrls = await Promise.all(
        images.map((file) =>
          this.uploadReviewImageToSupabase(
            file.buffer,
            `${Date.now()}-${file.originalname}`,
          ),
        ),
      );
    }

    const review = this.productReviewRepo.create({
      user: { id: userId },
      product: { id: dto.productId },
      title: dto.title,
      description: dto.description,
      rating: dto.rating,
      recommender: dto.recommender,
      imageUrls: uploadedUrls,
      status: ReviewStatus.PENDING,
    });

    return this.productReviewRepo.save(review);
  }

  private async uploadReviewImageToSupabase(
    buffer: Buffer,
    filename: string,
  ): Promise<string> {
    const { data, error } = await supabase.storage
      .from('reviewimages')
      .upload(filename, buffer, {
        contentType: 'image/jpeg', // or detect via file.mimetype
        upsert: true,
      });

    if (error)
      throw new InternalServerErrorException('Failed to upload review image');

    const { data: publicData } = supabase.storage
      .from('reviewimages')
      .getPublicUrl(filename);

    return publicData?.publicUrl;
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
