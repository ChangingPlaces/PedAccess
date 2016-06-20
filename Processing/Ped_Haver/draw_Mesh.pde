//JSONObject network = loadJSONObject("pednetworkgeolinestrings.json");
//JSONArray lines = network.getJSONArray("geometries");
void drawMesh(){ 
     int scale = 12;
    int U = int(width/scale);
    int V = int(height/scale);
    int SCALE = scale;
    
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        noFill();
        color c = 0;
            for (int d = 0; d<xy_peds.size(); d++){
            if(abs(i*SCALE + scale/2 - xy_peds.get(d).x) <= scale/2 && abs(j*SCALE + scale/2 - xy_peds.get(d).y) <= scale/2){
              c = #9494b8;
            }
            }
        stroke(c);
        ellipse(i*SCALE + scale/2, j*SCALE + scale/2, scale, scale);    
      }
    }    
  
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
               
      for(int i = 0; i<ped_nodes.getRowCount()-1; i++){ 
       if(ped_nodes.getInt(i, "shapeid") == ped_nodes.getInt(i+1, "shapeid")){
              stroke(100);
               line(xy_peds.get(i).x, xy_peds.get(i).y, xy_peds.get(i+1).x, (xy_peds.get(i+1).y));
          }  
             }
             
             println("done");
}
