PImage img;
Table amenities; 
Table ped_nodes;
Table bus_stops;
Table bridges;
Table second;

void initData(){
  amenities = loadTable("data/temp-nodes.csv", "header");
  ped_nodes = loadTable("data/pednetv2nodes.csv", "header");
  bus_stops = loadTable("data/EZ-nodes.csv", "header");
  bridges = loadTable("data/bridges_links.csv", "header");
  second = loadTable("data/2ndmerc.csv", "header");
  img = loadImage("map.jpg");
}
