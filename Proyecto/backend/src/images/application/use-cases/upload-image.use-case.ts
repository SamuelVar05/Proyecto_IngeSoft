import { Inject, Injectable } from '@nestjs/common';
import { ImageRepository } from 'src/images/domain/ports/image.repository';

@Injectable()
export class UploadImageUseCase {
  constructor(
    @Inject('IImageRepository')
    private readonly imageRepository: ImageRepository,
  ) {}
  async execute(file: Express.Multer.File): Promise<string> {
    return this.imageRepository.uploadImage(file);
  }
}
