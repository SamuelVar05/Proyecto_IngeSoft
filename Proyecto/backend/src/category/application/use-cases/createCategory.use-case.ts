import { Inject, Injectable } from '@nestjs/common';
import { Category } from 'src/category/domain/entites/category.entity';
import { CategoryRepository } from 'src/category/domain/port/category.repository';
import { ErrorManager } from 'utils/ErrorManager';
import { CreateCategoryUseCaseDto } from '../dtos/createCategory.use-case.dto';
import { CreateCategoryDto } from 'src/category/interface/dtos/createCategory.dto';
import { CategoryBuilder } from 'src/category/domain/builders/category.builder';

@Injectable()
export class CreateCategoryUseCase {
  constructor(
    @Inject('ICategoryRepository')
    private readonly categoryRepository: CategoryRepository,
  ) {}

  async execute(
    categoryDto: CreateCategoryDto,
  ): Promise<CreateCategoryUseCaseDto> {
    try {
      const { name } = categoryDto;
      const categoryExists =
        await this.categoryRepository.findCategoryByName(name);

      if (categoryExists) {
        throw new ErrorManager({
          message: 'Category already exists',
          type: 'BAD_REQUEST',
        });
      }

      // Create a new Category entity from the DTO
      const category = new CategoryBuilder()
        .setDescription(categoryDto.description)
        .setName(categoryDto.name)
        .build();

      return (await this.categoryRepository.createCategory(
        category,
      )) as CreateCategoryUseCaseDto;
    } catch (error) {
      throw ErrorManager.createSignatureError(error.message);
    }
  }
}
