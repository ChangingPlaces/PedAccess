void bresenham(){
for(int i = 0; i<ped_nodes.getRowCount()-1; i++){ 
              if(xy_peds.get(i).x >= 0 && xy_peds.get(i+1).x >= 0 
              && xy_peds.get(i).x <= width && xy_peds.get(i+1).x <= width
              && xy_peds.get(i).y >= 0 && xy_peds.get(i+1).y >= 0
              && xy_peds.get(i).y <= height && xy_peds.get(i+1).y <= height){
                        float x1 = xy_peds.get(i).x;
                        float x2 = xy_peds.get(i+1).x;
                        float y1 = xy_peds.get(i).y;
                        float y2 = xy_peds.get(i+1).y;
                        
                        if(x2 < x1 && y2 < y1){
                           x2 = xy_peds.get(i).x;
                           x1 = xy_peds.get(i+1).x;
                           y2 = xy_peds.get(i).y;
                           y1 = xy_peds.get(i+1).y;
                        }
                        
                          float dx = abs(x2-x1);
                          float dy = abs(y2-y1);
                          
                              if(dx > dy){
                                Steps = dx/(scale/2);
                              }
                              else{
                                Steps = dy/(scale/2);    
                              }
                              
                          float xInc = (dx)/(Steps);
                          float yInc = (dy)/(Steps);
                
                          x = x1;
                          y = y1;
                          
                          for(int v = 0; v< (int)Steps; v++){
                              if(y2 < y1){
                                 x = x + xInc;
                                 y = y - yInc;
                              }
                              
                             else if(x2 < x1){
                                 x = x - xInc;
                                 y = y + yInc;
                              }
                  
                             else{ 
                              x = x + xInc;
                              y = y + yInc;
                             }
                              
                              noFill();
                              if(x <= max(x1, x2) && y<= max(y1, y2) && x >= min(x1, x2) && y >= min(y1, y2)){
                              Coordinates.add(new PVector(x, y));
                              }
                    }
              }
             }
             
     println("bresenham run", Coordinates.size());        
}