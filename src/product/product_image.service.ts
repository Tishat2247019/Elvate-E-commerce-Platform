import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateProductImageDto } from './dto/create_product_image.dto';
import { UpdateProductImageDto } from './dto/update_product_image.dto';
import { ProductImage } from './entities/product_image.entity';
import { User } from 'src/user/entities/user.entity';
import { ProductImageLog } from 'src/log/entities/product_image_logs.entity';

@Injectable()
export class ProductImageService {
  constructor(
    @InjectRepository(ProductImage)
    private productImageRepository: Repository<ProductImage>,
    @InjectRepository(ProductImageLog)
    private imageLogRepository: Repository<ProductImageLog>,
  ) {}

  async createProductImage(
    createProductImageDto: CreateProductImageDto,
    user: any,
  ): Promise<ProductImage> {
    const productImage = this.productImageRepository.create({
      ...createProductImageDto,
      createdBy: { id: user.userId },
    });

    const savedImage = await this.productImageRepository.save(productImage);

    await this.imageLogRepository.save({
      product_image_id: savedImage.id,
      action: 'create',
      previous_state: null,
      new_state: savedImage,
      performed_by: user.userId,
      performed_by_role: user.role,
    });

    return savedImage;
  }

  // async createProductImage(dto: CreateProductImageDto): Promise<ProductImage> {
  //   const productImage = this.productImageRepository.create(dto);
  //   return this.productImageRepository.save(productImage);
  // }

  async showAllProductImages(): Promise<ProductImage[]> {
    return this.productImageRepository.find({
      relations: ['product', 'variant'],
    });
  }

  async findOneProductImage(id: number): Promise<ProductImage> {
    const image = await this.productImageRepository.findOne({ where: { id } });
    if (!image) {
      throw new NotFoundException(`ProductImage with ID ${id} not found`);
    }
    return image;
  }

  async updateProductImage(
    id: number,
    updateProductImageDto: UpdateProductImageDto,
    user: any,
  ): Promise<{ message: string; image: ProductImage }> {
    const image = await this.productImageRepository.findOneBy({ id });

    if (!image) {
      throw new NotFoundException(`ProductImage with ID ${id} not found`);
    }

    const previousState = { ...image };

    Object.assign(image, updateProductImageDto);
    image.updated_by = user.userId;

    try {
      const updatedImage = await this.productImageRepository.save(image);

      await this.imageLogRepository.save({
        product_image_id: id,
        action: 'update',
        previous_state: previousState,
        new_state: updatedImage,
        performed_by: user.userId,
        performed_by_role: user.role,
      });

      return {
        message: `ProductImage with ID ${id} successfully updated`,
        image: updatedImage,
      };
    } catch (error) {
      if (error.code === '23503') {
        const detail = error.detail || '';
        if (detail.includes('product_id')) {
          throw new BadRequestException(
            `Product with ID ${updateProductImageDto.product_id} does not exist`,
          );
        }
        if (detail.includes('variant_id')) {
          throw new BadRequestException(
            `Variant with ID ${updateProductImageDto.variant_id} does not exist`,
          );
        }
      }

      throw new ConflictException('Failed to update product image');
    }
  }

  async removeProductImage(
    id: number,
    user: any,
  ): Promise<{ message: string }> {
    const image = await this.productImageRepository.findOneBy({ id });

    if (!image) {
      throw new NotFoundException(`ProductImage with ID ${id} not found`);
    }

    const previousState = { ...image };

    await this.productImageRepository.delete(id);

    await this.imageLogRepository.save({
      product_image_id: id,
      action: 'delete',
      previous_state: previousState,
      new_state: null,
      performed_by: user.userId,
      performed_by_role: user.role,
    });

    return {
      message: `ProductImage with ID ${id} successfully deleted`,
    };
  }
}
