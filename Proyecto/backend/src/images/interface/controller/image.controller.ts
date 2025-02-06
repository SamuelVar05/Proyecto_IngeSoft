import {
  Controller,
  Get,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { FindAllImagesUseCase } from 'src/images/application/use-cases/findAll-images.use-case';
import { UploadImageUseCase } from 'src/images/application/use-cases/upload-image.use-case';

@Controller('image')
export class ImageController {
  constructor(
    private uploadImageUseCase: UploadImageUseCase,
    private readonly findAllImagesUseCase: FindAllImagesUseCase,
  ) {}

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  async uploadImage(@UploadedFile() file: Express.Multer.File) {
    return this.uploadImageUseCase.execute(file);
  }

  @Get('findAll')
  async findAllImages() {
    return this.findAllImagesUseCase.execute();
  }
}
