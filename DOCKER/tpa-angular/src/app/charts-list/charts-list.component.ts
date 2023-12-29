import {Component, Input, OnInit} from '@angular/core';
import {ApiService} from "../../services/api.service";

@Component({
  selector: 'app-charts-list',
  templateUrl: './charts-list.component.html',
  styleUrls: ['./charts-list.component.scss']
})
export class ChartsListComponent implements OnInit{
  isLoading: boolean = false;
  dataChart1: any;
  dataChart2: any;
  dataChart3: any;
  dataChart4: any;

  constructor(private apiService: ApiService) { }

  @Input() marque:string;
  ngOnInit() {
    this.loadData();
  }

  loadData(){
      this.apiService.getPrixParMarque(this.marque).subscribe((data: any[])=>{
      this.dataChart1 = data;
    })

    this.apiService.getCouleursParMarque(this.marque).subscribe((data: any[])=>{
      this.dataChart2 = data;
    } )

    this.apiService.getPuissanceParMarque(this.marque).subscribe((data: any[])=>{
      this.dataChart3 = data;
    })

    this.apiService.getVentesParMarque(this.marque).subscribe((data: any[])=>{
      this.dataChart4 = data;
    })
}
}
