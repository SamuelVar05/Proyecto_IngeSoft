import { Chaza } from '../entities/chaza.entity';

export interface ChazaRepository {
  createChaza(chaza: Chaza): Promise<void>;
  findChazaById(id: string): Promise<Chaza | null>;
  updateChaza(id:string ,updateData: Chaza): Promise<Chaza|void>;
}
