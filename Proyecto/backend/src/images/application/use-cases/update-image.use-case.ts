import { Inject, Injectable } from '@nestjs/common';
import { ImageRepository } from 'src/images/domain/ports/image.repository';

@Injectable()
export class UpdateImageUseCase {
  constructor(
    @Inject('IImageRepository')
    private readonly imageRepository: ImageRepository,
  ) {}

  async execute(iamgeId: string, file: Express.Multer.File): Promise<string> {
    return 'hello world';
  }
}
