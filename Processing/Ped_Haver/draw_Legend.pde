void drawLegend(){
      fill(50, 50);
      rect(width-316, height-140, 310, 130, 5);
  //draw a legend at the bottom of the screen for my own sanity
      fill(#ff00ff);       
      text("bus stop", width-200, height-20);      
      fill(#ffff00);
      text("amenities", width-200, height-40); 
      fill(100);
      text("ped network",  width-200, height-60);
      fill(255);
      text("bridge", width-200, height-80);
      fill(190);
      text("second story ped network", width-200, height-100);
      stroke(#ff0000);
      fill(#ff0000);
      text("300 meters, max ped path length", width-310, height-125);
      line(width-10, height-120,  width-310, height-120);
}