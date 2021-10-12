import { RegisterType } from '../interfaces/enum';

export interface UserRegister {
  type: RegisterType;
  phone: string;
  email: string;
  password: string;
  msgVerify: string;
  nickname: string;
  username: string;
}
