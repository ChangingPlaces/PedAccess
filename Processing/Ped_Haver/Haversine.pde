float R = 6371000; //in meters

float longitude, latitude;

//always from origin (upperleft), these are the radian values
float lat1 = Upper_left.x * PI/180;
float lon1 = Upper_left.y * PI/180;

ArrayList<PVector> xy_amenities = new ArrayList<PVector>();
ArrayList<PVector> xy_bus = new ArrayList<PVector>();
ArrayList<PVector> xy_peds = new ArrayList<PVector>();
ArrayList<PVector> xy_bridges = new ArrayList<PVector>();
ArrayList<PVector> xy_second = new ArrayList<PVector>();
ArrayList<PVector> xy_network = new ArrayList<PVector>();


void Haversine(){ 
    //Amenities
           for(int i = 0; i<amenities.getRowCount(); i++){
                       //get longitude in radians
                          longitude = amenities.getFloat(i, "x") * PI/180;
                       //get latitude in radians      
                          latitude = amenities.getFloat(i, "y") * PI/180;
                     
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
                             xy_amenities.add(xy_coord); 
                }


     //Bus Stops
             for(int i = 0; i<bus_stops.getRowCount(); i++){
                       //get longitude in radians
                          longitude = bus_stops.getFloat(i, "x") * PI/180;
                       //get latitude in radians      
                          latitude = bus_stops.getFloat(i, "y") * PI/180;
                     
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
                             xy_bus.add(xy_coord); 
                }

    //Ped Network ground
             for(int i = 0; i<ped_nodes.getRowCount(); i++){
                       //get longitude in radians
                          longitude = ped_nodes.getFloat(i, "x") * PI/180;
                       //get latitude in radians      
                          latitude =  ped_nodes.getFloat(i, "y") * PI/180;
                          
                          
                     
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
                             xy_peds.add(xy_coord);                            
                             
                }


    //Bridges
            for(int i = 0; i<bridges.getRowCount(); i++){
                       //get longitude in radians
                          longitude = bridges.getFloat(i, "x") * PI/180;
                       //get latitude in radians      
                          latitude =  bridges.getFloat(i, "y") * PI/180;
                     
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
                             xy_bridges.add(xy_coord); 
                }    

//Second story
            for(int i = 0; i<second.getRowCount(); i++){
                       //get longitude in radians
                          longitude = second.getFloat(i, "x") * PI/180;
                       //get latitude in radians      
                          latitude =  second.getFloat(i, "y") * PI/180;
                     
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));
                             xy_second.add(xy_coord); 
                }   
                
}
