void drawLines(){ 
    println("rendering lines");
      //bridges        
      for(int i = 0; i<bridges.getRowCount()-1; i++){ 
         if(bridges.getInt(i, "shapeid") == bridges.getInt(i+1, "shapeid")){
                stroke(#70C1B3);
                 line(xy_bridges.get(i).x, xy_bridges.get(i).y, xy_bridges.get(i+1).x, (xy_bridges.get(i+1).y));
            }      
               }      
      //second story     
      for(int i = 0; i<second.getRowCount()-1; i++){ 
         if(second.getInt(i, "shapeid") == second.getInt(i+1, "shapeid")){
                stroke(#247BA0);
                 line(xy_second.get(i).x, xy_second.get(i).y, xy_second.get(i+1).x, (xy_second.get(i+1).y));
            }      
               } 
      //ped network  
      for(int i = 0; i<ped_nodes.getRowCount()-1; i++){ 
       if(ped_nodes.getInt(i, "shapeid") == ped_nodes.getInt(i+1, "shapeid")){
              stroke(#F25F5C);
              strokeWeight(1.5);
               line(xy_peds.get(i).x, xy_peds.get(i).y, xy_peds.get(i+1).x, (xy_peds.get(i+1).y));
          }      
             }
             
       
       println("lines drawn"); 
}