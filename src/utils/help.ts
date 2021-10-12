//验证验证码是否正确
import { HttpException, HttpStatus } from '@nestjs/common';

export async function verifyPhoneCode(
  phone: string,
  code: string,
): Promise<void> {
  //从redis里面查询对比验证码是否正确
  if (code !== '123456') {
    throw new HttpException('验证码不正确', HttpStatus.SEE_OTHER);
  }
}
//生成唯一的uuid
export function generateUUID(): string {
  const originStr = 'xxxxxxxxcxxxixxxrxxxixxxxxxxxxxx',
    originChar = '0123456789abcdefghijk',
    len = originChar.length;
  return originStr.replace(/x/g, function (match) {
    return originChar.charAt(Math.floor(Math.random() * len));
  });
}
