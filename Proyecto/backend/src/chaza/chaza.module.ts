import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Chaza } from './domain/entities/chaza.entity';
import {CreateChazaUseCase} from './application/use-cases/create-chaza.use-case';
import { ChazaController } from './interface/controllers/chaza.controller';
import { TypeOrmChazaRepository } from './infrastructure/repositories/chaza.repository';
import { AuthModule } from '../auth/auth.module';


@Module({
  imports: [TypeOrmModule.forFeature([Chaza])],
  providers: [
    {
      provide: 'IChazaRepository',
      useClass: TypeOrmChazaRepository,
    },
    CreateChazaUseCase,
  ],
  controllers: [ChazaController],
  exports: ['IChazaRepository']
})
export class ChazaModule {}
