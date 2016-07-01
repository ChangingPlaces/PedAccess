class Grid{
  int dim;
  float cellwidth, cellheight, areawidth, areaheight;

  void scale(int dim, float cellwidth){
    cellheight = cellwidth*(22.0/18.0);
  }

}
