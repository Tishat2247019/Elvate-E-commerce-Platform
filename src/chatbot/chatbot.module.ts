import { Module } from '@nestjs/common';
import { ChatbotService } from './chatbot.service';
import { GeminiService } from './gemini.service';
import { ChatbotController } from './chatbot.controller';
import { ProductService } from 'src/product/product.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Product } from 'src/product/entities/product.entity';
import { ProductLog } from 'src/log/entities/product_logs.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Product, ProductLog])],
  controllers: [ChatbotController],
  providers: [ChatbotService, GeminiService, ProductService],
})
export class ChatbotModule {}
