Table pednetwork, roadnetwork, bridges, intersections, secondstory, coveredlinks;

void initData(){
      pednetwork = loadTable("data/pednet.csv", "header");
      roadnetwork = loadTable("data/road.csv", "header");
      bridges = loadTable("data/overhead.csv", "header");
      intersections = loadTable("data/crossings.csv", "header");
      secondstory = loadTable("data/second.csv", "header");
      coveredlinks = loadTable("data/cover.csv", "header");

      
      println("data loaded");
}
