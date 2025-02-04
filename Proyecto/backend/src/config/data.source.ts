import { ConfigService } from '@nestjs/config';
import { ConfigModule } from '@nestjs/config';
import { DataSource, DataSourceOptions } from 'typeorm';

if (process.env.NODE_ENV === 'development') {
  ConfigModule.forRoot({
    envFilePath: `.env.${process.env.NODE_ENV.trim()}`,
    isGlobal: true,
  });
} else {
  ConfigModule.forRoot({
    envFilePath: `.env.production`,
    isGlobal: true,
  });
}

const configService = new ConfigService();

export const DataSourceConfig: DataSourceOptions = {
  type: 'postgres',
  host: configService.get('DB_HOST'),
  port: configService.get('DB_PORT'),
  username: configService.get('DB_USER'),
  password: configService.get('DB_PASSWORD'),
  database: configService.get('DB_NAME'),
  entities: [__dirname + '/../**/**/*.entity{.ts,.js}'],
  migrations: [__dirname + '/../migrations/*{ .ts,.js}'],
  synchronize: true,
  //   ssl: true,
  logging: false,
};

export const AppDs = new DataSource(DataSourceConfig);
