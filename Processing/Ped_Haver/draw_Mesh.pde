  ArrayList<PVector> Coordinates = new ArrayList<PVector>();
  float Steps, x, y;
  int scale = 12;
  
void drawMesh(){ 

      //bridges        
      for(int i = 0; i<bridges.getRowCount()-1; i++){ 
         if(bridges.getInt(i, "shapeid") == bridges.getInt(i+1, "shapeid")){
                stroke(250);
                 line(xy_bridges.get(i).x, xy_bridges.get(i).y, xy_bridges.get(i+1).x, (xy_bridges.get(i+1).y));
            }      
               }      
      //second story     
      for(int i = 0; i<second.getRowCount()-1; i++){ 
         if(second.getInt(i, "shapeid") == second.getInt(i+1, "shapeid")){
                stroke(250);
                 line(xy_second.get(i).x, xy_second.get(i).y, xy_second.get(i+1).x, (xy_second.get(i+1).y));
            }      
               } 
      //ped network  
      for(int i = 0; i<ped_nodes.getRowCount()-1; i++){ 
       if(ped_nodes.getInt(i, "shapeid") == ped_nodes.getInt(i+1, "shapeid")){
              stroke(120);
               line(xy_peds.get(i).x, xy_peds.get(i).y, xy_peds.get(i+1).x, (xy_peds.get(i+1).y));
          }      
             }
             
       //draw grid
       int U = int(width/scale);
       int V = int(height/scale);
       int SCALE = scale;
        ////draw grid
        for (int i=0; i<U; i++) {
          for (int j=0; j<V; j++) {
            float a = (i*SCALE + scale/2);
            float b = (j*SCALE + scale/2);
                    
              stroke(50);
              noFill();
              ellipse(a, b, 12, 12);
                }
              }
       println("mesh drawn"); 
}