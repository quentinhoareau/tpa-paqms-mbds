import { Injectable } from '@angular/core';
import {Observable, of} from 'rxjs';
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class ApiService{
    private apiUrl = 'http://localhost:8080';

    constructor(private http: HttpClient) { }

  getMarquesList(){
    //TODO: remove this mock when the API is ready
    return of(
        [
          {
            nom: 'BMW',
            nbModel: '5'
          },
          {
            nom: 'Marque2',
            nbModel: '10'
          },
        ]
    );

    return this.http.get(`${this.apiUrl}/marques`);
  }

  getVentesParModele(marque: string): Observable<any> {
    //TODO: remove this mock when the API is ready
    return of([
      { nom: "BMW Série 3", nbVentes: 1267 },
      { nom: "BMW X5", nbVentes: 1564 },
      { nom: "BMW Série 5", nbVentes: 1432 },
      { nom: "BMW X3", nbVentes: 234 },
      { nom: "BMW Série 7", nbVentes: 753 },
    ]);

    return this.http.get(`${this.apiUrl}/ventes-par-modele/${marque}`);
  }

  getPrixParModele(marque: string): Observable<any> {
    //TODO: remove this mock when the API is ready
    return of( [
      { nom: "BMW Série 3", prix: 45000 },
      { nom: "BMW X5", prix: 65000 },
      { nom: "BMW Série 5", prix: 55000 },
      { nom: "BMW X3", prix: 50000 },
      { nom: "BMW Série 7", prix: 80000 },
    ]);

    return this.http.get(`${this.apiUrl}/prix-par-modele/${marque}`);
  }

  getCouleursParMarque(marque: string): Observable<any> {
    //TODO: remove this mock when the API is ready
    return of([
      { couleur: "Rouge", nbVentes: 120 },
      { couleur: "Vert", nbVentes: 60 },
      { couleur: "Bleu", nbVentes: 180 },
      { couleur: "Orange", nbVentes: 90 }
    ]
    )

    return this.http.get(`${this.apiUrl}/couleurs-par-marque/${marque}`);
  }

  getPuissanceParModele(marque: string): Observable<any> {
    //TODO: remove this mock when the API is ready
    return  of([
      { nom: "BMW Série 3", horsePower: 250 },
      { nom: "BMW X5", horsePower: 355 },
      { nom: "BMW Série 5", horsePower: 335 },
      { nom: "BMW X3", horsePower: 248 },
      { nom: "BMW Série 7", horsePower: 600 },
    ]);

    return this.http.get(`${this.apiUrl}/puissance-par-modele/${marque}`);
  }

}