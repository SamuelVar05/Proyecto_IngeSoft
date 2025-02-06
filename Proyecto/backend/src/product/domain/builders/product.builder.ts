import { Category } from '../entities/category.entity';
import { Product } from '../entities/product.entity';

export class ProductBuilder {
  private product: Product;
  constructor() {
    this.product = new Product();
  }
  setName(name: string): ProductBuilder {
    this.product.name = name;
    return this;
  }
  setPrice(price: number): ProductBuilder {
    this.product.price = price;
    return this;
  }
  setCategory(categoryId: string): ProductBuilder {
    this.product.category = new Category();
    this.product.category.id = categoryId;
    return this;
  }
  build(): Product {
    return this.product;
  }
}
