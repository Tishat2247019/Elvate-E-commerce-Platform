import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { PromoCodeUsage } from './promocode_usage.entity';

@Entity('coupons')
export class Coupon {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ unique: true })
  code: string;

  @Column()
  type: string;

  @Column('decimal', { precision: 10, scale: 2 })
  value: number;

  @Column({ type: 'date' })
  expiry_date: Date;

  @Column()
  usage_limit: number;

  @Column({ default: 0 })
  usage_count: number;

  @OneToMany(() => PromoCodeUsage, (usage) => usage.coupon)
  usages: PromoCodeUsage[];
}
