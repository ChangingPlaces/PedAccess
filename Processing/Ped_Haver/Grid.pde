JSONObject nodes;
JSONArray nodevals;
JSONArray neighbors;
      
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
                  neighbors = new JSONArray();
                  nodes.setFloat("u", SnapGrid.get(i).x);
                  nodes.setFloat("v", SnapGrid.get(i).y);
                  nodes.setFloat("z", SnapGrid.get(i).z);
                  neighbors.setInt(0, i);
                  nodes.setJSONArray("neighbors", neighbors);
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
 
//               for(int j = 0; j<nodevals.size()-1; j++){
//                 dist = sqrt(sq(nodevals.getJSONObject(j+1).getFloat("u") - nodevals.getJSONObject(j).getFloat("u")) + sq(nodevals.getJSONObject(j+1).getFloat("v") - nodevals.getJSONObject(j).getFloat("v")));
//                 
//                 if(dist<scale*2 && dist != 0){
//                     nodes.setFloat("neighbors", j);
//                 }
//               }
    
             saveJSONArray(nodevals, "exports/nodes" + cellwidth + "_meters_" + dimx + "_by_" + dimy + ".json"); 
             println("nodes exported");
    }
      
  }
