boolean showPOI; 

boolean showMesh = true;
boolean showlines = true;

void keyPressed() {
     //draws lines
      if (key=='l') {
         showlines = toggle(showlines);
      }
      //draws POI
      else if(key=='p') {
         showPOI = toggle(showPOI);
      }   
      else if(key == 'g'){
         showMesh = toggle(showMesh);
      }

}

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}