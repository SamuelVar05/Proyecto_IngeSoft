import { Category } from "../entites/category.entity";

export interface CategoryRepository {
  createCategory(category: Category): Promise<Category>;
  findCategoryById(id: string): Promise<Category | null>;
  findCategoryByName(name: string): Promise<Category | null>;
  listCategories(): Promise<Category[]>;
  updateCategory(category: Category): Promise<Category>;
  deleteCategory(id: string): Promise<void>;
}
