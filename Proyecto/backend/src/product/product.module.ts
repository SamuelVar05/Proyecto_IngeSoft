import { TypeOrmModule } from '@nestjs/typeorm';

import { Module } from '@nestjs/common';
import { TypeOrmProductRepository } from './infrastructure/repositories/product.repository';
import { Product } from './domain/entities/product.entity';

import { CreateProductUseCase } from './application/use-cases/create-product.use-case';
import { Chaza } from 'src/chaza/domain/entities/chaza.entity';
import { ProductController } from './interface/controller/product.controller';
import { Category } from 'src/category/domain/entites/category.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Product, Category, Chaza])],
  providers: [
    {
      provide: 'IProductRepository',
      useClass: TypeOrmProductRepository,
    },
    CreateProductUseCase,
  ],
  controllers: [ProductController],
})
export class ProductModule {}
