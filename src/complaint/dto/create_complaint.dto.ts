import { isNotEmpty, IsString } from 'class-validator';

export class CreateComplaintDto {
  @IsString()
  message: string;
}
