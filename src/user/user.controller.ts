import {
  Controller,
  Delete,
  ForbiddenException,
  Get,
  HttpException,
  HttpStatus,
  Param,
  Request,
  UseGuards,
} from '@nestjs/common';
import { UserService } from './user.service';
import { User } from './entities/user.entity';
import { AuthGuard } from '@nestjs/passport';

@Controller('user')
export class UserController {
  constructor(private userService: UserService) {}

  @Get()
  @UseGuards(AuthGuard('jwt'))
  async getUserInfo(@Request() req) {
    // console.log(req);
    return this.userService.getUserInfo(req.user);
  }

  @Get('all-users')
  @UseGuards(AuthGuard('jwt'))
  async showallUser(@Request() req): Promise<User[] | any[]> {
    // if (req.user.role !== 'admin') {
    //   throw new ForbiddenException('Only admin can create products');
    // }
    // console.log(req);
    return this.userService.showallUser();
  }

  @Delete(':id')
  @UseGuards(AuthGuard('jwt'))
  async deleteUser(@Param('id') id: string, @Request() req) {
    // Optional: You can check if the requesting user has permission to delete this user (e.g. admin or self)
    const userId = req.user.id;

    // Example: Only allow deleting self or admin role (adjust as needed)
    if (userId !== +id && req.user.role !== 'admin') {
      throw new HttpException('Forbidden', HttpStatus.FORBIDDEN);
    }

    const result = await this.userService.deleteUserById(+id);

    if (!result) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }

    return { message: 'User deleted successfully' };
  }
}
