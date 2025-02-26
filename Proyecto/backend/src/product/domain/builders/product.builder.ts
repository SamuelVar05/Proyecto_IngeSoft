import { Chaza } from 'src/chaza/domain/entities/chaza.entity';

import { Product } from '../entities/product.entity';
import { Category } from 'src/category/domain/entites/category.entity';

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
  setChazaId(chazaId: string): ProductBuilder {
    this.product.chaza = new Chaza();
    this.product.chaza.id = chazaId;
    return this;
  }
  setDescription(description: string): ProductBuilder {
    this.product.description = description;
    return this;
  }
  setBarcode(barcode: string): ProductBuilder {
    this.product.barcode = barcode;
    return this;
  }
  build(): Product {
    return this.product;
  }
}
