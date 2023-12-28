// @ts-nocheck

import {AfterViewInit, Component, Input, OnInit} from '@angular/core';
import * as d3 from 'd3';

@Component({
  selector: 'app-stats3',
  templateUrl: './stats3.component.html',
  styleUrls: ['./stats3.component.scss']
})
export class Stats3Component implements AfterViewInit {
  @Input() chartId:string;
  @Input() data:{nom:string, horsePower:number}[] = [];

  constructor() {
  }

  ngAfterViewInit(): void {
    const data = this.data;


// Dimensions et marges du graphique
    var margin = {top: 30, right: 30, bottom: 100, left: 60},
      width = 360 - margin.left - margin.right,
      height = 300 - margin.top - (margin.bottom);

// Créer l'élément SVG
    var svg = d3.select("#"+this.chartId)
      .append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// Créer l'échelle X
    var x = d3.scaleBand()
      .domain(data.map(function(d) { return d.nom; }))
      .range([0, width])
      .padding(0.1);

    svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x))
      .selectAll("text")
      .style("text-anchor", "end")
      .attr("dx", "-.8em")
      .attr("dy", ".15em")
      .attr("transform", "rotate(-65)");

    // Ajoute un titre au chart
    svg
        .append("text")
        .attr("x", width / 2)
        .attr("y", 15- margin.top)
        .attr("text-anchor", "middle")
        .style("font-size", "12px")
        .style("font-weight", "bold")
        .text("Puissance des véhicules par modèle");


// Créer l'échelle Y
    var y = d3.scaleLinear()
      .domain([0, d3.max(data, function(d) { return +d.horsePower; })])
      .range([ height, 0 ]);

    svg.append("g")
      .call(d3.axisLeft(y));

// Ajouter la ligne
    svg.append("path")
      .datum(data)
      .attr("fill", "none")
      .attr("stroke", "steelblue")
      .attr("stroke-width", 1.5)
      .attr("d", d3.line()
        .x(function(d) { return x(d.nom) + x.bandwidth() / 2; })
        .y(function(d) { return y(d.horsePower); })
      );


  }


}
