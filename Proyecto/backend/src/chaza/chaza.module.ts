import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Chaza } from './domain/entities/chaza.entity';
import {CreateChazaUseCase} from './application/use-cases/create-chaza.use-case';
import { ChazaController } from './interface/controllers/chaza.controller';
import { TypeOrmChazaRepository } from './infrastructure/repositories/chaza.repository';
import { AuthModule } from '../auth/auth.module';
import { UserModule } from 'src/user/user.module';
import { GetChazaByIdUseCase } from './application/use-cases/get_chaza_by_id.use-case';


@Module({
  imports: [TypeOrmModule.forFeature([Chaza]),UserModule,forwardRef(() => AuthModule)],
  providers: [
    {
      provide: 'IChazaRepository',
      useClass: TypeOrmChazaRepository,
    },
    CreateChazaUseCase,
    GetChazaByIdUseCase
  ],
  controllers: [ChazaController],
  exports: ['IChazaRepository']
})
export class ChazaModule {}
