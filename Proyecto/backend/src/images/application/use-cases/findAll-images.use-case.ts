import { Inject, Injectable } from '@nestjs/common';
import { ImageRepository } from 'src/images/domain/ports/image.repository';

@Injectable()
export class FindAllImagesUseCase {
  constructor(
    @Inject('IImageRepository')
    private readonly imageRepository: ImageRepository,
  ) {}
  async execute(): Promise<string[]> {
    return this.imageRepository.findAllImages();
  }
}
