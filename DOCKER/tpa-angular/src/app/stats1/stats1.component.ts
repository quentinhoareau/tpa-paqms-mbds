// @ts-nocheck
import {AfterViewInit, Component, Input, OnInit} from '@angular/core';
import * as d3 from 'd3';
@Component({
  selector: 'app-stats1',
  templateUrl: './stats1.component.html',
  styleUrls: ['./stats1.component.scss']
})
export class Stats1Component implements AfterViewInit{

  @Input() chartId:string;
  @Input() data:{nom:string, prix:number}[] = [];

  ngAfterViewInit() {
    const data = this.data;

// Set the dimensions and margins of the graph
    var margin = { top: 50, right: 30, bottom: 100, left: 40 },
        width = 360 - margin.left - margin.right,
        height = 300 - margin.top - margin.bottom;

// Append the svg object to the body of the pageé
    var svg = d3
        .select("#"+this.chartId)
        .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// X axis: scale and draw
    var x = d3
        .scaleBand()
        .domain(data.map(function (d) { return d.nom; }))
        .range([0, width])
        .padding(0.1);

    // Ajoute un titre au chart
    svg
        .append("text")
        .attr("x", width / 2)
        .attr("y", 15- margin.top)
        .attr("text-anchor", "middle")
        .style("font-size", "12px")
        .style("font-weight", "bold")
        .text("Distribution des prix par modèle");

    svg.append("g")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.axisBottom(x))
        .selectAll("text")
        .style("text-anchor", "end")
        .attr("dx", "-.8em")
        .attr("dy", ".15em")
        .attr("transform", "rotate(-65)");

// Y axis: scale and draw
    var y = d3
        .scaleLinear()
        .domain([0, d3.max(data, function (d) { return d.prix; })])
        .nice()
        .range([height, 0]);

    svg.append("g").call(d3.axisLeft(y));

// Append the bar rectangles to the svg element
    svg
        .selectAll("rect")
        .data(data)
        .enter()
        .append("rect")
        .attr("x", function (d) { return x(d.nom); })
        .attr("y", function (d) { return y(d.prix); })
        .attr("width", x.bandwidth())
        .attr("height", function (d) { return height - y(d.prix); })
        .style("fill", "#69b3a2");
  }


}
