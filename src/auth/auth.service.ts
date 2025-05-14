import {
  ConflictException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcryptjs';
import { User } from '../user/entities/user.entity';
import { CreateUserDto } from './dto/CreateUser.dto';
import { UserService } from 'src/user/user.service';
import { PendingUser } from 'src/user/entities/pending_user.entity';
import { VerifyOtpDto } from 'src/user/dto/verify_otp.dto';
import { RequestOtpDto } from 'src/user/dto/request_otp.dto';
import { MailerService } from '@nestjs-modules/mailer';
import { RefreshToken } from './entities/refresh_token.entity';
import { BlacklistToken } from './entities/blackList_token.entity';
import { UserLog } from 'src/log/entities/user_logs.entity';
import { PasswordReset } from 'src/user/entities/password_reset.entity';
import { VerifyResetOtpDto } from 'src/user/dto/varify_reset_pass.dto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    private jwtService: JwtService,
    private userService: UserService,
    private mailerService: MailerService,
    @InjectRepository(PendingUser)
    private pendingUserRepo: Repository<PendingUser>,
    @InjectRepository(RefreshToken)
    private readonly refreshTokenRepository: Repository<RefreshToken>,
    @InjectRepository(BlacklistToken)
    private readonly blackListTokenRepository: Repository<BlacklistToken>,
    @InjectRepository(UserLog)
    private readonly UserLogRepository: Repository<UserLog>,
    @InjectRepository(PasswordReset)
    private readonly passwordResetRepo: Repository<PasswordReset>,
  ) {}

  // async register(createUserDto: CreateUserDto) {
  //   const userExists = await this.userService.findByEmail(createUserDto.email);
  //   if (userExists) {
  //     throw new ConflictException(
  //       `Cannot register: Email: ${createUserDto.email} already exists`,
  //     );
  //   }
  //   const newUser = await this.userService.create(createUserDto);
  //   return { message: 'User registered', user: newUser };
  // }
  //   async validateUser(email: string, password: string): Promise<any> {
  //     const user = await this.userRepository.findOne({ where: { email } });
  //     if (user && (await bcrypt.compare(password, user.password))) {
  //       const { password, ...result } = user;
  //       return result;
  //     }
  //     return null;
  //   }

  async validateUser(email: string, password: string): Promise<any> {
    const user = await this.userRepository.findOne({ where: { email } });

    if (user && user.password === password) {
      return user;
    }
    return null;
  }

  async login(user: any, ip: string, userAgent: string) {
    const payload = { username: user.email, sub: user.id, role: user.role };
    const access_token = this.jwtService.sign(payload);
    const refresh_token = this.jwtService.sign(payload, {
      expiresIn: '7d',
      secret: process.env.JWT_REFRESH_SECRET,
    });

    await this.UserLogRepository.save({
      user: user,
      action: 'login',
      ip_address: ip,
      user_agent: userAgent,
      success: true,
      jwt_id: payload.sub,
    });

    await this.userRepository.update(user.id, { lastLogin: new Date() });

    await this.refreshTokenRepository.save({
      userId: user.id,
      token: refresh_token,
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
    });

    const decoded = this.jwtService.verify(access_token);
    return {
      access_token,
      id: decoded.sub,
      role: decoded.role,
    };
  }

  // async login(user: any) {
  //   const payload = { username: user.email, sub: user.id, role: user.role };
  //   const access_token = this.jwtService.sign(payload);
  //   const refresh_token = this.jwtService.sign(payload, {
  //     expiresIn: '7d',
  //     secret: process.env.JWT_REFRESH_SECRET,
  //   });

  //   await this.refreshTokenRepository.save({
  //     userId: user.id,
  //     token: refresh_token,
  //     expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
  //     // revoked: false,
  //   });

  //   const decoded = this.jwtService.verify(access_token);
  //   return {
  //     access_token,
  //     // refresh_token,
  //     // user: {
  //     //   id: user.id,
  //     //   role: user.role,
  //     // },
  //     id: decoded.sub,
  //     role: decoded.role,
  //   };
  // }

  async isBlacklisted(token: string): Promise<boolean> {
    const entry = await this.blackListTokenRepository.findOne({
      where: { token },
    });
    return !!entry;
  }

  async logout(
    userId: number,
    accessToken: string,
    ip: string,
    userAgent: string,
  ) {
    const decoded = this.jwtService.decode(accessToken) as { exp: number };
    const expiresAt = new Date(decoded.exp * 1000);

    await this.refreshTokenRepository.delete({ userId });

    await this.blackListTokenRepository.save({
      token: accessToken,
      expiresAt,
    });

    await this.UserLogRepository.save({
      action: 'logout',
      user: { id: userId },
      ip_address: ip,
      user_agent: userAgent,
      success: true,
      jwt_id: undefined,
    });

    await this.userRepository.update(userId, { lastLogout: new Date() });
  }

  // async logout(userId: number, accessToken: string) {
  //   const decoded = this.jwtService.decode(accessToken) as { exp: number };
  //   const expiresAt = new Date(decoded.exp * 1000);

  //   await this.refreshTokenRepository.delete({ userId });

  //   await this.blackListTokenRepository.save({
  //     token: accessToken,
  //     expiresAt,
  //   });
  // }

  // async requestOtp(dto: RequestOtpDto) {
  //   const existing = await this.userRepository.findOne({
  //     where: { email: dto.email },
  //   });
  //   if (existing) throw new ConflictException('Email already registered');

  //   const otp = Math.floor(100000 + Math.random() * 900000).toString();

  //   const hashedPassword = await bcrypt.hash(dto.password, 10);

  //   const pending = this.pendingUserRepo.create({
  //     email: dto.email,
  //     password: hashedPassword,
  //     otp,
  //   });

  //   await this.pendingUserRepo.save(pending);

  //   console.log(`Simulated email OTP: ${otp}`);

  //   return { message: 'OTP sent to email' };
  // }

  // async verifyOtp(dto: VerifyOtpDto) {
  //   const pending = await this.pendingUserRepo.findOne({
  //     where: { email: dto.email, otp: dto.otp },
  //   });

  //   if (!pending) {
  //     throw new UnauthorizedException('Invalid OTP');
  //   }

  //   const newUser = this.userRepository.create({
  //     email: pending.email,
  //     password: pending.password,
  //   });

  //   await this.userRepository.save(newUser);
  //   await this.pendingUserRepo.delete({ email: dto.email });

  //   return { message: 'User registered successfully', user: newUser };
  // }

  async requestOtp(dto: RequestOtpDto) {
    const existing = await this.userRepository.findOne({
      where: { email: dto.email },
    });
    if (existing) throw new ConflictException('Email already registered');

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const otpHtml = `
    <div style="font-family: sans-serif;">
      <h2>Your OTP Code</h2>
      <p>Please use the following code to complete your registration:</p>
      <table style="margin: 10px 0; border-spacing: 10px;">
        <tr>
          ${otp
            .split('')
            .map(
              (digit) => `
            <td style="
              background-color: #4CAF50;
              color: white;
              font-size: 24px;
              font-weight: bold;
              text-align: center;
              width: 40px;
              height: 40px;
              border-radius: 5px;
            ">
              ${digit}
            </td>
          `,
            )
            .join('')}
        </tr>
      </table>
      <p>This code will expire in 10 minutes.</p>
      <p>If you didn't request this, please ignore this email.</p>
      <br>
      <small>Thank you for using OurApp!</small>
    </div>
  `;

    const pending = this.pendingUserRepo.create({
      email: dto.email,
      password: dto.password,
      otp,
    });

    await this.pendingUserRepo.save(pending);

    // await this.mailerService.sendMail({
    //   to: dto.email,
    //   subject: 'Your OTP Code',
    //   text: `Your OTP is ${otp}`,
    //   html: `<p>Hello,</p><p>Your OTP is <strong>${otp}</strong>.</p><p>This code will expire in 10 minutes.</p>`,
    // });

    // await this.mailerService.sendMail({
    //   to: dto.email,
    //   subject: 'Elvate Registration Otp Code',
    //   html: otpHtml,
    // });

    // const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const otpDigits = otp.split('');
    await this.mailerService.sendMail({
      to: dto.email,
      subject: 'Your OTP Code',
      template: 'otp',
      context: {
        name: dto.email.split('@')[0], // Or user's actual name if available
        otpDigits, // array of digits for {{#each otpDigits}} in template
        verificationLink: 'https://yourapp.com/verify', // your fallback or login link
      },
    });

    return { message: 'OTP sent to email' };
  }

  async verifyOtp(dto: VerifyOtpDto) {
    const pending = await this.pendingUserRepo.findOne({
      where: { email: dto.email, otp: dto.otp },
    });

    if (!pending) {
      throw new UnauthorizedException('Invalid OTP or email');
    }

    const newUser = this.userRepository.create({
      email: pending.email,
      password: pending.password,
    });

    await this.userRepository.save(newUser);
    await this.pendingUserRepo.delete({ email: dto.email });

    return { message: 'User registered successfully', user: newUser };
  }

  async refreshTokens(refreshToken: string) {
    try {
      const payload = this.jwtService.verify(refreshToken, {
        secret: process.env.JWT_REFRESH_SECRET,
      });

      const user = await this.userRepository.findOne({
        where: { id: payload.sub },
      });
      if (!user) {
        throw new UnauthorizedException('User not found');
      }

      const newAccessToken = this.jwtService.sign(
        { username: user.email, sub: user.id, role: user.role },
        { expiresIn: '15m' },
      );

      return {
        access_token: newAccessToken,
      };
    } catch (err) {
      throw new UnauthorizedException('Invalid or expired refresh token');
    }
  }

  async requestPasswordReset(ip: string, userAgent: string, email: string) {
    const user = await this.userRepository.findOne({ where: { email } });

    if (!user) {
      throw new UnauthorizedException('No user found with this email');
    }

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 10 * 60 * 1000); // 10 mins

    await this.passwordResetRepo.save({ email, otp, expiresAt });

    const otpDigits = otp.split('');

    await this.mailerService.sendMail({
      to: email,
      subject: 'Password Reset OTP',
      template: 'otp',
      context: {
        name: email.split('@')[0],
        otpDigits,
      },
    });

    await this.UserLogRepository.save({
      user: user, // The logged-in user
      action: 'forgot_password',
      ip_address: ip, // IP address of the user
      user_agent: userAgent, // User-Agent of the request
      success: true, // This is a successful login
      jwt_id: undefined, // Optional, if using `jti`
    });

    return { message: 'OTP sent to your email' };
  }

  async verifyResetOtp(
    ip: string,
    userAgent: string,
    email: string,
    dto: VerifyResetOtpDto,
  ) {
    const reset = await this.passwordResetRepo.findOne({
      where: { email, otp: dto.otp },
    });

    if (!reset || reset.expiresAt < new Date()) {
      throw new UnauthorizedException('Invalid or expired OTP');
    }

    const user = await this.userRepository.findOne({ where: { email } });
    if (!user) throw new UnauthorizedException('User not found');

    user.password = dto.newPassword;
    await this.userRepository.save(user);

    await this.passwordResetRepo.delete({ email }); // Clean up OTP

    await this.UserLogRepository.save({
      user: user, // The logged-in user
      action: 'reset_password',
      ip_address: ip, // IP address of the user
      user_agent: userAgent, // User-Agent of the request
      success: true, // This is a successful login
      jwt_id: undefined, // Optional, if using `jti`
    });

    return { message: 'Password reset successfully' };
  }
}
