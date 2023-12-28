// @ts-nocheck

import {AfterViewInit, Component, Input, OnInit} from '@angular/core';
import * as d3 from 'd3';
@Component({
  selector: 'app-stats2',
  templateUrl: './stats2.component.html',
  styleUrls: ['./stats2.component.scss']
})
export class Stats2Component implements AfterViewInit{
   @Input() chartId:string;
  @Input() data:{couleur:string, nbPerson:number}[] = [];

  constructor() { }

  convertToColor(str:string):string{
    debugger
    switch(str.toLowerCase()){
      case "bleu":
        return "#75a4d2";
      case "rouge":
        return "#d27575";
      case "vert":
        return "#75d27b";
      case "jaune":
        return "#d2d275";
      case "orange":
        return "#d29f75";
      case "violet":
        return "#d275d2";
      case "rose":
        return "#d275a4";
      case "gris":
        return "#a4a4a4";
      case "marron":
        return "#a4754d";
      case "noir":
        return "#000000";
      case "blanc":
        return "#ffffff";
      default:
        return "#000000";
    }
  }


  ngAfterViewInit(): void {

    const data = this.data;

    // Specify the chart’s dimensions.
    const width = 300;
    const height = 350

    // Create the color scale.
    const color = d3.scaleOrdinal()
      .domain(data.map(d => d.couleur))
      .range(d3.quantize(t => d3.interpolateSpectral(t * 0.8 + 0.1), data.length).reverse())

    // Create the pie layout and arc generator.
    const pie = d3.pie()
      .sort(null)
      .value(d => d.nbPerson);

    const arc = d3.arc()
      .innerRadius(0)
      .outerRadius(Math.min(width, height) / 2 - 1);

    const labelRadius = arc.outerRadius()() * 0.8;

    // A separate arc generator for labels.
    const arcLabel = d3.arc()
      .innerRadius(labelRadius)
      .outerRadius(labelRadius);

    const arcs = pie(data);

    // Create the SVG container.
    const svg =
      d3.select("#"+this.chartId)
      .append("svg")
      .attr("width", width)
      .attr("height", height)
      .attr("viewBox", [-width / 2, -height / 2, width, height])
      .attr("style", "max-width: 100%; height: auto; font: 10px sans-serif");

// Add a title for the chart
    svg.append("text")
        .attr("x", 0)
        .attr("y", -height / 2 + 20) // Adjust the y position as needed
        .attr("text-anchor", "middle")
        .style("font-size", "18px")
        .style("font-weight", "bold")
        .text("Préférences de couleur");


    // Add a sector path for each value.
    svg.append("g")
      .attr("stroke", "white")
      .selectAll()
      .data(arcs)
      .join("path")
      .attr("fill", d => this.convertToColor(d.data.couleur))
      .attr("d", arc)
      .append("title")
      .text(d => `${d.data.couleur}: ${d.data.nbPerson.toLocaleString("en-US")}`);

    // Create a new arc generator to place a label close to the edge.
    // The label shows the value if there is enough room.
    svg.append("g")
      .attr("text-anchor", "middle")
      .selectAll()
      .data(arcs)
      .join("text")
      .attr("transform", d => `translate(${arcLabel.centroid(d)})`)
      .call(text => text.append("tspan")
        .attr("y", "-0.4em")
        .attr("font-weight", "bold")
          .attr("fill", d => this.convertToColor(d.data.couleur) === "#000000" ? "#ffffff" : "#000000")
          .text(d => d.data.couleur))
      .call(text => text.filter(d => (d.endAngle - d.startAngle) > 0.25).append("tspan")
        .attr("x", 0)
        .attr("y", "0.7em")
          .attr("fill", d => this.convertToColor(d.data.couleur) === "#000000" ? "#ffffff" : "#000000")

          .attr("fill-opacity", 0.7)
        .text(d => d.data.nbPerson.toLocaleString("en-US")));

    return svg.node();
  }

}
