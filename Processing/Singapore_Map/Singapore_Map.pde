import org.gicentre.geomap.*;
 
GeoMap geoMap;
GeoMap geoMap1;
GeoMap geoMap2;
 
void setup()
{
  size(500, 500);
 
  geoMap = new GeoMap(this);
  geoMap1 = new GeoMap(this);
  geoMap2 = new GeoMap(this);
  geoMap.readFile("JE Land Use");
  geoMap1.readFile("JE Road Network");
  geoMap2.readFile("JE pedestrian network v2");
  // Set up text appearance.
  textAlign(LEFT, BOTTOM);
  textSize(12);
  println("Data read...");
//  geoMap.getAttributes().writeAsTable(25);


}
 
void draw()
{
  background(255);  
  stroke(#6633ff);        //lines      
  fill(#99ff99);          // Land colour
  geoMap.draw();          
  stroke(255);              //roadnetwork color
  strokeWeight(1);
  geoMap1.draw();
  hover();
}
