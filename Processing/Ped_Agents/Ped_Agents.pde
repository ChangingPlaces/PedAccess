//////////
//Nina Lutz, MIT Media Lab, Summer 2016, nlutz@mit.edu
//Supervisor: Ira Winder, MIT Media Lab, jiw@mit.edu
//Agent based modeling based off the work of Ira Winder in the CityScope Andorra Project
/////////

/* 
For this simple demo all that's required is to chose a left corner as an origin 
I used an online tool developed by Chris Veness 

His tool utilizes the Haversine formula to get distances

In my demo, one pixel is one meter

http://www.movable-type.co.uk/scripts/latlong.html

*/ 

int  Width = 1200;
int  Height = 900;

PImage img;

PVector Upper_left  = new PVector(1.343234, 103.73601);

Table amenities; 
Table ped_nodes;
Table bus_stops;

void setup(){
  size(Width, Height, P3D);
  amenities = loadTable("data/temp-nodes.csv", "header");
  ped_nodes = loadTable("data/pednetv2nodes.csv", "header");
  bus_stops = loadTable("data/EZ-nodes.csv", "header");
    //Calculation of region --> rectangular canvas done only once
  Haversine();

  img = loadImage("map.jpg");
}

void draw(){
 background(0); 
 image(img, 0, 0);
 drawPOI();
}
