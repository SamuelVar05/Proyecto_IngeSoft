import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as morgan from 'morgan';
import { ConfigService } from '@nestjs/config';
import { ValidationPipe } from '@nestjs/common';
import { NestExpressApplication } from '@nestjs/platform-express';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  //configure the app and set some security settings
  app.disable('x-powered-by');
  app.enableCors();
  app.use(morgan('dev'));
  app.setGlobalPrefix('api');
  app.useGlobalPipes(new ValidationPipe());

  //configure Swagger in the app
  const config = new DocumentBuilder()
    .setTitle('Api Ingesoft')
    .setDescription('This is the API for the Ingesoft project')
    .setVersion('1.0')
    .addTag('Ingesoft')
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api/docs', app, document);

  const configService = app.get(ConfigService);
  await app.listen(configService.get('PORT') ?? 3000);
  console.log(`PORT ${configService.get('PORT')}`);
  console.log(`Application is running on ${await app.getUrl()}`);
}
bootstrap();
