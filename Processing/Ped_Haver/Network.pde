class Network {
        Network(String GeoJSONfile){
         JSONObject network = loadJSONObject(GeoJSONfile);
         JSONArray lines = network.getJSONArray("geometries");
         JSONArray points;
            for(int i = 0 ; i <lines.size(); i++){
                points = lines.getJSONObject(i).getJSONArray("coordinates");
                int p = 0;
              for(int j = 0; j<points.size(); j++){
                PVector coord = new PVector(points.getJSONArray(j).getFloat(1), points.getJSONArray(j).getFloat(0));
                //get longitude in radians
                          longitude = coord.y* PI/180;
                       //get latitude in radians      
                          latitude =  coord.x * PI/180;
                               
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
                             xy_network.add(xy_coord); 
                            
                }
           }
        }
        
}

class MultiNetwork {
        MultiNetwork(String GeoJSONfile){
         JSONObject network = loadJSONObject(GeoJSONfile);
         JSONArray lines = network.getJSONArray("geometries");
         JSONArray points, coords, bleh;
            for(int i = 0 ; i <lines.size(); i++){
                points = lines.getJSONObject(i).getJSONArray("coordinates");
             for(int j = 0; j<points.size(); j++){
               coords = points.getJSONArray(j);
             for(int p = 0; p<coords.size(); p++){
               PVector coordinate = new PVector(coords.getJSONArray(p).getFloat(1), coords.getJSONArray(p).getFloat(0));
                //get longitude in radians
                          longitude = coordinate.y* PI/180;
                       //get latitude in radians      
                          latitude =  coordinate.x * PI/180;
                               
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coordmult = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
                             xy_network.add(xy_coordmult); 
             }
            }              
          }
        }     
}
