// src/product/infrastructure/repositories/product.repository.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Product } from 'src/product/domain/entities/product.entity';
import { ProductRepository } from 'src/product/domain/port/product.repository';
import { Repository, UpdateResult } from 'typeorm';

@Injectable()
export class TypeOrmProductRepository implements ProductRepository {
  constructor(
    @InjectRepository(Product)
    private readonly productRepository: Repository<Product>,
  ) {}
  async createProduct(product: Product): Promise<Product> {
    return await this.productRepository.save(product);
  }
  findProductById(id: string): Promise<Product | null> {
    return this.productRepository.findOne({
      where: {
        id,
      },
    });
  }
  async updateProduct(id: string, product: Product): Promise<boolean> {
    const updatedProduct = await this.productRepository.update(id, product);
    return updatedProduct.affected === 1;
  }
  async deleteProduct(id: string): Promise<boolean> {
    const productDeleted = await this.productRepository.delete(id);
    return productDeleted.affected === 1;
  }

  async findByCategoryId(categoryId: string): Promise<Product[]> {
    return this.productRepository.find({
      where: { category: { id: categoryId } },
    });
  }
}
