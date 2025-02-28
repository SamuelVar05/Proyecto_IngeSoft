import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import { CreateCategoryUseCaseDto } from 'src/category/application/dtos/createCategory.use-case.dto';
import { CreateCategoryUseCase } from 'src/category/application/use-cases/createCategory.use-case';
import { deleteCategoryUseCase } from 'src/category/application/use-cases/deleteCategory.use-case';
import { getAllCategoriesUseCase } from 'src/category/application/use-cases/getCategory.use-case';
import { Category } from 'src/category/domain/entites/category.entity';
import { ApiResponse } from 'types/ApiResponse';
import { CreateCategoryDto } from '../dtos/createCategory.dto';
import {
  ApiOperation,
  ApiResponse as SwaggerResponse,
  ApiTags,
  ApiParam,
  ApiExcludeEndpoint,
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/infrastructure/guards/Jwt-auth.guard';

@ApiTags('Categories')
@Controller('category')
@UseGuards(AuthGuard)
export class CategoryController {
  constructor(
    private readonly createCategoryUseCase: CreateCategoryUseCase,
    private readonly getAllCategoriesUseCase: getAllCategoriesUseCase,
    private readonly deleteCategoryUseCase: deleteCategoryUseCase,
  ) {}

  @Post('create')
  @ApiOperation({ summary: 'Create a new category' })
  @SwaggerResponse({
    status: 201,
    description: 'Category created successfully',
    schema: {
      example: {
        success: true,
        data: {
          id: 'e87ef3f1-1f2a-4b6f-b381-4ea3c40b6d3a',
          name: 'Electronics',
          description: 'Electronic devices and accessories',
        },
        message: 'Category created successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 400,
    description: 'Bad request - Invalid input data',
    schema: {
      example: {
        statusCode: 400,
        message: 'BAD_REQUEST :: Invalid category data',
      },
    },
  })
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
  @ApiOperation({ summary: 'Get all categories' })
  @SwaggerResponse({
    status: 200,
    description: 'Categories retrieved successfully',
    schema: {
      example: {
        success: true,
        data: [
          {
            id: 'e87ef3f1-1f2a-4b6f-b381-4ea3c40b6d3a',
            name: 'Electronics',
            description: 'Electronic devices and accessories',
          },
          {
            id: 'a12bc3d4-5e6f-7g8h-9i0j-klmno1pqrst',
            name: 'Food',
            description: 'Food and beverages',
          },
        ],
        message: 'Categories retrieved successfully',
      },
    },
  })
  async getCategories(): Promise<ApiResponse<CreateCategoryUseCaseDto[]>> {
    const categories = await this.getAllCategoriesUseCase.execute();
    return {
      data: categories,
      message: 'Categories retrieved successfully',
      success: true,
    };
  }

  @Delete('delete/:id')
  @ApiOperation({ summary: 'Delete a category by ID' })
  @ApiParam({
    name: 'id',
    description: 'Category ID',
    example: 'e87ef3f1-1f2a-4b6f-b381-4ea3c40b6d3a',
  })
  @SwaggerResponse({
    status: 200,
    description: 'Category deleted successfully',
    schema: {
      example: {
        success: true,
        data: [],
        message: 'Category deleted successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Category not found',
    schema: {
      example: {
        statusCode: 404,
        message: 'NOT_FOUND :: Category not found',
      },
    },
  })
  async deleteCategory(@Param() id: string): Promise<ApiResponse<[]>> {
    await this.deleteCategoryUseCase.execute(id);
    return {
      data: [],
      message: 'Category deleted successfully',
      success: true,
    };
  }

  @Patch('update')
  @ApiExcludeEndpoint()
  @ApiOperation({ summary: 'Update a category' })
  @SwaggerResponse({
    status: 200,
    description: 'Category updated successfully',
    schema: {
      example: {
        success: true,
        data: {
          id: 'e87ef3f1-1f2a-4b6f-b381-4ea3c40b6d3a',
          name: 'Updated Electronics',
          description: 'Updated description for electronic devices',
        },
        message: 'Category updated successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Category not found',
    schema: {
      example: {
        statusCode: 404,
        message: 'NOT_FOUND :: Category not found',
      },
    },
  })
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
