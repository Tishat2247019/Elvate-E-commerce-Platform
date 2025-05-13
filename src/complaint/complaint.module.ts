import { Module } from '@nestjs/common';
import { ComplaintService } from './complaint.service';
import { ComplaintController } from './complaint.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Complaint } from './entities/complaint.entity';
import { ComplaintResponse } from './entities/complaint_response.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Complaint, ComplaintResponse])],
  controllers: [ComplaintController],
  providers: [ComplaintService],
})
export class ComplaintModule {}
