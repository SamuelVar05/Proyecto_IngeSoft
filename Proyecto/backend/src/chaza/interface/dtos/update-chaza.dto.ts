import { ApiProperty } from '@nestjs/swagger';
import { User } from '@supabase/supabase-js';
import { IsNotEmpty, IsString, IsOptional, IsInt, IsUUID } from 'class-validator';

export class UpdateChazaDto {
  @ApiProperty({
    example: 'bb1452f2-8ffa-4624-90d0-0bab55f80352',
    description: 'ID único de la chaza',
  })
  @IsString()
  @IsNotEmpty()
  id_usuario: string;


  @ApiProperty({
    example: 'Puesto de Tacos',
    description: 'Nombre de la chaza',
  })
  @IsNotEmpty()
  @IsString()
  nombre: string;

  @ApiProperty({
    example: 'Venta de tacos mexicanos',
    description: 'Descripción breve de la chaza',
  })
  // @IsOptional()
  @IsString()
  descripcion: string;

  @ApiProperty({
    example: 'Calle 45 #12-30, Bogotá',
    description: 'Ubicación de la chaza',
  })
  @IsOptional()
  @IsString()
  ubicacion: string;

  @ApiProperty({
    example: 1,
    description: 'ID de la foto asociada a la chaza',
  })
  @IsOptional()
  @IsInt()
  foto_id?: number;
}
