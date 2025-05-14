import {
  Body,
  Controller,
  ForbiddenException,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { RatingService } from './rating.service';
import { CreateReviewDto } from './dto/create_review.dto';
import { Review, ReviewStatus } from './entities/review.entity';
import { AuthGuard } from '@nestjs/passport';

@Controller('rating')
export class RatingController {
  constructor(private readonly ratingService: RatingService) {}

  // @UseGuards(JwtAuthGuard)
  // @UseGuards(AuthGuard('jwt'))
  @Post()
  async createReview(@Body() dto: CreateReviewDto, @Req() req) {
    const userId = req.user.userId; // extracted from JWT
    return this.ratingService.createReview(userId, dto);
  }

  // 🔐 Admin-only route to approve/reject reviews
  // @UseGuards(JwtAuthGuard) // Add RoleGuard if you separate admin role
  @Patch(':id/status/:status')
  async updateReviewStatus(
    @Param('id', ParseIntPipe) id: number,
    @Param('status') status: ReviewStatus,
  ) {
    return this.ratingService.moderateReview(id, status);
  }

  @Get('products/:id/average-rating')
  async getAverageRating(@Param('id') id: number): Promise<number> {
    return this.ratingService.getAverageRating(Number(id));
  }

  @UseGuards(AuthGuard('jwt'))
  @Get('get-all-reviews')
  async getAllReviews(@Req() req): Promise<Review[]> {
    if (req.user.role !== 'admin') {
      throw new ForbiddenException('Unathorized endpiont');
    }
    return this.ratingService.getAllReviews();
  }
}
