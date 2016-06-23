//////////
//Nina Lutz, MIT Media Lab, Summer 2016, nlutz@mit.edu
//Supervisor: Ira Winder, MIT Media Lab, jiw@mit.edu
/////////

/* 
For this simple demo all that's required is to chose a left corner as an origin 
Then I use the Haversine formula to take lat lon to Cartesian coordinates

I used an online tool developed by Chris Veness for some of the math and to check my own
http://www.movable-type.co.uk/scripts/latlong.html

The brensenham algorithm is used to create a smart snap mesh for the agents to navigate
More nots on this 
*/ 

////////
//Controls: 
//    l = line toggle
//    g = grid toggle
//    p = POI toggle
////////

/*
To Do
0. Make things run one time only, not each frame
    Frame step? Ughhhhh
1. Clean code and put things into classes and all that
2. Clean Haversine calculation to be from center and scalable
3. Export Snap nodes and render the grids differently (SOOOOO SLOW)
4. Add agents going from POIs and using the Snap grid as nodes
5. Make swarms on different demographics with different values based on population
6. Handle elevated pedestrian paths with z coords 
*/

//upper left corner for region
//PVector Upper_left = new PVector(1.33043, 103.74836);
//PVector Upper_left = new PVector(1.34229, 103.73598);
//PVector Upper_left = new PVector(1.34366, 103.74997);
PVector Upper_left = new PVector(1.339963, 103.745826);

bresenham brez = new bresenham();

// used to initialize objects when application is first run or reInitialized
boolean initialized = false;

// Number of frames for draw function to run before
// running setup functions. Setting to greater than 0 
// allows you to draw a loading screen
int drawDelay = 10;

void setup(){
        size(800, 500, P3D);
        
        //initializes data
        initData();
        
        //does haversine calculation to go from lat, lon to Cartesian
        Haversine();
        
        //runs a version of breseham's algorithm 
        brez.bresenham();

}

void draw(){
     background(0); 
     
     //draws Google map capture of Upper_left at 1.343234, 103.73601 for 1200 by 900 meters
     //image(img, 0, 0);
          if(showlines){
            drawLines();
          }
          
          if(showPOI){
            drawPOI();
          }
          
          if(showMesh){
            brez.draw_grid();
          }
}