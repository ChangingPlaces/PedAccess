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
*/ 

////////
//Controls: 
//    l = line toggle
//    g = grid toggle
//    p = POI toggle
////////

/*
To Do
2. Clean Haversine calculation to be from center and scalable
3. Export Snap nodes and render the grids differently (SOOOOO SLOW)
      quicker to add stuff to other arraylists and compare? 
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
Haver hav = new Haver();


//carried over from agent demo 
// used to initialize objects when application is first run or reInitialized
boolean initialized = true;
boolean bw = true;

float version = 1.1;
String loadText = "AgentDemo | Version " + version;

boolean showFrameRate = false;
boolean printFrames = false;


// Number of frames for draw function to run before
// running setup functions. Setting to greater than 0 
// allows you to draw a loading screen
int drawDelay = 10;


void setup(){
  
        noLoop();
        
        size(800, 500, P3D);
        
        //runs haversine calculation on any csv file to get xy coords from lat lon
        hav.calc("data/temp-nodes.csv", xy_amenities);
        hav.calc("data/EZ-nodes.csv", xy_bus);
        hav.calc("data/pednetv2nodes.csv", xy_peds);
        hav.calc("data/bridges_links.csv", xy_bridges);
        hav.calc("data/2ndmerc.csv", xy_second);
    
        //initializes data
        initData();
        
        //runs a version of breseham's algorithm on chosen network(s)
        brez.bresenham("data/pednetv2nodes.csv", xy_peds);
        brez.bresenham("data/bridges_links.csv", xy_bridges);
        brez.bresenham("data/2ndmerc.csv", xy_second);
//       
        //initCanvas();

}


void mainDraw() {
  // Draw Functions Located here should exclusively be drawn onto 'tableCanvas',
  // a PGraphics set up to hold all information that will eventually be 
  // projection-mapped onto a big giant table:
  drawTableCanvas(tableCanvas);

  // Renders the finished tableCanvas onto main canvas as a projection map or screen
  renderTableCanvas();
  
}


void draw(){
     background(0); 
     
     //mainDraw();
     
     
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

void renderTableCanvas() {
  // most likely, you'll want a black background
  background(0);
  
  // Renders the tableCanvas as either a projection map or on-screen 
  
    image(tableCanvas, 0, 0, tableCanvas.width, tableCanvas.height);
  
}  