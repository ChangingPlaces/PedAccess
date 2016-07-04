PVector Central = new PVector(1.34718, 103.72825);

PVector Upper_left;
Haver hav = new Haver();

boolean initialized = false;

 int Canvaswidth = 800; 
 float Canvasheight = Canvaswidth*(22.0/18.0);
 
 float areawidth = 2880;
 
 void setup(){
        size(Canvaswidth, int(Canvasheight), P3D);
        initData();
        
       //finds left corner given a center point
       hav.left(Central);
      
        //runs haversine calculation on any csv file to get xy coords from lat lon
        hav.calc("data/pednet.csv", "peds", xy_peds);
        hav.calc("data/overhead.csv", "bridges", xy_bridges);
        hav.calc("data/second.csv", "second", xy_second);
        hav.calc("data/crossings.csv", "crossings", crossings);
        hav.calc("data/road.csv", "roads", xy_roads);
        hav.calc("data/cover.csv", "covered", xy_covered);
        
 }
 

void draw(){
  
    if (!initialized) {
        background(0);
        //comment and uncomment which layers you want
        drawLines("data/overhead.csv", xy_bridges, #ff00ff);
        drawLines("data/second.csv", xy_second, #ffff00); 
        drawLines("data/road.csv", xy_roads, #0000ff);
        drawLines("data/crossings.csv", crossings, #ffffff);
        drawLines("data/cover.csv", xy_covered, #00ff00);
        drawLines("data/pednet.csv", xy_peds, #ff0000);
        
        //saves the png of the screen
            save("lines.png");
        
        println("Initialized");      
        initialized = true;
    }
    
}