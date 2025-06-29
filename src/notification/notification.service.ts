import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Notification } from './entities/notification.entity';
import { NotFoundException } from '@nestjs/common';

@Injectable()
export class NotificationService {
  constructor(
    @InjectRepository(Notification)
    private notifRepo: Repository<Notification>,
  ) {}

  async create(data: Partial<Notification>): Promise<Notification> {
    const notif = this.notifRepo.create(data);
    return this.notifRepo.save(notif);
  }

  async findAll(): Promise<Notification[]> {
    return this.notifRepo.find({
      order: { createdAt: 'DESC' },
    });
  }

  async markAsRead(id: number): Promise<Notification> {
    const notif = await this.notifRepo.findOneBy({ id });
    if (!notif) {
      throw new NotFoundException(`Notification with id ${id} not found`);
    }
    notif.isRead = true;
    return this.notifRepo.save(notif);
  }

  async getUnreadCount(): Promise<number> {
    return this.notifRepo.count({
      where: { isRead: false },
    });
  }
  async markAllAsRead(): Promise<void> {
    await this.notifRepo.update(
      { isRead: false }, // condition: only this user's unread
      { isRead: true }, // set isRead true
    );
  }
}
