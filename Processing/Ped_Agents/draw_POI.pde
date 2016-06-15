void drawPOI(){
//amenities in white
//busstops in purple
//nodes in yellow
  
for(int i = 0; i<xy_amenities.size(); i++){
         noStroke();
         fill(255);
         ellipse(xy_amenities.get(i).x, xy_amenities.get(i).y, 5, 5);
         }
         
for(int i = 0; i<xy_bus.size(); i++){
         noStroke();
         fill(#ff00ff);
         ellipse(xy_bus.get(i).x, xy_bus.get(i).y, 5, 5);
         }  

//mesh circles         
for(int i = 0; i<xy_peds.size(); i++){
         stroke(#ffff00);
         noFill();
         ellipse(xy_peds.get(i).x, xy_peds.get(i).y, 10, 10);
         }    
for(int i = 0; i<xy_peds2nd.size(); i++){
         stroke(#00ff00);
         noFill();
         ellipse(xy_peds2nd.get(i).x, xy_peds2nd.get(i).y, 10, 10);
         }            
   
}
