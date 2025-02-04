// src/auth/interface/controllers/auth.controller.ts
import { Controller, Post, Body } from '@nestjs/common';
import { AuthenticateUserUseCase } from 'src/auth/application/use-cases/authenticate-user.use-case';

@Controller('auth')
export class AuthController {
  constructor(
    private readonly authenticateUserUseCase: AuthenticateUserUseCase,
  ) {}

  @Post('login')
  async login(@Body() body: { email: string; password: string }) {
    const token = await this.authenticateUserUseCase.execute(
      body.email,
      body.password,
    );
    return { token };
  }
}
