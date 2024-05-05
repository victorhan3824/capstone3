
void select() {
  generalDisplay();
  selectionCalculation();
}

void generalDisplay() {
  background(gold);
  image(selectPic, width/2, height/2);  
  
  textSize(72);
  text("SELECT YOUR BATTLE", width/2, 150);
  
  textSize(32);
  map1B.show();
  text("Map 1", width/5, 550);
  map2B.show();
  text("Map 2", width*0.4, 550);
  map3B.show();
  text("Map 3", width*0.6, 550);
  map4B.show();  
  text("Map 4", width*0.8, 550);
}

void selectionCalculation() {
  if (map1B.buttonClicked()) {
    mode = GAME;
    loadTerrain(map1);
  }
  if (map2B.buttonClicked()) {
    mode = GAME;
    loadTerrain(map2);
  }
  if (map3B.buttonClicked()) {
    mode = GAME;
    loadTerrain(map3);
  }
  if (map4B.buttonClicked()) {
    mode = GAME;
    loadTerrain(map4);
  }  
}

void loadTerrain(PImage MAP) {
  for (int x=0; x<48; x++) {
    for (int y=0; y<25; y++) {
      color c = MAP.get(x,y);
      Tile t = new Tile(tileSize/2 + x*tileSize, tileSize/2 + y*tileSize, 0);
      switch(c) {
        case tGreen:
          t.type = 0;
          t.tileGraphic = land;
          break;
        case tRed:
          t.type = 1;
          t.tileGraphic = road;
          break;
        case tYellow:
          t.type = 2;
          t.tileGraphic = forest;
          break;
        case tBlue:
          t.type = 3;
          t.tileGraphic = water;
          break;
        case tWhite: //starting block, only difference between this and regular road is that the system would copy down the coords for these
          t.type = 1;
          t.tileGraphic = road;
          startX = t.x;
          startY = t.y;
          break;
        case tBlack: //ending block
          t.type = 4;
          t.tileGraphic = end;
          break;
      }
      terrain[x][y] = t;
    }
  }
}
