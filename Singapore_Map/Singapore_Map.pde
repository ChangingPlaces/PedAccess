import org.gicentre.geomap.*;
 
GeoMap geoMap;
GeoMap geoMap1;
 
void setup()
{
  size(750, 750);
 
  geoMap = new GeoMap(this);
  geoMap1 = new GeoMap(this);
  geoMap.readFile("JE Land Use");
  geoMap1.readFile("JE Road Network");
  // Set up text appearance.
  textAlign(LEFT, BOTTOM);
  textSize(12);
//  geoMap.getAttributes().writeAsTable(25);


}
 
void draw()
{
  background(255);  
  stroke(#6633ff);        //lines      
  fill(#99ff99);          // Land colour
  geoMap.draw();          // Draw the entire map.
  stroke(0);
  strokeWeight(1);
  geoMap1.draw();
  hover();
}
