import { Module } from '@nestjs/common';
import { LogController } from './log.controller';
import { LogService } from './log.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProductLog } from './entities/product_logs.entity';
import { ProductImageLog } from './entities/product_image_logs.entity';
import { UserLog } from './entities/user_logs.entity';

@Module({
  imports: [TypeOrmModule.forFeature([ProductLog, ProductImageLog, UserLog])],
  controllers: [LogController],
  providers: [LogService],
  exports: [TypeOrmModule.forFeature([ProductLog]), LogService],
})
export class LogModule {}
