import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class AlbumsService {

  constructor(private http: HttpClient) { }

  get(): Observable<any> {
    const apiURL = 'http://localhost:5000/getAllAlbums';
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
  newAlbun(body: any) {
    const apiURL = 'http://localhost:5000/newAlbum?name=' + body.name + '&description=' + body.description;
    return this.http.post(apiURL, body).pipe(
      map((response: any) => {

        let resp: any;
        resp = response;
        console.log('newAlbun resp', resp);

        return resp;
      }), catchError(err => {
        let user_message;
        user_message = err;
        throw (user_message);
      })
    );
  }

  assocImageToAlbum(body) {
    const apiURL = 'http://localhost:5000/newImageToAlbum?tb_image_id_image=' +
      body.tb_image_id_image + '&tb_album_id_album=' + body.tb_album_id_album;
    return this.http.post(apiURL, body).pipe(
      map((response: any) => {

        let resp: any;
        resp = response;
        console.log('newAlbun resp', resp);

        return resp;
      }), catchError(err => {
        let user_message;
        user_message = err;
        throw (user_message);
      })
    );
  }
  public delete(idEntidad: any) {
    const apiURL = 'http://localhost:5000/album?id=' + idEntidad;
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
}
