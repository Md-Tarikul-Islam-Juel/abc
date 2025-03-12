
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { XyzController } from './xyz/xyz.controller';
import { XyzService } from './xyz/xyz.service';
import { XyzModule } from './xyz/xyz.module';


@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    XyzModule,
  ],
  providers: [
    XyzService,
  ],
  controllers: [XyzController],
})
export class AppModule {
}