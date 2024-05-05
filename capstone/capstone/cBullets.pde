public class Bullet {
  float x, y, vx, vy, startX, startY;
  int range;
  
  public Bullet() {};
  
  public Bullet(float X, float Y, float VX, float VY, int R) {
    x = startX = X;
    y = startY = Y;
    vx = VX;
    vy = VY;
    range = R;
  }
  
  void act() {
    fill(black);
    circle(x, y, 6);
    x += vx;
    y += vy;
    
    collideWithEnemy();
    //self removal if outside range
    if (dist(startX, startY, x, y) > range) bullets.remove(this);
  }
  
  void collideWithEnemy() {
    for (int i=0; i<enemies.size(); i++) {
      Enemy e = enemies.get(i);
      if (dist(x, y, e.x, e.y) < e.d/2) {//if collide
        e.hp--;   
        bullets.remove(this);
      }
    }
  }
}

public class DamageRing extends Bullet {
    //x, y inherits from parent class
    int range, counter;
    
    DamageRing(float X, float Y, int R){
      super();  
      x = X;
      y = Y;
      range = R;
    }
    
    void act() {
      fill(255, 0, 0, 30);
      circle(x, y, range*2);
      noFill();
      
      for (int i=0; i<enemies.size(); i++) {
        Enemy e = enemies.get(i);
        if (dist(x, y, e.x, e.y) < range) {//if collide
          e.hp--;   
        }
      }
      
      bullets.remove(this); 
    }
}

public class Grapeshot extends Bullet {
  //x, y, vx, vy, range all inherited  
  Grapeshot(float X, float Y, float VX, float VY, int R) {
    super(X, Y, VX, VY, R);
  }
  
  void act() {
    fill(gold);
    circle(x, y, 10);
    x += vx;
    y += vy;
    
    //super.collideWithEnemy();
    //self removal if outside range & spawn some new bullets
    if (dist(startX, startY, x, y) > range/4) {
      bulletSpread();
      bullets.remove(this); 
    }
  }
  
  //void collideWithEnemy() {
  //  //println("hi");
  //  for (int i=0; i<enemies.size(); i++) {
  //    Enemy e = enemies.get(i);
  //    if (dist(x, y, e.x, e.y) < e.d/2) {//if collide
  //      e.hp--;   
  //      bulletSpread(1);
  //      bullets.remove(this);        
  //    }
  //  }
  //}
  
  void bulletSpread(){
    //spawns the extra bullets that are a part of the grapeshot
    for (float i = -0.8; i <= 0.8; i+=0.4) {
      float angle = atan(vy/vx); //calculates the angle of the mother bullet
      float speed = pow(pow(vx, 2) + pow(vy, 2), 0.5) ; // (vx^2 + vy^2) ^ 0.5, calculate magnitude of bullet velocity
      float newVX = (vx/abs(vx))*speed*cos(angle + i); 
      float newVY = (vx/abs(vx))*speed*sin(angle + i);
      bullets.add(new Bullet(this.x, this.y, newVX, newVY, range));
    }
  }
}
