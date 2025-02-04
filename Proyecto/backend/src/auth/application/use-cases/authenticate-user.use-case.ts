import { Inject } from '@nestjs/common';
import { AuthService } from 'src/auth/domain/ports/auth.service';
import { LoginUserDto } from 'src/auth/interface/dto/login-user.dto';
import { UserRepository } from 'src/user/domain/ports/user.repository';
import { ErrorManager } from 'utils/ErrorManager';
import { LoginUserResponseDto } from './dtos/login-user-response.dto';

export class AuthenticateUserUseCase {
  constructor(
    @Inject('IUserRepository')
    private readonly userRepository: UserRepository,
    @Inject('AuthService')
    private readonly authService: AuthService,
  ) {}
  async execute(
    email: string,
    password: string,
  ): Promise<LoginUserResponseDto> {
    try {
      const user = await this.userRepository.findUserByEmail(email);

      if (!user) {
        throw new ErrorManager({
          message: 'User not found',
          type: 'UNAUTHORIZED',
        });
      }

      const isValidPassword = await this.authService.comparePasswords(
        password,
        user.password,
      );

      if (!isValidPassword) {
        throw new ErrorManager({
          message: 'Invalid password',
          type: 'UNAUTHORIZED',
        });
      }
      const jwtToken = this.authService.generateToken(user.id);
      return { token: jwtToken };
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
