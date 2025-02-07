// src/user/infrastructure/repositories/user.repository.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '../../domain/entities/user.entity';
import { UserRepository } from '../../domain/ports/user.repository';
import { Repository } from 'typeorm';

@Injectable()
export class TypeOrmUserRepository implements UserRepository {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async createUser(user: User): Promise<void> {
    await this.userRepository.save(user);
  }

  async findUserByEmail(email: string): Promise<User | null> {
    return this.userRepository.findOneBy({ email });
  }

  findUserById(id: string): Promise<User | null> {
    return this.userRepository.findOneBy({ id });
  }
}
