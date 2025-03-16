import { Controller, Get } from '@nestjs/common';

@Controller('xyz')
export class XyzController {

    @Get()
    getHello(): string {
        return 'hello world 5';
    }
}
