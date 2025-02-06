import { Inject } from '@nestjs/common';
import { ProductBuilder } from 'src/product/domain/builders/product.builder';
import { Product } from 'src/product/domain/entities/product.entity';
import { ProductRepository } from 'src/product/domain/port/product.repository';
import { CreateProductDto } from 'src/product/interface/dtos/create-product.dto';
import { ErrorManager } from 'utils/ErrorManager';

export class CreateProductUseCase {
  constructor(
    @Inject('IProductRepository')
    private readonly productRepository: ProductRepository,
  ) {}
  async execute(product: CreateProductDto) {
    try {
      const { categoryId, name, price } = product;

      const newProduct = new ProductBuilder()
        .setCategory(categoryId)
        .setName(name)
        .setPrice(price)
        .build();

      await this.productRepository.createProduct(newProduct);
      return newProduct;
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
