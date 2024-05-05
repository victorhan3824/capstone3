//final variables
final int INTRO = 0;
final int END = 1;
final int GAME = 2;
final int BUILD = 3;
final int LEADERBOARD = 4;
final int SELECT = 5;

//colors
final color blue =   #023e8a;
final color red =    #d00000;
final color gold =   #ffc300;
final color black =  #000000;
final color white =  #ffffff;
final color indigo = #03045e;
final color brown =  #bc8a5f;

//tile colors (on the map, this is what the program will be reading)
final color tBlue   = #00b7ef; //river
final color tRed    = #ed1c24; //path
final color tYellow = #fff200; //forest
final color tGreen  = #a8e61d; //land
final color tWhite  = #ffffff; //starting block
final color tBlack  = #000000; //ending block

//map
PImage map1, map2, map3, map4; //the 4 maps
PImage map1pic, map2pic, map3pic, map4pic; //the 4 pics that are used for buttons selecting maps

//int/float variables----------------------------------
int mode, tileSize;
float startX, startY;
int money, health, waveNum;
int amtSpawned; //used for enemy spawning

//buttons -----------------------------------------
Button playB, leaderboardB, map1B, map2B, map3B, map4B;
Button buildB, nextWaveB, gameB, quitB;
Button t0B, t1B, t2B, t3B; //tower building buttons
Button returnB;
Button startB; //go from leaderboard mode to start screen

//aesthetics -------------------------------------------
PFont font;
PImage land, road, forest, water, end;
PImage introPic, selectPic, leaderboardPic, endPic; //background images
PImage sniper, riflemen, cavalry, artillery; //tower pics
PImage e1pic, e2pic, e3pic; //enemy pics
String userName;

//array & arraylists
Tile[][] terrain;
ArrayList<Enemy> enemies;
ArrayList<Tower> towers;
ArrayList<Bullet> bullets;

//key
boolean qkey;

//actual code-------------------------------------------
void setup() {
  fullScreen();
  imageMode(CENTER);
  mode = INTRO;
  
  numbersInitiate();
  arrInitiate();
  aestheticsLoad();
  loadMap();
  buttonMake();
  
  qkey = false;
  
  textFont(font, 24);
}

void numbersInitiate() {
  //initialize int and float
  tileSize = 32;
  
  health = 10;
  money = 9999;
  waveNum = amtSpawned = 0;
}

void arrInitiate() {
  //initialize array and arraylists
  terrain = new Tile[48][25]; //must be 48 x 25
  enemies = new ArrayList<Enemy>();
  towers  = new ArrayList<Tower>();
  bullets = new ArrayList<Bullet>();
}

void aestheticsLoad() {
  //load images & fonts  
  font = createFont("aesthetics/Napoleon-Bold.ttf", 24);
  
  land = loadImage("aesthetics/grass.jpg");
  road = loadImage("aesthetics/path.jpg");
  forest = loadImage("aesthetics/forest.jpg");
  water = loadImage("aesthetics/water.jpg");
  end = loadImage("aesthetics/end.jpg");
  
  //background images
  introPic = loadImage("aesthetics/intropic.jpg");
  selectPic = loadImage("aesthetics/selectpic.jpg");
  leaderboardPic = loadImage("aesthetics/leaderboardpic.jpg");
  endPic = loadImage("aesthetics/endpic.jpg");
  
  PImage[] PP = {introPic, selectPic, leaderboardPic, endPic};
  for (int i=0; i<PP.length; i++) PP[i].resize(width,height);
  
  //tower pics
  sniper =  loadImage("aesthetics/sniper.png");
  riflemen =  loadImage("aesthetics/riflemen.png");
  cavalry =  loadImage("aesthetics/cavalry.png");
  artillery =  loadImage("aesthetics/artillery.png");  
  
  //resize image for tiles
  PImage[] P = {land, road, forest, water, end, sniper, riflemen, cavalry, artillery};
  for (int i=0; i<P.length; i++) {
    P[i].resize(tileSize, tileSize);  
  }
  
  //enemy pics
  e1pic = loadImage("aesthetics/e1pic.png");
  e1pic.resize(30,30);
  e2pic = loadImage("aesthetics/e2pic.png");
  e2pic.resize(50,50);
  e3pic = loadImage("aesthetics/e3pic.png");  
  e3pic.resize(60,60);
  
  //LEADERBOARD Mode stuff
  userName = "";
}

void loadMap() {
  //loading in the maps and the map pics for buttons
  map1 = loadImage("everything about maps/map1.png");
  map2 = loadImage("everything about maps/map2.png");
  map3 = loadImage("everything about maps/map3.png");
  map4 = loadImage("everything about maps/map4.png");  
  
  //the images, random for now, no need to resize because it's done in the constructor for the buttons
  map1pic = loadImage("everything about maps/map1pic.png");
  map2pic = loadImage("everything about maps/map2pic.png");
  map3pic = loadImage("everything about maps/map3pic.png");
  map4pic = loadImage("everything about maps/map4pic.png");
}

void buttonMake() {
  //INTRO
  playB = new Button(0, width*0.8, 600, 300, 60, 3, 0, blue, white, gold, "PLAY");
  leaderboardB = new Button(0, width*0.8, 675, 300, 60, 3, 0, blue, white, gold, "LEADERBOARD");
  
  //SELECT
  map1B = new Button(1,width/5,height/2,200,200,3,white,map1pic);
  map2B = new Button(1,width*0.4,height/2,200,200,3,white,map2pic);
  map3B = new Button(1,width*0.6,height/2,200,200,3,white,map3pic);
  map4B = new Button(1,width*0.8,height/2,200,200,3,white,map4pic);
  
  //GAME
  buildB = new Button(0, width*0.88, 832, 100, 50, 3, 0, white, gold, indigo, "BUILD");
  nextWaveB = new Button(0, width*0.95, 832, 100, 50, 3, 0, white, gold, indigo, "SEND"); 
  quitB = new Button(0, width*0.81, 832, 100, 50, 3, 0, white, gold, indigo, "QUIT");   
  
  //BUILD
  gameB = new Button(0, width*0.95, 832, 100, 50, 3, 0, white, gold, indigo, "PLAY");
  t0B =   new Button(0, 160, 832, 300, 50, 3, 0, white, gold, indigo, "Cavalry $150");
  t1B =   new Button(0, 470, 832, 300, 50, 3, 0, white, gold, indigo, "Riflemen $150");
  t2B =   new Button(0, 780, 832, 300, 50, 3, 0, white, gold, indigo, "Artillery $350");
  t3B =   new Button(0, 1090, 832, 300, 50, 3, 0, white, gold, indigo, "Sniper $400");
  
  //END
  returnB = new Button(0, width*0.8, 675, 300, 60, 3, 0, blue, white, gold, "Save and Return");
  
  //leaderboard
  startB = new Button(0, width*0.8, 675, 300, 60, 3, 0, blue, white, gold, "Return to Start");
}

void draw() {
  switch(mode) {
    case INTRO:
      intro();
      break;
    case SELECT:
      select();
      break;
    case GAME:
      game();
      break;
    case BUILD:
      build();
      break;
    case END:
      end();
      break;
    case LEADERBOARD:
      leaderboard();
      break;
  }
}
