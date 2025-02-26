import { Inject, Injectable } from '@nestjs/common';
import { CategoryRepository } from 'src/category/domain/port/category.repository';
import { ErrorManager } from 'utils/ErrorManager';

@Injectable()
export class deleteCategoryUseCase {
  constructor(
    @Inject('ICategoryRepository')
    private readonly categoryRepository: CategoryRepository,
  ) {}
  async execute(categoryId: string): Promise<void> {
    try {
      const categoryData =
        await this.categoryRepository.deleteCategory(categoryId);
      return categoryData;
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
