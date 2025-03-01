// src/user/infrastructure/repositories/user.repository.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Chaza } from '../../domain/entities/chaza.entity';
import { ChazaRepository } from '../../domain/ports/chaza.repository';
import { Repository } from 'typeorm';

@Injectable()
export class TypeOrmChazaRepository implements ChazaRepository {
  constructor(
    @InjectRepository(Chaza)
    private readonly chazaRepository: Repository<Chaza>,
  ) {}


  async createChaza(chaza: Chaza): Promise<void> {
    await this.chazaRepository.save(chaza);
  }

  
  async findChazaById(id: string): Promise<Chaza | null> {
    return this.chazaRepository.findOne({ where: { id } });
  }
  
  async updateChaza (id: string, updateData: Chaza): Promise<void | Chaza> {
    const chaza = await this.chazaRepository.findOne({ where: { id } });

    if (!chaza) {
      console.log('Chaza not found');
      return ;
    }

    // await 

    await this.chazaRepository.update(id, updateData);
    return updateData
  }

  async deleteChaza(id: string): Promise<void> {
    await this.chazaRepository.delete(id);}


    async findChazasByUserId(userId: string): Promise<Chaza[]> {
      return await this.chazaRepository
        .createQueryBuilder('chaza')
        .innerJoin('chaza.id_usuario', 'user')
        .where('user.id = :userId', { userId })
        .leftJoinAndSelect('chaza.products', 'product') // Opcional: cargar productos
        .getMany();
    }
}
