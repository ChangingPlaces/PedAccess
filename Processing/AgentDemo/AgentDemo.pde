import org.gicentre.geomap.io.*;
import org.gicentre.geomap.*;
GeoMap geoMap2;

// This is the staging script for the Pathfinding for agent-based modeling
// Ira Winder, MIT Media Lab, jiw@mit.edu, Fall 2015

int canvasWidth = 1200;
int canvasHeight = 900;

boolean bw = true;

float version = 1.1;
String loadText = "AgentDemo | Version " + version;

boolean showFrameRate = false;
boolean printFrames = false;

// used to initialize objects when application is first run or reInitialized
boolean initialized = false;

// Number of frames for draw function to run before
// running setup functions. Setting to greater than 0 
// allows you to draw a loading screen
int drawDelay = 5;

PImage img;

void setup() {
  
  size(canvasWidth, canvasHeight, P3D);
  initData();
  Haversine();
  initCanvas();
  geoMap2 = new GeoMap(this);
  
    geoMap2.readFile("JE pedestrian network v2");
  
//  img = loadImage("map.jpg");
}


void mainDraw() {
  // Draw Functions Located here should exclusively be drawn onto 'tableCanvas',
  // a PGraphics set up to hold all information that will eventually be 
  // projection-mapped onto a big giant table:
  drawTableCanvas(tableCanvas);
  
  
  if (!keyLoaded) {
    // Draws loading screen on top of last drawn content if keypressed while drawing
    loading(tableCanvas, loadText);
  }
  
  // Renders the finished tableCanvas onto main canvas as a projection map or screen
  renderTableCanvas();

}


void draw() {
  // If certain key commands are pressed, it causes a <0 delay which counts down in this section
  if (drawDelay > 0) {
    
    if (initialized) {
      mainDraw();
    } else {
      // Draws loading screen
      loading(tableCanvas, loadText);
      renderTableCanvas();
    }
    
    drawDelay--;
  }
  
  // These are usually run in setup() but we put them here so that 
  // the 'loading' screen successfully runs for the user
  else if (!initialized) {
    initContent(tableCanvas);
    initialized = true;
  }
  
  // Methods run every frame (i.e. 'draw()' functions) go here
  else {
    
    // These are initialization functions that may be called while the app is running
    if (!keyLoaded) {
      keyInit();
      keyLoaded = true;  
    }
//    
//    
    mainDraw();
    // Print Framerate of animation to console
    if (showFrameRate) {
      println(frameRate);
    }
    
    // If true, saves every frame of the main canvas to a PNG
    if (printFrames) {
      //tableCanvas.save("videoFrames/" + millis() + ".png");
      save("videoFrames/" + millis() + ".png");
    }
  }
//  geoMap2.draw();    
  stroke(255, 0, 0);  //roadnetwork color
}

void renderTableCanvas() {
  background(0);
  image(tableCanvas, 0, 0, tableCanvas.width, tableCanvas.height);
}  

