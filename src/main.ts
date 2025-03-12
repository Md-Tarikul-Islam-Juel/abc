import {NestFactory} from '@nestjs/core';
import {AppModule} from './app.module';
import {ValidationPipe} from '@nestjs/common';


async function bootstrap() {
  const app = await NestFactory.create(AppModule, {abortOnError: false});

  // Enable CORS
  app.enableCors({
    origin: ['http://localhost:3000', 'http://your-web-app.com', 'http://your-mobile-app.com'],
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
    credentials: true
  });

  //validate all incoming packets based on all DTOs
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true
      // disableErrorMessages:true
      // transform: true,
    })
  );


  await app.listen(3000);
}

bootstrap();
