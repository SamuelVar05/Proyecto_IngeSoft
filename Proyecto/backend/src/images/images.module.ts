import { Module } from '@nestjs/common';
import { SupabaseImageRepository } from './infrastructure/repositories/image.repositories';
import { UploadImageUseCase } from './application/use-cases/upload-image.use-case';
import { ImageController } from './interface/controller/image.controller';
import { FindAllImagesUseCase } from './application/use-cases/findAll-images.use-case';

@Module({
  imports: [],
  providers: [
    {
      provide: 'IImageRepository',
      useClass: SupabaseImageRepository,
    },
    UploadImageUseCase,
    FindAllImagesUseCase,
  ],
  controllers: [ImageController],
})
export class ImageModule {}
