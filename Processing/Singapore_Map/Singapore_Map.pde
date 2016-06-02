import org.gicentre.geomap.*;
 
GeoMap geoMap;
GeoMap geoMap1;
GeoMap geoMap2;
 
void setup()
{
  size(700, 700);
 
  geoMap = new GeoMap(this);
  geoMap1 = new GeoMap(this);
  geoMap.readFile("JE Land Use");
  geoMap1.readFile("JE Road Network");
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
  stroke(255, 0, 0);              //roadnetwork color
  strokeWeight(1);
  geoMap1.draw();
    hover();

}
