  ArrayList<PVector> Coordinates = new ArrayList<PVector>();
  float Steps, x, y;
  int scale = 12;
  
void drawMesh(){ 

      //bridges        
      for(int i = 0; i<xy_bridges.size(); i++){
               noFill();
               stroke(255);
               ellipse(xy_bridges.get(i).x, xy_bridges.get(i).y, 5, 5);
               }       
      //second story     
      for(int i = 0; i<xy_second.size(); i++){
               noFill();
               stroke(190);
               ellipse(xy_second.get(i).x, xy_second.get(i).y, 5, 5);
               }   
               println("second story done");
      //ped network  
      for(int i = 0; i<ped_nodes.getRowCount()-1; i++){ 
       if(ped_nodes.getInt(i, "shapeid") == ped_nodes.getInt(i+1, "shapeid")){
              stroke(100);
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
        
        //           for(int p = 0; p<Coordinates.size(); p++){
        //            if(abs(a - Coordinates.get(p).x) <= scale/2 && abs(b - Coordinates.get(p).y) <= scale/2s){
        //            stroke(#ffff00);
        //            ellipse(a, b, 2, 2);
        //            }
        //          }
                }
              }
       println("mesh drawn"); 
}