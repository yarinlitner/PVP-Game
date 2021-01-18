/*** Plane *********************************************
 * Purpose: Creates plane objects, reloads, speed,     *
 * hitbox(Balloon)                                     *                                           *
/*** Variable Dictionary *******************************
 * shieldTime - Amount of time the shield is activated  *
 * powerShield - Displays the shield icon in the HUD    *
 * startReload - Time it takes to reload                *
 * x - x coordinate of the plane                        *
 * y - y coordinate of the plane                        *
 * vel - Velocity of the plane                          *
 * angle - The angle at which the plane is facing       *
 * relative to its starting position                    *
 * ammo - Default bullet capacity in one magazine       *
 * loonx - x coordinate of the balloon relative to      *
 * the plane                                            *
 * loony - y coordinate of the balloon relative to      *
 * the plane                                            *
 * lives - Default number of lives (3)                  *
 * balloonRespawning - Returns true when a balloon is   *
 * spawned                                              *
 * balloonTime - Time it takes for the ballon to respawn* 
 * crash - Determines whether the plane has collided    *
 * rad - Radius of the plane                            *
 * planeIdentifier - Keeps track of all players'        *
 * statistics                                           *
 * reloading - Returns true if a player reloads his     *
 * cannon                                               *
 *******************************************************/

class Plane
{
  int shieldTime;
  boolean powerShield = false;
  float startReload;
  float x;
  float y;
  float vel = minVel;
  int angle = 0;
  int ammo = 10;
  float loonx = (planeWidth/2 + balloonDiameter/2)*cos(PI-radians(angle));
  float loony = (planeWidth/2 + balloonDiameter/2)*sin(PI-radians(angle));
  int lives = 3;
  boolean balloonRespawning = false;
  float balloonTime;
  boolean crash = false;
  int rad = 65;
  int planeIdentifier;
  boolean reloading = false;
  /*** Plane *********************************************
   * Purpose: initializes x, y, angle, and planeIdentifier*                                    *         
   * Parameters: px, py, pangle, identify                 *
   * Returns: none                                        *
   *******************************************************/

  Plane (float px, float py, int pangle, int identify)
  {
    x = px;
    y = py;
    angle = pangle;
    planeIdentifier = identify;
  }
  /*** reload *******************************************
   * Purpose: Reloads the planes ammunition after a      *
   * specific time frame                                 *
   * Parameters: none                                    *
   * Returns: none                                       *
   ******************************************************/

  void reload ()
  {
    if (ammo > 9)
    {
      reloading = false;
    } else if (ammo == 0)
    {
      if ((millis() - startReload) > 3000)
      {
        ammo = 10;
        reloading = false;
      }
    } else if (ammo > 0)
    {
      if ((millis()-startReload) > 2000)
      {
        ammo = 10;
        reloading =false;
      }
    }
  }
  /*** speed ********************************************
   * Purpose: Makes the plane move faster or slower      *
   * depending on the keys pressed                       *
   * Parameters: none                                    *
   * Returns: none                                       *
   ******************************************************/

  void speed ()
  {
    x += vel*cos(radians(angle));
    y -= vel*sin(radians(angle));
  }
  /*** drawBalloon **************************************
   * Purpose: Draws the ballon with a specific color     *
   * depending on how many lifes the player has          *
   * Parameters: none                                    *
   * Returns: none                                       *
   ******************************************************/

  void drawBalloon ()
  {
    loonx = x - (planeWidth/2 + balloonDiameter/2)*cos(-radians(angle));
    loony = y - (planeWidth/2 + balloonDiameter/2)*sin(-radians(angle));
    if (millis() - balloonTime > 1000 || balloonRespawning == false)
    {
      balloonRespawning = false;
      noStroke();
      if (lives == 3)
      {
        fill (#00D124);
        ellipse (loonx, loony, balloonDiameter, balloonDiameter);
      } else if (lives == 2)
      {
        fill (#FFFF00);
        ellipse (loonx, loony, balloonDiameter, balloonDiameter);
      } else if (lives == 1)
      {
        fill (#FF0000);
        ellipse (loonx, loony, balloonDiameter, balloonDiameter);
      }
    }
  }
  /*** changeDirOne *************************************
   * Purpose: Changes the direction of the plane 1       *
   * depending on the keys pressed                       *
   * Parameters: none                                    *
   * Returns: none                                       *
   ******************************************************/

  void changeDirOne()
  {
    if (keys [0] && vel < maxVel)
      vel += 0.1;
    if (keys [1])
      angle +=3;
    if (keys [2] && vel > minVel)
      vel -= 0.1;
    if (keys [3])
      angle -= 3;
    if (keys [8] && ammo > 0 && reloading == false)
    {

      for (int j = 1; j < 20; j++)
      {
        if (bullets1[j].active == false)
        {
          bullets1[j].active = true;
          bullets1[j].bangle = angle;
          bullets1[j].bx = x + (planeWidth/2)*cos(-radians(angle));
          bullets1[j].by = y + (planeWidth/2)*sin(-radians(angle));
          ammo--;
          break;
        }
      }
      keys [8] = false;
    }
    if (keys [10] && ammo < 10 && reloading != true)
    {
      startReload = millis();
      reloading = true;
    }
  }
  /*** changeDirTwo *************************************
   * Purpose: Changes the direction of the plane 2       *
   * depending on the keys pressed                       *
   * Parameters: none                                    *
   * Returns: none                                       *
   ******************************************************/

  void changeDirTwo()
  {
    if (keys [4] && vel < maxVel)
      vel += 0.1;
    if (keys [5])
      angle +=3;
    if (keys [6] && vel > minVel)
      vel -= 0.1;
    if (keys [7])
      angle -= 3;
    if (keys [9] && ammo > 0 && reloading == false)
    {
      for (int p = 1; p < 20; p++)
      {
        if (bullets2[p].active == false)
        {
          bullets2[p].active = true;
          bullets2[p].bangle = angle;
          bullets2[p].bx = x + (planeWidth/2)*cos(-radians(angle));
          bullets2[p].by = y + (planeWidth/2)*sin(-radians(angle));
          ammo--;
          break;
        }
      }
      keys [9] = false;
    }
    if (keys [11] && ammo < 10 && reloading != true)
    {
      startReload = millis();
      reloading = true;
    }
  }
  /*** collision ****************************************
   * Purpose: Checks if the two planes collided          *
   * Parameters: distance - finds the distance between   *
   the two planes                                        *
   * Returns: if the plane collided                      *
   ******************************************************/

  void collision (Plane other)
  {
    float distance = sqrt ((pow(other.x-x, 2) + (pow(other.y-y, 2))));
    if (distance < rad)
    {
      crash = true;
      other.crash = true;
      other.x = width - 100;
      other.y = height/2;
      other.angle = 180;
      other.vel = minVel;
      x = 100;
      y = height/2;
      angle = 0;
      vel = minVel;
    }
  }
  /*** boundary *****************************************
   * Purpose: when the plane goes into edge diagonally   *
   * come out on the opposite side relative to its       *
   * initial direction                                   *
   * Parameters:none                                     *
   * Returns: none                                       *
   ******************************************************/

  void boundary()
  {
    if (x <= -50)
    {
      x = width + 50;
    } else if (x >= width + 50)
    {
      x = -50;
    } else if (y <= -50)
    {
      y = height - 150;
    } else if (y >= height - 50)
    {
      y = -50;
    }
  }
  /*** HUD ************************************************
   * Purpose: Heads up display, player's can see their     *  
   * ammunition count and health. Includes powerup graphics*
   * sheild, exmag                                         * 
   * Parameters: none                                      *
   * Returns: none                                         *
   ********************************************************/

  void HUD ()
  {
    fill (0);
    myFont = createFont ("Times New Roman", 12);
    textFont(myFont);
    textAlign (LEFT, CENTER);
    if (planeIdentifier == 1)
    {
      text ("Ammo Count: " + ammo, 30, height - 60);
      text ("Health: " + lives, 30, height - 40);
      myFont = createFont ("Times New Roman", 20);
      textFont(myFont);
      text ("Player "+ planeIdentifier + ":", 30, height - 80);
      if (p1.ammo > 10)
      {
        image (exMag, 150, height - 70, sz, sz);
      }
      if (p1.powerShield == true)
      {
        image (shield, 150, height - 35, sz, sz);
      }
    }
    if (planeIdentifier == 2)
    {
      text ("Ammo Count: " + ammo, width - 160, height - 60);
      text ("Health: " + lives, width - 160, height - 40);
      myFont = createFont ("Times New Roman", 20);
      textFont(myFont);
      text ("Player " + planeIdentifier + ":", width - 160, height - 80);
      if (p2.ammo > 10)
      {
        image (exMag, width - 30, height - 70, sz, sz);
      }
      if (p2.powerShield == true)
      {
        image (shield, width - 30, height - 35, sz, sz);
      }
    }
  }
}
