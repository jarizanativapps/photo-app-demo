import { Component, OnInit } from '@angular/core';
import { ImagesService } from 'src/app/services/images.service';
import { ActivatedRoute, Router } from '@angular/router';

declare const google: any;

@Component({
  selector: 'app-maps',
  templateUrl: './maps.component.html',
  styleUrls: ['./maps.component.scss']
})
export class MapsComponent implements OnInit {
  images: Array<any>;
  sub: any;
  id: any;
  constructor(public _serviceImage: ImagesService, private route: ActivatedRoute, private router: Router) { 
    this.images = [];
  }

  ngOnInit() {
    this.sub = this.route.params.subscribe(params => {
      this.id = +params['id']; // (+) converts string 'id' to a number
      this.getImages(this.id);
      // In a real app: dispatch action to load the details here.
    });
  }

  getImages(id) {
    this.images = [];
    this._serviceImage.getImageByAlbum(id).subscribe(
      data => {
        console.log(data);
        this.images = data;
      }
    );
  }
  back() {
    this.router.navigate(['/tables']);
  }

}
