
          
void MiniBox() {

Table box; 
    try {
      box = loadTable("export/" + nrows + "_" + centerlon  + "_" + centerlat + ".csv", "header");
      println("yay");
    } catch(RuntimeException e){
      box = new Table();
      println("sad");
    }

   
    
}
   
