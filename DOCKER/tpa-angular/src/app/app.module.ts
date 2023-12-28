import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MatTableModule} from '@angular/material/table';
import {MatIconModule} from "@angular/material/icon";
import { DashboardComponent } from './dashboard/dashboard.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { Stats1Component } from './stats1/stats1.component';
import { Stats2Component } from './stats2/stats2.component';
import { Stats3Component } from './stats3/stats3.component';
import { Stats4Component } from './stats4/stats4.component';
import { ChartsListComponent } from './charts-list/charts-list.component';
import {HttpClient, HttpClientModule} from "@angular/common/http";
import {MatInputModule} from "@angular/material/input";
@NgModule({
  declarations: [
    AppComponent,
    DashboardComponent,
    Stats1Component,
    Stats2Component,
    Stats3Component,
    Stats4Component,
    ChartsListComponent
  ],
    imports: [
        BrowserModule,
        BrowserAnimationsModule,
        MatTableModule,
        MatIconModule,
        NgbModule,
        HttpClientModule,
        MatInputModule
    ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
