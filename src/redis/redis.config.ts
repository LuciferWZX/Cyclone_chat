import { RedisModuleOptions } from 'nestjs-redis/dist/redis.interface';

const redisConfig: RedisModuleOptions | RedisModuleOptions[] = {
  port: 6379,
  host: '127.0.0.1',
  password: '',
  db: 0,
};
export default redisConfig;
