import { User } from 'src/user/entities/user.entity';
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToMany,
  ManyToOne,
  JoinColumn,
} from 'typeorm';

@Entity('user_rewards')
export class UserRewards {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  user_id: number;

  @ManyToOne(() => User, (user) => user.user_rewards)
  @JoinColumn({ name: 'user_id' })
  user: User;

  @Column()
  balance: number;

  @Column()
  points: number;

  @Column()
  reason: string;

  @Column({ nullable: true })
  order_id: number;

  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;
}
