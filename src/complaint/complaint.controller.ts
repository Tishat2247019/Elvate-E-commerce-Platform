import {
  Controller,
  Post,
  Body,
  UseGuards,
  Get,
  Param,
  ParseIntPipe,
  Request,
  ForbiddenException,
} from '@nestjs/common';
import { ComplaintService } from './complaint.service';

import { CreateComplaintDto } from './dto/create_complaint.dto';
import { RespondComplaintDto } from './dto/respond_complaint.dto';
import { AuthGuard } from '@nestjs/passport';

@Controller('complaints')
export class ComplaintController {
  constructor(private readonly complaintService: ComplaintService) {}

  @Post()
  create(@Request() req, @Body() dto: CreateComplaintDto) {
    return this.complaintService.create(req.user, dto);
  }

  @Get()
  @UseGuards(AuthGuard('jwt'))
  myComplaints(@Request() req) {
    return this.complaintService.findUserComplaints(req.user.userId);
  }

  @Get('all')
  findAll() {
    return this.complaintService.findAll();
  }

  @Post(':id/respond')
  respond(
    @Param('id', ParseIntPipe) id: number,
    @Request() req,
    @Body() dto: RespondComplaintDto,
  ) {
    if (req.user.role !== 'admin') {
      throw new ForbiddenException('Only admin can respond to a complaint');
    }
    return this.complaintService.respond(req.user, id, dto);
  }
}
