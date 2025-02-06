import { Category } from 'src/product/domain/entities/category.entity';
import { Product } from '../entities/product.entity';

export interface CategoryRepository {
  createCategory(category: Category): Promise<Category>;
  findCategoryById(id: string): Promise<Category | null>;
  findCategoryByName(name: string): Promise<Category | null>;
  listCategories(): Promise<Category[]>;
  updateCategory(category: Category): Promise<Category>;
  deleteCategory(id: string): Promise<void>;
}
