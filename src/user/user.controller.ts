import { Controller, Get, Request, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { User } from './entities/user.entity';
import { AuthGuard } from '@nestjs/passport';

@Controller('user')
export class UserController {
  constructor(private userServive: UserService) {}

  @Get()
  @UseGuards(AuthGuard('jwt'))
  async getUserInfo(@Request() req) {
    // console.log(req);
    return this.userServive.getUserInfo(req.user);
  }
}
