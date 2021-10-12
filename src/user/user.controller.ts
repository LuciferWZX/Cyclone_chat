import {
  Body,
  Controller,
  Get,
  HttpException,
  HttpStatus,
  Post,
  Req,
} from '@nestjs/common';
import { UserService } from './user.service';
import { Request } from 'express';
import { ControllerPrefix, RegisterType } from 'src/interfaces/enum';
import { UserRegister } from './user.type';
import { verifyPhoneCode } from '../utils/help';

@Controller(ControllerPrefix.user)
export class UserController {
  constructor(private userServer: UserService) {}
  @Post('register')
  async register(@Body() body: UserRegister): Promise<any> {
    const { type } = body;
    const { username, msgVerify, phone, email } = body;
    await this.userServer.verifyUser(phone, username, email); //用户是否可以注册
    if (type === RegisterType.PHONE) {
      await verifyPhoneCode(phone, msgVerify); //验证验证码是否正确
    }
    return this.userServer.register(body); //用户注册成功
  }
  @Get('/info')
  findAll(@Req() request: Request): any {
    return this.userServer.findOne();
  }
}
