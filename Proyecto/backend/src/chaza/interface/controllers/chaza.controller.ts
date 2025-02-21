import { Controller, Post, Body, UseGuards, Headers, Param, Get,Delete, NotFoundException, InternalServerErrorException, BadRequestException,Put } from '@nestjs/common';
import { CreateChazaUseCase } from 'src/chaza/application/use-cases/create-chaza.use-case';
import { CreateChazaDto } from '../dtos/create-chaza.dto';
import { ApiResponse } from 'types/ApiResponse';
import { CreateChazaResponseDto } from 'src/chaza/interface/controllers/create-chaza-response.dto';
import { GetChazaByIdUseCase } from 'src/chaza/application/use-cases/get_chaza_by_id.use-case'; 
import {
  ApiOperation,
  ApiResponse as SwaggerResponse,
  ApiTags,
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/infrastructure/guards/Jwt-auth.guard';
import { findChazaByIdChazaResponseDto } from './find-chaza-by-id-response.dto';
import { UpdateChazaUseCase } from 'src/chaza/application/use-cases/update-chaza.use-case';
import { UpdateChazaResponseDto } from './update-chaza-response.dto';
import { UpdateChazaDto } from '../dtos/update-chaza.dto';
import { DeleteChazaUseCase } from 'src/chaza/application/use-cases/delete-chaza.use-case';
// import { UpdateChazaDto } from ;
import {DeleteChazaResponseDto} from './delete-chaza-response.dto';

@ApiTags('Chazas')
@Controller('chazas')
export class ChazaController {
  constructor(private readonly createChazaUseCase: CreateChazaUseCase, private readonly getChazaUseCase:GetChazaByIdUseCase,private readonly updateChazaUseCase: UpdateChazaUseCase, readonly deleteChazaUseCase: DeleteChazaUseCase ) {}

  @Post('/')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Create a new chaza' })
  @SwaggerResponse({
    status: 201,
    description: 'Chaza successfully created',
    schema: {
      example: {
        success: true,
        data: {
          chaza: {
            nombre: 'Puesto de Tacos',
            descripcion: 'Venta de tacos mexicanos',
            ubicacion: 'Calle 45 #12-30, Bogotá',
            foto_id: 1,
            id_usuario: 'bb1452f2-8ffa-4624-90d0-0bab55f80352',
          },
        },
        message: 'Chaza created successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 400,
    description: 'Bad request - Invalid input data',
    schema: {
      example: {
        statusCode: 400,
        message: 'BAD_REQUEST :: Invalid chaza data',
      },
    },
  })
  
  async createChaza(
    @Body() body: CreateChazaDto,
    
  ): Promise<ApiResponse<CreateChazaResponseDto>> {
    const responseUseCase = await this.createChazaUseCase.execute(
      body.nombre,
      body.descripcion || '',
      body.ubicacion || '',
      body.foto_id || 0,
      body.id_usuario.toString(),
    );

    return {
      success: true,
      data: responseUseCase,
      message: 'Chaza created successfully',
    };
  }


  // ----------------------------------------


  @Get('/:idChaza')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get chaza details' })
  @SwaggerResponse({
    status: 200,
    description: 'Chaza found successfully',
    schema: {
      example: {
        status: 'success',
        data: {
          id_chaza: 789,
          nombre: 'La Esquina del Sabor',
          descripcion: 'Deliciosas comidas rápidas y bebidas refrescantes.',
          ubicacion: 'Bloque A, primer piso',
          foto: 'https://ejemplo.com/foto_chaza.jpg',
          id_vendedor: 456,
          horario: 'Lunes a Viernes, 8:00 AM - 6:00 PM',
          medios_pago: 'Efectivo, Tarjeta, Transferencia',
          puntuacion_promedio: 4.5,
        },
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Chaza not found',
    schema: {
      example: {
        status: 'error',
        message: 'La chaza con el ID proporcionado no existe.',
      },
    },
  })
  @SwaggerResponse({
    status: 500,
    description: 'Internal server error',
    schema: {
      example: {
        status: 'error',
        message: 'No se pudo encontrar la chaza debido a un error interno.',
      },
    },
  })
  async getChaza(@Param('idChaza') idChaza: string): Promise<ApiResponse<findChazaByIdChazaResponseDto>> {

      const chaza = await this.getChazaUseCase.execute(idChaza);
  
      return {
        success: true,
        data: chaza,
        message: 'Chaza find successfully',
      };

  }

  // -------------------------------------
  @Put('/:idChaza')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Update an existing chaza' })
  @SwaggerResponse({
    status: 200,
    description: 'Chaza successfully updated',
    schema: {
      example: {
        status: 'success',
        message: 'Chaza actualizada exitosamente',
      },
    },
  })
  @SwaggerResponse({
    status: 400,
    description: 'Bad request - Invalid input data',
    schema: {
      example: {
        status: 'error',
        message: 'Datos inválidos. Por favor verifica los campos requeridos.',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Chaza not found',
    schema: {
      example: {
        status: 'error',
        message: 'La chaza con el ID proporcionado no existe.',
      },
    },
  })
  @SwaggerResponse({
    status: 500,
    description: 'Internal server error',
    schema: {
      example: {
        status: 'error',
        message: 'No se pudo actualizar la chaza debido a un error interno.',
      },
    },
  })
  async updateChaza(@Param('idChaza') idChaza: string, @Body() body: UpdateChazaDto): Promise<ApiResponse<UpdateChazaResponseDto>> {
    
 

      const updatedChaza = await this.updateChazaUseCase.execute(idChaza,body.descripcion,body.nombre,body.ubicacion,body.foto_id,body.id_usuario.toString()); 

      return {
        success: true,
        data: updatedChaza,
        message: 'Chaza updated successfully',
      };

  }

  // -----------------------------------
  @Delete('/:idChaza')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Delete an existing chaza' })

  @SwaggerResponse({
    status: 200,
    description: 'Chaza successfully deleted',
    schema: {
      example: {
        status: 'success',
        message: 'Chaza eliminada exitosamente',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Chaza not found',
    schema: {
      example: {
        status: 'error',
        message: 'La chaza con el ID proporcionado no existe.',
      },
    },
  })
  @SwaggerResponse({
    status: 500,
    description: 'Internal server error',
    schema: {
      example: {
        status: 'error',
        message: 'No se pudo eliminar la chaza debido a un error interno.',
      },
    },
  })
  async deleteChaza(
    @Param('idChaza') idChaza: string
  ): Promise<ApiResponse<DeleteChazaResponseDto>> {
    
      const wasDeleted = await this.deleteChazaUseCase.execute(idChaza);

      return {
        success: true,
        data: { message: 'Chaza eliminada exitosamente',
          status: 'success'
         },
        message: 'Chaza deleted successfully',
      };
   
  }

}
