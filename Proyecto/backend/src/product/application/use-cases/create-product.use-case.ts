import { Inject, Injectable } from '@nestjs/common';
import { ProductBuilder } from 'src/product/domain/builders/product.builder';
import { Product } from 'src/product/domain/entities/product.entity';
import { ProductRepository } from 'src/product/domain/port/product.repository';
import { CreateProductDto } from 'src/product/interface/dtos/create-product.dto';
import { ErrorManager } from 'utils/ErrorManager';
import { CreateProductUseCaseDto } from '../dtos/createProduct.dto';

@Injectable()
export class CreateProductUseCase {
  constructor(
    @Inject('IProductRepository')
    private readonly productRepository: ProductRepository,
  ) {}
  async execute(product: CreateProductDto): Promise<CreateProductUseCaseDto> {
    try {
      const { categoryId, chazaId, description, name, price, barcode } =
        product;

      const productExists =
        await this.productRepository.findProductByName(name);

      if (productExists) {
        throw new ErrorManager({
          message: 'Product already exists',
          type: 'CONFLICT',
        });
      }

      const newProduct = new ProductBuilder()
        .setName(name)
        .setDescription(description)
        .setCategory(categoryId)
        .setChazaId(chazaId)
        .setPrice(price)
        .build();

      barcode != null ? (newProduct.barcode = barcode) : null;

      await this.productRepository.createProduct(newProduct);

      return {
        name: newProduct.name,
        price: newProduct.price,
        description: newProduct.description,
        barcode: newProduct.barcode,
        categoryId: categoryId,
        chazaId: chazaId,
      };
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
