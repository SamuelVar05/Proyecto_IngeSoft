import { Inject } from '@nestjs/common';
import { AuthService } from 'src/auth/domain/ports/auth.service';
import { UserRepository } from 'src/user/domain/ports/user.repository';

export class AuthenticateUserUseCase {
  constructor(
    @Inject('IUserRepository')
    private readonly userRepository: UserRepository,
    @Inject('AuthService')
    private readonly authService: AuthService,
  ) {}
  async execute(email: string, password: string) {
    const user = await this.userRepository.findUserByEmail(email);

    if (!user) {
      throw new Error('User not found');
    }
    const isValidPassword = await this.authService.comparePasswords(
      password,
      user.password,
    );
    if (!isValidPassword) {
      throw new Error('Invalid password');
    }
    return this.authService.generateToken(user.id);
  }
}
