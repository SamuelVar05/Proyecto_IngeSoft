import { Inject, Injectable } from '@nestjs/common';
import { Product } from 'src/product/domain/entities/product.entity';
import { ProductRepository } from 'src/product/domain/port/product.repository';
import { ErrorManager } from 'utils/ErrorManager';
import { GetProductByUserDto } from '../dtos/getProducyByUser.dto';

@Injectable()
export class GetProductByUserUseCase {
  constructor(
    @Inject('IProductRepository')
    private readonly productRepository: ProductRepository,
  ) {}

  async execute(id: string): Promise<GetProductByUserDto[]> {
    try {
      const product = await this.productRepository.findProductsByUserId(id);
      if (product === null || product === undefined) {
        throw new ErrorManager({
          message: 'Product not found',
          type: 'NOT_FOUND',
        });
      }
      return product;
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
