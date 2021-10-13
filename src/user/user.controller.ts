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
import {
  ControllerPrefix,
  RedisKeyPrefix,
  RegisterType,
} from 'src/interfaces/enum';
import { UserLogin, UserRegister } from './user.type';
import { verifyPhoneCode } from '../utils/help';
import { CommonRedisService } from '../redis/commonRedis.service';

@Controller(ControllerPrefix.user)
export class UserController {
  constructor(
    private userServer: UserService,
    private commonRedisService: CommonRedisService,
  ) {}
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
  @Post('login')
  async login(@Body() body: UserLogin): Promise<any> {
    //查询登录用户
    const user = await this.userServer.userLogin(body);
    //查看是否已登录
    await this.userServer.verifyUserIsOnline(user.id);
    //生成token
    const token = await this.userServer.generateToken(user);
    const iUser = {
      ...user,
      token,
    };
    //将信息存入redis
    await this.commonRedisService.set(
      `${RedisKeyPrefix.user}-${user.id}`,
      iUser,
    );
    //返回用户信息
    return iUser;
  }
  @Get('/info')
  findAll(@Req() request: Request): any {
    return this.userServer.findOne();
  }
}
