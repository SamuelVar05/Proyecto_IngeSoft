// src/auth/auth.module.ts
import { Module } from '@nestjs/common';

import { AuthenticateUserUseCase } from './application/use-cases/authenticate-user.use-case';
import { AuthController } from './interface/controllers/auth.controller';
import { JwtAuthService } from './infrastructure/services/auth.services';

@Module({
  providers: [
    { provide: 'AuthService', useClass: JwtAuthService },
    AuthenticateUserUseCase,
  ],
  controllers: [AuthController],
})
export class AuthModule {}
