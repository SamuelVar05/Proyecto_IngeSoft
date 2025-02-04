// src/auth/infrastructure/services/auth.service.ts
import { Injectable } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';
import { AuthService } from 'src/auth/domain/ports/auth.service';


@Injectable()
export class JwtAuthService implements AuthService {
  async hashPassword(password: string): Promise<string> {
    return bcrypt.hash(password, 10);
  }

  async comparePasswords(plain: string, hashed: string): Promise<boolean> {
    return bcrypt.compare(plain, hashed);
  }

  generateToken(userId: string): string {
    return jwt.sign({ userId }, 'SECRET_KEY', { expiresIn: '1h' });
  }
}
