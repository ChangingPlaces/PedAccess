void importNodes() {
  
  switch(scale) {
    case 5:
      nodes = loadJSONArray("data/" + data5);
      break;
    case 10:
      nodes = loadJSONArray("data/" + data10);
      break;
    case 20:
      nodes = loadJSONArray("data/" + data20);
      break;
    case 40:
      nodes = loadJSONArray("data/" + data40);
      break;
  }
  
  println("Number of nodes: " + nodes.size());
  
//  // Loads Nina's exported nodes
//  nodes40 = loadJSONArray("data/nodes40_meters_72_by_88.json");
//  println("Number of 40m nodes: " + nodes40.size());
//  
//  nodes20 = loadJSONArray("data/nodes20_meters_144_by_176.json");
//  println("Number of 20m nodes: " + nodes20.size());
//  
//  nodes10 = loadJSONArray("data/nodes10_meters_288_by_352.json");
//  println("Number of 10m nodes: " + nodes10.size());
  
//  // Cleans nodes such that u, v are in grid units, not pixels
//  cleanNodes(nodes40, 72);
//  cleanNodes(nodes20, 144);
//  cleanNodes(nodes10, 288);
  
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
