/*
Bresenham Algorithm Demo 
  by Nina Lutz, nlutz@mit.edu               MIT Media Lab, Changing Places Group, Summer 2016
  Supervisor: Ira Winder, jiw@mit.edu       MIT Media Lab
  
  
The bresenham algorithm is a classic algorithm used in early computer graphics. It renders a line on rasterized (gridded) space. 
The algorithm takes in a start and end point and finds all the points between them at the scale that the user sets. 

This implementation takes in a csv with a series of points. I arranged them into seperate lines, each with a unique id. 
If you want to use the code exactly, name your columns "shapeid" for the line id number, "x" for your x coordinate and "y" for your y coordinate

I chose to draw a grid of ellipses, becuase I use this alogirthm in a path finding network over pedestrian paths and ellipses are easier for visual confirmation, but you can use squares
*/

//load a table of points 
//lines should have an ID, I call it "shapeid" because this matches most GeoSpatial data structures from programs like QGIS 
Table table;

//set a scale for your grid; this is the weight of each raster cell
 int scale = 12;
//these variables will be used to draw the grid
 int U = int(width/scale);
 int V = int(height/scale);
 int SCALE = scale;

void setup(){
      //loading the table
      table = loadTable("data/lines.csv", "header");
      size(500, 500);
}

void draw(){
        background(0);
        ArrayList<PVector> Coordinates = new ArrayList<PVector>();
        float Steps, x, y;

  for(int i = 0; i<table.getRowCount()-1; i++){
        float x1 = table.getFloat(i, "x");
        float x2 = table.getFloat(i+1, "x");
        float y1 = table.getFloat(i, "y");
        float y2 = table.getFloat(i+1, "y");
        
        //calculating the change in x and y across the line
        float dx = abs(x2-x1);
        float dy = abs(y2-y1);
          
        //calculating the number of steps for each line  
        //the smaller your divisor, the more points you can get
        if(dx > dy){
          Steps = dx/(scale/2);
        }
        else{
          Steps = dy/(scale/2);        
        }
          
        //x and y increments for the points in the line      
          float xInc = (dx)/(Steps);
          float yInc = (dy)/(Steps);

          x = x1;
          y = y1;
        
        //focuses on drawing the lines
          for(int v = 0; v< (int)Steps; v++){
            if(x2 < x1 && y2 < y1){
                 x = x - xInc;
                 y = y - yInc;
            }
            else if(y2 < y1){
                 x = x + xInc;
                 y = y - yInc;
              }  
           else if(x2 < x1){
                 x = x - xInc;
                 y = y + yInc;
              }
            else{ 
              x = x + xInc;
              y = y + yInc;
             }
             
             
            noFill();
            
                if(table.getInt(i, "id") == table.getInt(i+1, "id")){    
                    if(x <= max(x1, x2) && y<= max(y1, y2) && x >= min(x1, x2) && y >= min(y1, y2)){
                    Coordinates.add(new PVector(x, y));
                    }
                }
                
    }
           if(table.getInt(i, "id") == table.getInt(i+1, "id")){
              strokeWeight(2);
              stroke(#1a53ff);
              line(table.getFloat(i, "x"), table.getFloat(i, "y"), table.getFloat(i+1, "x"), table.getFloat(i+1, "y"));
           }
          
  }
  
          ////draw grid
           int U = int(width/scale);
           int V = int(height/scale);
           int SCALE = scale;
            //draw grid
            for (int d=0; d<U; d++) {
              for (int j=0; j<V; j++) {
                float a = (d*SCALE + scale/2);
                float b = (j*SCALE + scale/2);
                
                stroke(100);
                noFill();
                strokeWeight(.5);
                ellipse(a, b, 12, 12);
               
                 for(int p = 0; p<Coordinates.size(); p++){
                  if(abs(a - Coordinates.get(p).x) <= scale*2/3 && abs(b - Coordinates.get(p).y) <= scale*2/3){
                  strokeWeight(.5);
                  stroke(#ffd633);
                          ellipse(a, b, 12, 12);
                  }
                  
                }
                
               
              }
            }
            println(Coordinates.size() + " nodes on or tangent to line");
}