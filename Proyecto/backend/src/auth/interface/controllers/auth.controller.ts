// src/auth/interface/controllers/auth.controller.ts
import { Controller, Post, Body, HttpCode } from '@nestjs/common';
import { AuthenticateUserUseCase } from 'src/auth/application/use-cases/authenticate-user.use-case';
import { LoginUserDto } from '../dto/login-user.dto';
import { ApiResponse } from 'types/ApiResponse';
import { LoginUserResponseDto } from 'src/auth/application/use-cases/dtos/login-user-response.dto';

@Controller('auth')
export class AuthController {
  constructor(
    private readonly authenticateUserUseCase: AuthenticateUserUseCase,
  ) {}

  @Post('login')
  @HttpCode(200)
  async login(
    @Body() { email, password }: LoginUserDto,
  ): Promise<ApiResponse<LoginUserResponseDto>> {
    const token = await this.authenticateUserUseCase.execute(email, password);
    return {
      data: token,
      message: 'User logged in',
      success: true,
    };
  }
}
