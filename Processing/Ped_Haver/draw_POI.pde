void drawPOI(){          
      //draws amenities data
      for(int i = 0; i<xy_amenities.size(); i++){
               noStroke();
               fill(#ffff00);
               ellipse(xy_amenities.get(i).x, xy_amenities.get(i).y, 5, 5);
               }
      //draws busstop data         
      for(int i = 0; i<xy_bus.size(); i++){
               noStroke();
               fill(#ff00ff);
               ellipse(xy_bus.get(i).x, xy_bus.get(i).y, 5, 5);
               }  

}
