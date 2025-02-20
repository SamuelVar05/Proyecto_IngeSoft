import { Injectable, Inject, NotFoundException, InternalServerErrorException } from '@nestjs/common';
import { ChazaRepository } from 'src/chaza/domain/ports/chaza.repository';
import { DeleteChazaResponseDto } from 'src/chaza/interface/controllers/delete-chaza-response.dto';
import { ErrorManager } from 'utils/ErrorManager';

@Injectable()
export class DeleteChazaUseCase {
  constructor(
    @Inject('IChazaRepository')
    private readonly chazaRepository: ChazaRepository) {}

  async execute(idChaza: string): Promise<DeleteChazaResponseDto > {
    try {
      const chaza = await this.chazaRepository.findChazaById(idChaza);

      if (!chaza) {
        throw new ErrorManager({
          message: 'La chaza con el ID proporcionado no existe.',
          type: 'BAD_REQUEST',
        });
      }

      await this.chazaRepository.deleteChaza(idChaza);

      return {
        status: 'success',
        message: 'Chaza eliminada exitosamente',
      };
    } catch (error) {
          throw ErrorManager.createSignatureError(error.message);
        }
  }
}
