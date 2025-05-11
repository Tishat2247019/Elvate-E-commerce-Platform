import { IsNotEmpty, IsString, Length } from 'class-validator';

export class VerifyResetOtpDto {
  @IsNotEmpty()
  @IsString()
  @Length(6, 6)
  otp: string;

  @IsNotEmpty()
  @IsString()
  newPassword: string;
}
