// src/user/application/use-cases/register-user.use-case.ts
import { Inject, Injectable } from '@nestjs/common';
import { AuthService } from 'src/auth/domain/ports/auth.service';
import { User } from 'src/user/domain/entities/user.entity';
import { UserRepository } from 'src/user/domain/ports/user.repository';

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
  ): Promise<{ user: string; token: string }> {
    const existingUser = await this.userRepository.findUserByEmail(email);
    if (existingUser) {
      throw new Error('User already exists');
    }

    const hashedPassword = await this.authService.hashPassword(password);
    const newUser = new User();
    newUser.email = email;
    newUser.password = hashedPassword;

    await this.userRepository.createUser(newUser);
    const token = await this.authService.generateToken(newUser.id);
    return { user: '', token };
  }
}
