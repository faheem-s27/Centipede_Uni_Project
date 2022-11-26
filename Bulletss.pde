import java.util.Iterator;

//ArrayList<Bullet> bulletsList = new ArrayList<>();
Bullets bullets = new Bullets();

class Bullet
{
  float x, y, speed;

  Bullet(float x, float y, float speed)
  {
    this.x = x;
    this.y = y;
    this.speed = speed;
  }

  void update()
  {
    move();
    display();
  }

  void move()
  {
    y-=speed;
  }

  void display()
  {
    fill(#F5FA00);
    ellipse(x, y, size/2, size/2);
  }
}

class Bullets
{
  ArrayList<Bullet> bulletsList = new ArrayList<>();

  void addBullet()
  {
    bulletsList.add(new Bullet(playerShip.getCoordinates().x, playerShip.getCoordinates().y, speed));
  }

  void clearBullets()
  {
    bulletsList.clear();
  }

  void updateBullets()
  {
    try {
      Iterator<Bullet> bullet = bulletsList.iterator();
      while (bullet.hasNext())
      {
        Bullet currentBullet = bullet.next();
        currentBullet.update();
        if (currentBullet.y < -size) bullet.remove();
        for (Mushroom mushy : mushrooms)
        {
          if (mushy.checkForDamage(currentBullet)) bullet.remove();
        }
      }
    }
    catch (Exception e)
    {
      //println("Beautiful error that we will ignore: " + e);
    }
  }
}