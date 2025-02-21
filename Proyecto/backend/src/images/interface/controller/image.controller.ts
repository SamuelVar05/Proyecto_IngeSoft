import {
  Controller,
  Get,
  Param,
  Patch,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { FindAllImagesUseCase } from 'src/images/application/use-cases/findAll-images.use-case';
import { UpdateImageUseCase } from 'src/images/application/use-cases/update-image.use-case';
import { UploadImageUseCase } from 'src/images/application/use-cases/upload-image.use-case';

@Controller('image')
export class ImageController {
  constructor(
    private uploadImageUseCase: UploadImageUseCase,
    private readonly findAllImagesUseCase: FindAllImagesUseCase,
    private readonly updateImageUseCase: UpdateImageUseCase,
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

  @Patch('update/:id')
  @UseInterceptors(FileInterceptor('file'))
  async updateImage(
    @Param('id') imageId: string,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return this.updateImageUseCase.execute(imageId, file);
  }
}
