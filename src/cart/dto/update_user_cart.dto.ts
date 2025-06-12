import { IsInt, Min, IsOptional } from 'class-validator';

export class UpdateUserCartDto {
  @IsOptional()
  @IsInt()
  product_id?: number;

  @IsOptional()
  @IsInt()
  @Min(1)
  quantity: number;
}
