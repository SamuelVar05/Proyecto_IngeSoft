import { Inject, Injectable, NotFoundException, BadRequestException, InternalServerErrorException } from '@nestjs/common';
import { ChazaRepository } from 'src/chaza/domain/ports/chaza.repository';
import { UpdateChazaResponseDto } from 'src/chaza/interface/controllers/update-chaza-response.dto';
import { ErrorManager } from 'utils/ErrorManager';
import { ChazaBuilder } from 'src/chaza/domain/builders/chaza.builder';


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
        throw new ErrorManager({
          type: 'BAD_REQUEST',
          message: 'La chaza con el ID proporcionado no existe.',
        });
      }


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
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
