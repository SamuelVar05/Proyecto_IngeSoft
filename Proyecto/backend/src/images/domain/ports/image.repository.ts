export interface ImageRepository {
  uploadImage(file: Express.Multer.File): Promise<string>;
  deleteImage(imageUrl: string): Promise<void>;
  findAllImages(): Promise<string[]>;
}
