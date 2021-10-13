import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { generateUUID } from '../utils/help';
import { UserLogin, UserRegister } from './user.type';
import {
  CustomCode,
  LoginType,
  RedisKeyPrefix,
  UserStatus,
} from '../interfaces/enum';
import { CommonRedisService } from '../redis/commonRedis.service';
import { IUser } from 'src/interfaces/interface';
import { User } from '../entity/user.entity';
import { JwtService } from '@nestjs/jwt';
import { jwtContants } from './jwt.contants';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    private readonly commonRedisService: CommonRedisService,
    private jwtServer: JwtService,
  ) {}
  //注册
  async register(registerParams: UserRegister): Promise<User> {
    return await this.userRepository
      .save({
        id: generateUUID(),
        username: registerParams.username,
        email: registerParams.email,
        phone: registerParams.phone,
        password: registerParams.password,
        nickname: registerParams.nickname,
      })
      .catch((reason) => {
        console.log(reason.sqlMessage);
        throw new HttpException(reason.sqlMessage, CustomCode.SQLERROR);
      });
  }
  async findOne(): Promise<any> {
    return this.userRepository.find();
  }
  //查询是否已经同样的数据
  async verifyUser(
    phone: string,
    username: string,
    email: string,
  ): Promise<void> {
    const user = await this.userRepository.findOne({
      where: [{ phone: phone }, { username: username }, { email: email }],
    });
    if (user) {
      if (user.phone === phone) {
        throw new HttpException('该手机号已被注册', HttpStatus.FORBIDDEN);
      }
      if (user.username === username) {
        throw new HttpException('该用户名已存在', HttpStatus.FORBIDDEN);
      }
      if (user.email === email) {
        throw new HttpException('该邮箱已被注册', HttpStatus.FORBIDDEN);
      }
    }
  }
  //登录的用户
  async userLogin(params: UserLogin): Promise<User> {
    switch (params.type) {
      case LoginType.EMAIL: {
        const user = await this.userRepository.findOne({
          where: [{ email: params.email, password: params.password }],
        });
        if (!user) {
          throw new HttpException('邮箱或密码错误', HttpStatus.UNAUTHORIZED);
        }
        if (user.status === UserStatus.BANNED) {
          throw new HttpException('该用户已被禁用', HttpStatus.UNAUTHORIZED);
        }
        return user;
      }
      case LoginType.PHONE: {
        const user = await this.userRepository.findOne({
          where: [{ phone: params.phone, password: params.password }],
        });
        if (!user) {
          throw new HttpException('手机号或密码错误', HttpStatus.UNAUTHORIZED);
        }
        if (user.status === UserStatus.BANNED) {
          throw new HttpException('该用户已被禁用', HttpStatus.UNAUTHORIZED);
        }
        return user;
      }
      case LoginType.verify: {
        //处理验证码
        return null;
      }
    }
    return null;
  }
  //生成token
  async generateToken(user: User): Promise<string> {
    return this.jwtServer.sign({ username: user.username, sub: user.id });
  }
  //验证用户是否已经登录
  async verifyUserIsOnline(id: string): Promise<void> {
    const user: IUser | null = await this.commonRedisService.get(
      `${RedisKeyPrefix.user}-${id}`,
    );
    if (user) {
      throw new HttpException(
        '该用户已在其他地方登录',
        HttpStatus.UNAUTHORIZED,
      );
    }
  }

  async getUserByToken(token?: string): Promise<IUser> {
    if (!token) {
      throw new HttpException('token未传入', HttpStatus.UNAUTHORIZED);
    }
    try {
      const id: string = await this.jwtServer.verify(token, {
        secret: jwtContants.secret,
      }).sub;
      const user: IUser | null = await this.commonRedisService.get(
        `${RedisKeyPrefix.user}-${id}`,
      );
      if (!user) {
        throw new HttpException(
          '该token已过期,请重新登录',
          HttpStatus.UNAUTHORIZED,
        );
      }
      return user;
    } catch (e) {
      throw new HttpException('token不正确', HttpStatus.UNAUTHORIZED);
    }
  }
}
