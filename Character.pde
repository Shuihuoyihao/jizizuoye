class Character {
  float x, y;
  int health = 100;
  boolean alive = true;

  Character(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void hitCharacter() {
    health -= 10;
    if (health <= 0) {
      alive = false;
    }
  }

  boolean collide(Character other) {
    if (!this.alive || !other.alive) {
      return false;
    }
    float d = dist(this.x, this.y, other.x, other.y);
    return d < 20;
  }
}
