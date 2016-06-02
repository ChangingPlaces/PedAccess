import org.gicentre.geomap.*;
 
GeoMap geoMap;
 
void setup()
{
  size(750, 750);
 
  geoMap = new GeoMap(this);
  geoMap.readFile("JE Land Use");
   
  // Set up text appearance.
  textAlign(LEFT, BOTTOM);
  textSize(12);

}
 
void draw()
{
  background(255);  
  stroke(#996633);              
  fill(#99ff99);          // Land colour
  geoMap.draw();              // Draw the entire map.
 
   hover();
}
