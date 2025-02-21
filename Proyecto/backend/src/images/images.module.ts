import { Module } from '@nestjs/common';
import { SupabaseImageRepository } from './infrastructure/repositories/image.repositories';
import { UploadImageUseCase } from './application/use-cases/upload-image.use-case';
import { ImageController } from './interface/controller/image.controller';
import { FindAllImagesUseCase } from './application/use-cases/findAll-images.use-case';
import { UpdateImageUseCase } from './application/use-cases/update-image.use-case';

@Module({
  imports: [],
  providers: [
    {
      provide: 'ImageRepository',
      useClass: SupabaseImageRepository,
    },
    UploadImageUseCase,
    FindAllImagesUseCase,
    UpdateImageUseCase,
  ],
  controllers: [ImageController],
})
export class ImageModule {}
