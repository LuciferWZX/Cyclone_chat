import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from '../entity/user.entity';
import { CommonRedisService } from 'src/redis/commonRedis.service';
import { JwtModule } from '@nestjs/jwt';
import { jwtContants } from './jwt.contants';

@Module({
  imports: [
    TypeOrmModule.forFeature([User]),
    CommonRedisService,
    JwtModule.register({
      secret: jwtContants.secret,
    }),
  ],
  controllers: [UserController],
  providers: [UserService, CommonRedisService],
  exports: [UserService],
})
export class UserModule {}
