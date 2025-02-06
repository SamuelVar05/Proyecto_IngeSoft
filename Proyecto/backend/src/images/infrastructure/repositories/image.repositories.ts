// src/image/infrastructure/supabase-image.repository.ts
import { Injectable } from '@nestjs/common';
import { createClient } from '@supabase/supabase-js';
import { ImageRepository } from '../../domain/ports/image.repository';
import path from 'path';

@Injectable()
export class SupabaseImageRepository implements ImageRepository {
  private readonly supabase;
  private bucketName;

  constructor() {
    this.supabase = createClient(
      process.env.SUPABASE_URL!,
      process.env.SUPABASE_KEY!,
    );
    this.bucketName = process.env.SUPABASE_BUCKET_NAME!;
  }

  async uploadImage(file: Express.Multer.File): Promise<string> {
    const filePath = `images/${Date.now()}-${file.originalname}`;
    const { data, error } = await this.supabase.storage
      .from(this.bucketName)
      .upload(filePath, file.buffer, {
        contentType: file.mimetype,
      });

    if (error) {
      throw new Error(`Failed to upload image: ${error.message}`);
    }

    return this.supabase.storage.from(this.bucketName).getPublicUrl(data.path)
      .data.publicUrl;
  }

  async deleteImage(imageUrl: string): Promise<void> {
    const fileName = imageUrl.split('/').pop();
    const { error } = await this.supabase.storage
      .from(this.bucketName)
      .remove([fileName]);
    if (error) {
      throw new Error(`Failed to delete image: ${error.message}`);
    }
  }

  async findAllImages(): Promise<string[]> {
    const bucketName = process.env.SUPABASE_BUCKET_NAME!;
    console.log(this.bucketName);
    const { data, error } = await this.supabase.storage
      .from(this.bucketName)
      .list('images/');
    if (error) {
      throw new Error(`Failed to list images: ${error.message}`);
    }
    console.log(data);
    return data;
  }
}
