class Player {
  // variables
  int x; // player's x position
  int y; // player's y position
  int size;
  int runSpeed; // the speed of the player as it runs
  int jumpSpeed; // the speed the player jumps up in the air
  int fallSpeed; // the speed the player falls
  int topBound;  // the top boundary of the player
  int bottomBound; // the bottom boundary of the player
  int leftBound; // the left boundary of the player
  int rightBound; // the right boundary of the player
  boolean movingLeft; // when it is true, the player will move to the left
  boolean movingRight; // when it is true, the player will move to the right
  boolean isJumping; // when it is true, the player will be rising from a jump
  boolean isFalling; // when it is true, the player will be falling
  int jumpHeight; // the amount of distance the player moves up when the player jumps
  int peakY; // the y value the player will have when it reaches the top of its jump
  boolean onPlatform; // when it is true, the player is on a platform  
  int points;
  
  
  // character variables (on the character selection screen)
  int peachX; // Peach box's x position 
  int peachY; // Peach box's y position
  int marioX; // Mario box's x position
  int marioY; // Mario box's y position
  int toadX; // Toad box's x position
  int toadY; // Toad box's y position
  int yoshiX; // Yoshi box's x position
  int yoshiY; // Yoshi box's y position
  int luigiX; // Luigi box's x position
  int luigiY; // Luigi box's y position
  boolean peachPressed; // true if Peach box is pressed
  boolean marioPressed; // true if Mario box is pressed
  boolean toadPressed; // true if Toad box is pressed
  boolean yoshiPressed; // true if Yoshi box is pressed
  boolean luigiPressed; // true if Luigi box is pressed
  
  
  // constructor
  Player(){
    x = 140;//tempX;
    y = 730; //tempY;
    size = 50; //tempSize;    
    runSpeed = 8;
    jumpSpeed = 6;
    fallSpeed = 4;
    topBound = y-(115/2);
    bottomBound = y+(115/2);
    leftBound = x-31;
    rightBound = x+31;
    movingLeft = false;
    movingRight = false;
    isJumping = false;
    isFalling = false;
    
    jumpHeight = 180;
    peakY = y-jumpHeight;
    onPlatform = false;
    points = 0;

    peachX = 105-(90/2); 
    peachY = 730-(46/2); 
    marioX = 200-(90/2); 
    marioY = 500-(46/2);
    toadX = 400-(90/2);
    toadY = 330-(46/2);
    yoshiX = 585-(90/2);
    yoshiY = 500-(46/2);
    luigiX = 695-(90/2);
    luigiY = 730-(46/2);
    peachPressed = false;
    marioPressed = false;
    toadPressed = false;
    yoshiPressed = false;
    luigiPressed = false;
  }
 
 
  /*
   functions
  */
  
  
  // moves the player to the right
  void moveRight(){
    if (movingRight==true){
      x=x+runSpeed;
    }
  }
  
  // moves the player to the left
  void moveLeft(){
    if (movingLeft==true){
      x=x-runSpeed;
    }
  }
  
  // makes the player jump
  void jump(){
    if (isJumping==true&&isFalling==false){
      y=y-jumpSpeed;
    }
  }
  
  // tells whether the player has reached the top of its jump
  void reachedTopOfJump(){
    if (y<peakY&&isJumping==true){
      isJumping=false;
      isFalling=true;
    }
  }
  
  // makes the player fall
  void fall(){
    if (isFalling==true&&isJumping==false){
      y=y+fallSpeed;
    }
  }
  
  // tells whether the player has hit the ground
  void land(){
    if (bottomBound>=height){
      isFalling=false;
    }
  }
  
  // updates the player's boundaries as the player moves
  void resetBoundaries(){
    topBound = y;
    bottomBound = y+size;
    leftBound = x;
    rightBound = x+size;
  }
  
  // tells whether the player is on a platform when the player is not jumping
  void fallOffPlatform(ArrayList<Platform> somePlatforms){
    if (isJumping==false&&y+size<=height){
      onPlatform=false;
      for (Platform platform1 : somePlatforms){
        if (bottomBound>=platform1.topBound){
          if (topBound<=platform1.bottomBound-size){
            if (leftBound<=platform1.rightBound){
              if (rightBound>=platform1.leftBound){
                onPlatform=true;
              }
            }
          }
        }
      }
      if (onPlatform==false){
        isFalling=true;
      }
    }
  }
  
  void nextLevel(){
    if (y<=0){
      PLAYER.onPlatform=true;
      PLAYER.movingLeft = false;
      PLAYER.movingRight = false;
      PLAYER.isJumping = false;
      PLAYER.isFalling = false;
      //isGroundSafe = false;
      PLAYER.y = 740;
      PLAYER.x = width/2;
      platformList.add(new Platform (width/2-40,height-10));
      points = points + 400;
    }
  }

  void updatePoints(){
    if (isJumping==true){
      points = points + 1;
    }
    textSize(32);
    text(points,width/2,50);
  }
  
  boolean isBetween(int aValue, int bound1, int bound2){
    if (aValue >= bound1 && aValue <= bound2){
      return true;
    }
    else {
      return false;
    }
  }
  
  boolean isInBox(int boxX, int boxY, int boxW, int boxH){
    if (isBetween(mouseX, boxX, boxX+boxW) == true){
      if (isBetween(mouseY, boxY, boxY+boxH) == true){
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }  
}
