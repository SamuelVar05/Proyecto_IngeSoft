import { Inject, Injectable, NotFoundException, BadRequestException, InternalServerErrorException } from '@nestjs/common';
import { ChazaRepository } from 'src/chaza/domain/ports/chaza.repository';
import { UpdateChazaResponseDto } from 'src/chaza/interface/controllers/update-chaza-response.dto';
import { ErrorManager } from 'utils/ErrorManager';
import { ChazaBuilder } from 'src/chaza/domain/builders/chaza.builder';
import { Chaza } from 'src/chaza/domain/entities/chaza.entity';
import { CreateChazaDto } from 'src/chaza/interface/dtos/create-chaza.dto';
import { User } from 'src/user/domain/entities/user.entity';

@Injectable()
export class UpdateChazaUseCase {
  constructor(
    @Inject('IChazaRepository')
    private readonly chazaRepository: ChazaRepository,
  ) {}

  async execute(idChaza: string, 
    descripcion:string ,
    nombre:string,
    ubicacion:string,
    foto_id:number |undefined,
    id_usuario:string): Promise<UpdateChazaResponseDto> {
    try {
      // Buscar la chaza por ID
      const chaza = await this.chazaRepository.findChazaById(idChaza);
      if (!chaza) {
        throw new NotFoundException({
          status: 'error',
          message: 'La chaza con el ID proporcionado no existe.',
        });
      }

      // // Validar que los datos no estén vacíos NECESARIO?
      // if (!updateChazaDto || Object.keys(updateChazaDto).length === 0) {
      //   throw new BadRequestException({
      //     status: 'error',
      //     message: 'Datos inválidos. Por favor verifica los campos requeridos.',
      //   });
      // }

      // Actualizar la chaza con los nuevos datos
      const updatedChaza = new ChazaBuilder()
        .setNombre(nombre)
        .setDescripcion(descripcion)
        .setUbicacion(ubicacion)
        .setFotoId(foto_id)
        .setUsuario(id_usuario)
        .build();


      await this.chazaRepository.updateChaza(idChaza, updatedChaza);
      
      return {
        // status: 'success',
        // message: 'Chaza actualizada exitosamente',
        chaza: {
          chazaId: updatedChaza.id,
          nombre: updatedChaza.nombre,
          descripcion: updatedChaza.descripcion,
          ubicacion: updatedChaza.ubicacion,
          foto_id: updatedChaza.foto_id,
          id_usuario: updatedChaza.id_usuario,
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
