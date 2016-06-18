class Network {
  //Attributes

  
  //Contstructor 
  Network(String GeoJSONfile){
//    
    JSONObject network = loadJSONObject(GeoJSONfile);
    JSONArray lines = network.getJSONArray("features");
    
    for(int i = 0; i<lines.size(); i++){
    JSONArray points = lines.getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
    
//           for(int j=0; j<lines.size(); j++) {
////           PVector pos = new PVector(points.getJSONArray(j).getFloat(1), points.getJSONArray(j).getFloat(0));
//           }
    }
    
  }
}
