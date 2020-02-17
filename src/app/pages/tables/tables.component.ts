import { Component, OnInit } from '@angular/core';
import { AlbumsService } from 'src/app/services/albums.service';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { ImagesService } from 'src/app/services/images.service';
import { Router } from '@angular/router';
 
@Component({
  selector: 'app-tables',
  templateUrl: './tables.component.html',
  styleUrls: ['./tables.component.scss']
})
export class TablesComponent implements OnInit {
  showTable: boolean;
  albums: any;
  showAlertDFelete: boolean;
  images: any;
  addImageAlbum: Array<any>;
  public FormEntity: FormGroup;

  constructor(private _serviceAlbums: AlbumsService, private _serviceImage: ImagesService, private router:Router) {
    this.initForm();
    this.showTable = true;
    this.showAlertDFelete = false;
    this.addImageAlbum = [];

  }

  ngOnInit() {
    this.getAlbums();
    this.getImages();
  }

  goToAlbums(id) {
     
    this.router.navigate(['/maps', id]);
   }
  /**
   * Albums funtions
   */
  getAlbums() {
    this._serviceAlbums.get().subscribe(
      data => {
        console.log(data);
        this.albums = data;
      }
    );
  }
  deleteAlbum(id) {
    console.log('id_album', id);

    this._serviceAlbums.delete(id).subscribe(
      data => {
        this.showAlert();
        console.log(data);
        this.getAlbums();
      }
    );
  }

  newAlbun() {

    let formValue;
    console.log(this.FormEntity);

    formValue = this.FormEntity.value;
    if (this.FormEntity.valid) {
      console.log('formValue', formValue);
      this.saveAlbum(formValue);
      this.showTable = true;
      this.getAlbums();

    } else {
      // alerta
    }

  }

  saveAlbum(body) {
    this._serviceAlbums.newAlbun(body).subscribe(
      data => {
        console.log('saveAlbum', data);
        if (this.addImageAlbum.length > 0) {
          this.addImageAlbum.forEach(element => {
            // this.assocImageToAlbum(data.id_album, element);
            body = {
              id_album: data.id_album,
              id_image: element,
            };
            this._serviceAlbums.assocImageToAlbum(body).subscribe(
              datas => {
                console.log('assocImageToAlbum', datas);
              },
              err => {
                console.log(err);

              }
            );
          });
        }
        this.showAlert();
        this.getAlbums();
      }
    );
  }

  assocImageToAlbum(id_album, id_photo) {
    let body;
    body = {
      tb_album_id_album: id_album,
      tb_image_id_image: id_photo,
    };
    this._serviceAlbums.assocImageToAlbum(body).subscribe(
      data => {
        console.log('assocImageToAlbum', data);
      }
    );

  }
  /**
   * Images funtions
   */
  getImages() {
    this._serviceImage.get().subscribe(
      data => {
        console.log(data);
        this.images = data;
      }
    );
  }
  /**
   * alert funtions
   */
  showAlert() {
    this.showAlertDFelete = true;
    setTimeout(() => {
      this.showAlertDFelete = false;
    }, 3000);
  }
  closeAlert() {
    this.showAlertDFelete = false;
  }
  /**
   * inti fomr
   */
  private initForm() {

    this.FormEntity = new FormGroup({
      name: new FormControl('', [
        Validators.required,
        Validators.maxLength(100)
      ]),
      description: new FormControl('', [
        Validators.maxLength(100)
      ])
    });




  }
  // add image to array
  addImageToalbum(id) {
    let i = this.addImageAlbum.indexOf(id);

    if (i !== -1) {
      this.addImageAlbum.splice(i, 1);
      console.log('entro eliminar iten arr');
    } else {
      this.addImageAlbum.push(id);
    }
    console.log(this.addImageAlbum);
  }
  // R emoe image to array
  reomveImagenFromArray(id) {

  }

}
