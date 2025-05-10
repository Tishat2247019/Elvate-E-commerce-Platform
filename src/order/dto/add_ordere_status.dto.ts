import { IsString } from 'class-validator';

export class AddOrderStatusHistoryDto {
  @IsString()
  previousStatus: string;

  @IsString()
  newStatus: string;
}
