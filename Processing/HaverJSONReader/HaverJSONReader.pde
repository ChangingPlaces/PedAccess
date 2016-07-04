PImage map;
JSONArray nodes40, nodes20, nodes10;

void setup() {
  size(2*720, 2*880);
  
  // Loads a map of singapore that is 3,520m x 2,880m, centered at (1.33342 lat, 103.74234 lon)
  map = loadImage("singapore_40.png");
  map.resize(width, height);
  
  // Loads Nina's exported nodes
  nodes40 = loadJSONArray("data/nodes40_meters_72_by_88.json");
  println("Number of 40m nodes: " + nodes40.size());
  
  nodes20 = loadJSONArray("data/nodes20_meters_144_by_176.json");
  println("Number of 20m nodes: " + nodes20.size());
  
  nodes10 = loadJSONArray("data/nodes10_meters_288_by_352.json");
  println("Number of 10m nodes: " + nodes10.size());
  
  // Cleans nodes such that u, v are in grid units, not pixels
  cleanNodes(nodes40, 72);
  cleanNodes(nodes20, 144);
  cleanNodes(nodes10, 288);
}

void draw() {
  background(0);
  image(map, 0, 0);
  
  //drawNodes(nodes40, 72);
  //drawNodes(nodes20, 144);
  drawNodes(nodes10, 288);
}

void cleanNodes(JSONArray nodes, int arrayWidth) {
  
  printNode(nodes, 0);
  
  // Nina's node values are in arbitrary pixelsaccording to the following:
  float gridScale = 800.0/arrayWidth;
  
  JSONObject node;
  float u, v;
  
  for (int i=0; i<nodes.size(); i++) {
    node = nodes.getJSONObject(i);
    u = node.getFloat("u");
    v = node.getFloat("v") + 72;
    node.setInt("u", int(u/gridScale));
    node.setInt("v", int(v/gridScale));
  }
  
  printNode(nodes, 0);
}

void printNode(JSONArray nodes, int i) {
  if (nodes.size() > 0) {
    println("Node(" + i + ").u: " + nodes.getJSONObject(i).getInt("u") );
    println("Node(" + i + ").v: " + nodes.getJSONObject(i).getInt("v") );
    println("Node(" + i + ").z: " + nodes.getJSONObject(i).getInt("z") );
    println("Node(" + i + ").crossing: " + nodes.getJSONObject(i).getBoolean("crossing") );
  }  
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
    
    if (node.getInt("z") == 0) {
      fill(255, 0, 0);
    } else {
      fill(0, 255, 0);
    }
    noStroke();
    ellipse (u*gridWidth, v*gridWidth, 0.5*gridWidth, 0.5*gridWidth);
  }
}
