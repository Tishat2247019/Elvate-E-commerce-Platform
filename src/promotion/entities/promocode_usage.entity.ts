import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Coupon } from './coupon.entity';
import { User } from 'src/user/entities/user.entity';

@Entity('promo_code_usages')
export class PromoCodeUsage {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  user_id: number;

  @ManyToOne(() => User, (user) => user.promocode_usages)
  @JoinColumn({ name: 'user_id' })
  user: User;

  @Column()
  coupon_id: number;

  @ManyToOne(() => Coupon, (coupon) => coupon.usages)
  @JoinColumn({ name: 'coupon_id' })
  coupon: Coupon;

  @Column({ type: 'timestamp' })
  used_at: Date;
}
