class Player extends Character {
  int lives = 5;
  int invulnerableTime = 3000; 
  int lastHitTime = 0; 
  int shootInterval = 500; 
  int lastShotTime = 0;
  boolean isInvulnerable = false; 

  Player(float x, float y) {
    super(x, y);
  }

  void update() {
    if (isInvulnerable && millis() - lastHitTime > invulnerableTime) {
      isInvulnerable = false;
    }
  }

  void display() {
    if (isInvulnerable) {
      if (millis() % 400 < 200) {
        return; 
      }
    }
    
    fill(256, 185, 6);
    noStroke();
    ellipse(x, y + 35, 20, 60);

    fill(30, 144, 255);
    arc(x, y + 36, 40, 40, PI, 0, CHORD);

    fill(255, 0, 0);
    ellipse(x, y, 30, 80);

    fill(255);
    ellipse(x, y - 12, 15, 15);
    ellipse(x, y + 6, 15, 15);

    fill(30, 144, 255);
    ellipse(x, y + 32, 5, 30);
  } 

  void shoot(ArrayList<Projectile> projectiles) {
    int currentTime = millis();
    if (currentTime - lastShotTime >= shootInterval) { 
      projectiles.add(new Projectile(x, y)); 
      lastShotTime = currentTime; 
    }
  }

  void hitCharacter(BossEnemy boss) {
    if (!isInvulnerable) {
      int damage = (boss != null) ? 2 : 1;
      lives -= damage;

      if (lives <= 0) {
        textSize(50);
        fill(255, 0, 0);
        text("Game Over", width / 2 - 100, height / 2);
        noLoop();
      } else {
        isInvulnerable = true;
        lastHitTime = millis();
      }
    }
  }

  void move(float dx, float dy) {
    x += dx;
    y += dy;

    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }

  boolean collideBullet(Bullet bullet) {
    float d = dist(x, y, bullet.x, bullet.y);
    return d < 20;
  }
}
