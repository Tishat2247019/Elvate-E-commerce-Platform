import { ForbiddenException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Complaint } from './entities/complaint.entity';
import { Repository } from 'typeorm';
import { ComplaintResponse } from './entities/complaint_response.entity';
import { CreateComplaintDto } from './dto/create_complaint.dto';
import { RespondComplaintDto } from './dto/respond_complaint.dto';
import { User } from 'src/user/entities/user.entity';

@Injectable()
export class ComplaintService {
  constructor(
    @InjectRepository(Complaint)
    private complaintRepo: Repository<Complaint>,
    @InjectRepository(ComplaintResponse)
    private responseRepo: Repository<ComplaintResponse>,
  ) {}

  create(user: any, dto: CreateComplaintDto) {
    const complaint = this.complaintRepo.create({
      message: dto.message,
      user_id: user.userId,
    });
    return this.complaintRepo.save(complaint);
  }

  findAll() {
    return this.complaintRepo.find({ relations: ['response'] });
  }

  async respond(admin: any, complaintId: number, dto: RespondComplaintDto) {
    const complaint = await this.complaintRepo.findOneByOrFail({
      id: complaintId,
    });

    if (complaint.status === 'responded'!) {
      throw new ForbiddenException('Complain is already responded by an admin');
    }

    // const complaint = await this.complaintRepo.findOneOrFail({
    //   where: { id: complaintId },
    //   relations: ['response'],
    // });

    // if (complaint.response) {
    //   throw new ForbiddenException(
    //     `Complaint is already responded by admin ${complaint.response.given_by}`,
    //   );
    // }

    const response = this.responseRepo.create({
      response: dto.response,
      complaint,
      given_by: admin.userId,
    });

    await this.responseRepo.save(response);

    complaint.status = 'responded';
    return this.complaintRepo.save(complaint);
  }

  findUserComplaints(userId: number) {
    return this.complaintRepo.find({
      where: { user: { id: userId } },
      relations: ['response'],
    });
  }
}
