import {Component, OnInit} from '@angular/core';
import { animate, state, style, transition, trigger } from "@angular/animations";
import {ApiService} from "../../services/api.service";
import {DataSource} from "@angular/cdk/collections";
import {MatTableDataSource} from "@angular/material/table";


export interface Marque {
  nom: string;
  nbVehicles: string;
}

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
  animations: [
    trigger('detailExpand', [
      state('collapsed', style({height: '0px', minHeight: '0'})),
      state('expanded', style({height: '*'})),
      transition('expanded <=> collapsed', animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')),
    ]),
  ],
})

export class DashboardComponent implements OnInit{
  columnsToDisplay = ['nom', 'nbModel'];
  expandedElement: Marque | null;
  columnsToDisplayWithExpand = [...this.columnsToDisplay, 'expand'];
  marques: MatTableDataSource<Marque>;

  constructor(private apiService: ApiService) { }

  ngOnInit() {
    this.apiService.getMarquesList().subscribe((res: any) => {
      this.marques = new MatTableDataSource(res);
    })

  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.marques.filter = filterValue.trim().toLowerCase();
  }
}

