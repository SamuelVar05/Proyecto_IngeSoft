// src/auth/interface/controllers/auth.controller.ts
import { Controller, Post, Body, HttpCode } from '@nestjs/common';
import { AuthenticateUserUseCase } from 'src/auth/application/use-cases/authenticate-user.use-case';
import { LoginUserDto } from '../dto/login-user.dto';
import { ApiResponse } from 'types/ApiResponse';
import { LoginUserResponseDto } from 'src/auth/application/use-cases/dtos/login-user-response.dto';
import {
  ApiOperation,
  ApiTags,
  ApiResponse as SwaggerResponse,
} from '@nestjs/swagger';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(
    private readonly authenticateUserUseCase: AuthenticateUserUseCase,
  ) {}

  @Post('login')
  @ApiOperation({ summary: 'Login a user and get token' })
  @SwaggerResponse({
    status: 200,
    description: 'User logged in',
    schema: {
      example: {
        success: true,
        data: {
          token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
        },
        message: 'User logged in',
      },
    },
  })
  @SwaggerResponse({
    status: 401,
    description: 'Unauthorized - Invalid credentials',
    schema: {
      example: {
        statusCode: 401,
        message: 'UNAUTHORIZED :: Invalid credentials',
      },
    },
  })
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
