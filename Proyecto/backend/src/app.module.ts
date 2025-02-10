import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { UserModule } from './user/user.module';
import { DataSourceConfig } from './config/data.source';
import { ProductModule } from './product/product.module';
import { ImageModule } from './images/images.module';
import { ChazaModule } from './chaza/chaza.module';

console.log(`NodeEnv : ${process.env.NODE_ENV?.trim()}`);
const envFilePath =
  process.env.NODE_ENV?.trim() === 'production' ? '.env' : '.env.development';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: envFilePath,
      isGlobal: true,
    }),
    TypeOrmModule.forRoot({ ...DataSourceConfig }),
    AuthModule,
    UserModule,
    ProductModule,
    ImageModule,
    ChazaModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
