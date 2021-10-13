import { Column, Entity, PrimaryColumn, Timestamp } from 'typeorm';
import { UserStatus } from '../interfaces/enum';

@Entity({ name: 'user_tb' })
export class User {
  @PrimaryColumn({ type: 'varchar', length: 32, name: 'u_id' })
  id: string;
  @Column({ type: 'char', length: 11, name: 'u_phone' })
  phone: string;
  @Column({ type: 'varchar', length: 255, name: 'u_avatar' })
  avatar: string;
  @Column({ type: 'varchar', length: 15, name: 'u_nickname' })
  nickname: string;
  @Column({
    type: 'timestamp',
    default: () => 'current_timestamp',
    name: 'create_time',
  })
  createTime: Timestamp;
  @Column({ type: 'varchar', length: 20, name: 'u_password' })
  password: string;
  @Column({ type: 'varchar', length: 18, name: 'u_id_card' })
  IDCard: string;
  @Column({ type: 'date', name: 'u_birth_day' })
  birthday: string;
  @Column({ type: 'int', name: 'u_sex' })
  sex: number;
  @Column({ type: 'int', name: 'u_status' })
  status: UserStatus;
  @Column({ type: 'int', name: 'is_received_request' })
  isReceivedRequest: number;
  @Column({ type: 'varchar', length: 50, name: 'u_email' })
  email: string;
  @Column({ type: 'varchar', length: 20, name: 'u_username' })
  username: string;
  @Column({
    type: 'timestamp',
    onUpdate: 'current_timestamp',
    default: null,
    name: 'update_time',
  })
  updateTime: Timestamp;
}
