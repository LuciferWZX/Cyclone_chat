import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './filters/http-exception.filter';
import { TransformInterceptor } from './interceptor/transform.interceptor';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalInterceptors(new TransformInterceptor()); // 全局注册拦截器
  app.useGlobalFilters(new HttpExceptionFilter()); //全局过滤器

  await app.listen(3000);
}
bootstrap().then();
