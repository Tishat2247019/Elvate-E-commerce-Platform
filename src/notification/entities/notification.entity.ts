import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
} from 'typeorm';

@Entity()
export class Notification {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column()
  message: string;

  @Column({ default: false })
  isRead: boolean;

  @Column()
  type: string; // e.g., 'order' or 'review'

  @Column('jsonb', { nullable: true })
  data: any;

  @CreateDateColumn()
  createdAt: Date;
}
