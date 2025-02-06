import { Controller, Post, Body, Get, UseGuards } from '@nestjs/common';
import { CreateProductUseCase } from 'src/product/application/use-cases/create-product.use-case';
import { CreateProductDto } from '../dtos/create-product.dto';

@Controller('product')
export class ProductController {
  constructor(private readonly createProductUseCase: CreateProductUseCase) {}
  @Post('create')
  createProduct(@Body() product: CreateProductDto) {
    return this.createProductUseCase.execute(product);
  }
}
