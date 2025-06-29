import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateUserCartDto } from './dto/create_user_cart.dto';
import { UpdateUserCartDto } from './dto/update_user_cart.dto';
import { ProductVariant } from 'src/product/entities/product_variant.entity';
import { UserCart } from './entities/user_cart.entity';
import { Product } from 'src/product/entities/product.entity';

@Injectable()
export class CartService {
  constructor(
    @InjectRepository(UserCart)
    private userCartRepository: Repository<UserCart>,

    @InjectRepository(Product)
    private productRepository: Repository<Product>,
    // @InjectRepository(ProductVariant)
    // private productVariantRepository: Repository<ProductVariant>,
  ) {}

  async addOrUpdateCartItem(
    user: any,
    createUserCartDto: CreateUserCartDto,
  ): Promise<UserCart> {
    const { product_id, quantity } = createUserCartDto;
    const user_id = user.userId;

    const product = await this.productRepository.findOne({
      where: { id: product_id },
    });
    if (!product) {
      throw new NotFoundException(`Product  with ID ${product_id} not found`);
    }

    let cartItem = await this.userCartRepository.findOne({
      where: { user_id, product_id },
    });

    if (cartItem) {
      cartItem.quantity += quantity;
      return this.userCartRepository.save(cartItem);
    }

    cartItem = this.userCartRepository.create({
      user_id,
      product_id,
      quantity,
    });

    return this.userCartRepository.save(cartItem);
  }

  async updateCartItem(
    id: number,
    updateUserCartDto: UpdateUserCartDto,
  ): Promise<UserCart> {
    const cartItem = await this.userCartRepository.findOne({ where: { id } });
    if (!cartItem) {
      throw new NotFoundException(`Cart item with ID ${id} not found`);
    }

    cartItem.quantity = updateUserCartDto.quantity;
    return this.userCartRepository.save(cartItem);
  }

  async removeCartItem(id: number): Promise<{ message: string }> {
    const cartItem = await this.userCartRepository.findOne({ where: { id } });
    if (!cartItem) {
      throw new NotFoundException(`Cart item with ID ${id} not found`);
    }

    await this.userCartRepository.delete(id);
    return { message: `Cart item with ID ${id} successfully deleted` };
  }

  async getCartItems(userId: number): Promise<any> {
    const cartItems = await this.userCartRepository.find({
      where: { user_id: userId },
      relations: ['product', 'product.images'],
    });

    let totalCost = 0;
    const cartDetails = cartItems.map((item) => {
      const cost = item.product.base_price * item.quantity;
      totalCost += cost;

      return {
        product: item.product,
        // variant: item.variant,
        quantity: item.quantity,
        totalCost: cost,
      };
    });

    return {
      cartItems: cartDetails,
      totalCost,
    };
  }

  // async increaseCartItemQuantity(
  //   id: number,
  // ): Promise<{ cartItem: UserCart; message: string }> {
  //   const cartItem = await this.userCartRepository.findOne({ where: { id } });
  //   if (!cartItem) {
  //     throw new NotFoundException(`Cart item with ID ${id} not found`);
  //   }

  //   const oldQuantity = cartItem.quantity;
  //   cartItem.quantity += 1;
  //   const updatedCartItem = await this.userCartRepository.save(cartItem);

  //   return {
  //     cartItem: updatedCartItem,
  //     message: `Quantity increased from ${oldQuantity} to ${updatedCartItem.quantity}`,
  //   };
  // }

  async increaseCartItemQuantity(
    userId: number,
    productId: number,
  ): Promise<{ cartItem: UserCart; message: string }> {
    const cartItem = await this.userCartRepository.findOne({
      where: {
        user: { id: userId },
        product: { id: productId },
      },
    });

    if (!cartItem) {
      throw new NotFoundException(
        `Cart item not found for user ${userId} and product ${productId}`,
      );
    }

    const oldQuantity = cartItem.quantity;
    cartItem.quantity += 1;
    const updatedCartItem = await this.userCartRepository.save(cartItem);

    return {
      cartItem: updatedCartItem,
      message: `Quantity increased from ${oldQuantity} to ${updatedCartItem.quantity}`,
    };
  }

  // async decreaseCartItemQuantity(
  //   id: number,
  // ): Promise<{ cartItem: UserCart; message: string }> {
  //   const cartItem = await this.userCartRepository.findOne({ where: { id } });
  //   if (!cartItem) {
  //     throw new NotFoundException(`Cart item with ID ${id} not found`);
  //   }

  //   const oldQuantity = cartItem.quantity;

  //   if (cartItem.quantity > 1) {
  //     cartItem.quantity -= 1; // Decrement by 1 if quantity > 1
  //   } else {
  //     throw new BadRequestException(`Cannot decrease quantity below 1`);
  //   }

  //   const updatedCartItem = await this.userCartRepository.save(cartItem);

  //   return {
  //     cartItem: updatedCartItem,
  //     message: `Quantity decreased from ${oldQuantity} to ${updatedCartItem.quantity}`,
  //   };
  // }

  async decreaseCartItemQuantity(
    userId: number,
    productId: number,
  ): Promise<{ cartItem: UserCart; message: string }> {
    const cartItem = await this.userCartRepository.findOne({
      where: {
        user: { id: userId },
        product: { id: productId },
      },
    });

    if (!cartItem) {
      throw new NotFoundException(
        `Cart item not found for user ${userId} and product ${productId}`,
      );
    }

    const oldQuantity = cartItem.quantity;

    if (cartItem.quantity > 1) {
      cartItem.quantity -= 1;
    } else {
      throw new BadRequestException(`Cannot decrease quantity below 1`);
    }

    const updatedCartItem = await this.userCartRepository.save(cartItem);

    return {
      cartItem: updatedCartItem,
      message: `Quantity decreased from ${oldQuantity} to ${updatedCartItem.quantity}`,
    };
  }

  async removeCartItemByUser(
    userId: number,
    productId: number,
  ): Promise<{ message: string }> {
    const cartItem = await this.userCartRepository.findOne({
      where: {
        user: { id: userId },
        product: { id: productId },
      },
    });

    if (!cartItem) {
      throw new NotFoundException(
        `Cart item not found for user ${userId} and product ${productId}`,
      );
    }

    await this.userCartRepository.remove(cartItem);

    return {
      message: `Cart item for product ${productId} removed successfully.`,
    };
  }
}
