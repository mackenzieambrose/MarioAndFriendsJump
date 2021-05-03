// Mario & Friends Jump CODE

import processing.sound.*;

// adding sound
SoundFile jumpingSound;
SoundFile gameOverSound;
SoundFile marioMusic;

// setting the scene 
PImage background;
PImage gameOver;
PImage titleScreen;
PImage characterSelect;


// declaring variable for finite states
char switchVal;

// declaring boolean values for the character selection
boolean peachSelect;
boolean luigiSelect;
boolean marioSelect; 
boolean yoshiSelect;
boolean toadSelect;

boolean shouldPlaySound; // if true, then plays the gameOverSound


// construct a player
Player PLAYER = new Player();//140,750,50,color(76,222,143));

// construct some platforms
ArrayList<Platform> platformList;


Animation luigiWingsAnimation;
PImage[] luigiWingsImages = new PImage[6];

Animation marioWingsAnimation;
PImage[] marioWingsImages = new PImage[6];

Animation peachWingsAnimation;
PImage[] peachWingsImages = new PImage[6];

Animation toadWingsAnimation;
PImage[] toadWingsImages = new PImage[6];

Animation yoshiWingsAnimation;
PImage[] yoshiWingsImages = new PImage[6];



void setup(){
  // setting the size of the window
  size(800,800);
  textAlign(CENTER,CENTER);
  imageMode(CENTER);
  rectMode(CENTER);
  
  shouldPlaySound = true;
  
  peachSelect = false;
  luigiSelect = false;
  marioSelect = false;
  yoshiSelect = false;
  toadSelect = false; 
  
  // adding background image (clouds)
  background = loadImage("background.png");
  // adding gameOver image/screen
  gameOver = loadImage("gameOver.png");
  // adding start image
  titleScreen = loadImage("titleScreenImage.png");
  // adding character selection image
  characterSelect = loadImage("characterSelect.png");

  
  // initial state
  switchVal = 1;
  
  
  // initialize the sound variables
  //backgroundSound = new SoundFile(this,"birdSong.mp3");
  jumpingSound = new SoundFile(this,"jumpingSound.wav");
  gameOverSound = new SoundFile(this,"gameOverSound.wav");
  marioMusic = new SoundFile(this,"marioMusic.wav");
  
  // adjusting the preferences of the sounds
  marioMusic.rate(1);
  marioMusic.amp(0.5);
  //backgroundSound.rate(1);
  //backgroundSound.amp(0.4);
  
  // adjusting the volume of the game over sound
  gameOverSound.amp(1);
  // adjusting the speed of the game over sound
  gameOverSound.rate(1);
  
  
  // adjusting the volume of the jump sound
  jumpingSound.amp(0.3);
  
  
  // fill array of Luigi Wings images
  for (int i=0; i<luigiWingsImages.length; i++){
    luigiWingsImages[i] = loadImage("luigiWings"+i+".png");
  }
  // fill array of Mario Wings images
  for (int i=0; i<marioWingsImages.length; i++){
    marioWingsImages[i] = loadImage("marioWings"+i+".png");
  }
  // fill array of Peach Wings images
  for (int i=0; i<peachWingsImages.length; i++){
    peachWingsImages[i] = loadImage("peachWings"+i+".png");
  }
  // fill array of Toad Wings images
  for (int i=0; i<toadWingsImages.length; i++){
    toadWingsImages[i] = loadImage("toadWings"+i+".png");
  }
  // fill array of Yoshi Wings images
  for (int i=0; i<yoshiWingsImages.length; i++){
    yoshiWingsImages[i] = loadImage("yoshiWings"+i+".png");
  }  
  
  
  // initialize character wings objects
  luigiWingsAnimation = new Animation(luigiWingsImages,0.1,1);
  
  marioWingsAnimation = new Animation(marioWingsImages,0.1,1);
  
  peachWingsAnimation = new Animation(peachWingsImages,0.1,1);
  
  toadWingsAnimation = new Animation(toadWingsImages,0.1,1);
  
  yoshiWingsAnimation = new Animation(yoshiWingsImages,0.1,1);
  

  platformList = new ArrayList<Platform>();
  // adding platforms to platformList
  // platform that player starts out on
  platformList.add(new Platform(100,height-10));
  platformList.add(new Platform(590,725));
  platformList.add(new Platform(310,640));
  platformList.add(new Platform(180,500));
}



void draw(){
  // background music
  if (!marioMusic.isPlaying()){
    marioMusic.play();
  }
  
  if (PLAYER.y>=height-46){
    switchVal = 4;
  }



  switch(switchVal){
    case 1:
    background(255,255,255);
    image(titleScreen,400,400);
    break;
    
    
    
    case 2:
    background(255,255,255);
    image(characterSelect,400,400);
    
    // creating the names of the characters
    fill(255,255,255);
    rect(105,730,90,46);
    textSize(30);
    fill(0,0,0);
    text("Peach",105,730);
    
    fill(255,255,255);
    rect(695,730,90,46);
    textSize(30);
    fill(0,0,0);
    text("Luigi",695,730);
    
    fill(255,255,255);
    rect(200,500,90,46);
    textSize(30);
    fill(0,0,0);
    text("Mario",200,500);
    
    fill(255,255,255);
    rect(585,500,90,46);
    textSize(30);
    fill(0,0,0);
    text("Yoshi",585,500);
    
    fill(255,255,255);
    rect(400,330,90,46);
    textSize(30);
    fill(0,0,0);
    text("Toad",400,330);
    
    break;
    
    
    
    case 3:
    // drawing the background
    image(background,width/2,height/2);
  
    if (peachSelect == true){
      peachWingsAnimation.display(PLAYER.x,PLAYER.y);
    }
    if (luigiSelect == true){
      luigiWingsAnimation.display(PLAYER.x,PLAYER.y);
    }
    if (marioSelect == true){
      marioWingsAnimation.display(PLAYER.x,PLAYER.y);
    }
    if (yoshiSelect == true){
      yoshiWingsAnimation.display(PLAYER.x,PLAYER.y);
    }
    if (toadSelect == true){
      toadWingsAnimation.display(PLAYER.x,PLAYER.y);
    }
                         
    PLAYER.moveRight();
    PLAYER.moveLeft();
    PLAYER.jump();
    PLAYER.reachedTopOfJump();
    PLAYER.fall();
    PLAYER.land();
    PLAYER.resetBoundaries();
    PLAYER.updatePoints();
    PLAYER.nextLevel();
  
    for (Platform platform1 : platformList){
      platform1.render();                            
      platform1.resetBoundaries();
      platform1.landedOn(PLAYER);  
    }
  
    PLAYER.fallOffPlatform(platformList);
    break;
    
    
    
    case 4:
    marioMusic.stop();
    
    if (gameOverSound.isPlaying()==false&& shouldPlaySound == true){
      gameOverSound.play();
      shouldPlaySound = false;
    }
 
    image(gameOver,width/2,height/2);
    fill(0,0,0);
    rect(width/2,height-200,430,50,7);
    fill(255,255,255);
    textSize(20);
    text("To restart, press the 'm' key",width/2,height-200);
    break;
    }
}



void keyPressed(){
  // when the 'd' key is pressed, the player moves to the right
  if (key == 'd'){
    PLAYER.movingRight=true;
  }
  // when the 'a' key is pressed, the player moves to the left
  else if (key == 'a'){
    PLAYER.movingLeft=true;
  }
  // when the 'w' key is pressed, the player jumps
  else if (key == 'w'){
    if (PLAYER.isJumping==false&&PLAYER.isFalling==false){
      PLAYER.isJumping=true;
      PLAYER.peakY=PLAYER.y-PLAYER.jumpHeight;
   
      // play the boing sound when the player jumps
      jumpingSound.play();
      
      // play the wings animations
      luigiWingsAnimation.isAnimating = true;
      marioWingsAnimation.isAnimating = true;
      peachWingsAnimation.isAnimating = true;
      toadWingsAnimation.isAnimating = true;
      yoshiWingsAnimation.isAnimating = true;
      
      for (Platform platform1 : platformList){
        platform1.y=platform1.y+80;
        }
      // update the platform list
      platformList.add(new Platform (random(0,width-80),PLAYER.y-40));
    }
  }
  else if (key == ' '){
    if (switchVal==1){
      switchVal=2;
    }
  }
  else if (key == 'm'){
    if (switchVal==4){
      switchVal=1;
      if (gameOverSound.isPlaying()==true){
        gameOverSound.stop();
      }
      marioMusic.loop();
      // reset values and booleans
      PLAYER.onPlatform=false;
      PLAYER.movingLeft = false;
      PLAYER.movingRight = false;
      PLAYER.isJumping = false;
      PLAYER.isFalling = false;
      PLAYER.y = 730;
      PLAYER.x = width/2;
      peachSelect = false;
      luigiSelect = false;
      marioSelect = false;
      yoshiSelect = false;
      toadSelect = false;
      shouldPlaySound = true;
      platformList.add(new Platform (width/2-40,height-10));
    }
  }
}



void keyReleased(){
  if (key == 'd'){
    PLAYER.movingRight=false;
  }
  else if (key == 'a'){
    PLAYER.movingLeft=false;
  }
}



void mousePressed(){
  if (switchVal==2){
    boolean inPeach = PLAYER.isInBox(PLAYER.peachX, PLAYER.peachY, 90, 46);
    boolean inLuigi = PLAYER.isInBox(PLAYER.luigiX, PLAYER.luigiY, 90, 46);
    boolean inMario = PLAYER.isInBox(PLAYER.marioX, PLAYER.marioY, 90, 46);
    boolean inYoshi = PLAYER.isInBox(PLAYER.yoshiX, PLAYER.yoshiY, 90, 46);
    boolean inToad = PLAYER.isInBox(PLAYER.toadX, PLAYER.toadY, 90, 46);
    if (inPeach == true){
      switchVal=3;
      peachSelect = true;
    }
    else if (inLuigi == true){
      switchVal=3;
      luigiSelect = true;
    }
    else if (inMario == true){
      switchVal=3;
      marioSelect = true;
    }
    else if (inYoshi == true){
      switchVal=3;
      yoshiSelect = true;
    }
    else if (inToad == true){
      switchVal=3;
      toadSelect = true;
    }
  }
}
