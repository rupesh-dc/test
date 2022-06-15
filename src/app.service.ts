import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';

@Injectable()
export class AppService {
  constructor(private httpService: HttpService) {}
  getHello(): string {
    this.httpService
      .get('https://cat-fact.herokuapp.com/facts')
      .subscribe((data) => console.log(data.data));
    return 'Hello World!';
  }
}
