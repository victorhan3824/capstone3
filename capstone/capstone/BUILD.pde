void build() {
  animateEverything(); //source in the GAME tab
  //calculating things for enemies
  for (int i=0; i<enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.show();
  }  
  
  gameB.show();
  t0B.show();
  t1B.show();
  t2B.show();
  t3B.show();
  
  if (qkey && towers.size() > 0 && towers.get(towers.size() - 1).status == 0 ) {
    towers.remove(towers.size() - 1);
  }
  
  fill(white);
  textSize(18);
  text("press Q \n to cancel", width*0.85, 832);
  noFill();
  
  if (gameB.buttonClicked()) mode = GAME;
  if (health <= 0) mode = END;
  
  if (t0B.buttonClicked() && notCurrentlyPlacing()) {
    towers.add(new Tower(0,mouseX, mouseY, 100, cavalry));
    money -= 150;
  }
  if (t1B.buttonClicked() && notCurrentlyPlacing()) {
    towers.add(new Tower(1,mouseX, mouseY, 200, riflemen));
    money -= 150;
  }
  if (t2B.buttonClicked() && notCurrentlyPlacing()) {
    towers.add(new Tower(2,mouseX, mouseY, 400, artillery));
    money -= 350; 
  }    
  if (t3B.buttonClicked() && notCurrentlyPlacing()) {
    towers.add(new Tower(3,mouseX, mouseY, 400, sniper));
    money -= 300;    
  }
}

boolean notCurrentlyPlacing () {
  //status when placing == 0
  if (towers.size() > 0) return (towers.get(towers.size() - 1).status != 0);
  else return true;
}
