Player player;
ArrayList<BasicEnemy> enemies = new ArrayList<>();
ArrayList<Projectile> projectiles = new ArrayList<>();
BossEnemy boss;
PImage img;

int spawnInterval = 3000;
int lastSpawnTime = 0;
int score = 0;
int gameStartTime;
boolean gameOver = false;

void setup() {
  size(600, 600);
  player = new Player(width / 2, height - 50);
  boss = new BossEnemy(width / 2, 50);
  spawnEnemies(10);

  for (int i = 0; i < 10; i++) {
    enemies.add(new BasicEnemy());
  }
  img = loadImage("data/universe.jpg");
  gameStartTime = millis();
}

void draw() {
  background(220);
  
  image(img, 0, 0, width, height);
  
  int gameTime = millis() - gameStartTime;

  // Player updates and display
  player.update();
  player.display();

  // Enemies updates and display
  for (BasicEnemy enemy : enemies) {
    enemy.move();
    enemy.display();

    if (player.collide(enemy)) {
      player.hitCharacter();
    }
  }

  // Boss update and display
  boss.move();
  boss.display();
  
  if (player.collide(boss)) {
    player.hitCharacter();
  }

  // Projectiles
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile projectile = projectiles.get(i);
    projectile.update();
    projectile.display();

    // Check collisions with enemies
    if (projectile.collide(enemies, boss)) {
      projectiles.remove(i);
      score += 5;
    }

    if (projectile.collide(boss)) {
      boss.hitCharacter();
      projectiles.remove(i);
      score += 10;
    }
  }
  
  // Display HUD
  textSize(20);
  fill(255, 218, 185);
  text("Score: " + score, 10, 30);

  // Game Over / Win conditions
  if (gameTime >= 300000) {
    textSize(50);
    fill(255, 0, 0);
    text("Game Over", width / 2 - 150, height / 2);
    gameOver = true;
    noLoop();
  }

  if (gameOver == false) {
    textSize(20);
    fill(255);
    text("Lives: " + max(player.lives, 0), 10, 60);
  }
}

void spawnEnemies(){
  // Spawn enemies
  if (millis() - lastSpawnTime >= spawnInterval) {
    for (int i = 0; i < 3; i++) {
      enemies.add(new BasicEnemy());
    }
    lastSpawnTime = millis();
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    player.move(-20, 0);
  } else if (keyCode == RIGHT) {
    player.move(20, 0);
  } else if (keyCode == UP) {
    player.move(0, -20);
  } else if (keyCode == DOWN) {
    player.move(0, 20);
  }

  // Fire projectile
  if (keyCode == 32) {
    projectiles.add(new Projectile(player.x, player.y));
  }
}
