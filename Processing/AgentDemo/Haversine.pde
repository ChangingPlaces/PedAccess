//PVector Upper_left  = new PVector(1.343234, 103.73601);
//PVector Upper_left  = new PVector(1.335843, 103.737601);
PVector Upper_left  = new PVector(1.336983, 103.746332);

Table amenities; 
Table ped_nodes;
Table bus_stops;
Table second_ped;
Table bridges;  
Table buildings;

float R = 6371000; //in meters

float longitude, latitude;

//always from origin (upperleft), these are the radian values
float lat1 = Upper_left.x * PI/180;
float lon1 = Upper_left.y * PI/180;

ArrayList<PVector> latlon_amenities = new ArrayList<PVector>();
ArrayList<PVector> xy_amenities = new ArrayList<PVector>();

ArrayList<PVector> latlon_bus = new ArrayList<PVector>();
ArrayList<PVector> xy_bus = new ArrayList<PVector>();

ArrayList<PVector> latlon_peds = new ArrayList<PVector>();
ArrayList<PVector> xy_peds = new ArrayList<PVector>();
ArrayList<PVector> xy_peds_canvas = new ArrayList<PVector>();


void Haversine(){ 
 
   
 //Amenities
             for(int i = 0; i<amenities.getRowCount(); i++){
             //get longitude in radians
                          longitude = amenities.getFloat(i, "x") * PI/180;
             //get latitude in radians      
                          latitude = amenities.getFloat(i, "y") * PI/180;

                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     
                     float d = c*R;
                     
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                     
                     PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));

                     if(xy_coord.x > 0 && xy_coord.x < width  && xy_coord.y < height && xy_coord.y > 0){
                     xy_amenities.add(xy_coord); 
                     }
                }


////Bus Stops
//         for(int i = 0; i<bus_stops.getRowCount(); i++){
//         //get longitude in radians
//                      longitude = bus_stops.getFloat(i, "x") * PI/180;
//         //get latitude in radians      
//                      latitude = bus_stops.getFloat(i, "y") * PI/180; 
//                      
//                     float delta_lat = latitude-lat1;
//                     float delta_lon = longitude-lon1;
//                     
//                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
//                     
//                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
//                     
//                     float d = c*R;
//                     
//                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
//                     
//                     PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
//                      if(xy_coord.x > 0 && xy_coord.x < width  && xy_coord.y < height && xy_coord.y > 0){
//                     xy_bus.add(xy_coord); 
//                      }
//                }

//Ped Network ground
   for(int i = 0; i<ped_nodes.getRowCount(); i++){
         //get longitude in radians
                      longitude = ped_nodes.getFloat(i, "x") * PI/180;
         //get latitude in radians      
                      latitude = ped_nodes.getFloat(i, "y") * PI/180;

                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     
                     float d = c*R;
                     
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                     
                     PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
                      
                     xy_peds.add(xy_coord); 
                     
                      if(xy_coord.x > 0 && xy_coord.x < width  && xy_coord.y < height && xy_coord.y > 0){
                      xy_peds_canvas.add(xy_coord);
                      }
                }
     
}
