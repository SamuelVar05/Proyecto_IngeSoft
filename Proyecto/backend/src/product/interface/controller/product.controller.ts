import {
  Controller,
  Post,
  Body,
  Get,
  UseGuards,
  Delete,
  Patch,
  Param,
  ValidationPipe,
} from '@nestjs/common';
import { CreateProductUseCase } from 'src/product/application/use-cases/create-product.use-case';
import { CreateProductDto } from '../dtos/create-product.dto';
import {
  ApiOperation,
  ApiResponse as SwaggerResponse,
  ApiTags,
  ApiParam,
} from '@nestjs/swagger';
import { ApiResponse } from 'types/ApiResponse';
import { getProductsUseCase } from 'src/product/application/use-cases/getProduct.use-case';
import { CreateProductUseCaseDto } from 'src/product/application/dtos/createProduct.dto';
import { GetAllProductsDto } from 'src/product/application/dtos/getAllProducts.dto';
import { GetProductByUserUseCase } from 'src/product/application/use-cases/getProductByUse.use-case';
import { GetProductByUserDto } from 'src/product/application/dtos/getProducyByUser.dto';
import { GetProductByUserParamDto } from '../dtos/get-product-by-user.dto';

@ApiTags('Products')
@Controller('product')
export class ProductController {
  constructor(
    private readonly createProductUseCase: CreateProductUseCase,
    private readonly getProductsUseCase: getProductsUseCase,
    private readonly getProductByUseUseCase: GetProductByUserUseCase,
  ) {}

  @Post('create')
  @ApiOperation({ summary: 'Create a new product' })
  @SwaggerResponse({
    status: 201,
    description: 'Product successfully created',
    schema: {
      example: {
        success: true,
        data: {
          name: 'Example Product',
          price: 99.99,
          description: 'This is an example product',
          chazaId: '1234-5678-90ab-cdef',
          categoryId: '2345-6789-01bc-defg',
        },
        message: 'Product created successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 400,
    description: 'Bad request - Invalid input data',
    schema: {
      example: {
        statusCode: 400,
        message: 'BAD_REQUEST :: Invalid product data',
      },
    },
  })
  async createProduct(
    @Body() product: CreateProductDto,
  ): Promise<ApiResponse<CreateProductUseCaseDto>> {
    const productResponse = await this.createProductUseCase.execute(product);
    return {
      data: productResponse,
      message: 'Product created successfully',
      success: true,
    };
  }

  @Get('')
  @ApiOperation({ summary: 'Get all products' })
  @SwaggerResponse({
    status: 200,
    description: 'List of products retrieved successfully',
    schema: {
      example: {
        success: true,
        data: [
          {
            id: '1234-5678-90ab-cdef',
            name: 'Example Product 1',
            price: 99.99,
            description: 'This is an example product',
          },
          {
            id: '2345-6789-01bc-defg',
            name: 'Example Product 2',
            price: 149.99,
            description: 'This is another example product',
          },
        ],
        message: 'Products retrieved successfully',
      },
    },
  })
  async getProducts(): Promise<ApiResponse<GetAllProductsDto[]>> {
    const products = await this.getProductsUseCase.execute();
    return {
      success: true,
      data: products,
      message: 'Products retrieved successfully',
    };
  }

  @Get('/:id')
  @ApiOperation({ summary: 'Get product by ID' })
  @SwaggerResponse({
    status: 200,
    description: 'Product retrieved successfully',
    schema: {
      example: {
        success: true,
        data: {
          id: '1234-5678-90ab-cdef',
          name: 'Example Product',
          price: 99.99,
          description: 'This is an example product',
        },
        message: 'Product retrieved successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Product not found',
    schema: {
      example: {
        statusCode: 404,
        message: 'NOT_FOUND :: Product not found',
      },
    },
  })
  getProductById(@Param('id') id: string) {}

  @Delete('/:id')
  @ApiOperation({ summary: 'Delete product by ID' })
  @SwaggerResponse({
    status: 200,
    description: 'Product deleted successfully',
    schema: {
      example: {
        success: true,
        data: null,
        message: 'Product deleted successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Product not found',
    schema: {
      example: {
        statusCode: 404,
        message: 'NOT_FOUND :: Product not found',
      },
    },
  })
  deleteProduct(@Param('id') id: string) {}

  @Patch('update')
  @ApiOperation({ summary: 'Update product information' })
  @SwaggerResponse({
    status: 200,
    description: 'Product updated successfully',
    schema: {
      example: {
        success: true,
        data: {
          id: '1234-5678-90ab-cdef',
          name: 'Updated Product Name',
          price: 129.99,
          description: 'This is an updated product description',
        },
        message: 'Product updated successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 400,
    description: 'Bad request - Invalid input data',
    schema: {
      example: {
        statusCode: 400,
        message: 'BAD_REQUEST :: Invalid product data',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Product not found',
    schema: {
      example: {
        statusCode: 404,
        message: 'NOT_FOUND :: Product not found',
      },
    },
  })
  updateProduct() {}

  @Get('user/:userId')
  @ApiOperation({ summary: 'Get products by user ID' })
  @ApiParam({
    name: 'userId',
    type: String,
    description: 'ID del usuario en formato UUID',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  @SwaggerResponse({
    status: 200,
    description: 'List of products retrieved successfully',
    schema: {
      example: {
        success: true,
        data: [
          {
            id: '1234-5678-90ab-cdef',
            name: 'Example Product 1',
            price: 99.99,
            description: 'This is an example product',
            barcode: '123456789',
          },
          {
            id: '2345-6789-01bc-defg',
            name: 'Example Product 2',
            price: 149.99,
            description: 'This is another example product',
            barcode: '987654321',
          },
        ],
        message: 'Products retrieved successfully',
      },
    },
  })
  @SwaggerResponse({
    status: 404,
    description: 'Products not found or user has no products',
    schema: {
      example: {
        statusCode: 404,
        message: 'NOT_FOUND :: Product not found',
      },
    },
  })
  @SwaggerResponse({
    status: 400,
    description: 'Bad request - Invalid user ID',
    schema: {
      example: {
        statusCode: 400,
        message: 'BAD_REQUEST :: Invalid user ID format',
      },
    },
  })
  async getProductsByUserId(
    @Param(ValidationPipe) params: GetProductByUserParamDto,
  ): Promise<ApiResponse<GetProductByUserDto[]>> {
    const productsData = await this.getProductByUseUseCase.execute(
      params.userId,
    );
    return {
      success: true,
      data: productsData,
      message: 'Products retrieved successfully',
    };
  }
}
