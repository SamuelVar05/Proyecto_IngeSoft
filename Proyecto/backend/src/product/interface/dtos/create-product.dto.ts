import {
  IsNumber,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  max,
  Min,
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateProductDto {
  @ApiProperty({
    description: 'The name of the product',
    example: 'Chocolate Bar',
    type: String,
  })
  @IsString()
  name: string;

  @ApiProperty({
    description: 'The price of the product',
    example: 5000,
    minimum: 0,
    maximum: 10000000,
    type: Number,
  })
  @IsNumber()
  @Min(0)
  @Max(10000000)
  price: number;

  @ApiPropertyOptional({
    description: 'The barcode of the product (optional)',
    example: '7501234567890',
    type: String,
  })
  @IsOptional()
  @IsString()
  barcode?: string;

  @ApiProperty({
    description: 'The description of the product',
    example: 'Delicious chocolate bar made with premium cocoa',
    type: String,
  })
  @IsString()
  description: string;

  @ApiProperty({
    description: 'The UUID of the chaza (store) that sells this product',
    example: '123e4567-e89b-12d3-a456-426614174000',
    type: String,
  })
  @IsUUID()
  chazaId: string;

  @ApiProperty({
    description: 'The UUID of the category this product belongs to',
    example: '123e4567-e89b-12d3-a456-426614174001',
    type: String,
  })
  @IsUUID()
  categoryId: string;
}
