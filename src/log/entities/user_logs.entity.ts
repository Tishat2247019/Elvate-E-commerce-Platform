import { User } from 'src/user/entities/user.entity';
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  ManyToOne,
} from 'typeorm';

@Entity('user_logs')
export class UserLog {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User, (user) => user.logs)
  user: User;

  @Column()
  action:
    | 'login'
    | 'logout'
    | 'failed_login'
    | 'refresh_token'
    | 'reset_password'
    | 'forgot_password';

  @Column({ nullable: true })
  ip_address: string;

  @Column({ type: 'text', nullable: true })
  user_agent: string;

  @Column({ default: true })
  success: boolean;

  @Column({ nullable: true })
  jwt_id: number;

  @CreateDateColumn()
  timestamp: Date;
}
