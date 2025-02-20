// src/chaza/application/use-cases/get-chaza-by-id.use-case.ts
import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { ChazaRepository } from 'src/chaza/domain/ports/chaza.repository';
import { ErrorManager } from 'utils/ErrorManager';

import { findChazaByIdChazaResponseDto } from 'src/chaza/interface/controllers/find-chaza-by-id-response.dto';

@Injectable()
export class GetChazaByIdUseCase {
  constructor(
    @Inject('IChazaRepository')
    private readonly chazaRepository: ChazaRepository,
  ) {}

  async execute(idChaza: string): Promise<findChazaByIdChazaResponseDto> {
    try {
      const chaza = await this.chazaRepository.findChazaById(idChaza);

      if (!chaza) {
        throw new ErrorManager({
          message: 'La chaza con el ID proporcionado no existe.',
          type: 'BAD_REQUEST',
        });
      }
      return {
        chaza,
      };
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}