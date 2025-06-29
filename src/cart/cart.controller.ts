import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Req,
  Request,
} from '@nestjs/common';
import { CreateUserCartDto } from './dto/create_user_cart.dto';
import { UpdateUserCartDto } from './dto/update_user_cart.dto';
import { CartService } from './cart.service';

@Controller('cart')
export class CartController {
  constructor(private cartService: CartService) {}

  @Get(':userId')
  async getCartItems(@Param('userId') userId: number) {
    return this.cartService.getCartItems(userId);
  }

  @Post()
  async addOrUpdateCartItem(
    @Req() req,
    @Body() createUserCartDto: CreateUserCartDto,
  ) {
    return this.cartService.addOrUpdateCartItem(req.user, createUserCartDto);
  }

  @Put('increase')
  async increaseCartItemQuantity(
    @Request() req,
    @Body('productId') productId: number,
  ) {
    const userId = req.user.userId; // Extracted from JWT
    // return userId;
    return this.cartService.increaseCartItemQuantity(userId, productId);
  }

  @Put('decrease')
  async decreaseCartItemQuantity(
    @Request() req,
    @Body('productId') productId: number,
  ) {
    const userId = req.user.userId;
    return this.cartService.decreaseCartItemQuantity(userId, productId);
  }

  @Put(':id')
  async updateCartItem(
    @Param('id') id: number,
    @Body() updateUserCartDto: UpdateUserCartDto,
  ) {
    return this.cartService.updateCartItem(id, updateUserCartDto);
  }

  @Delete(':id')
  async removeCartItem(@Param('id') id: number) {
    return this.cartService.removeCartItem(id);
  }

  @Delete('product/:productId')
  async removeCartItemForUser(
    @Param('productId') productId: number,
    @Req() req,
  ) {
    const userId = req.user.userId; // JWT must attach this in payload
    return this.cartService.removeCartItemByUser(userId, productId);
  }
}
