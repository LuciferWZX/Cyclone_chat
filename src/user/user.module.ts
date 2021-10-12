import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from '../entity/user.entity';
import { CommonRedisService } from 'src/redis/commonRedis.service';

@Module({
  imports: [TypeOrmModule.forFeature([User]), CommonRedisService],
  controllers: [UserController],
  providers: [UserService, CommonRedisService],
})
export class UserModule {}
