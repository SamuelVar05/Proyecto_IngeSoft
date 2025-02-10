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


 
}
