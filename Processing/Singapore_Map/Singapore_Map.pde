import org.gicentre.geomap.*;

import java.util.List;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.MultiPolygon;
import com.vividsolutions.jts.geom.Polygon;
import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.geom.Envelope;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.index.strtree.STRtree;

import com.vividsolutions.jts.geom.GeometryFactory;
 
GeoMap geoMap;
GeoMap geoMap1;
GeoMap geoMap2;

int offset = 400;

// 96 x 96
// scale: 10m / Lego unit
// scale: 5m  / Lego Unit

void setup()
{
  size(1000, 1000);
  geoMap = new GeoMap(-offset, -offset, width+offset, height+offset, this);
  geoMap1 = new GeoMap(-offset, -offset, width+offset, height+offset, this);
  geoMap2 = new GeoMap(-offset, -offset, width+offset, height+offset, this);
  geoMap.readFile("JE Land Use");
  geoMap1.readFile("JE Road Network");
  geoMap2.readFile("JE pedestrian network v2");
  //also want amenities 
  
  // Set up text appearance.
  textAlign(LEFT, BOTTOM);
  textSize(12);
  println("Data read...");
// println(geoMap.getAttributes().writeAsTable(10));
}
 
void draw()
{
  translate(offset/2, offset/2);
  background(255);  
  stroke(#6633ff);        //lines      
  fill(#99ff99);          // Land colour
  geoMap.draw();    
  stroke(255, 0, 0);              //roadnetwork color
  strokeWeight(1);
//  geoMap1.draw();
  stroke(0);
  geoMap2.draw();
//  hover();
  
  stroke(#FF0000);
  for (int i=0; i<=22; i++)
    line((i)/22.0*height/2, 0, (i)/22.0*height/2, width/2);
  
  for (int i=0; i<=22; i++) 
    line(0, (i)/22.0*width/2, height/2, (i)/22.0*width/2);
    
}
