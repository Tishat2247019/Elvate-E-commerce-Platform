import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import dbConfig from './config/db.config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProductModule } from './product/product.module';
import { CategoryModule } from './category/category.module';
import { CartModule } from './cart/cart.module';
import { PromotionModule } from './promotion/promotion.module';
import { AuthModule } from './auth/auth.module';
import { MailerModule } from '@nestjs-modules/mailer';
import { HandlebarsAdapter } from '@nestjs-modules/mailer/dist/adapters/handlebars.adapter';
// import path, { join } from 'path';
import { LogModule } from './log/log.module';
import { ChatbotModule } from './chatbot/chatbot.module';
import { OrderModule } from './order/order.module';
import { CommonModule } from './common/common.module';
import { AddressModule } from './address/address.module';
import { ComplaintModule } from './complaint/complaint.module';
import * as path from 'path';
import { UserModule } from './user/user.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      expandVariables: true,
      load: [dbConfig],
    }),
    MailerModule.forRoot({
      transport: {
        host: process.env.MAIL_HOST,
        port: parseInt(process.env.MAIL_PORT!),
        auth: {
          user: process.env.MAIL_USER,
          pass: process.env.MAIL_PASS,
        },
      },
      defaults: {
        from: `"Elvate " <${process.env.MAIL_FROM}>`,
      },
      template: {
        dir: path.join(process.cwd(), 'templates'),
        adapter: new HandlebarsAdapter(),
        options: {
          strict: true,
        },
      },
    }),
    TypeOrmModule.forRootAsync({ useFactory: dbConfig }),
    ProductModule,
    CartModule,
    PromotionModule,
    CategoryModule,
    AuthModule,
    UserModule,
    LogModule,
    ChatbotModule,
    OrderModule,
    CommonModule,
    AddressModule,
    ComplaintModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
