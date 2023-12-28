// @ts-nocheck

import {AfterViewInit, Component, Input, OnInit} from '@angular/core';
import * as d3 from 'd3';
@Component({
  selector: 'app-stats4',
  templateUrl: './stats4.component.html',
  styleUrls: ['./stats4.component.scss']
})
export class Stats4Component implements AfterViewInit {
  @Input() chartId:string;
  @Input() data:{nom:string, nbVentes:number}[] = [];

  constructor() {
  }

  ngAfterViewInit(): void {
    const data = this.data;

// Configuration du graphique
    var width = 600;
    var height = 300;
    var margin = { top: 30, right: 30, bottom: 40, left: 90 };

// Création de l'élément SVG
    var svg = d3.select("#"+this.chartId).append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// Création de l'échelle X
    var x = d3.scaleLinear()
      .domain([0, d3.max(data, function(d) { return d.nbVentes; })])
      .range([0, width - margin.left - margin.right]);

// Création de l'échelle Y
    var y = d3.scaleBand()
      .range([0, height - margin.top - margin.bottom])
      .padding(0.1)
      .domain(data.map(function(d) { return d.nom; }));

// Ajout des barres
    svg.selectAll(".bar")
      .data(data)
      .enter().append("rect")
      .attr("class", "bar")
      .attr("width", function(d) { return x(d.nbVentes); })
      .attr("y", function(d) { return y(d.nom); })
      .attr("height", y.bandwidth())
        .style("fill", "#75a4d2");



    // Ajoute un titre au chart
    svg
        .append("text")
        .attr("x", (width-margin.left-margin.right) / 2)
        .attr("y", 15- margin.top)
        .attr("text-anchor", "middle")
        .style("font-size", "12px")
        .style("font-weight", "bold")
        .text("Répartition des ventes par modèle");


// Ajout de l'axe X
    svg.append("g")
      .attr("transform", "translate(0," + (height - margin.top - margin.bottom) + ")")
      .call(d3.axisBottom(x));

// Ajout de l'axe Y
    svg.append("g")
      .call(d3.axisLeft(y));


  }

}
