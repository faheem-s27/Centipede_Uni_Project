Player playerShip;

class Player
{
  int speed;
  private int x;
  private int y;
  private boolean useMouseToMove;
  float size;
  
  Player(int x, int y, int speed, boolean useMouse, float size)
  {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.useMouseToMove = useMouse;
    this.size = size;
  }
  
  PVector getCoordinates()
  {
    return new PVector(x, y); 
  }
  
  void setX(float x){ this.x = int(x);}
  float getX() { return x; }
  void setY(float y) {this.y = int(y);}
  float getY() { return y; }
  
  void update()
  {
    move();
    display();
  }
  
  void display()
  {
    stroke(0);
    fill(255);
    ellipse(x,y, size, size);
  }
  
  void move()
  {
    if (useMouseToMove) x = mouseX;
  } 
}

void keyPressed()
{
  if (key != CODED) return;
  if (playerShip == null) return;
  if (gameState != INGAME) return;
  if (playerShip.useMouseToMove) return;
  
  if (keyCode == LEFT && playerShip.getX() > 0 + playerShip.size/2) playerShip.setX(playerShip.x-=playerShip.speed);
  if (keyCode == RIGHT && playerShip.x < width - playerShip.size/2) playerShip.setX(playerShip.x+=playerShip.speed);
  
  
  //if (key == CODED)
  //{
  //  if (keyCode == LEFT && !playerShip.useMouseToMove && gameState == INGAME)
  //  {
  //    println("LEFT");
  //    if (playerShip.getCoordinates().x > 0 + playerShip.size/2) playerShip.getCoordinates().x-=playerShip.speed;
  //  }
  //  if (keyCode == RIGHT && !playerShip.useMouseToMove && gameState == INGAME)
  //  {
  //    if (playerShip.getCoordinates().x < width - playerShip.size/2) playerShip.getCoordinates().x+=playerShip.speed;
  //  }
  //  //if (keyCode == UP && !playerShip.useMouseToMove && playerShip.getCoordinates().y > height-100 && gameState == INGAME) playerShip.getCoordinates().y-=playerShip.speed;
  //  //if (keyCode == DOWN && !playerShip.useMouseToMove && playerShip.getCoordinates().y < height && gameState == INGAME) playerShip.getCoordinates().y+=playerShip.speed;
  //}
}