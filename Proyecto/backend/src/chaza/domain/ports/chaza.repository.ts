import { Chaza } from '../entities/chaza.entity';

export interface ChazaRepository {
  createChaza(chaza: Chaza): Promise<void>;
  findChazaById(id: string): Promise<Chaza | null>;
  updateChaza(id:string ,updateData: Chaza): Promise<Chaza|void>;
  deleteChaza(id: string): Promise<void>;
  findChazasByUserId(userId: string): Promise<Chaza[]>;
}
