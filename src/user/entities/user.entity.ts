import { Exclude } from 'class-transformer';
import { UserLog } from 'src/log/entities/user_logs.entity';
import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  Unique,
  UpdateDateColumn,
  OneToMany,
} from 'typeorm';
import { Address } from '../../address/entities/address.entity';
import { UserCart } from 'src/cart/entities/user_cart.entity';
import { PromoCodeUsage } from 'src/promotion/entities/promocode_usage.entity';
import { UserRewards } from 'src/promotion/entities/user_rewards.entity';
import { Order } from 'src/order/entities/order.entity';
import { Complaint } from 'src/complaint/entities/complaint.entity';
import { ComplaintResponse } from 'src/complaint/entities/complaint_response.entity';
@Entity()
@Unique(['email'])
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Exclude()
  @Column()
  email: string;

  @Exclude()
  @Column()
  password: string;

  @Column({ default: 'user' })
  role: string;

  @Column({ type: 'timestamp', nullable: true })
  lastLogin: Date;

  @Column({ type: 'timestamp', nullable: true })
  lastLogout: Date;

  @OneToMany(() => UserLog, (log) => log.user)
  logs: UserLog[];

  @OneToMany(() => Address, (address) => address.user, { cascade: true })
  addresses: Address[];

  @OneToMany(() => UserCart, (cart) => cart.user)
  cart: UserCart[];

  @OneToMany(() => PromoCodeUsage, (promocode_usages) => promocode_usages.user)
  promocode_usages: PromoCodeUsage[];

  @OneToMany(() => UserRewards, (user_rewards) => user_rewards.user)
  user_rewards: UserRewards[];

  @OneToMany(() => Order, (orders) => orders.user)
  orders: Order[];

  @OneToMany(() => Complaint, (complaints) => complaints.user)
  complaints: Complaint[];

  @OneToMany(
    () => ComplaintResponse,
    (complaint_response) => complaint_response.admin,
  )
  complaint_response: ComplaintResponse[];
}
