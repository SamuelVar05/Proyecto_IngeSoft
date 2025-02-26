import {
  IsNumber,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  max,
  Min,
} from 'class-validator';

export class CreateProductDto {
  @IsString()
  name: string;
  @IsNumber()
  @Min(0)
  @Max(10000000)
  price: number;

  @IsOptional()
  @IsString()
  barcode?: string;
  @IsString()
  description: string;
  @IsUUID()
  chazaId: string;
  @IsUUID()
  categoryId: string;
}
