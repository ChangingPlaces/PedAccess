boolean showlines, showPOI, showGrid;

void keyPressed() {
     //draws lines
      if (key=='l') {
         showlines = toggle(showlines);
      }
     
      else if (key=='p') {
          showPOI = toggle(showPOI);
      } 
      
      else if (key == 'g'){
        showGrid = toggle(showGrid);
      }
}

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}