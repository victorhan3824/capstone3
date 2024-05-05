void game() {
  /*
  display: 1536 x 864, this is the dimensions for the canvas for processing, 
  however build bar is at the buttom, so actual display is 1536 x 800
  this means when tileSize = 32, map needs to be 48 x 25  
  */
  animateEverything();
  
  //calculating things for enemies
  for (int i=0; i<enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.show();
    e.act();
  }  
  //calculating things for bullets
  for (int i=0; i<bullets.size(); i++) {
    bullets.get(i).act();  
  }
  
  nextWaveB.show();
  buildB.show();
  quitB.show();
  enemySpawn();
  
  if (quitB.buttonClicked()) mode = END;
  if (buildB.buttonClicked()) mode = BUILD;
  if (health <= 0) mode = END;  
}

void enemySpawn() {
  int totalAmt = waveNum*2; 
  if (nextWaveB.buttonClicked() && enemies.size() == 0 && amtSpawned == totalAmt) {
    waveNum++;
    amtSpawned = 0;
  }
  //enemy(x, y, vx=0, vy=0, speed, size/diameter, hp, value, image)
  
  if (frameCount % 20 == 0 && amtSpawned < totalAmt) {
    //type 2
    enemies.add(new Enemy(startX, startY, 0, 0, 4, 50, 50, 5, e2pic));    
    //type 3
    enemies.add(new Enemy(startX, startY, 0, 0, 1, 60, 500, 5, e3pic));  
    //type 1
    enemies.add(new Enemy(startX, startY, 0, 0, 8, 30, 5, 5, e1pic));  //enemy speed can ONLY be 1,2,4,8,16 (due to the movement code)    
    
    amtSpawned+=2;
  }  
}

void animateEverything() { //also used in BUILD
  //this function is for displaying everything that is shown in both GAME and BUILD
  background(white);
  noStroke();
  //the bar
  fill(blue);
  rect(width/2, 832, width, 64);
  //showing terrain
  terrainShow();  
  //calculating things for towers
  for (Tower t: towers) {
    t.act();  
  }
  //wave count display
  textSize(32);
  fill(white);
  text("WAVE COUNT: " + waveNum, width/2, 38);
  
  //money and health display
  textSize(16);
  text("Health: " + health, 1450,38);
  text("Resources: " + money, 1450, 55);
}

void terrainShow() {
  //draw the terrain
  for (Tile[] tt: terrain) {
    for (Tile t: tt) {
      t.show();  
    }
  }
}
