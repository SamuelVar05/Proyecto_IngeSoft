import { Inject, Injectable, NotFoundException, BadRequestException, InternalServerErrorException } from '@nestjs/common';
import { ChazaRepository } from 'src/chaza/domain/ports/chaza.repository';
import { UpdateChazaResponseDto } from 'src/chaza/interface/controllers/update-chaza-response.dto';
import { ErrorManager } from 'utils/ErrorManager';
import { ChazaBuilder } from 'src/chaza/domain/builders/chaza.builder';
import { Chaza } from 'src/chaza/domain/entities/chaza.entity';
import { CreateChazaDto } from 'src/chaza/interface/dtos/create-chaza.dto';

@Injectable()
export class UpdateChazaUseCase {
  constructor(
    @Inject('IChazaRepository')
    private readonly chazaRepository: ChazaRepository,
  ) {}

  async execute(idChaza: string, updateChazaDto: CreateChazaDto): Promise<UpdateChazaResponseDto> {
    try {
      // Buscar la chaza por ID
      const chaza = await this.chazaRepository.findChazaById(idChaza);
      if (!chaza) {
        throw new NotFoundException({
          status: 'error',
          message: 'La chaza con el ID proporcionado no existe.',
        });
      }

      // Validar que los datos no estén vacíos
      if (!updateChazaDto || Object.keys(updateChazaDto).length === 0) {
        throw new BadRequestException({
          status: 'error',
          message: 'Datos inválidos. Por favor verifica los campos requeridos.',
        });
      }

      // Actualizar la chaza con los nuevos datos
      const udpatedChaza = new ChazaBuilder()
        .setNombre(updateChazaDto.nombre)
        .setDescripcion(updateChazaDto.descripcion)
        .setUbicacion(updateChazaDto.ubicacion)
        .setFotoId(updateChazaDto.foto_id)
        .setUsuario(updateChazaDto.id_usuario)
        .build();


      await this.chazaRepository.updateChaza(idChaza, udpatedChaza);
      
      return {
        // status: 'success',
        // message: 'Chaza actualizada exitosamente',
        chaza: {
          chazaId: udpatedChaza.id,
          nombre: udpatedChaza.nombre,
          descripcion: udpatedChaza.descripcion,
          ubicacion: udpatedChaza.ubicacion,
          foto_id: udpatedChaza.foto_id,
          id_usuario: udpatedChaza.id_usuario.id,
        },
      };
    } catch (error) {
      if (error instanceof NotFoundException || error instanceof BadRequestException) {
        throw error;
      }
      throw new InternalServerErrorException({
        status: 'error',
        message: 'No se pudo actualizar la chaza debido a un error interno.',
      });
    }
  }
}
