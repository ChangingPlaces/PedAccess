JSONObject nodes;
JSONArray nodevals;
      
class Grid{
  int dimx, dimy, cellwidth;
  

  void render(int cellwidth, int dimx, int dimy){
       scale = Canvaswidth/dimx;
  }
  
  void export(int cellwidth, int dimx, int dimy){
    println("exporting nodes");
            nodevals = new JSONArray();
                     float dist;
            
            for(int i = 0; i<SnapGrid.size(); i++){
                  nodes = new JSONObject();
                  nodes.setFloat("u", SnapGrid.get(i).x);
                  nodes.setFloat("v", SnapGrid.get(i).y);
                  nodes.setFloat("z", SnapGrid.get(i).z);
                  
                          for(int j = 0; j<crossings.size(); j++){
                            if(abs(crossings.get(j).x - SnapGrid.get(i).x) <= cellwidth && abs(crossings.get(j).y - SnapGrid.get(i).y) <= cellwidth){
                              nodes.setString("crossing", "true");
                            }
                            else if(abs(crossings.get(j).x - SnapGrid.get(i).x) > cellwidth && abs(crossings.get(j).y - SnapGrid.get(i).y) > cellwidth){
                              nodes.setString("crossing", "false");
                            }
                          }
                          
                  nodevals.setJSONObject(i, nodes);
                      }
    
             saveJSONArray(nodevals, "data/nodes" + cellwidth + "_meters_" + dimx + "_by_" + dimy + ".json"); 
             println("nodes exported");
    }
      
  }
