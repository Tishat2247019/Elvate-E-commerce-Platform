import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Address } from './entities/address.entity';
import { User } from '../user/entities/user.entity';
import { CreateAddressDto } from './dto/create_address.dto';
import { UpdateAddressDto } from './dto/update_address.dto';

@Injectable()
export class AddressService {
  constructor(
    @InjectRepository(Address)
    private readonly addressRepository: Repository<Address>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async createAddress(
    userId: number,
    dto: CreateAddressDto,
  ): Promise<{ Address; message: string }> {
    const user = await this.userRepository.findOne({
      where: { id: userId },
      select: ['id'],
    });

    if (!user) throw new NotFoundException('User not found');

    const address = this.addressRepository.create({
      ...dto,
      user,
    });

    const saved_address = await this.addressRepository.save(address);
    return {
      Address: saved_address,
      message: `new address created of user ${userId}`,
    };
  }

  async updateAddress(
    actorId: number,
    addressId: number,
    dto: UpdateAddressDto,
  ): Promise<{ address: Address; message: string }> {
    const address = await this.addressRepository.findOne({
      where: { id: addressId },
      relations: ['user'],
    });

    if (!address) throw new NotFoundException('Address not found');

    // Optional: Check if actor is authorized
    const actor = await this.userRepository.findOne({ where: { id: actorId } });
    if (!actor) throw new NotFoundException('User not found');

    if (actor.role !== 'admin' && actor.id !== address.user.id) {
      throw new ForbiddenException(
        'You are not allowed to update this address',
      );
    }

    Object.assign(address, dto);
    const updated = await this.addressRepository.save(address);

    return { address: updated, message: 'Address updated successfully' };
  }

  async getAddressesByUser(userId: number): Promise<Address[] | null> {
    return await this.addressRepository.find({
      where: { user: { id: userId } },
      // relations: ['user'],
      // select: ['user'],
    });
  }
  async deleteAddress(
    userId: number,
    addressId: number,
  ): Promise<{ message: string }> {
    const address = await this.addressRepository.findOne({
      where: { id: addressId, user: { id: userId } },
      relations: ['user'], // Check both userId and addressId
    });

    if (!address) {
      throw new NotFoundException(
        `Address with ID ${addressId} not found for user ${userId}`,
      );
    }

    const actor = await this.userRepository.findOne({ where: { id: userId } });
    if (!actor) throw new NotFoundException('User not found');

    if (actor.role !== 'admin' && address.user.id !== userId) {
      throw new ForbiddenException(
        'You are not authorized to delete this address',
      );
    }

    // Remove the address
    await this.addressRepository.remove(address);

    return {
      message: `Address with ID ${addressId} deleted successfully for user ${userId}`,
    };
  }
}
