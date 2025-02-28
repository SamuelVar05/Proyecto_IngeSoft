import { Inject, Injectable } from '@nestjs/common';
import { UserRepository } from 'src/user/domain/ports/user.repository';
import { ErrorManager } from 'utils/ErrorManager';
import { FindUserDto } from '../dtos/findUser.dto';

@Injectable()
export class FindUserByIdUseCase {
  constructor(
    @Inject('IUserRepository')
    private readonly userRepository: UserRepository,
  ) {}
  async execute(id: string): Promise<FindUserDto> {
    try {
      const user = await this.userRepository.findUserById(id);
      if (!user || user === null) {
        throw new ErrorManager({
          message: ' User not found',
          type: 'NOT_FOUND',
        });
      }
      const { email, role } = user;
      return { email, role };
    } catch (error) {
      throw ErrorManager.createSignatureError(error);
    }
  }
}
