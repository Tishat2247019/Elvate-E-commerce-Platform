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

@Controller('logs')
export class LogController {
  constructor(
    private readonly logService: LogService,
    @InjectRepository(ProductLog)
    private readonly productLogRepository: Repository<ProductLog>,
    @InjectRepository(ProductImageLog)
    private readonly productImageLogRepository: Repository<ProductImageLog>,
  ) {}

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
