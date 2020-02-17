import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';


@Injectable({
  providedIn: 'root'
})
export class ImagesService {
  private images$ = new Subject<any>();
  constructor(private http: HttpClient) { }

  get(): Observable<any> {
    const apiURL = 'http://localhost:5000/getAllImages';
    return this.http.get(apiURL).pipe(
      map((response: any) => {
        let resp: any;
        resp = response;

        return resp;
      }), catchError(err => {
        let user_message;
        user_message = err;
        throw (user_message);
      })
    );
  }

  getImageByAlbum(id): Observable<any> {
    const apiURL = 'http://localhost:5000/getImageByAlbum?id=' + id;
    return this.http.get(apiURL).pipe(
      map((response: any) => {
        let resp: any;
        resp = response;

        return resp;
      }), catchError(err => {
        let user_message;
        user_message = err;
        throw (user_message);
      })
    );
  }

  public delete(idEntidad: any) {
    const apiURL = 'http://localhost:5000/image?id=' + idEntidad;
    return this.http.delete(apiURL).pipe(
      map((response: any) => {
        let resp: any;
        resp = response;
        return resp;
      }), catchError(err => {
        let user_message;
        user_message = err;
        throw (user_message);
      })
    );
  }
  newImage(body) {
    console.log('body img', body);

    const apiURL = 'http://localhost:5000/newImage?file=' + body.file + '&description=' + body.description;
    return this.http.post(apiURL, body).pipe(
      map((response: any) => {

        let resp: any;
        resp = response;
        console.log('newImage resp', resp);

        return resp;
      }), catchError(err => {
        let user_message;
        user_message = err;
        throw (user_message);
      })
    );
  }
}
