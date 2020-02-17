import { Component, OnInit } from '@angular/core';
import Chart from 'chart.js';
import { ImagesService } from 'src/app/services/images.service';

// core components

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  public datasets: any;
  public data: any;
  public salesChart;

  images: any;
  constructor(public _serviceImage: ImagesService) { }

  ngOnInit() {

    this.getImages();
  }

  getImages() {
    this._serviceImage.get().subscribe(
      data => {
        console.log(data);
        this.images = data;
      }
    );
  }

  delete(id) {
    console.log('id', id);

    this._serviceImage.delete(id).subscribe(
      data => {
        console.log(data);
        this.getImages();
      }
    );
  }




}
