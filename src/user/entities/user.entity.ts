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
  orders: any;

  @OneToMany(() => Address, (address) => address.user, { cascade: true })
  addresses: Address[];
}
