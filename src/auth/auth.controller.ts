import {
  Controller,
  Post,
  Body,
  ForbiddenException,
  UseGuards,
  Request,
  Req,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateUserDto } from './dto/CreateUser.dto';
import { RequestOtpDto } from 'src/user/dto/request_otp.dto';
import { VerifyOtpDto } from 'src/user/dto/verify_otp.dto';
import { AuthGuard } from '@nestjs/passport';
import { NoJwtBlacklistGuard } from './custom_decoretors/no_jwt_blacklist.decorator';
import { UserLog } from 'src/log/entities/user_logs.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, UnorderedBulkOperation } from 'typeorm';
import { VerifyResetOtpDto } from 'src/user/dto/varify_reset_pass.dto';

@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    @InjectRepository(UserLog)
    private readonly UserLogRepository: Repository<UserLog>,
  ) {}

  // @Post('register')
  // async register(@Body() createUserDto: CreateUserDto) {
  //   return this.authService.register(createUserDto);
  // }

  @Post('request-otp')
  @NoJwtBlacklistGuard()
  async requestOtp(@Body() dto: RequestOtpDto) {
    return this.authService.requestOtp(dto);
  }

  @Post('verify-otp')
  @NoJwtBlacklistGuard()
  async verifyOtp(@Body() dto: VerifyOtpDto) {
    return this.authService.verifyOtp(dto);
  }

  // @Post('login')
  // @NoJwtBlacklistGuard()
  // async login(@Body() loginDto: { email: string; password: string }) {
  //   const user = await this.authService.validateUser(
  //     loginDto.email,
  //     loginDto.password,
  //   );
  //   if (!user) {
  //     throw new ForbiddenException('Invalid credentials');
  //   }
  //   return this.authService.login(user);
  // }

  @Post('login')
  @NoJwtBlacklistGuard()
  async login(
    @Req() req,
    @Body() loginDto: { email: string; password: string },
  ) {
    const user = await this.authService.validateUser(
      loginDto.email,
      loginDto.password,
    );
    // const ip = req.ip; // IP address of the user
    const ip = req.connection.remoteAddress; // IP address of the user
    const userAgent = req.headers['user-agent']; // User-Agent from header

    if (!user) {
      // Log failed login attempt if credentials are incorrect
      await this.UserLogRepository.save({
        action: 'failed_login',
        ip_address: req.ip,
        user_agent: req.headers['user-agent'],
        success: false,
        jwt_id: undefined, // No JWT for failed login
      });

      throw new ForbiddenException('Invalid credentials');
    }

    // Log successful login attem

    return this.authService.login(user, ip, userAgent); // Pass to service
  }

  @UseGuards(AuthGuard('jwt'))
  @Post('logout')
  async logout(@Req() req) {
    const userId = req.user.userId;

    const authHeader = req.headers.authorization;
    const accessToken = authHeader && authHeader.split(' ')[1];

    const ip = req.connection.remoteAddress; // IP address of the user
    const userAgent = req.headers['user-agent']; // User-Agent from header

    if (!accessToken) {
      throw new Error('Access token not found in Authorization header');
    }

    await this.authService.logout(userId, accessToken, ip, userAgent);
    return { message: 'Logged out successfully' };
  }

  @Post('refresh')
  async refresh(@Body() body: { refresh_token: string }) {
    return this.authService.refreshTokens(body.refresh_token);
  }

  // @UseGuards(JwtAuthGuard)
  @UseGuards(AuthGuard('jwt'))
  @Post('forgot-password')
  requestPasswordReset(@Request() req) {
    const email = req.user.email;
    // console.log('Decoded user from JWT:', email);
    const ip = req.connection.remoteAddress; // IP address of the user
    const userAgent = req.headers['user-agent'];
    return this.authService.requestPasswordReset(ip, userAgent, email);
  }

  // @UseGuards(JwtAuthGuard)
  @Post('reset-password')
  verifyResetOtp(@Request() req, @Body() dto: VerifyResetOtpDto) {
    const ip = req.connection.remoteAddress; // IP address of the user
    const userAgent = req.headers['user-agent'];
    const email = req.user.email;
    return this.authService.verifyResetOtp(ip, userAgent, email, dto);
  }
}
