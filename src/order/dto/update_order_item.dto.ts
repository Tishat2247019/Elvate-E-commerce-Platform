import { IsInt, IsPositive, IsString, IsOptional } from 'class-validator';

export class UpdateOrderItemDto {
  @IsOptional()
  @IsString()
  productName?: string;

  @IsOptional()
  @IsInt()
  @IsPositive()
  quantity?: number;

  @IsOptional()
  @IsInt()
  @IsPositive()
  price?: number;

  @IsOptional()
  @IsInt()
  @IsPositive()
  totalPrice?: number; // Optionally update the total price of the item

  @IsOptional()
  @IsString()
  productDescription?: string;
}
