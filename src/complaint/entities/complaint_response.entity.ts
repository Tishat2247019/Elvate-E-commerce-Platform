import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  OneToOne,
  JoinColumn,
  ManyToOne,
  CreateDateColumn,
} from 'typeorm';
import { Complaint } from './complaint.entity';
import { User } from 'src/user/entities/user.entity';

@Entity()
export class ComplaintResponse {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  response: string;

  @CreateDateColumn()
  createdAt: Date;

  @OneToOne(() => Complaint, (complaint) => complaint.response)
  @JoinColumn()
  complaint: Complaint;

  @Column()
  given_by: number;

  @ManyToOne(() => User, (admin) => admin.complaint_response)
  @JoinColumn({ name: 'given_by' })
  admin: User;
}
