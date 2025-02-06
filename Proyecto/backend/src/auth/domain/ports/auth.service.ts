import { JwtPayloadDto } from "../dtos/jwt-payload.dto";

export interface AuthService {
  hashPassword(password: string): Promise<string>;
  comparePasswords(plain: string, hashed: string): Promise<boolean>;
  generateToken(userId: string): string;
  validateToken(token: string): string | JwtPayloadDto;
}
