class Network {
  //Attributes
  
//  //Contstructor 
//  Network(String GeoJSONfile){
//
// JSONObject network = loadJSONObject(GeoJSONfile);
//    JSONArray lines = network.getJSONArray("features");
//    
//    for(int i = 0; i<lines.size(); i++){
//    JSONArray points = lines.getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
//    
//           for(int j=0; j<lines.size(); j++) {
//           PVector pos = new PVector(points.getJSONArray(j).getFloat(1), points.getJSONArray(j).getFloat(0));
//
//                       //get longitude in radians
//                          longitude = pos.y* PI/180;
//                       //get latitude in radians      
//                          latitude =  pos.x * PI/180;
//                               
//                     //use the Haversine formula
//                     float delta_lat = latitude-lat1;
//                     float delta_lon = longitude-lon1;
//                     
//                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
//                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
//                     float d = c*R;
//                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
//                             
//                             //convert to polar and put in array
//                             PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
//                             xy_network.add(xy_coord); 
//    }
//    }
//    
//  }

        Network(String GeoJSONfile){
         JSONObject network = loadJSONObject(GeoJSONfile);
         JSONArray lines = network.getJSONArray("geometries");
         JSONArray points;
            for(int i = 0 ; i < 22; i++){
                points = lines.getJSONObject(i).getJSONArray("coordinates");
              for(int j = 0; j<points.size(); j++){
                PVector coord = new PVector(points.getJSONArray(j).getFloat(1), points.getJSONArray(j).getFloat(0));
                }
            }
        }
}
