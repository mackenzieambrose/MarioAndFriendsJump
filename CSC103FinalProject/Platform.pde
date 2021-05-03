class Platform {
  // variables
  float x;
  int y;
  int w; // the width
  int h; // the height
  color c; // the color
  int topBound;  // the top boundary of the platform
  int bottomBound; // the bottom boundary of the platform
  float leftBound; // the left boundary of the platform
  float rightBound; // the right boundary of the platform
  boolean isLandedOn; // true if the player has landed on a platform
 
  
  // constructor
  Platform(float tempX,int tempY){
    x = tempX;
    y = tempY;
    w = 80;
    h = 10;
    c = color(0,0,0);
    topBound = y;
    bottomBound = y+h;
    leftBound = x;
    rightBound = x+w;
    isLandedOn = false;
  }
  
  /*
   functions
  */
  
  // draws the platform in the window
  void render(){
    fill(0,0,0);
    rect(x,y,w,h);
  }
  
  // updates the boundaries of the platforms
  void resetBoundaries(){
    topBound = y;
    bottomBound = y+h;
    leftBound = x;
    rightBound = x+w;
  }
  
  // tells whether the player has landed on a platform
  void landedOn(Player aPlayer){
    if (aPlayer.isFalling==true){
      if (aPlayer.bottomBound>=topBound){
        if (aPlayer.topBound<=bottomBound-aPlayer.size){
          if (aPlayer.leftBound<=rightBound){
            if (aPlayer.rightBound>=leftBound){
              aPlayer.isFalling=false;
              isLandedOn=true;
            }
          }
        }
      }
    }
    else {
      isLandedOn=false;
    }
  }  
}
