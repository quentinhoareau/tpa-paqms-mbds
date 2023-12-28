import { Injectable } from '@angular/core';
import {Observable, of} from 'rxjs';
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class ApiService{
    private apiUrl = 'http://localhost:5004/api';

    constructor(private http: HttpClient) { }

  getMarquesList(){

    return this.http.get(`${this.apiUrl}/getAllMarque`);
  }

  getVentesParMarque(marque: string): Observable<any> {


    return this.http.get(`${this.apiUrl}/ventes-par-marque/${marque}`);
  }

  getPrixParMarque(marque: string): Observable<any> {


    return this.http.get(`${this.apiUrl}/prix-par-marque/${marque}`);
  }

  getCouleursParMarque(marque: string): Observable<any> {


    return this.http.get(`${this.apiUrl}/couleurs-par-marque/${marque}`);
  }

  getPuissanceParMarque(marque: string): Observable<any> {

    return this.http.get(`${this.apiUrl}/puissance-par-marque/${marque}`);
  }

}