import org.gicentre.geomap.*;
//super neat library called GeoMap lets you read shape files in Processing
//need the .shp and .dbf files in the data folder of the sketch 
 
GeoMap geoMap;                // Declare the geoMap object.
 
void setup()
{
  size(1000, 1000);
  
  geoMap = new GeoMap(this);  // Create the geoMap object.
  geoMap.readFile("JE Land Use");   // Reads shapefile.
}
 
void draw()
{ 
  geoMap.draw();              // Draw the entire map.
}
