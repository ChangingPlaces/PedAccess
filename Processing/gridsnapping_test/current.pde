/*
  Table table;
  int scale = 12;

void setup(){
  size(500, 500);
  table = loadTable("data/lines.csv", "header");
}

void draw(){
  background(0);
  
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
        noFill();
        float a = (i*SCALE + scale/2);
        float b = (j*SCALE + scale/2);
        
        stroke(100);
        ellipse(a, b, 12, 12);
        for(int k = 0; k<table.getRowCount()-1; k++){
                  float x1 = table.getFloat(k, "x");
                  float x2 = table.getFloat(k+1, "x");
                  float y1 = table.getFloat(k, "y");
                  float y2 = table.getFloat(k+1, "y");
            //if(abs(i*SCALE + scale/2 - table.getFloat(k, "x")) <= scale/2 &&
            //abs(j*SCALE + scale/2 - table.getFloat(k, "y")) <= scale/2){
            //  stroke(#fff000);
            //  ellipse(i*SCALE + scale/2, j*SCALE + scale/2, scale, scale);
            //}
            
         float A = a-x1;
         float B = b-x1; 
         float C = x2 - x1;   
         float D = y2-y1;    
         
         float dot = A*C + B*D; 
         float len_sq = C*C + D*D; 
         float param = -1;
         
         if(len_sq != 0){ //in case of 0 length line
             param = dot;
             }
         
         float xx, yy; 
         
         if(param<0){
           xx = x1; 
           yy = y1; 
         }
         
         else if(param >1){
           xx = x2;
           yy = y2;
         }
         
           else {
            xx = x1 + param * C;
            yy = y1 + param * D;
          }
        
          float dx = a - xx;
          float dy = b - yy;
          float dist = sqrt(dx * dx + dy * dy);
              if(dist < scale+scale/2){
              stroke(#ff0000);
              ellipse(a, b, scale, scale);
              }
      }
      }
    }
}
*/