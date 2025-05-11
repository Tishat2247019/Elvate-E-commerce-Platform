import { IsString, IsOptional, IsPhoneNumber } from 'class-validator';

export class CreateAddressDto {
  @IsString()
  fullName: string;

  @IsString()
  street: string;

  @IsString()
  city: string;

  @IsString()
  state: string;

  @IsString()
  postalCode: string;

  @IsString()
  country: string;

  @IsPhoneNumber()
  phoneNumber: string;
}
