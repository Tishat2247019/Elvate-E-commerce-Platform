import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  OneToMany,
  ManyToOne,
  JoinColumn,
  Timestamp,
  UpdateDateColumn,
} from 'typeorm';
import { ProductVariant } from './product_variant.entity';
import { ProductImage } from './product_image.entity';
import { Category } from 'src/category/entities/category.entity';
import { User } from 'src/user/entities/user.entity';
import { Expose } from 'class-transformer';
import { Review } from 'src/rating/entities/review.entity';
import { productReview } from 'src/rating/entities/productReview.entity';

@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column()
  description: string;

  @Column('decimal')
  base_price: number;

  @Column()
  brand_id: number;

  @ManyToOne(() => Category, (category) => category.product)
  @JoinColumn({ name: 'category_id' })
  category: Category;

  @Column()
  category_id: number;

  // @Column({ type: 'int', nullable: true })
  // created_by: number;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'created_by' })
  createdBy: User;

  // @Column()
  // created_at: Timestamp;
  @Column({
    type: 'timestamp',
    default: () => 'CURRENT_TIMESTAMP',
    nullable: true,
  })
  created_at: Date;

  @Column({ nullable: true })
  updated_by: number;

  @UpdateDateColumn({
    type: 'timestamp',
    default: () => 'CURRENT_TIMESTAMP',
    nullable: true,
  })
  updated_at: Date;

  @OneToMany(() => ProductVariant, (variant) => variant.product)
  variants: ProductVariant[];

  @OneToMany(() => ProductImage, (image) => image.product)
  images: ProductImage[];

  @OneToMany(() => productReview, (reviews) => reviews.product)
  reviews: productReview[];
}
