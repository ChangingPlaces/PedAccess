/* PedAccess is a derivative of Pixelizer.  It's purpose it to render geospatial urban data and run analysis an simulation of pedestrain networks

/* Pixelizer is a script that transforms a cloud of weighted latitude-longitude points
 * into a discrete, pixelized aggregation data set.  Input is a TSV file
 * of weighted lat-lon and output is a JSON.
 *
 *      ---------------> + U-Axis
 *     |
 *     |
 *     |
 *     |
 *     |
 *     |
 *   + V-Axis
 *
 * Ira Winder (jiw@mit.edu)
 * Mike Winder (mhwinder@gmail.com)
 * Write Date: January, 2015
 *
 */

/* Graphics Architecture:
 *
 * projector  <-  main  <-  table  <-  (p)opulation, (h)eatmap, (s)tores(s), (l)ines, (c)ursor, input
 *                 ^
 *                 |
 *               screen <-  (i)nfo <-  minimap, legendH, legendP
 */
 
 // This is the staging script for the Pathfinding for agent-based modeling
// Ira Winder, MIT Media Lab, jiw@mit.edu, Fall 2015


//int canvasWidth = 1920;
//int canvasHeight = 1200;
int canvasWidth = 1200;
int canvasHeight = 700;

boolean bw = true;

boolean enableProjectionMapping = false;


float version = 1.1;
String loadText = "AgentDemo | Version " + version;

boolean printFrames = false;


// Number of frames for draw function to run before
// running setup functions. Setting to greater than 0 
// allows you to draw a loading screen
int drawDelay = 10;

 

String systemOS;

// Library needed for ComponentAdapter()
import java.awt.event.*;

// 0 = Denver
// 1 = San Jose
// 2 = Singapore
int modeIndex = 2;

// 0 = random
// 1 = rows
// 2 = clear
int randomType = 2;

int projectorWidth = 1920;
int projectorHeight = 1200;
int projectorOffset = 1842;

int screenWidth = 1842;
int screenHeight = 1026;

boolean hideWallyWorld = true;

// Set this to true to display the main menu upon start
boolean showMainMenu = true;
boolean showFrameRate = false;

boolean showStores = false;
boolean showDeliveryData = false;
boolean showPopulationData = true;
boolean showBasemap = true;

boolean showInputData = true;
boolean showFacilities = false;
boolean showMarket = false;
//boolean showObstacles = false;
boolean showForm = true;

boolean showOutputData = true;
boolean showDeliveryCost = true;
boolean showTotalCost = false;
boolean showAllocation = false;
boolean showVehicle = false;

boolean initialized = false;


//Walmart Logo
PImage wmt_logo;

// Class that holds a button menu
Menu mainMenu, hideMenu;

void setup() {
  size(screenWidth, screenHeight, P3D);
  
   initCanvas();

  // Frame Options

      // Window may be resized after initialized
      frame.setResizable(true);

      // Recalculates relative positions of canvas items if screen is resized
      frame.addComponentListener(new ComponentAdapter() {
         public void componentResized(ComponentEvent e) {
           if(e.getSource()==frame) {
             flagResize = true;
           }
         }
       }
       );

  // Functions run only once during setup

      // Graphics Objects for Data Layers
      initDataGraphics();

      // Initial Projection-Mapping Canvas
      initializeProjection2D();
      
      // Allows application to receive information from Colortizer via UDP
      initUDP();

      // Sets up Lego Piece Data Information
      setupPieces();

      // Initialize Input Packages for CTL Data
      dataForCTL = new ClientPackage(CTL_ADDRESS, CTL_PORT, CTL_SCALE);
      dataFromCTL = new OutputPackage(CTL_SCALE);

      // Initializes Facility Configurations
      updateFacilitiesList();

  // Functions called during setup, but also called again at other points

      // Resets the scale, resolution and extents of analysis area
      resetGridParameters();

      // Reads point data from TSV file, converts to JSON, prints to JSON, and reads in from JSON
      reloadData(gridU, gridV, modeIndex);

      // Initializes Pieces with Random Placement
      fauxPieces(randomType, tablePieceInput, IDMax);

      // Renders Minimap
      reRenderMiniMap(miniMap);

      // Refreshes the graphics available in all of the canvases
      reRender();

      // Loads and formats menu items
      loadMenu(tableWidth, tableHeight);

      //Load Walmart "Spark" Logo
      wmt_logo = loadImage("Walmart_Spark.png");
       
      systemOS = System.getProperty("os.name").substring(0,3);
      println(systemOS);
}

void mainDraw() {
  // Draw Functions Located here should exclusively be drawn onto 'tableCanvas',
  // a PGraphics set up to hold all information that will eventually be 
  // projection-mapped onto a big giant table:
  drawTableCanvas(tableCanvas);
  
  
  // Renders the finished tableCanvas onto main canvas as a projection map or screen
  renderTableCanvas();

}

void draw() {
 

  if (flagResize) {
    initScreenOffsets();
    if (applet != null) applet.reset(); // Resets Projection Graphics
    loadMenu(screenWidth, screenHeight);
    flagResize = false;
  }

  // Decode pieces only if there is a change in Colortizer input
  if (changeDetected) {
    decodePieces();
    if (!enableCTL) {
      updateFacilitiesList();
      updateOutput();
      renderOutputTableLayers(output);
    } else {
      sendCTLData();
    }
    renderDynamicTableLayers(input);
    changeDetected = false;
  }

  if (outputReady) {
    renderOutputTableLayers(output);
    outputReady = false;
  }

  background(background);

  // Render Table Surface Graphic
  renderTable();
  image(table, TABLE_IMAGE_OFFSET, STANDARD_MARGIN, TABLE_IMAGE_WIDTH, TABLE_IMAGE_HEIGHT);

  // Renders everything else drawn to Screen
  renderScreen();
  image(screen, 0, 0);

  // Exports table Graphic to Projector
  projector = get(TABLE_IMAGE_OFFSET, STANDARD_MARGIN, TABLE_IMAGE_WIDTH, TABLE_IMAGE_HEIGHT);
  margin = get(TABLE_IMAGE_OFFSET - STANDARD_MARGIN - int(mapRatio*TABLE_IMAGE_HEIGHT), STANDARD_MARGIN, int(mapRatio*TABLE_IMAGE_HEIGHT) + STANDARD_MARGIN, TABLE_IMAGE_HEIGHT);
  margin.resize(int(mapRatio*TABLE_IMAGE_HEIGHT), margin.height);
  
  // In Lieu of Projection creates the square table on main canvas for testing when on mac
  if (systemOS.equals("Mac") && testProjectorOnMac) {
    background(textColor);
    image(margin, 0, 0);
    image(projector, margin.width, 0);
  }

  fill(textColor, 80);
  text("CTL Optimization = " + enableCTL, 20, 35);
  text("(Press Spacebar to Toggle)", 20, 50);
  fill(textColor);
  
  if (waitingForCTL){
    if(waiting_blink){
      fill(walmart_light_green);
      text("** OPTIMIZING **", 20, 65);
      fill(textColor);
      waiting_blink = false;
    }
    else{
      waiting_blink = true;
    }
  }

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

}

void renderTableCanvas() {
  // most likely, you'll want a black background
  background(0);
  
  // Renders the tableCanvas as either a projection map or on-screen 
  if (!enableProjectionMapping) {
    image(tableCanvas, 0, 0, tableCanvas.width, tableCanvas.height);
  } else {
//    drawKeyStone();
  }
}  

// Method that opens a folder
String folderPath;
void folderSelected(File selection) {
  if (selection == null) { // Notifies console and closes program
    println("User did not select a folder");
    exit();
  } else { // intitates the rest of the software
    println("User selected " + selection.getAbsolutePath());
    folderPath = selection.getAbsolutePath() + "/";
    // some other startup function
  }
}


