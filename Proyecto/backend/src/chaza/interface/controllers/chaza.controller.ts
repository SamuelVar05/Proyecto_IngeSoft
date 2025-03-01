import { Controller, Post, Body, UseGuards, Headers, Param, Get,Delete,ValidationPipe, NotFoundException, InternalServerErrorException, BadRequestException,Put } from '@nestjs/common';
import { CreateChazaUseCase } from 'src/chaza/application/use-cases/create-chaza.use-case';
import { CreateChazaDto } from '../dtos/create-chaza.dto';
import { ApiResponse } from 'types/ApiResponse';
import { CreateChazaResponseDto } from 'src/chaza/interface/controllers/create-chaza-response.dto';
import { GetChazaByIdUseCase } from 'src/chaza/application/use-cases/get_chaza_by_id.use-case'; 
import {
  ApiOperation,
  ApiResponse as SwaggerResponse,
  ApiTags,ApiParam, ApiBody
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/infrastructure/guards/Jwt-auth.guard';
import { findChazaByIdChazaResponseDto } from './find-chaza-by-id-response.dto';
import { UpdateChazaUseCase } from 'src/chaza/application/use-cases/update-chaza.use-case';
import { UpdateChazaResponseDto } from './update-chaza-response.dto';
import { UpdateChazaDto } from '../dtos/update-chaza.dto';
import { DeleteChazaUseCase } from 'src/chaza/application/use-cases/delete-chaza.use-case';
// import { UpdateChazaDto } from ;
import {DeleteChazaResponseDto} from './delete-chaza-response.dto';
import {GetChazasByUserParamDto} from '../dtos/get.chaza-by-user.dto';
import { Chaza } from 'src/chaza/domain/entities/chaza.entity';
import { GetChazasByUserUseCase } from 'src/chaza/application/use-cases/getChazastByUser.use-case';

@ApiTags('Chazas')
@Controller('chazas')
export class ChazaController {
  constructor(private readonly createChazaUseCase: CreateChazaUseCase, private readonly getChazaUseCase:GetChazaByIdUseCase,private readonly updateChazaUseCase: UpdateChazaUseCase, readonly deleteChazaUseCase: DeleteChazaUseCase,
    private readonly getChazasByUserUseCase: GetChazasByUserUseCase
   ) {}

   @Post('/create')
   @UseGuards(AuthGuard)
   @ApiOperation({ summary: 'Crear una nueva chaza' })
   @ApiBody({
     description: 'Datos para la creación de una chaza',
     schema: {
       example: {
         nombre: 'Puesto de Tacos',
         descripcion: 'Venta de tacos mexicanos',
         ubicacion: 'Calle 45 #12-30, Bogotá',
         foto_id: 1,
         id_usuario: 'bb1452f2-8ffa-4624-90d0-0bab55f80352',
       },
     },
   })
   @SwaggerResponse({
     status: 201,
     description: 'Chaza creada exitosamente',
     schema: {
       example: {
         success: true,
         message: 'Chaza creada exitosamente',
         data: {
           chaza: {
             chazaId: 'a1b2c3d4-e5f6-7890-ab12-cd34ef56gh78',
             nombre: 'Puesto de Tacos',
             descripcion: 'Venta de tacos mexicanos',
             ubicacion: 'Calle 45 #12-30, Bogotá',
             foto_id: 1,
             id_usuario: 'bb1452f2-8ffa-4624-90d0-0bab55f80352',
           },
         },
       },
     },
   })
   @SwaggerResponse({
     status: 400,
     description: 'Solicitud incorrecta - Datos inválidos',
     schema: {
       example: {
         success: false,
         message: 'BAD_REQUEST :: Invalid chaza data',
       },
     },
   })
   @SwaggerResponse({
     status: 500,
     description: 'Error interno del servidor',
     schema: {
       example: {
         success: false,
         message: 'No se pudo crear la chaza debido a un error interno.',
       },
     },
   })
   async createChaza(
     @Body() body: CreateChazaDto
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
       message: 'Chaza creada exitosamente',
     };
   }
   


  // ----------------------------------------


  @Get('/get/:idChaza')
@UseGuards(AuthGuard)
@ApiOperation({ summary: 'Obtener detalles de una chaza' })
@ApiParam({
  name: 'idChaza',
  type: String,
  description: 'ID de la chaza en formato UUID',
  example: '4acc014c-05a3-4536-8895-858f9cf0d339',
})
@SwaggerResponse({
  status: 200,
  description: 'Chaza encontrada exitosamente',
  schema: {
    example: {
      success: true,
      message: 'Chaza encontrada exitosamente',
      data: {
        id: '4acc014c-05a3-4536-8895-858f9cf0d339',
        nombre: 'La Esquina del Sabor',
        descripcion: 'Deliciosas comidas rápidas y bebidas refrescantes.',
        ubicacion: 'Bloque A, primer piso',
        foto_id: 2,
        id_usuario: '123e4567-e89b-12d3-a456-426614174000',
      },
    },
  },
})
@SwaggerResponse({
  status: 404,
  description: 'Chaza no encontrada',
  schema: {
    example: {
      success: false,
      message: 'La chaza con el ID proporcionado no existe.',
    },
  },
})
@SwaggerResponse({
  status: 500,
  description: 'Error interno del servidor',
  schema: {
    example: {
      success: false,
      message: 'No se pudo obtener la chaza debido a un error interno.',
    },
  },
})
async getChaza(
  @Param('idChaza') idChaza: string
): Promise<ApiResponse<findChazaByIdChazaResponseDto>> {
  const chaza = await this.getChazaUseCase.execute(idChaza);

  return {
    success: true,
    data: chaza,
    message: 'Chaza encontrada exitosamente',
  };
}


  // -------------------------------------
  @Put('/update/:idChaza')
@UseGuards(AuthGuard)
@ApiOperation({ summary: 'Actualizar una chaza existente' })
@ApiParam({
  name: 'idChaza',
  type: String,
  description: 'ID de la chaza a actualizar (UUID)',
  example: '4acc014c-05a3-4536-8895-858f9cf0d339',
})
@ApiBody({
  description: 'Datos para actualizar la chaza',
  schema: {
    example: {
      nombre: 'Nueva Chaza',
      descripcion: 'Venta de comida rápida',
      ubicacion: 'Calle 123, Ciudad',
      foto_id: 2,
      id_usuario: '123e4567-e89b-12d3-a456-426614174000',
    },
  },
})
@SwaggerResponse({
  status: 200,
  description: 'Chaza actualizada correctamente',
  schema: {
    example: {
      success: true,
      message: 'Chaza actualizada exitosamente',
      data: {
        chazaId: '4acc014c-05a3-4536-8895-858f9cf0d339',
        nombre: 'Nueva Chaza',
        descripcion: 'Venta de comida rápida',
        ubicacion: 'Calle 123, Ciudad',
        foto_id: 2,
        id_usuario: '123e4567-e89b-12d3-a456-426614174000',
      },
    },
  },
})
@SwaggerResponse({
  status: 400,
  description: 'Solicitud incorrecta - Datos inválidos',
  schema: {
    example: {
      success: false,
      message: 'Datos inválidos. Verifica los campos requeridos.',
    },
  },
})
@SwaggerResponse({
  status: 404,
  description: 'Chaza no encontrada',
  schema: {
    example: {
      success: false,
      message: 'La chaza con el ID proporcionado no existe.',
    },
  },
})
@SwaggerResponse({
  status: 500,
  description: 'Error interno del servidor',
  schema: {
    example: {
      success: false,
      message: 'No se pudo actualizar la chaza debido a un error interno.',
    },
  },
})
async updateChaza(
  @Param('idChaza') idChaza: string, 
  @Body() body: UpdateChazaDto
): Promise<ApiResponse<UpdateChazaResponseDto>> {
  const updatedChaza = await this.updateChazaUseCase.execute(
    idChaza,
    body.descripcion,
    body.nombre,
    body.ubicacion,
    body.foto_id,
    body.id_usuario.toString()
  );

  return {
    success: true,
    data: updatedChaza,
    message: 'Chaza actualizada exitosamente',
  };
}


  // -----------------------------------
  @Delete('/delete/:idChaza')
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

  @Get('user/:userId')
  @ApiOperation({ summary: 'Get chazas by user ID' })
  @ApiParam({
    name: 'userId',
    type: String,
    description: 'ID del usuario en formato UUID',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  @SwaggerResponse({
    status: 200,
    description: 'List of chazas retrieved successfully',
    schema: {
      example: {
        success: true,
        data: [
          {
            id: 'abcd-efgh-ijkl-mnop',
            nombre: 'Chaza de Ejemplo',
            descripcion: 'Venta de productos artesanales',
            ubicacion: 'Plaza Central',
            foto_id: 1,
          },
          {
            id: 'qrst-uvwx-yzab-cdef',
            nombre: 'Otra Chaza',
            descripcion: 'Venta de comida rápida',
            ubicacion: 'Calle 10',
            foto_id: 2,
          },
        ],
        message: 'Chazas retrieved successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Chazas not found or user has no chazas',
    schema: {
      example: {
        statusCode: 404,
        message: 'NOT_FOUND :: Chazas not found',
      },
    },
  })
  @SwaggerResponse({
    status: 400,
    description: 'Bad request - Invalid user ID',
    schema: {
      example: {
        statusCode: 400,
        message: 'BAD_REQUEST :: Invalid user ID format',
      },
    },
  })
  async getChazasByUserId(
    @Param(ValidationPipe) params: GetChazasByUserParamDto,
  ): Promise<ApiResponse<Chaza[]>> {
    const chazasData = await this.getChazasByUserUseCase.execute(
      params.userId,
    );
    return {
      success: true,
      data: chazasData,
      message: 'Chazas retrieved successfully',
    };
  }


}
