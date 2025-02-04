// src/user/interface/controllers/user.controller.ts
import { Controller, Post, Body } from '@nestjs/common';
import { RegisterUserUseCase } from 'src/user/application/use-cases/register-user.use-case';

@Controller('users')
export class UserController {
  constructor(private readonly registerUserUseCase: RegisterUserUseCase) {}

  @Post('register')
  async register(@Body() body: { email: string; password: string }) {
    await this.registerUserUseCase.execute(body.email, body.password);
    return { message: 'User registered successfully' };
  }
}
