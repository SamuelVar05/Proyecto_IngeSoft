import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './domain/entities/user.entity';
import { TypeOrmUserRepository } from './infrastructure/repositories/user.repository';
import { RegisterUserUseCase } from './application/use-cases/register-user.use-case';
import { UserController } from './interface/controllers/user.controller';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [TypeOrmModule.forFeature([User]), forwardRef(() => AuthModule)],
  providers: [
    {
      provide: 'IUserRepository',
      useClass: TypeOrmUserRepository,
    },
    RegisterUserUseCase,
  ],
  controllers: [UserController],
  exports: ['IUserRepository'],
})
export class UserModule {}
