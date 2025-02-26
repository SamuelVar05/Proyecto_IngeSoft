import { Inject, Injectable } from '@nestjs/common';
import { CategoryRepository } from 'src/category/domain/port/category.repository';
import { CreateCategoryUseCaseDto } from '../dtos/createCategory.use-case.dto';
import { ErrorManager } from 'utils/ErrorManager';

@Injectable()
export class getAllCategoriesUseCase {
  constructor(
    @Inject('ICategoryRepository')
    private readonly categoryRepository: CategoryRepository,
  ) {}

  async execute(): Promise<CreateCategoryUseCaseDto[]> {
    try {
      const categories = await this.categoryRepository.listCategories();
      return categories;
    } catch (error) {
      console.log(error);
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
