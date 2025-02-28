import { Inject, Injectable } from '@nestjs/common';
import { ProductRepository } from 'src/product/domain/port/product.repository';
import { ErrorManager } from 'utils/ErrorManager';
import { GetAllProductsDto } from '../dtos/getAllProducts.dto';

@Injectable()
export class getProductsUseCase {
  constructor(
    @Inject('IProductRepository')
    private readonly productRepository: ProductRepository,
  ) {}
  async execute(): Promise<GetAllProductsDto[]> {
    try {
      const products = await this.productRepository.getProducts();
      return products.map((product) => ({
        name: product.name,
        price: product.price,
        description: product.description,
        barcode: product.barcode,
        categoryId: product.category?.id || '',
        chazaId: product.chaza?.id || '',
      }));
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
