import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  OneToOne,
  JoinColumn,
  CreateDateColumn,
} from 'typeorm';
import { User } from 'src/user/entities/user.entity';
import { ComplaintResponse } from './complaint_response.entity';

@Entity()
export class Complaint {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  user_id: number;

  @Column()
  message: string;

  @Column({ default: 'pending' }) // or enum
  status: string;

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => User, (user) => user.complaints)
  @JoinColumn({ name: 'user_id' })
  user: User;

  @OneToOne(() => ComplaintResponse, (response) => response.complaint)
  response: ComplaintResponse;
}
