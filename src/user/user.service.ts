// src/user/user.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './entities/user.entity';

@Injectable()
export class UserService {
  constructor(@InjectRepository(User) private userRepo: Repository<User>) {}

  async create(user: Partial<User>): Promise<User> {
    const newUser = this.userRepo.create(user);
    return this.userRepo.save(newUser);
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.userRepo.findOne({ where: { email } });
  }

  async showallUser(): Promise<User[] | any[]> {
    return this.userRepo.find();
  }

  async findByUsername(username: string): Promise<User | null> {
    return this.userRepo.findOne({ where: { email: username } });
  }

  async getUserInfo(user: any) {
    const user_id = user.userId;
    // console.log(user);
    return this.userRepo.findOne({
      where: { id: user_id },
      relations: [
        'cart',
        'addresses',
        'logs',
        'promocode_usages',
        'user_rewards',
        'orders',
        'complaints',
        'complaints.response',
        'reviews',
      ],
    });
  }

  async deleteUserById(id: number): Promise<boolean> {
    const user = await this.userRepo.findOne({ where: { id } });

    if (!user) {
      return false;
    }

    await this.userRepo.delete(id);
    return true;
  }
}
