// src/user/interface/controllers/user.controller.ts
import { Controller, Post, Body } from '@nestjs/common';
import { RegisterUserUseCase } from 'src/user/application/use-cases/register-user.use-case';
import { RegisterUserDto } from '../dtos/register-user.dto';

@Controller('users')
export class UserController {
  constructor(private readonly registerUserUseCase: RegisterUserUseCase) {}

  @Post('register')
  async register(@Body() body: RegisterUserDto) {
    const token = await this.registerUserUseCase.execute(
      body.email,
      body.password,
    );

    return {
      sucess: true,
      data: {
        token,
      },
    };
  }
}
