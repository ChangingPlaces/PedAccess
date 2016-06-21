void setup(){
  size(1000, 500);
}

  int scale = 12;
      float Steps;
      
  ArrayList<PVector> coords = new ArrayList<PVector>();

void draw(){
   background(0);
  
   int U = int(width/scale);
   int V = int(height/scale);
   int SCALE = scale;
    //draw grid
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        float a = (i*SCALE + scale/2);
        float b = (j*SCALE + scale/2);
        
        stroke(100);
        noFill();
        ellipse(a, b, 12, 12);
        for(int p = 0; p<coords.size(); p++){
          if(abs(a - coords.get(p).x) <= scale/2 && abs(b - coords.get(p).y) <= scale/2){
          stroke(#ffff00);
          ellipse(a, b, 12, 12);
          }
        }
      }
    }
    
    //render a line with Bresenham's Algorithm
    float x1 = 200;
    float x2 = 500;
    float y1 = 0;
    float y2 = 20;
    
    stroke(#00ff99);
    line(x1, y1, x2, y2);
    
    stroke(#ff0000);
    ellipse(x1, y1, 15, 15);
    ellipse(x2, y2, 15, 15);
    
    float dx = x2-x1;
    float dy = y2-y1;
    
        if(dx > dy){
          Steps = abs(dx);
        }
        else{
          Steps = abs(dy);        
        }
        
    float xInc =  dx/(Steps);
    float yInc = dy/(Steps);
    
    float x = x1;
    float y = y1;
    
    for(int v = 0; v< (int)Steps; v++){
        x = x + xInc;
        y = y + yInc;
        noFill();
        if(x < x2 && y<y2){
        coords.add(new PVector(x, y));
        }
    }
}