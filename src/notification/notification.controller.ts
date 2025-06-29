import { Body, Controller, Get, Param, Patch, Post } from '@nestjs/common';
import { NotificationService } from './notification.service';
import { Notification } from './entities/notification.entity';

@Controller('notification')
export class NotificationController {
  constructor(private readonly notificationService: NotificationService) {}

  @Get()
  async findAll(): Promise<Notification[]> {
    return this.notificationService.findAll();
  }

  @Get('unread-count')
  async getUnreadCount(): Promise<{ count: number }> {
    const count = await this.notificationService.getUnreadCount();
    return { count };
  }

  @Post()
  async create(@Body() body: Partial<Notification>): Promise<Notification> {
    return this.notificationService.create(body);
  }

  @Patch('mark-all-read')
  async markAllAsRead() {
    return this.notificationService.markAllAsRead();
  }

  @Patch(':id/read')
  async markAsRead(@Param('id') id: string): Promise<Notification> {
    return this.notificationService.markAsRead(Number(id));
  }
}
