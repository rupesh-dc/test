import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { HttpService } from '@nestjs/axios';

@Injectable()
export class AxiosInterceptor implements NestInterceptor {
  constructor(private readonly httpService: HttpService) {}
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    console.log('inside nest js interceptor');
    const axiosRef = this.httpService.axiosRef;
    axiosRef.interceptors.response.use(
      function (response) {
        console.log('Logging response form interceptor');
        return response;
      },
      function (error) {
        console.log('logging error form respnse interceptor catch block');
        return Promise.reject(error);
      },
    );
    return next.handle();
  }
}
