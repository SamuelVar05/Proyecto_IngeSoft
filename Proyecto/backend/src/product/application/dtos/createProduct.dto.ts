export interface CreateProductUseCaseDto {
  name: string;
  price: number;
  description: string;
  barcode?: string;
  categoryId: string;
  chazaId: string;
}
