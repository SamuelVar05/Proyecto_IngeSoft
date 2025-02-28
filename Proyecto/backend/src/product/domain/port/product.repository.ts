import { Product } from '../entities/product.entity';

export interface ProductRepository {
  createProduct(product: Product): Promise<Product>;
  findProductById(id: string): Promise<Product | null>;
  updateProduct(id: string, product: Product): Promise<boolean>;
  deleteProduct(id: string): Promise<boolean>;
  getProducts(): Promise<Product[]>;
  findProductByName(name: string): Promise<Product | null>;
  findProductsByUserId(userId: string): Promise<Product[]>;
}
