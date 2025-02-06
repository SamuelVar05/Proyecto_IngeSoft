import { Module } from '@nestjs/common';
import { TypeOrmProductRepository } from './infrastructure/repositories/product.repository';

@Module({
  imports: [],
  providers: [
    {
      provide: 'IProductRepository',
      useClass: TypeOrmProductRepository,
    },
  ],
  controllers: [],
  exports: ['IUserRepository'],
})
export class UserModule {}
