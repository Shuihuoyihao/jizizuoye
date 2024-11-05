class Projectile {
  float x, y;
  float speedY = -5;
  static final float COLLISION_RADIUS = 15;
  Projectile(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    y += speedY;
  }

  void display() {
    fill(0, 255, 0);
    ellipse(x, y, 10, 10);
  }

  boolean offscreen() {
    return y < 0;
  }

  boolean collide(Character target) {
    if (target != null && target.alive) {
      float distance = dist(x, y, target.x, target.y);
      if (distance < COLLISION_RADIUS) {
        target.hitCharacter(); // Call the target's hit logic
        return true; // Collision occurred
      }
    }
    return false;
  }
}
