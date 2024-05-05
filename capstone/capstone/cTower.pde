

public class Tower {
  final int PLACING = 0; //this mode is when we are selcting locations, 
                         //tower follows the mouse
  final int PLACED = 1; //this mode means tower is in place
  
  float x, y;
  int type, value, range;
  int status; //sets the placing status
  boolean inRange; //checks whether there is enemy in range
  Enemy target;
  PImage pic;
  
  Tower(int T, float X, float Y, int R, PImage P) {
      type = T;
      x = X;
      y = Y;
      status = PLACING;
      range = R; 
      inRange = false;
      target = null;
      pic = P;
  }
  
  void act() {
    //graphical display: 
    if (status == PLACED) {
      image(pic, x, y);
    } else if (status == PLACING) {
      //display ranges of towers already there
      strokeWeight(3);
      stroke(color(20,20,20, 50));
      fill(color(20,20,20,30));
      for (int i=0; i<towers.size() - 1; i++) {
        circle(towers.get(i).x, towers.get(i).y, 2*towers.get(i).range);
      }
      //display range
      stroke(color(0,255,0,200));
      fill(color(0,255,0,50));
      circle(mouseX, mouseY, range*2);
      noStroke();
      //displaytower
      image(pic, mouseX, mouseY); 
      if (mousePressed && allowPlace()) {
        this.x = (round(mouseX/32) * 32) + 16;
        this.y = (round(mouseY/32) * 32) + 16;
        status = PLACED;
      }
    }
    
    for (Enemy e : enemies) {
      if (dist(x, y, e.x, e.y) < range) {
        inRange = true;
        target = e;
      }
    }    
    
    if (enemies.size() != 0 && inRange) { //firing enemies when they exist
      switch(type) {
        case 0: 
          type0act();
          break;
        case 1: 
          type1and3act(10);
          break;
        case 2: 
          type2act();
          break;
        case 3: 
          type1and3act(40);
          break;
      }  
    }
    
    inRange = false;
  }
  
  boolean allowPlace() { //checking if placement is the correct tile type AND whether there is already a tower there
    boolean allowed = true; 
    
    float placementLocationX = (round(mouseX/32) * 32) + 16;
    float placementLocationY = (round(mouseY/32) * 32) + 16;
    
    int Xindex = round(mouseX/32);
    int Yindex = round(mouseY/32);
    
    if (mouseY < 800) { //making sure user is pressing inside the game area
      if (terrain[Xindex][Yindex].type == 0) { //correct tile type?
        for (Tower tt: towers) {
          if (tt.x == placementLocationX && tt.y == placementLocationY) allowed = false;  
        }
      } else allowed = false;
    } else allowed = false;
    return allowed;  
  }
  
  //boolean specialCase() { //special exception for forest tile, you can place type 
    
  //}
  
  void type0act() { //area damage tower
    if (frameCount % 30 == 0) {
      bullets.add(new DamageRing(this.x, this.y, this.range)); //ring lasts 3 frame
    }
  }
  
  void type1and3act(int threshold) { //short range shooter & long range sniper
    float dx = target.x - this.x;
    float dy = target.y - this.y;
    
    float angle = atan(dy/dx); //calculates the angle between this and the enemy
    float speed = 30;    
    float newVX = (dx/abs(dx))*speed*cos(angle); 
    float newVY = (dx/abs(dx))*speed*sin(angle);
    
    if (frameCount % threshold == 0) bullets.add(new Bullet(this.x, this.y, newVX, newVY, this.range));    
  }
  
  void type2act() { //cannon with shells
    float dx = target.x - this.x;
    float dy = target.y - this.y;
    
    float angle = atan(dy/dx); //calculates the angle between this and the enemy
    float speed = 16;    
    float newVX = (dx/abs(dx))*speed*cos(angle); 
    float newVY = (dx/abs(dx))*speed*sin(angle);
    
    if (frameCount % 50 == 0) bullets.add(new Grapeshot(this.x, this.y, newVX, newVY, this.range));        
  }
}
