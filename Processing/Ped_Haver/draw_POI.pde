void drawPOI(){
//amenities in yellow
//busstops in purple
//nodes in grey
//second story in light grey
//bridges in white


//mesh circles         
for(int i = 0; i<xy_peds.size(); i++){
         stroke(100);
         noFill();
         ellipse(xy_peds.get(i).x, xy_peds.get(i).y, 5, 5);
         }    
         
for(int i = 0; i<xy_bridges.size(); i++){
         noFill();
         stroke(255);
         ellipse(xy_bridges.get(i).x, xy_bridges.get(i).y, 5, 5);
         }       
     
for(int i = 0; i<xy_second.size(); i++){
         noFill();
         stroke(175);
         ellipse(xy_second.get(i).x, xy_second.get(i).y, 5, 5);
         }              

for(int i = 0; i<xy_amenities.size(); i++){
         noStroke();
         fill(#ffff00);
         ellipse(xy_amenities.get(i).x, xy_amenities.get(i).y, 5, 5);
         }
         
for(int i = 0; i<xy_bus.size(); i++){
         noStroke();
         fill(#ff00ff);
         ellipse(xy_bus.get(i).x, xy_bus.get(i).y, 5, 5);
         }  

}
