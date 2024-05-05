
void intro() {
  background(brown);  
  image(introPic, width/2, height/2);
  
  textAlign(CENTER,CENTER);
  rectMode(CENTER);
  
  stroke(gold);
  fill(0,0,255,100);
  rectMode(CENTER);
  rect(width*0.5, 200, 1200, 300);
  
  fill(white);
  textSize(150);
  text("Tower Defense", width*0.5, 200);
  
  buttonCalculations();
}

void buttonCalculations() {
  leaderboardB.show();
  playB.show();
  
  if (playB.buttonClicked()) mode = SELECT;
  if (leaderboardB.buttonClicked()) mode = LEADERBOARD;
}
