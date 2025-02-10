// src/chaza/application/use-cases/create-chaza.use-case.ts
import { Inject, Injectable } from '@nestjs/common';
import { CreateChazaResponseDto } from 'src/chaza/interface/controllers/create-chaza-response.dto';
import { ChazaRepository } from 'src/chaza/domain/ports/chaza.repository';
import { ChazaBuilder } from 'src/chaza/domain/builders/chaza.builder';
import { UserRepository } from 'src/user/domain/ports/user.repository';
import { ErrorManager } from 'utils/ErrorManager';

@Injectable()
export class CreateChazaUseCase {
  constructor(
    @Inject('IChazaRepository')
    private readonly chazaRepository: ChazaRepository,
    @Inject('IUserRepository')
    private readonly userRepository: UserRepository,
  ) {}

  async execute( 
    nombre: string,
    descripcion: string,
    ubicacion: string,
    foto_id: number,
    id_usuario: string,

  ): Promise<CreateChazaResponseDto> {
    try {
      

      const user = await this.userRepository.findUserById(id_usuario);
      if (!user) {
        throw new ErrorManager({
          message: 'User not found',
          type: 'BAD_REQUEST',
        });
      }

      const newChaza = new ChazaBuilder()
        .setNombre(nombre)
        .setDescripcion(descripcion)
        .setUbicacion(ubicacion)
        .setFotoId(foto_id)
        .setUsuario(user)
        .build();

      await this.chazaRepository.createChaza(newChaza);

      return {
        chaza: {
          nombre: newChaza.nombre,
          descripcion: newChaza.descripcion,
          ubicacion: newChaza.ubicacion,
          foto_id: newChaza.foto_id,
          id_usuario: newChaza.id_usuario.id,
        },
      };
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
