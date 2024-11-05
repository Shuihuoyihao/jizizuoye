class BasicEnemy extends Character {
  float speedX, speedY;
  int lastDefeatedTime = 0;
  final int respawnTime = 3000;
  boolean alive = true;

  BasicEnemy() {
    super(random(width), random(height));
    this.speedX = random(-1, 1.5);
    this.speedY = random(-1, 1.5);
  }

  void setPosition(float x, float y){   
    this.x = x;
    this.y = y;
  }

  void move() {
    x += speedX;
    y += speedY;

    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }
  }

  void display() {
    fill(255, 228, 225);
    ellipse(x, y, 20, 20);
  }
  
 /* void respawn(ArrayList<BasicEnemy> enemies) {
    int numNewEnemies = 3; 

    for (int i = 0; i < numNewEnemies; i++) {
      BasicEnemy newEnemy = new BasicEnemy(); 
      float newX = random(width);
      float newY = random(height);
      newEnemy.setPosition(newX, newY); 
      enemies.add(newEnemy); 
    }

    this.lastDefeatedTime = 0;
  }
  */
}
