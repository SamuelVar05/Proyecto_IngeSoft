import {
  CanActivate,
  ExecutionContext,
  Inject,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Request } from 'express';
import { AuthService } from 'src/auth/domain/ports/auth.service';
import { PUBLIC_KEY } from 'src/constants/key-decorator';
import { UserRepository } from 'src/user/domain/ports/user.repository';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    @Inject('AuthService')
    private readonly authService: AuthService,
    @Inject('IUserRepository')
    private readonly userRepository: UserRepository,
    private readonly reflector: Reflector,
  ) {}
  async canActivate(context: ExecutionContext) {
    const isPublic = this.reflector.get<boolean>(
      PUBLIC_KEY,
      context.getHandler(),
    );

    if (isPublic) return true;

    const req = context.switchToHttp().getRequest<Request>();

    if (!req.headers.authorization)
      throw new UnauthorizedException('Invalid Token');

    let token = req.headers.authorization.split(' ')[1];

    if (!token) throw new UnauthorizedException('Invalid Token');

    const payloadToken = this.authService.validateToken(token);
    if (typeof payloadToken === 'string')
      throw new UnauthorizedException('Invalid token');

    const { userId } = payloadToken;
    const user = await this.userRepository.findUserById(userId);
    if (!user) throw new UnauthorizedException('Invalid User');

    req.idUser = user.id;
    return true;
  }
}
