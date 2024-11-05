class Bullet {
  float x, y;
  float angle;
  float speed = 3;
  float radius = 5;

  Bullet(float x, float y, float angle) {
    this.x = x;
    this.y = y;
    this.angle = angle;
  }

  void update() {
    x += speed * cos(angle);
    y += speed * sin(angle);
  }

  void display() {
    fill(205, 32, 110);
    ellipse(x, y, radius * 2, radius * 2);
  }

  boolean offscreen() {
    return (x < 0 || x > width || y < 0 || y > height);
  }
}
