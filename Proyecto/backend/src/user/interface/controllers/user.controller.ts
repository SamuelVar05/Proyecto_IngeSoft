import { Controller, Post, Body, Get, UseGuards, Req } from '@nestjs/common';
import { RegisterUserUseCase } from 'src/user/application/use-cases/register-user.use-case';
import { RegisterUserDto } from '../dtos/register-user.dto';
import { ApiResponse } from 'types/ApiResponse';
import { RegisterUserResponseDto } from 'src/auth/application/use-cases/dtos/register-user-response.dto';
import {
  ApiOperation,
  ApiResponse as SwaggerResponse,
  ApiTags,
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/infrastructure/guards/Jwt-auth.guard';
import { FindUserByIdUseCase } from 'src/user/application/use-cases/findUserById.use-case';
import { Request } from 'express';
import { FindUserDto } from 'src/user/application/dtos/findUser.dto';

@ApiTags('Users')
@Controller('users')
export class UserController {
  constructor(
    private readonly registerUserUseCase: RegisterUserUseCase,
    private readonly findUserByIdUseCase: FindUserByIdUseCase,
  ) {}

  @UseGuards(AuthGuard)
  @Get('testoperation')
  @ApiOperation({ summary: 'Test endpoint' })
  @SwaggerResponse({
    status: 200,
    description: 'Test operation successful',
    schema: {
      example: {
        data: 'test operation',
      },
    },
  })
  async testOperation() {
    return {
      data: 'testt operation',
    };
  }

  @Post('register')
  @ApiOperation({ summary: 'Register a new user' })
  @SwaggerResponse({
    status: 201,
    description: 'User successfully registered',
    schema: {
      example: {
        success: true,
        data: {
          user: {
            email: 'example@email.com',
            userid: 'bb1452f2-8ffa-4624-90d0-0bab55f80352',
          },
          token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
        },
        message: 'User registered successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 400,
    description: 'Bad request - Invalid input data',
    schema: {
      example: {
        statusCode: 400,
        message: 'BAD_REQUEST :: User already exists',
      },
    },
  })
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

  @Get('info')
  @ApiOperation({ summary: 'Get user info' })
  @SwaggerResponse({
    status: 200,
    description: 'User info retrieved successfully',
    schema: {
      example: {
        success: true,
        data: {
          email: 'example.email.com',
          role: 'User',
          userid: 'bb1452f2-8ffa-4624-90d0-0bab55f80352',
        },
        message: 'User info retrieved successfully',
      },
    },
  })
  @UseGuards(AuthGuard)
  async getUserInfo(
    @Req() req: Request,
  ): Promise<ApiResponse<FindUserDto & { idUser: string }>> {
    const userId = req.idUser;
    const user = await this.findUserByIdUseCase.execute(userId);
    return {
      message: 'User info retrieved successfully',
      data: { ...user, idUser: userId },
      success: true,
    };
  }
}
