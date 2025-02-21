import { Chaza } from '../entities/chaza.entity';

export interface ChazaRepository {
  createChaza(chaza: Chaza): Promise<void>;
}
