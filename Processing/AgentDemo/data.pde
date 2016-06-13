// Objects for converting Latitude-Longitude to Canvas Coordinates
   
    //need for both scales
    // corner locations for topographic model (latitude and longitude)
    PVector UpperLeft = new PVector(1.344774, 103.733616);
    PVector UpperRight = new PVector(1.344774, 103.745163);
    PVector LowerRight = new PVector(1.338609, 103.745163);
    PVector LowerLeft = new PVector(1.338609, 103.733616);
    
    //Amount of degrees rectangular canvas is rotated from horizontal latitude axis
    float rotation = 25.5000; //degrees
    float lat1 = 103.745163; // Uppermost Latitude on canvas
    float lat2 = 42.496164; // Lowermost Latitude on canvas
    float lon1 = 1.509961; // Leftmost Longitude on canvas
    float lon2 = 1.549798; // Rightmost Longitude on canvas
     
    MercatorMap mercatorMap; // rectangular projection environment to convert latitude and longitude into pixel locations on the canvas
