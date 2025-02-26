import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Category } from 'src/category/domain/entites/category.entity';

import { CategoryRepository } from 'src/category/domain/port/category.repository';
import { Repository } from 'typeorm';

@Injectable()
export class TypeOrmCategoryRepository implements CategoryRepository {
  constructor(
    @InjectRepository(Category)
    private readonly categoryRepository: Repository<Category>,
  ) {}
  async createCategory(category: Category): Promise<Category> {
    return await this.categoryRepository.save(category);
  }
  async deleteCategory(id: string): Promise<void> {
    await this.categoryRepository.delete(id);
  }
  async findCategoryById(id: string): Promise<Category | null> {
    return await this.categoryRepository.findOneBy({ id });
  }
  async findCategoryByName(name: string): Promise<Category | null> {
    return await this.categoryRepository.findOneBy({ name });
  }
  listCategories(): Promise<Category[]> {
    return this.categoryRepository.find();
  }
  updateCategory(category: Category): Promise<Category> {
    return this.categoryRepository.save(category);
  }
}
