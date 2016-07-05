PImage map;
JSONArray nodes40, nodes20, nodes10, nodes5;

int gridU = 2*4*72;
int gridV = 2*4*88;

void setup() {
  size(4*gridU, 4*gridV);
  
  // Loads Raster Images into memory with variable alpha()
  importRaster();
  
  // Resamples each raster image into a grid of nodes
  for (int i=0; i<6; i++) {
    processRaster(networkRaster[i], gridU, gridV, i);
  }
  
  // saves the JSONArray to file
  saveJSONArray(rasterNodes, "data/nodes5_meters_576_by_704.json");
  
  // Loads Node Network from JSON
  importNodes();
  
  // Loads a map of singapore that is 3,520m x 2,880m, centered at (1.33342 lat, 103.74234 lon)
  map = loadImage("singapore_40.png");
  map.resize(width, height);
  image(map, 0, 0);
  
  // Draws the Node Network
  drawNodes(nodes5, gridU);
  
}

void drawNodes(JSONArray nodes, int arrayWidth) {
  
  // Calculates grid pixel width based upon canvas size and array size:
  float gridWidth = float(width) / arrayWidth;
  
  JSONObject node;
  int u, v;
  
  for (int i=0; i<nodes.size(); i++) {
    node = nodes.getJSONObject(i);
    u = node.getInt("u");
    v = node.getInt("v");
    
    noFill();
    
    color road = #D6D6D6;
    color ped_ground = #FFFA95;
    color ped_xing = #FF9A3B;
    color ped_linkway = #3BFFF4;
    color ped_bridge = #FF453B;
    color ped_2nd = #4BCB2F;
    
    if (node.getString("type").equals("road")) {
      stroke(road);
    }
    if (node.getString("type").equals("ped_ground")) {
      stroke(ped_ground);
    }
    if (node.getString("type").equals("ped_xing")) {
      stroke(ped_xing);
    }
    if (node.getString("type").equals("ped_linkway")) {
      stroke(ped_linkway);
    }
    if (node.getString("type").equals("ped_bridge")) {
      stroke(ped_bridge);
    }
    if (node.getString("type").equals("ped_2nd")) {
      stroke(ped_2nd);
    }
    
    ellipse (u*gridWidth, v*gridWidth, gridWidth, gridWidth);
  }
}
