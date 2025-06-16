// src/user/user.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './entities/user.entity';
import { CartService } from 'src/cart/cart.service';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User) private userRepo: Repository<User>,
    private readonly cartService: CartService,
  ) {}

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

  // async getUserInfo(user: any) {
  //   const user_id = user.userId;
  //   // console.log(user);
  //   return this.userRepo.findOne({
  //     where: { id: user_id },
  //     relations: [
  //       'cart',
  //       'addresses',
  //       'logs',
  //       'promocode_usages',
  //       'user_rewards',
  //       'orders',
  //       'complaints',
  //       'complaints.response',
  //       'reviews',
  //     ],
  //   });
  // }

  async getUserInfo(user: any) {
    const user_id = user.userId;

    const userData = await this.userRepo.findOne({
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

    const cart = await this.cartService.getCartItems(user_id);

    return {
      ...userData,
      cart, // now userInfo includes cart details and totalCost
    };
  }

  async UserInfoAdmin(id: number): Promise<User | null> {
    // const user_id = user.userId;
    // console.log(user);
    return this.userRepo.findOne({
      where: { id: id },
      relations: [
        'cart',
        'cart.variant',
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
