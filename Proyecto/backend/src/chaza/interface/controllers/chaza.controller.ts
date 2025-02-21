import { Controller, Post, Body, UseGuards, Headers } from '@nestjs/common';
import { CreateChazaUseCase } from 'src/chaza/application/use-cases/create-chaza.use-case';
import { CreateChazaDto } from '../dtos/create-chaza.dto';
import { ApiResponse } from 'types/ApiResponse';
import { CreateChazaResponseDto } from 'src/chaza/interface/controllers/create-chaza-response.dto';
import {
  ApiOperation,
  ApiResponse as SwaggerResponse,
  ApiTags,
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/infrastructure/guards/Jwt-auth.guard';

@ApiTags('Chazas')
@Controller('chazas')
export class ChazaController {
  constructor(private readonly createChazaUseCase: CreateChazaUseCase) {}

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
}
