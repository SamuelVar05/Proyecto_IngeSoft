import { TypeOrmModule } from '@nestjs/typeorm';

import { Module } from '@nestjs/common';
import { TypeOrmProductRepository } from './infrastructure/repositories/product.repository';
import { Product } from './domain/entities/product.entity';
import { Category } from './domain/entities/category.entity';
import { CreateProductUseCase } from './application/use-cases/create-product.use-case';

@Module({
  imports: [TypeOrmModule.forFeature([Product, Category])],
  providers: [
    {
      provide: 'IProductRepository',
      useClass: TypeOrmProductRepository,
    },
    CreateProductUseCase,
  ],
  controllers: [],
})
export class ProductModule {}
