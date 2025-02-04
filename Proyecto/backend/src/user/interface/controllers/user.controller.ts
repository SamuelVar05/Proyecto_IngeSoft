import { Controller, Post, Body } from '@nestjs/common';
import { RegisterUserUseCase } from 'src/user/application/use-cases/register-user.use-case';
import { RegisterUserDto } from '../dtos/register-user.dto';
import { ApiResponse } from 'types/ApiResponse';
import { RegisterUserResponseDto } from 'src/auth/application/use-cases/dtos/register-user-response.dto';

@Controller('users')
export class UserController {
  constructor(private readonly registerUserUseCase: RegisterUserUseCase) {}

  @Post('register')
  async register(
    @Body() body: RegisterUserDto,
  ): Promise<ApiResponse<RegisterUserResponseDto>> {
    const responseUseCase = await this.registerUserUseCase.execute(
      body.email,
      body.password,
    );

    return {
      success: true,
      data: responseUseCase,
      message: 'User registered successfully',
    };
  }
}
