class Grid{
  int dim;
  float cellwidth, cellheight, areawidth, areaheight;
  

  void render(int dim, float cellwidth){
    
    
        stroke(#00ff00);
    
         for (int i=1; i<dim; i++)
          line((i)*width/dim, 0, (i)*width/dim, Canvasheight);
        
         for (int i=1; i<dim; i++) 
               line(0, (i)*height/dim, Canvaswidth,  (i)*height/dim);
           
         fill(#00ff00);
         ellipse(Canvaswidth/2, Canvasheight/2, 10, 10);
    
  }
  
  void Object(int dim, float cellwidth){
    cellheight = cellwidth*(22.0/18.0);
  }
  
}
