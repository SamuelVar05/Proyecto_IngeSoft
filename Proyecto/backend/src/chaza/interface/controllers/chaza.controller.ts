import { Controller, Post, Body, UseGuards, Headers, Param, Get, NotFoundException, InternalServerErrorException } from '@nestjs/common';
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

@ApiTags('Chazas')
@Controller('chazas')
export class ChazaController {
  constructor(private readonly createChazaUseCase: CreateChazaUseCase, private readonly getChazaUseCase:GetChazaByIdUseCase ) {}

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
    // @Headers('Authorization') token: string,
  ): Promise<ApiResponse<CreateChazaResponseDto>> {
    const responseUseCase = await this.createChazaUseCase.execute(
      body.nombre,
      body.descripcion || '',
      body.ubicacion || '',
      body.foto_id || 0,
      body.id_usuario,
    );

    return {
      success: true,
      data: responseUseCase,
      message: 'Chaza created successfully',
    };
  }


  // ----------------------------------------

  // constructor(private readonly getChazaUseCase:GetChazaByIdUseCase ) {}
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
    try {
      console.log(idChaza);
      const a = typeof idChaza;
      console.log(a);
      const chaza = await this.getChazaUseCase.execute(idChaza);
      // console.log(chaza);
      console.log(idChaza);
      if (!chaza) {
        throw new NotFoundException({
          status: 'error',
          message: 'La chaza con el ID proporcionado no existe.',
        });
      }
      return {
        success: true,
        data: chaza,
        message: 'Chaza find successfully',
      };
    } catch (error) {
      throw new InternalServerErrorException({
        status: 'error',
        message: 'No se pudo encontrar la chaza debido a un error interno.assadasdasdsadsadsad',
        
      });
    }
  }




}
