
  Table table;
  int scale = 12;

void setup(){
  size(500, 500);
  table = loadTable("data/lines.csv", "header");
}

void draw(){
  background(0);
  
  ArrayList<PVector> Coordinates = new ArrayList<PVector>();
  
  stroke(255);
  for(int i = 0; i<table.getRowCount()-1; i++){
       if(table.getInt(i, "id") == table.getInt(i+1, "id")){
       line(table.getFloat(i, "x"), table.getFloat(i, "y"), table.getFloat(i+1, "x"), table.getFloat(i+1, "y"));
       }
  }
  
    int U = int(width/scale);
    int V = int(height/scale);
    int SCALE = scale;
    
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        float a = (i*SCALE + scale/2);
        float b = (j*SCALE + scale/2);
        
        stroke(100);
        noFill();
        ellipse(a, b, 12, 12);
        
        for(int k = 0; k<table.getRowCount()-1; k++){
                  int x1 = table.getInt(k, "x");
                  int x2 = table.getInt(k+1, "x");
                  int y1 = table.getInt(k, "y");
                  int y2 = table.getInt(k+1, "y");
                  
                  int dx = abs(x2-x1);
                  int dy = abs(y2-y1);
                  
                  int sx = (x1< x2) ? 1 : -1; 
                  int sy = (y1<y2) ? 1 : -1;
                  
                  int err = dx-dy;
                  
                  Coordinates.add(new PVector(x1, y1));
                 
                  while(!((x1 == x2) && (y1 == y2))){
                    int e2 = err << 1; 
                      if(e2 > -dy){
                          err += dx;
                          y1 += sy;
                          }
                      if(e2 < dx){
                          err += dx;
                          y1 += sy;
                          }
                    Coordinates.add(new PVector(x1, y1));
                  }
      }
      }
    }
}