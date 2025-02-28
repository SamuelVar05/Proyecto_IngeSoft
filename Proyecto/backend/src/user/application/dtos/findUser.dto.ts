import { User } from 'src/user/domain/entities/user.entity';

export interface FindUserDto
  extends Omit<User, 'id' | 'createdAt' | 'chazas' | 'password'> {}
