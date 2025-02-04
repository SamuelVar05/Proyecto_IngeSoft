// src/auth/auth.module.ts
import { forwardRef, Module } from '@nestjs/common';

import { AuthenticateUserUseCase } from './application/use-cases/authenticate-user.use-case';
import { AuthController } from './interface/controllers/auth.controller';
import { JwtAuthService } from './infrastructure/services/auth.services';
import { UserModule } from 'src/user/user.module';

@Module({
  imports: [forwardRef(() => UserModule)],
  providers: [
    { provide: 'AuthService', useClass: JwtAuthService },
    AuthenticateUserUseCase,
  ],
  controllers: [AuthController],
  exports: ['AuthService'],
})
export class AuthModule {}
