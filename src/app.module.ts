import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { HttpModule } from './http.module';
import { AxiosInterceptor } from './axios.interceptor';
import { APP_INTERCEPTOR } from '@nestjs/core';

@Module({
  imports: [HttpModule],
  controllers: [AppController],
  providers: [
    AppService,
    // {
    //     provide: APP_INTERCEPTOR,
    //     useClass: AxiosInterceptor,
    // },
  ],
})
export class AppModule {}
