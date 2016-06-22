void setup() {
  size(1000, 500);
}

float x, y, dx, dy;

int scale = 12;
float Steps;

ArrayList<PVector> coords = new ArrayList<PVector>();
float x2 = 900;
float x1 = 700;
float y2 = 200;
float y1 = 200;
PVector end, start;
void draw() {
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
      for (int p = 0; p<coords.size(); p++) {
        if (abs(a - coords.get(p).x) <= scale/2 && abs(b - coords.get(p).y) <= scale/2) {
          stroke(#ffff00);
          ellipse(a, b, 12, 12);
        }
      }
    }
  }

  if (y2 < y1 || x2 < x1) {
    start = new PVector(x2, y2);
    end = new PVector(x1, y1);
  }
  
  
  else{
    start = new PVector(x1, y1);
    end = new PVector(x2, y2);
  }
  


  dx = end.x - start.x;
  dy = end.y - start.y;


  stroke(#00ff99);
  line(x1, y1, x2, y2);

  stroke(#ff0000);
  ellipse(x1, y1, 15, 15);
  stroke(#0000ff);
  ellipse(x2, y2, 15, 15);



  if (dx > dy) {
    Steps = abs(dx);
  } else {
    Steps = abs(dy);
  }

  float xInc =  dx/(Steps);
  float yInc = dy/(Steps);

  float x = start.x;
  float y = start.y;

  for (int v = 0; v< (int)Steps; v++) {          
    x = x + xInc;
    y = y + yInc;
    noFill();
    if (x <= end.x && y<= end.y) {
      coords.add(new PVector(x, y));
    }
  }
}