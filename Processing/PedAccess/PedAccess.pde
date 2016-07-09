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
 * Write Date: January, 2016
 *
 */

/* Graphics Architecture:
 *
 * projector  <-  main  <-  table  <-  (p)opulation, (h)eatmap, (s)tores(s), (l)ines, (c)ursor, input
 *                 ^
 *                 |
 *               screen <-  (i)nfo <-  minimap, legendH, legendP
 */

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
int projectorHeight = 1080;
int projectorOffset = 1882;

int screenWidth = 1882;
int screenHeight = 1058;

boolean hideWallyWorld = true;
boolean implementMenu = true;
boolean implementAgents = true;

// Set this to true to display the main menu upon start
boolean showMainMenu = true;
boolean showFrameRate = false;

boolean showStores = false;
boolean showDeliveryData = false;
boolean showPopulationData = false;
boolean showBasemap = true;
boolean showNetworkRaster = true;

boolean showInputData = true;
boolean showFacilities = false;
boolean showMarket = false;
// boolean showObstacles = false;
boolean showForm = true;

boolean showOutputData = true;
boolean showDeliveryCost = true;
boolean showTotalCost = false;
boolean showAllocation = false;
boolean showVehicle = false;

//Walmart Logo
PImage wmt_logo;

// Class that holds a button menu
Menu mainMenu, hideMenu;

void setup() {
  size(screenWidth, screenHeight, P3D);

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
      
      if (implementAgents) setup_Agents();
      
      importPedNetwork();
      importPointsOfInterest();
      initWalkAccess();
      calcWalkAccess(0);
      calcWalkAccess(1);
      calcWalkAccess(2);
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
    println("New Pieces: " + newPOIs.size());
    refreshFinder(tableCanvas);
    initAgents(tableCanvas);
    calcWalkAccess(ageDemographic);
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
  
  if (implementAgents) draw_Agents();
  

//  // Renders everything else drawn to Screen
//  renderScreen();
//  image(screen, 0, 0);
  
  
  
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



//  // CTL Stuff
//  fill(textColor, 80);
//  text("CTL Optimization = " + enableCTL, 20, 35);
//  text("(Press Spacebar to Toggle)", 20, 50);
//  fill(textColor);
//  
//  if (waitingForCTL){
//    if(waiting_blink){
//      fill(walmart_light_green);
//      text("** OPTIMIZING **", 20, 65);
//      fill(textColor);
//      waiting_blink = false;
//    }
//    else{
//      waiting_blink = true;
//    }
//  }
  
  if (UDPdelay > 0) {
    UDPdelay--;
    if (UDPdelay == 0) allowUDP = true;
  }
  
  if (allowUDP) {
    if (showWalkAccess) drawWalkAccess();
    drawPOIs();
    drawSideBar();
  }
  
  if (changeClock > 0) {
    changeClock--;
    if (changeClock == 0) changeDetected = true;
  }
  
  println("changeClock " + changeClock);

}

void drawSideBar() {
  fill(0);
  int barWidth = int(4.0*TABLE_IMAGE_WIDTH/18);
  int barHeight = TABLE_IMAGE_HEIGHT;
  translate(TABLE_IMAGE_OFFSET - barWidth, STANDARD_MARGIN);
  
  stroke(textColor);
  //rect(0, 0, barWidth, barHeight);
  strokeWeight(1);
  
  fill(textColor);
  text("LEGEND", 10, 20);
  
  translate(10, 30);
  int gridSpace = 8; // pixels
  Integer[][] currentForm;
  for (int i=0; i<14; i++) {
    currentForm = inputForm.get(i);
    for (int u=0; u<currentForm.length; u++) {
      for (int v=0; v<currentForm[0].length; v++) {
        fill(#666666);
        if (currentForm[u][v] > 0) findFormFill(currentForm[u][v]);
        if (i != 8 && i != 11) {
          if (i < 8) rect(v*gridSpace, (i*5+u)*gridSpace, gridSpace, gridSpace);
          else if (i < 11) rect(v*gridSpace, ((i-1)*5+u)*gridSpace, gridSpace, gridSpace);
          else rect(v*gridSpace, ((i-2)*5+u)*gridSpace, gridSpace, gridSpace);
        }
      }
    }
  }
  
  for (int i=0; i<pieceNames.length; i++) {
    fill(textColor);
    text(pieceNames[i], 4*gridSpace + 3*gridSpace, (i*5)*gridSpace + 10);
    drawIcon(4*gridSpace + gridSpace, (i*5)*gridSpace, i, gridSpace);
  }
  
//  float webScale = 1.25;
  translate(0, TABLE_IMAGE_HEIGHT - 350);
//  stroke(#CCCCCC);
//  strokeWeight(1);
//  line(barWidth/2, 0, barWidth/2, webScale*50);
//  line(barWidth/2-webScale*50, webScale*86, barWidth/2, webScale*50);
//  line(barWidth/2+webScale*50, webScale*86, barWidth/2, webScale*50);

  color red = #FF0000;
  color green = #00FF00;
  int barH = 22;
  noStroke();
  for (int i=0; i<10; i++) {
    fill(lerpColor(green, red, i/9.0));
    rect(barWidth/2, -50+i*barH, 0.3*barWidth, barH);
  }
  fill(textColor);
  rect(barWidth/2-5, -50 + barH*10*(1-avgWalkAccess[ageDemographic]), 0.3*barWidth+10, barH/4);
  
  // Walk Access
  textSize(16);
  fill(textColor);
  text("WALK", 0, -60);
  text("ACCESS", 0, -40);
  text("Young", 0, 0);
  text("Working", 0, 70);
  text("Senior", 0, 140);
  textSize(20);
  
  for (int i=0; i<3; i++) {
    fill(lerpColor(red, green, avgWalkAccess[0]));
    text(int(100*avgWalkAccess[0]) + "%", 0, 30);
    fill(lerpColor(red, green, avgWalkAccess[1]));
    text(int(100*avgWalkAccess[1]) + "%", 0, 100);
    fill(lerpColor(red, green, avgWalkAccess[2]));
    text(int(100*avgWalkAccess[2]) + "%", 0, 170);
  }
  
  fill(0, 175);
  noStroke();
  switch(ageDemographic) {
    case 0:
      rect(-5, 55, barWidth/2-10, 130);
      break;
    case 1:
      rect(-5, -15, barWidth/2-10, 60);
      rect(-5, 105, barWidth/2-10, 70);
      break;
    case 2:
      rect(-5, -15, barWidth/2-10, 130);
      break;
  }
  
  
//  // Walk Quality
//  textSize(12);
//  
//  int marg = 30;
//  textSize(16);
//  textAlign(RIGHT);
//  fill(textColor);
//  
//  text("QUALITY", barWidth-marg, -40);
//  text("Young",barWidth-marg, 0);
//  text("Working",barWidth-marg, 70);
//  text("Senior",barWidth-marg, 140);
//  textSize(20);
//  
//  fill(lerpColor(red, green, avgWalkAccess[0]));
//  text(int(100*avgWalkAccess[0]) + "%",barWidth-marg, 30);
//  fill(lerpColor(red, green, avgWalkAccess[1]));
//  text(int(100*avgWalkAccess[1]) + "%",barWidth-marg, 100);
//  fill(lerpColor(red, green, avgWalkAccess[2]));
//  text(int(100*avgWalkAccess[2]) + "%",barWidth-marg, 170);
//  
  fill(textColor);
  stroke(textColor);
  textSize(12);
  textAlign(LEFT);
  
  // Draw Scale
  translate(20, TABLE_IMAGE_WIDTH/3.0 + TABLE_IMAGE_HEIGHT/22.0);
  float w = mapRatio*TABLE_IMAGE_WIDTH;
  int scale_0 = 20;
  int scale_1 = int(w + STANDARD_MARGIN);
  translate(-scale_0, 0);
  float scalePix = float(TABLE_IMAGE_HEIGHT)/displayV;
  translate(0, -4*scalePix);
  strokeWeight(1);
  line(scale_0, 0, scale_1, 0);
  line(scale_0, -4*scalePix, scale_1, -4*scalePix);
  line(2*scale_0, 0, 2*scale_0, -scalePix);
  line(2*scale_0, -3*scalePix, 2*scale_0, -4*scalePix);
  text(int(1000*4*gridSize) + " m", 30, -1.5*scalePix);
  translate(scale_0, 0);
}

void drawPOIs() {
  JSONObject poi;
  int u, v;
  String subtype;
  boolean inBounds;
  
  for (int i=0; i<amenity.size(); i++) {
    poi = amenity.getJSONObject(i);
    u = amenity.getJSONObject(i).getInt("u") - gridPanU - gridU/2;
    v = amenity.getJSONObject(i).getInt("v") - gridPanV - gridV/2;;
    subtype = amenity.getJSONObject(i).getString("subtype");
    inBounds = u>0 && u<4*18 && v>0 && v<4*22;
    
    if (inBounds) drawIcon(int(TABLE_IMAGE_OFFSET + u*TABLE_IMAGE_WIDTH/(4.0*18)), int(STANDARD_MARGIN + v*TABLE_IMAGE_HEIGHT/(4.0*22)), subtype, 10);
  }
  
  for (int i=0; i<transit.size(); i++) {
    poi = transit.getJSONObject(i);
    u = transit.getJSONObject(i).getInt("u") - gridPanU - gridU/2;
    v = transit.getJSONObject(i).getInt("v") - gridPanV - gridV/2;;
    subtype = transit.getJSONObject(i).getString("subtype");
    inBounds = u>0 && u<4*18 && v>0 && v<4*22;
    
    if (inBounds) drawIcon(int(TABLE_IMAGE_OFFSET + u*TABLE_IMAGE_WIDTH/(4.0*18)), int(STANDARD_MARGIN + v*TABLE_IMAGE_HEIGHT/(4.0*22)), subtype, 12);
  }
  
  for (int i=0; i<newPOIs.size(); i++) {
    poi = newPOIs.getJSONObject(i);
    u = newPOIs.getJSONObject(i).getInt("u") - gridPanU - gridU/2;
    v = newPOIs.getJSONObject(i).getInt("v") - gridPanV - gridV/2;;
    subtype = newPOIs.getJSONObject(i).getString("subtype");
    inBounds = u>0 && u<4*18 && v>0 && v<4*22;
    
    if (inBounds) drawIcon(int(TABLE_IMAGE_OFFSET + u*TABLE_IMAGE_WIDTH/(4.0*18)), int(STANDARD_MARGIN + v*TABLE_IMAGE_HEIGHT/(4.0*22)), subtype, 12);
  }
}

void drawIcon(int x, int y, int type, int dim) {
  
  strokeWeight(2);
  
//  color road = #D6D6D6;
//  color ped_ground = #FFFA95;
//  color ped_xing = #FF9A3B;
//  color ped_linkway = #3BFFF4;
//  color ped_bridge = #FF453B;
//  color ped_2nd = #4BCB2F;
  
  switch (type) {
    case 0: // School
      fill(tanBrick);
      stroke(textColor);
      rect(x, y, dim, dim);
      break;
    case 1: // Childcare
      fill(greenBrick);
      stroke(textColor);
      rect(x, y, dim, dim);
      break;
    case 2: // Healthcare
      fill(redBrick);
      stroke(textColor);
      rect(x, y, dim, dim);
      break;
    case 3: // Eldercare
      fill(brownBrick);
      stroke(textColor);
      rect(x, y, dim, dim);
      break;
    case 4: // Retail
      fill(blueBrick);
      stroke(textColor);
      ellipse(x+dim/2, y+dim/2, dim, dim);
      break;
    case 5: // Park
      fill(greenBrick);
      stroke(textColor);
      triangle(x+dim/2, y, x+dim+3, y+dim+3, x-3, y+dim+3);
      break;
    case 6: // Transit
      fill(redBrick);
      stroke(textColor);
      ellipse(x+dim/2, y+dim/2, dim, dim);
      break;
    case 7: // Ped Path
      stroke(ped_ground);
      strokeWeight(4);
      line(x-2, y+dim/2, x+dim+2, y+dim/2);
      break;
    case 8: // Housing
      fill(tanBrick);
      stroke(textColor);
      ellipse(x+dim/2, y+dim/2, dim, dim);
      break;
    case 9: // Ped Bridge
      stroke(ped_bridge);
      strokeWeight(4);
      line(x-2, y+dim/2, x+dim+2, y+dim/2);
      break;
    case 10: // elevated path
      stroke(ped_2nd);
      strokeWeight(4);
      line(x-2, y+dim/2, x+dim+2, y+dim/2);
      break;
    case 11: // Ped Crossing
      stroke(ped_xing);
      strokeWeight(4);
      line(x-2, y+dim/2, x+dim+2, y+dim/2);
      break;
  }
}

void drawIcon(int x, int y, String subtype, int dim) {
  if (subtype.equals("school"))
    drawIcon(x, y, 0, dim);
  if (subtype.equals("child_care"))
    drawIcon(x, y, 1, dim);
  if (subtype.equals("health"))
    drawIcon(x, y, 2, dim);
  if (subtype.equals("eldercare"))
    drawIcon(x, y, 3, dim);
  if (subtype.equals("retail"))
    drawIcon(x, y, 4, dim);
  if (subtype.equals("park"))
    drawIcon(x, y, 5, dim);
  if (subtype.equals("bus_stop"))
    drawIcon(x, y, 6, dim);
  if (subtype.equals("mrt"))
    drawIcon(x, y, 6, dim);
  if (subtype.equals("housing"))
    drawIcon(x, y, 8, dim);
}
