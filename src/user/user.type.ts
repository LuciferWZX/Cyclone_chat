import { LoginType, RegisterType } from '../interfaces/enum';

export interface UserRegister {
  type: RegisterType;
  phone: string;
  email: string;
  password: string;
  msgVerify: string;
  nickname: string;
  username: string;
}
export interface UserLogin {
  type: LoginType;
  phone: string;
  email: string;
  username: string;
  password: string;
  verifyCode: string;
}
