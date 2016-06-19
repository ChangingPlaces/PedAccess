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
      //ped network
        for(int i = 0; i<xy_network.size(); i++){
          stroke(100);
               noFill();
               ellipse(xy_network.get(i).x, xy_network.get(i).y, 5, 5);
               }    
               
}
