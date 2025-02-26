import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { CreateCategoryUseCaseDto } from 'src/category/application/dtos/createCategory.use-case.dto';
import { CreateCategoryUseCase } from 'src/category/application/use-cases/createCategory.use-case';
import { deleteCategoryUseCase } from 'src/category/application/use-cases/deleteCategory.use-case';
import { getAllCategoriesUseCase } from 'src/category/application/use-cases/getCategory.use-case';
import { Category } from 'src/category/domain/entites/category.entity';
import { ApiResponse } from 'types/ApiResponse';
import { CreateCategoryDto } from '../dtos/createCategory.dto';

@Controller('category')
export class CategoryController {
  constructor(
    private readonly createCategoryUseCase: CreateCategoryUseCase,
    private readonly getAllCategoriesUseCase: getAllCategoriesUseCase,
    private readonly deleteCategoryUseCase: deleteCategoryUseCase,
  ) {}

  @Post('create')
  async createProduct(
    @Body() category: CreateCategoryDto,
  ): Promise<ApiResponse<CreateCategoryUseCaseDto>> {
    const categoryData = await this.createCategoryUseCase.execute(category);
    return {
      data: categoryData,
      message: 'Category created successfully',
      success: true,
    };
  }

  @Get('list')
  async getCategories(): Promise<ApiResponse<CreateCategoryUseCaseDto[]>> {
    const categories = await this.getAllCategoriesUseCase.execute();
    return {
      data: categories,
      message: 'Categories retrieved successfully',
      success: true,
    };
  }

  @Delete('delete/:id')
  async deleteCategory(@Param() id: string): Promise<ApiResponse<[]>> {
    await this.deleteCategoryUseCase.execute(id);
    return {
      data: [],
      message: 'Category deleted successfully',
      success: true,
    };
  }

  @Patch('update')
  async updateCategory(
    @Body() category: Category,
  ): Promise<ApiResponse<CreateCategoryUseCaseDto>> {
    const categoryData = await this.createCategoryUseCase.execute(category);
    return {
      data: categoryData,
      message: 'Category updated successfully',
      success: true,
    };
  }
}
