import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Product } from './product.entity';
import { ProductVariant } from './product_variant.entity';
import { User } from 'src/user/entities/user.entity';

@Entity()
export class ProductImage {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  product_id: number;

  @ManyToOne(() => Product, (product) => product.images, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'product_id' })
  product: Product;

  @Column()
  variant_id: number;

  @ManyToOne(() => ProductVariant, (variant) => variant.images, {
    nullable: true,
  })
  @JoinColumn({ name: 'variant_id' })
  variant: ProductVariant;

  @Column('text')
  image_url: string;

  @Column({ default: false })
  is_main: boolean;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'created_by' })
  createdBy: User;

  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;

  @Column({ nullable: true })
  updated_by: number;

  @UpdateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;
}
