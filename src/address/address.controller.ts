import {
  Body,
  UseGuards,
  Request,
  Param,
  Delete,
  Controller,
  Post,
  Put,
  Get,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AddressService } from './address.service';
import { CreateAddressDto } from './dto/create_address.dto';
import { UpdateAddressDto } from './dto/update_address.dto';

@UseGuards(AuthGuard('jwt'))
@Controller('address')
export class AddressController {
  constructor(private readonly addressService: AddressService) {}

  @Post()
  async createAddress(@Request() req, @Body() dto: CreateAddressDto) {
    return this.addressService.createAddress(req.user.userId, dto);
  }

  @Get()
  async getAddressesByUser(@Request() req) {
    return this.addressService.getAddressesByUser(req.user.userId);
  }

  @Put(':id')
  async updateAddress(
    @Request() req,
    @Param('id') id: number,
    @Body() dto: UpdateAddressDto,
  ) {
    return this.addressService.updateAddress(req.user.userId, id, dto);
  }

  @Delete(':id')
  async deleteAddress(@Request() req, @Param('id') id: number) {
    return this.addressService.deleteAddress(req.user.userId, id);
  }
}
