// src/user/application/use-cases/register-user.use-case.ts
import { Inject, Injectable } from '@nestjs/common';
import { RegisterUserResponseDto } from 'src/auth/application/use-cases/dtos/register-user-response.dto';
import { AuthService } from 'src/auth/domain/ports/auth.service';
import { User } from 'src/user/domain/entities/user.entity';
import { UserRepository } from 'src/user/domain/ports/user.repository';
import { ErrorManager } from 'utils/ErrorManager';

@Injectable()
export class RegisterUserUseCase {
  constructor(
    @Inject('IUserRepository')
    private readonly userRepository: UserRepository,
    @Inject('AuthService')
    private readonly authService: AuthService,
  ) {}

  async execute(
    email: string,
    password: string,
  ): Promise<RegisterUserResponseDto> {
    try {
      const existingUser = await this.userRepository.findUserByEmail(email);
      if (existingUser) {
        throw new ErrorManager({
          message: ' User already exists',
          type: 'BAD_REQUEST',
        });
      }

      //hashed password
      const hashedPassword = await this.authService.hashPassword(password);
      const newUser = new User();
      newUser.email = email;
      newUser.password = hashedPassword;

      //create the user in the database
      await this.userRepository.createUser(newUser);

      //generate JWT token
      const token = this.authService.generateToken(newUser.id);
      return {
        user: {
          email: newUser.email,
          userid: newUser.id,
        },
        token,
      };
    } catch (error) {
      throw new ErrorManager({
        message: error.message,
        type: 'INTERNAL_SERVER_ERROR',
      });
    }
  }
}
