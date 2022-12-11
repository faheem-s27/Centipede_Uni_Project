import java.util.Iterator;

ArrayList<Centipede> enemies = new ArrayList<>();
ArrayList<Centipede> toAddEnemies = new ArrayList<>();

Bullet bulletToRemove = null;
SoundFile splitSound;

void updateEnemies()
{
  if (enemies.size() == 0)
  {
    currentState = gameStates.WIN;
    levelUp.play();
  } else {
    Iterator<Centipede> enemyIter = enemies.iterator();
    while (enemyIter.hasNext())
    {
      Centipede currentEnemy = enemyIter.next();
      currentEnemy.update();

      int resultOfBulletCollision = currentEnemy.collisionWithBullet();
      if (resultOfBulletCollision != -1) // bullet hit snake
      {
        // getting the x and y values of the snake body hit
        int bodyX = int(currentEnemy.bodyPos[resultOfBulletCollision].x);
        int bodyY = int(currentEnemy.bodyPos[resultOfBulletCollision].y);

        if (resultOfBulletCollision == 0) // head hit, kill off whole snake
        {
          //enemies.remove(this);
          enemyIter.remove();

          // 100 points per snake head kill
          changeScore(100);

          mushList.spawnMushroom(bodyX, bodyY);
        } else {
          int newSize = currentEnemy.sizeOfBody - resultOfBulletCollision;
          // println("Splitting snake with body parts: " + newSize + ", " + resultOfBulletCollision);

          mushList.spawnMushroom(bodyX, bodyY);

          enemyIter.remove();
          toAddEnemies.add(new Centipede(bodyX, bodyY, newSize, -1));
          toAddEnemies.add(new Centipede(bodyX, bodyY, resultOfBulletCollision, +1));

          changeScore(10);

          

          //toAddEnemies.add(new Enemy(currentEnemy.x, currentEnemy.y, newSize, 1));
          //toAddEnemies.add(new Enemy(currentEnemy.x, currentEnemy.y, resultOfBulletCollision, -1));
        }
        
        splitSound.play();
      }

      //if (currentEnemy.sizeOfBody == 1)
      //{
      //  enemyIter.remove();
      //} else {

      //}
    }

    enemies.addAll(toAddEnemies);
    toAddEnemies.clear();
  }
}

void resetEnemies()
{
  for (Centipede enemy : enemies)
  {
    enemy.y=0;
  }
}


void generateEnemies()
{
  enemies.clear();
  for (int i = 0; i < Level.getLevel(); i++)
  {
    int direction;
    if (i%2==0) direction = 1;
    else direction = -1;
    enemies.add(new Centipede(returningX(), 0, int(random(8, 15)), direction));
  }
}

int getNumberofEnemies()
{
  return enemies.size();
}

int returningX()
{
  int number;
  while (true)
  {
    number = int(random(width));
    if (number%size==0) break;
  }

  return number;
}



// Make a base enemy class
// with centipede as child class
// and scorpoions ?


// -------------- Need to introduce base and sub class

// Base Enemy
abstract class BaseEnemy
{
  int x, y, dx, dy;

  void move()
  {
  }

  void update()
  {
  }

  void display()
  {
  }

  Boolean collision(BaseEnemy enemy)
  {
    // returning true until construcuted
    return true;
  }
}


// Subclass Centipede

// Subclass Scorpion

// ---------- End of hell


class Centipede extends BaseEnemy
{
  int x, y;
  int sizeOfBody = int(random(10, 12));
  int dx = speed/2;
  PVector[] bodyPos;
  int colour = 200;
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));

  int jhead = 0;
  int jx = 1;

  Centipede(int x, int y)
  {
    this.x = x;
    this.y = y;

    this.bodyPos = new PVector[sizeOfBody];

    for (int i = 0; i<sizeOfBody; i++)
    {
      bodyPos[i] = new PVector(x, y);
    }
  }

  Centipede(int x, int y, int size, int direction)
  {
    this.x = x;
    this.y = y;
    this.sizeOfBody = size;
    this.dx *= direction;

    this.bodyPos = new PVector[sizeOfBody];

    for (int i = 0; i<sizeOfBody; i++)
    {
      bodyPos[i] = new PVector(x, y);
    }
  }

  void update()
  {
    //display();
    move();
    if (x%size==0) {
      for (int i = bodyPos.length-2; i >=0; i--)
      {
        bodyPos[i+1] = bodyPos[i];
      }
      bodyPos[0] = new PVector(x, y);
      jhead+=jx;

      if (jhead > centiHeads.length -2 || jhead <= 0) jx *= -1;
    }

    //float multiplier = 255/sizeOfBody;
    //float mr = r/sizeOfBody;
    //float mg = g/sizeOfBody;
    //float mb = b/sizeOfBody;
    for (int i = bodyPos.length-1; i >= 0; i--)
    {
      //fill((i+1)*multiplier, colour, colour);

      //fill((i+1)*mr, (i+1)*mg, (i+1)*mb);
      //display(bodyPos[i].x, bodyPos[i].y);
      imageMode(CORNER);
      if (i == 0)
      {
        image(centiHeads[jhead], bodyPos[i].x, bodyPos[i].y);
      } else {
        if (i < centiBodies.length)
        {
          image(centiBodies[i], bodyPos[i].x, bodyPos[i].y);
        } else {
          int random = int(random(0, centiBodies.length));
          image(centiBodies[random], bodyPos[i].x, bodyPos[i].y);
        }
      }

      // display image

      //if (i < centiBodies.length)
      //{
      //  image(centiBodies[i], bodyPos[i].x, bodyPos[i].y);
      //} else {
      //  fill((i+1)*mr, (i+1)*mg, (i+1)*mb);
      //  display(bodyPos[i].x, bodyPos[i].y);
      //}
    }

    if (collisionWithMushroom()) {
      dx*=-1;
      y+=size;
    }
    if (y > height)
    {
      Lives.setLives(Lives.getLives()-1);
      if (Lives.getLives() <= 0) currentState = gameStates.GAMEOVER;
      else currentState = gameStates.MENU;
    }
  }

  void display()
  {
    fill(155, 155, 0);
    rect(x, y, size, size, 2);
  }

  void display(float x, float y)
  {
    //fill(#075F01);
    strokeWeight(1);
    stroke(255);
    rect(x, y, size, size, 2);
    noStroke();
  }

  void move()
  {
    x+=dx;
    if (x < 0 || x > width-size) {
      dx*=-1;
      y+=size;
    }
  }

  int collisionWithBullet()
  {
    for (Bullet bully : bullets.bulletsList)
    {
      for (int i = 0; i < sizeOfBody; i++)
      {
        float x = bodyPos[i].x;
        float y = bodyPos[i].y;
        if (bully.x >= x && bully.x <= x + size && bully.y >= y && bully.y <= y + size)
        {
          bulletToRemove = bully;
          return i;
        }
      }
    }
    return -1;
  }

  boolean collisionWithMushroom()
  {
    for (Mushroom mush : mushList.mushrooms)
    {
      // check for any collision left and right
      if (x >= mush.x && x <= mush.x + size && y >= mush.y && y <= mush.y + size) {
        return true;
      }
    }
    return false;
  }
}
