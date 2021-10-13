import {
  MiddlewareConsumer,
  Module,
  NestModule,
  RequestMethod,
} from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './user/user.module';
import { LoggerMiddleware } from './middlewares/logger.middleware';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RedisModule } from 'nestjs-redis';
import redisConfig from './redis/redis.config';
import { VerifyMiddleware } from './middlewares/verify.middleware';

@Module({
  imports: [
    UserModule,
    TypeOrmModule.forRoot(),
    RedisModule.register(redisConfig),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule {
  //constructor(private readonly connection: Connection) {}
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(VerifyMiddleware)
      .exclude(
        {
          path: 'user/login',
          method: RequestMethod.POST,
        },
        {
          path: 'user/register',
          method: RequestMethod.POST,
        },
      )
      .forRoutes({ path: '*', method: RequestMethod.ALL });
    consumer
      .apply(LoggerMiddleware)
      .exclude({ path: 'user', method: RequestMethod.GET })
      .forRoutes({ path: '*', method: RequestMethod.ALL });
  }
}
