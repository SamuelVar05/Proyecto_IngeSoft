import { Injectable, UnauthorizedException } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';
import { JwtPayloadDto } from 'src/auth/domain/dtos/jwt-payload.dto';
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
    return jwt.sign({ userId }, process.env.SECRET_KEY, { expiresIn: '1h' });
  }

  validateToken(token: string): string | JwtPayloadDto {
    try {
      const tokenValidate = jwt.verify(
        token,
        process.env.SECRET_KEY,
      ) as JwtPayloadDto;
      console.log(`token validate ${tokenValidate}`);
      return tokenValidate;
    } catch (error) {
      throw new UnauthorizedException('Invalid Token');
    }
  }
}
