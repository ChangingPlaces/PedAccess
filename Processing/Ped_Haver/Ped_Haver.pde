//////////
//Nina Lutz, MIT Media Lab, Summer 2016, nlutz@mit.edu
//Supervisor: Ira Winder, MIT Media Lab, jiw@mit.edu
/////////

/* This is a demo of using the Haversine data type to read csvs from lat long and, using only a user defined left corner, plotting the data where 1 pixel = 1 meter
*/

/* 
For this simple demo all that's required is to chose a left corner as an origin 
I used an online tool developed by Chris Veness for some of the math and to check my own
http://www.movable-type.co.uk/scripts/latlong.html

*/ 

int  Width = 1200;
int  Height = 900;

PImage img;

PVector Upper_left  = new PVector(1.343234, 103.73601);

//PVector Upper_left = new PVector(1.34197, 103.74440);

Table amenities; 
Table ped_nodes;
Table bus_stops;
Table bridges;
Table second;

void setup(){
  size(Width, Height, P3D);
  amenities = loadTable("data/temp-nodes.csv", "header");
  ped_nodes = loadTable("data/pednetv2nodes.csv", "header");
  bus_stops = loadTable("data/EZ-nodes.csv", "header");
  bridges = loadTable("data/bridges_links.csv", "header");
  second = loadTable("data/2ndmerc.csv", "header");
    //Calculation of region --> rectangular canvas done only once
  Haversine();

  img = loadImage("map.jpg");
}

void draw(){
 background(0); 
// image(img, 0, 0);
   drawPOI();
  
  
  
  fill(#ff00ff);       
  text("bus stop", width-200, height-20);      
  fill(#ffff00);
  text("amenities", width-200, height-40); 
  fill(100);
  text("ped network",  width-200, height-60);
  fill(255);
  text("bridge", width-200, height-80);
  fill(175);
  text("second story ped network", width-200, height-100);
  stroke(#ff0000);
  fill(#ff0000);
  text("300 meters, max ped path length", width-310, height-125);
  line(width-10, height-120,  width-310, height-120);
 
}

