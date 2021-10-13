import { Injectable, NestMiddleware } from '@nestjs/common';
import { UserService } from '../user/user.service';
import { Request } from 'express';

@Injectable()
export class VerifyMiddleware implements NestMiddleware {
  constructor(private userService: UserService) {}
  async use(req: Request, res: any, next: () => void): Promise<any> {
    console.log('验证token');
    await this.userService.getUserByToken(req.header('token')?.split(' ')[1]);
    next();
  }
}
