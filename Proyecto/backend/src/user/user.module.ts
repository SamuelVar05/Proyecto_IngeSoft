// src/user/user.module.ts
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './domain/entities/user.entity';
import { TypeOrmUserRepository } from './infrastructure/repositories/user.repository';
import { RegisterUserUseCase } from './application/use-cases/register-user.use-case';
import { UserController } from './interface/controllers/user.controller';

@Module({
  imports: [TypeOrmModule.forFeature([User])],
  providers: [
    { provide: 'UserRepository', useClass: TypeOrmUserRepository },
    RegisterUserUseCase,
  ],
  controllers: [UserController],
})
export class UserModule {}
