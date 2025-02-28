import { IsUUID } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class GetProductByUserParamDto {
  @IsUUID(4, { message: 'userId must be a valid UUID' })
  @ApiProperty({
    description: 'ID del usuario en formato UUID',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  userId: string;
}
