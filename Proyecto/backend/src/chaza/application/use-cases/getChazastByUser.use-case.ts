import { Inject, Injectable } from '@nestjs/common';
import { Chaza } from 'src/chaza/domain/entities/chaza.entity';
import { ChazaRepository } from 'src/chaza/domain/ports/chaza.repository';
import { ErrorManager } from 'utils/ErrorManager';

@Injectable()
export class GetChazasByUserUseCase {
  constructor(
    @Inject('IChazaRepository')
    private readonly chazaRepository: ChazaRepository,
  ) {}

  async execute(userId: string): Promise<Chaza[]> {
    try {
      const chazas = await this.chazaRepository.findChazasByUserId(userId);
      if (!chazas || chazas.length === 0) {
        throw new ErrorManager({
          message: 'No chazas found for this user',
          type: 'NOT_FOUND',
        });
      }
      return chazas;
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
