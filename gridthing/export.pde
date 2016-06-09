void makeGridAndResample(boolean resample) {
      // get grid, try catch statement for nulls
      try {
        grid = new Grid(centerlat, centerlon, cellwidth, ncols, nrows, theta );
      } 
      catch(Exception ex) {
        grid = null;
      }
      saveInfo();
}

void saveInfo() {
      Table info = new Table();
      info.addColumn("xvert");
      info.addColumn("yvert");
      for (int i =0; i<thing.size (); i++) {
        TableRow newRow = info.addRow();
        newRow.setFloat("xvert", thing.get(i).x);
        newRow.setFloat("yvert", thing.get(i).y);
      }
      saveTable(info, "export/" + nrows + "_" + centerlon  + "_" + centerlat + ".csv");
}
