import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as morgan from 'morgan';
import { ConfigService } from '@nestjs/config';
import { ValidationPipe } from '@nestjs/common';
import { NestExpressApplication } from '@nestjs/platform-express';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  app.disable('x-powered-by');
  app.enableCors();
  app.use(morgan('dev'));
  app.setGlobalPrefix('api');
  app.useGlobalPipes(new ValidationPipe());

  const configService = app.get(ConfigService);
  await app.listen(configService.get('PORT') ?? 3000);
  console.log(`PORT ${configService.get('PORT')}`);
  console.log(`Application is running on ${await app.getUrl()}`);
}
bootstrap();
