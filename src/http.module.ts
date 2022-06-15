import { Logger, Module, OnModuleInit } from '@nestjs/common';
import { HttpModule as BaseHttpModule, HttpService } from '@nestjs/axios';

@Module({
  imports: [BaseHttpModule],
  exports: [BaseHttpModule],
})
export class HttpModule implements OnModuleInit {
  constructor(private readonly httpService: HttpService) {}

  public onModuleInit(): any {
    console.log('logging form on module init');
    const axios = this.httpService.axiosRef;
    axios.interceptors.response.use(
      (response) => {
        console.log('logging from axios interceptor.');
        return response;
      },
      (err) => {
        console.log(err);
        return Promise.reject(err);
      },
    );
  }
}
