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
    //x2 < x1; y2<y1
    //float x2 = 100;
    //float x1 = 200;
    //float y2 = 40;
    //float y1 = 200;
    
    //x2>x1; y1<y2
    //float x2 = 100;
    //float x1 = 200;
    //float y2 = 40;
    //float y1 = 20;
    
    //x2 > x1; y2>y1
    //float x2 = 200;
    //float x1 = 100;
    //float y2 = 400;
    //float y1 = 20;
    
     //x2 < x1; y2>y1
    float x2 = 100;
    float x1 = 200;
    float y2 = 400;
    float y1 = 20;
    
    if(y2 < y1){
      y1 = y2;
    }
    
    if(x2 < x1){
      x1 = x2;
    }
    
   PVector start = new PVector(x1, y1);
   PVector end = new PVector(x2, y2);
    
    stroke(#00ff99);
    line(x1, y1, x2, y2);
    
    stroke(#ff0000);
    ellipse(x1, y1, 15, 15);
    stroke(#0000ff);
    ellipse(x2, y2, 15, 15);
    
    float dx = end.x - start.x;
    float dy = end.y - start.y;
    
        if(dx > dy){
          Steps = abs(dx);
        }
        else{
          Steps = abs(dy);        
        }
        
    float xInc =  dx/(Steps);
    float yInc = dy/(Steps);
    
    float x = start.x;
    float y = start.y;
    
    for(int v = 0; v< (int)Steps; v++){
        x = x + xInc;
        y = y + yInc;
        noFill();
        if(x <= end.x && y<= end.y){
        coords.add(new PVector(x, y));
        }
    }
}