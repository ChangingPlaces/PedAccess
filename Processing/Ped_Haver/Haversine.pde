float R = 6371000; //in meters

float longitude, latitude;

//always from origin (upperleft), these are the radian values
float lat1 = Upper_left.x * PI/180;
float lon1 = Upper_left.y * PI/180;

//the arraylists this function will output
ArrayList<PVector> xy_amenities = new ArrayList<PVector>();
ArrayList<PVector> xy_amencenter = new ArrayList<PVector>();
ArrayList<PVector> xy_bus = new ArrayList<PVector>();
ArrayList<PVector> xy_peds = new ArrayList<PVector>();
ArrayList<PVector> xy_bridges = new ArrayList<PVector>();
ArrayList<PVector> xy_second = new ArrayList<PVector>();

class Haver{
  void calc(String filename, ArrayList<PVector> name){
            Table values = loadTable(filename, "header");
     for(int i = 0; i<values.getRowCount(); i++){
                       //get longitude in radians
                          longitude = values.getFloat(i, "x") * PI/180;
                       //get latitude in radians      
                          latitude = values.getFloat(i, "y") * PI/180;
                     
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coord = new PVector(d*cos(radians(abs(90-degrees(bearing)))), d*sin(radians(abs(90-degrees(bearing)))));

                             //determine what arraylist to put thing in
                             name.add(xy_coord);
                }
                  println("Haversine run on " + filename, "framerate: " + frameRate);
  }
      
}
