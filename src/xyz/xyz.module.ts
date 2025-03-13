import { Module } from '@nestjs/common';
import { XyzController } from './xyz.controller';  // Import the controller
import { XyzService } from './xyz.service';  // Import the service

@Module({
    controllers: [XyzController],  // Register the controller
    providers: [XyzService],  // Register the service
})
export class XyzModule {}
