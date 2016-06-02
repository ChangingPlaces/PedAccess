void hover(){

//see region at mouse position
  int loc = geoMap.getID(mouseX, mouseY);
  if (loc != -1)
  {
    //give it a different fill
    fill(#ffff66);
    geoMap.draw(loc);
   
    //print attribute
    String name = geoMap.getAttributes().getString(loc, 2);
    fill(0);
    text(name, mouseX+5, mouseY-5);
  }
}
