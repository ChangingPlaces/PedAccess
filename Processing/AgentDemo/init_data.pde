void initData(){ 
          amenities = loadTable("data/temp-nodes.csv", "header");
          ped_nodes = loadTable("data/pednetv2nodes.csv", "header");
          bus_stops = loadTable("data/EZ-nodes.csv", "header");
          second_ped = loadTable("data/2ndmerc.csv", "header");
          bridges = loadTable("data/bridges_links.csv", "header");
}
