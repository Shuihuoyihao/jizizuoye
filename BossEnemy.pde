class BossEnemy extends Character {
  float speed = 2;
  int health = 50; 
  boolean isAlive = true;
  int disappearTime = 20000; 
  int lastDisappearTime;
  float angle;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>(); 
  int lastBulletTime;
  int bulletInterval = 3000;

  BossEnemy(float x, float y) {
    super(x, y);
    lastDisappearTime = millis();
    lastBulletTime = millis();
    randomizeAngle();
  }
  
  void resetDisappearTimer() {
    lastDisappearTime = millis();
  }

  void randomizeAngle(){
    angle = random(TWO_PI);
  }
  
  boolean checkDisappearTime() {
    return millis() - lastDisappearTime >= disappearTime;
  }
  
  void handleDisappearance() {
    x = random(width);
    y = random(height);
    isAlive = false;
    resetDisappearTimer();
    randomizeAngle();
  }
  
  int getHealth(){
    return health;
  }

  void move() {
    if (isAlive) {
      x += speed * cos(angle);
      y += speed * sin(angle);

      if (x < 0 || x > width) angle = PI - angle;
      if (y < 0 || y > height) angle = TWO_PI - angle;
    }
  }
  
  void display() {
    if (isAlive) {
      fill(255, 0, 0);
      ellipse(x, y, 60, 60);
    }
  }
  
  void shoot() {
    if (millis() - lastBulletTime >= bulletInterval && isAlive) {
      bullets.add(new Bullet(x, y, random(TWO_PI)));
      lastBulletTime = millis();
    }
  }
  
  void updateBullets() {
    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet bullet = bullets.get(i);
      bullet.update();
      bullet.display();

      if (bullet.offscreen()) {
        bullets.remove(i);
      }
    }
  }
}
