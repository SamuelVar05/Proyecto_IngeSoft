import { Delete, Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Category } from './domain/entites/category.entity';
import { CreateCategoryUseCase } from './application/use-cases/createCategory.use-case';
import { TypeOrmCategoryRepository } from './infrastructure/repositories/category.repository';
import { CategoryController } from './interface/controllers/category.controller';
import { getAllCategoriesUseCase } from './application/use-cases/getCategory.use-case';
import { deleteCategoryUseCase } from './application/use-cases/deleteCategory.use-case';
import { AuthModule } from 'src/auth/auth.module';
import { UserModule } from 'src/user/user.module';

@Module({
  imports: [TypeOrmModule.forFeature([Category]), AuthModule, UserModule],
  providers: [
    {
      provide: 'ICategoryRepository',
      useClass: TypeOrmCategoryRepository,
    },
    CreateCategoryUseCase,
    getAllCategoriesUseCase,
    deleteCategoryUseCase,
  ],
  controllers: [CategoryController],
})
export class CategoryModule {}
