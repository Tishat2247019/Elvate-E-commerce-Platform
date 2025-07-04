import {
  Controller,
  Get,
  UseGuards,
  Request,
  Res,
  ForbiddenException,
  BadRequestException,
  Param,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Response } from 'express';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { LogService } from './log.service';
import { ProductLog } from './entities/product_logs.entity';
import { ProductImageLog } from './entities/product_image_logs.entity';
import { UserLog } from './entities/user_logs.entity';

@Controller('logs')
export class LogController {
  constructor(
    private readonly logService: LogService,

    @InjectRepository(ProductLog)
    private readonly productLogRepository: Repository<ProductLog>,
    @InjectRepository(ProductImageLog)
    private readonly productImageLogRepository: Repository<ProductImageLog>,
    @InjectRepository(UserLog)
    private readonly userLogRepository: Repository<UserLog>,
  ) {}

  @Get('user-logs')
  @UseGuards(AuthGuard('jwt'))
  async getUserLogs(@Request() req) {
    if (req.user.role !== 'admin') {
      throw new ForbiddenException('Only admin can view logs');
    }

    return this.logService.getAllUserLogs();
  }

  @Get('product-logs')
  @UseGuards(AuthGuard('jwt'))
  async getProductLogs(@Request() req) {
    const user = req.user;

    if (user.role !== 'admin') {
      throw new ForbiddenException('Only admins can view product logs');
    }

    return this.logService.getAllProductLogs();
  }

  @Get('download/user-logs')
  @UseGuards(AuthGuard('jwt'))
  async downloadUserLogs(@Request() req, @Res() res: Response) {
    if (req.user.role !== 'admin') {
      throw new ForbiddenException('Only admin can download logs');
    }

    const logs = await this.userLogRepository.find({ relations: ['user'] });

    const html = await this.logService.renderUserLogsHtml(logs, req.user);
    const pdfBuffer = await this.logService.generatePdf(html);

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=user-logs.pdf`,
    });
    res.send(pdfBuffer);
  }

  @Get('download/:entity')
  @UseGuards(AuthGuard('jwt'))
  async downloadEntityLog(
    @Param('entity') entity: string,
    @Request() req,
    @Res() res: Response,
  ) {
    if (req.user.role !== 'admin') {
      throw new ForbiddenException('Only admin can download logs');
    }

    let logs, title, idLabel;
    switch (entity) {
      case 'product':
        logs = await this.productLogRepository.find();
        title = 'Product';
        idLabel = 'Product ID';
        break;
      case 'productImage':
        logs = await this.productImageLogRepository.find();
        title = 'Product Image';
        idLabel = 'Image ID';
        break;
      // add more cases for other entities
      default:
        throw new BadRequestException('Invalid entity type');
    }

    const html = await this.logService.renderLogsHtml(
      logs,
      req.user,
      title,
      idLabel,
    );
    const pdfBuffer = await this.logService.generatePdf(html);

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=${entity}-logs.pdf`,
    });
    res.send(pdfBuffer);
  }
}
