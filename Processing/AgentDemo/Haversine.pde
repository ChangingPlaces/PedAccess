PVector Upper_left  = new PVector(1.343234, 103.73601);

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

ArrayList<PVector> latlon_peds2nd = new ArrayList<PVector>();
ArrayList<PVector> xy_peds2nd = new ArrayList<PVector>();

ArrayList<PVector> latlon_buildings = new ArrayList<PVector>();
ArrayList<PVector> xy_buildings = new ArrayList<PVector>();
int[] building_id;

Table merp = new Table();


void Haversine(){ 
 
    merp.addColumn("obstacle");
    merp.addColumn("vertX");
    merp.addColumn("vertY");
    
 //Amenities
             for(int i = 0; i<amenities.getRowCount(); i++){
             //get longitude in radians
                          longitude = amenities.getFloat(i, "x") * PI/180;
             //get latitude in radians      
                          latitude = amenities.getFloat(i, "y") * PI/180;
                   //add them to the arraylist
                   latlon_amenities.add(new PVector(latitude, longitude)); 
             }
             
            //now iterate through the arraylist of amenities in my range to calculate distance and bearing from upper left corner so I can plot them
             for(int i = 0; i<latlon_amenities.size(); i++){
                     float lat2 = latlon_amenities.get(i).x;
                     float lon2 = latlon_amenities.get(i).y;

//                     float lat2 = 1.3388888888888888 *PI/180;
//                     float lon2 = 103.73944444444444 * PI/180;
                     
                     float delta_lat = lat2-lat1;
                     float delta_lon = lon2-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(lat2)*(sin(delta_lon/2)*sin(delta_lon/2));
                     
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     
                     float d = c*R; //in meters
                     
                     float bearing = atan2(sin(delta_lon)*cos(lat2), cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(delta_lon));

                     float degrees = bearing*180/PI;

                     PVector xy_coord = new PVector(d*cos(degrees - 180), d*sin(degrees - 180));
                     if(xy_coord.x > 0 && xy_coord.x < width  && xy_coord.y < height && xy_coord.y > 0){
                     xy_amenities.add(xy_coord); 
                     }
                }


//Bus Stops
         for(int i = 0; i<bus_stops.getRowCount(); i++){
         //get longitude in radians
                      longitude = bus_stops.getFloat(i, "x") * PI/180;
         //get latitude in radians      
                      latitude = bus_stops.getFloat(i, "y") * PI/180;
               //add them to the arraylist
               latlon_bus.add(new PVector(latitude, longitude)); 
         }
        
        //now iterate through the arraylist of amenities in my range to calculate distance and bearing from upper left corner so I can plot them
             for(int i = 0; i<latlon_bus.size(); i++){
                     float lat2 = latlon_bus.get(i).x;
                     float lon2 = latlon_bus.get(i).y;
                     
                     float delta_lat = lat2-lat1;
                     float delta_lon = lon2-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(lat2)*(sin(delta_lon/2)*sin(delta_lon/2));
                     
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     
                     float d = c*R;
                     
                     float bearing = atan2(sin(delta_lon)*cos(lat2), cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(delta_lon));
                     
                     float degrees = bearing*180/PI;
                    
                     PVector xy_coord = new PVector(d*cos(degrees - 180), d*sin(degrees - 180));
                     xy_bus.add(xy_coord); 
                }

//Ped Network ground
   for(int i = 0; i<ped_nodes.getRowCount(); i++){
         //get longitude in radians
                      longitude = ped_nodes.getFloat(i, "x") * PI/180;
         //get latitude in radians      
                      latitude = ped_nodes.getFloat(i, "y") * PI/180;
               //add them to the arraylist
               latlon_peds.add(new PVector(latitude, longitude)); 
         }
        
        //now iterate through the arraylist of amenities in my range to calculate distance and bearing from upper left corner so I can plot them
             for(int i = 0; i<latlon_peds.size(); i++){
                     float lat2 = latlon_peds.get(i).x;
                     float lon2 = latlon_peds.get(i).y;
                     float delta_lat = lat2-lat1;
                     float delta_lon = lon2-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(lat2)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     
                     float bearing = atan2(sin(delta_lon)*cos(lat2), cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(delta_lon));
                     float degrees = bearing*180/PI;
                    
                     PVector xy_coord = new PVector(d*cos(degrees - 180), d*sin(degrees - 180));
                     
                     if(xy_coord.x > 0 && xy_coord.x < width && xy_coord.y > 0 && xy_coord.y < height){
                     xy_peds.add(xy_coord); 
                     }
                }

//Ped Network second story
    for(int i = 0; i<second_ped.getRowCount(); i++){
         //get longitude in radians
                      longitude = second_ped.getFloat(i, "x") * PI/180;
         //get latitude in radians      
                      latitude = second_ped.getFloat(i, "y") * PI/180;
               //add them to the arraylist
               latlon_peds2nd.add(new PVector(latitude, longitude)); 
         }
   
    for(int i = 0; i<bridges.getRowCount(); i++){
         //get longitude in radians
                      longitude = bridges.getFloat(i, "x") * PI/180;
         //get latitude in radians      
                      latitude = bridges.getFloat(i, "y") * PI/180;
               //add them to the arraylist
               latlon_peds2nd.add(new PVector(latitude, longitude)); 
         }

        //now iterate through the arraylist to calculate distance and bearing from upper left corner so I can plot them
             for(int i = 0; i<latlon_peds2nd.size(); i++){
                     float lat2 = latlon_peds2nd.get(i).x;
                     float lon2 = latlon_peds2nd.get(i).y;
                     float delta_lat = lat2-lat1;
                     float delta_lon = lon2-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(lat2)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     
                     float bearing = atan2(sin(delta_lon)*cos(lat2), cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(delta_lon));
                     float degrees = bearing*180/PI;
                    
                     PVector xy_coord = new PVector(d*cos(degrees - 180), d*sin(degrees - 180));
                     xy_peds2nd.add(xy_coord); 
                }  

//BUILDING FOOTPRINT 
    for(int i = 0; i<buildings.getRowCount(); i++){
         //get longitude in radians
                      longitude = buildings.getFloat(i, "x") * PI/180;
         //get latitude in radians      
                      latitude = buildings.getFloat(i, "y") * PI/180;
               //add them to the arraylist
               latlon_buildings.add(new PVector(latitude, longitude)); 
         
   
        //now iterate through the arraylist to calculate distance and bearing from upper left corner so I can plot them
                     float lat2 = latlon_buildings.get(i).x;
                     float lon2 = latlon_buildings.get(i).y;
                     float delta_lat = lat2-lat1;
                     float delta_lon = lon2-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(lat2)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     
                     float bearing = atan2(sin(delta_lon)*cos(lat2), cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(delta_lon));
                     float degrees = bearing*180/PI;
                    
                     PVector xy_coord = new PVector(d*cos(degrees - 180), d*sin(degrees - 180));
                     if(xy_coord.x > 0 && xy_coord.x < width && xy_coord.y > 0 && xy_coord.y < height){
                     xy_buildings.add(xy_coord);  
                              TableRow newRow = merp.addRow();
                              newRow.setInt("obstacle", buildings.getInt(i, "shapeid"));
                              newRow.setFloat("vertX", xy_coord.x);
                              newRow.setFloat("vertY", xy_coord.y);
                     }
                }        
              
        saveTable(merp, "data/merp.csv");        
}
