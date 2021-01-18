/*** Bullet ******************************************
 * Purpose: Creates bullets, calcualtes the trajectory*
 * draws the bullets, checks if they collided with a  *
 * balloon                                            *
 * Variables:                                         *
 * bx - x location of the bullet                      *
 * by - y location of the bullet                      *
 * bangle - angle of the bullet                       *
 * active - determines whether thebullet is on the    *
 * screen or not                                      *
 ******************************************************/
class Bullet
{
  float bx = -1000;
  float by = -1000;
  int bangle;
  boolean active = false;
  /*** Movement ****************************************
   * Purpose: Determines the velocity and direction of  *
   * the bullet                                         *
   * Parameters: none                                   *
   * Returns: none                                      *
   ******************************************************/
  void movement ()
  {
    bx += 20*cos(-radians(bangle));
    by += 20*sin(-radians(bangle));
  }
  /*** bulletActive ****************************************
   * Purpose: Determines whether the bullet in in the screen*
   * or not                                                 *
   * Parameters: none                                       *
   * Returns: none                                          *
   *********************************************************/
  boolean bulletActive ()
  {
    if (bx > width || bx < 0 || by > height || by < 0)
      active = false;
    else
      active = true;
    return active;
  }
  /*** drawBullet ****************************************
   * Purpose: Determines the velocity and direction of  *
   * the bullet                                         *
   * Parameters: none                                   *
   * Returns: none                                      *
   ******************************************************/
  void drawBullet ()
  {
    if (active == true)
    {
      pushMatrix();
      ellipse (bx, by, 8, 8);
      popMatrix();
    }
  }
  /*** collidingWith ************************************
   * Purpose: Checks if the bullet collided with the     *
   * balloon and plays the balloon sound effect          *
   * Parameters: none                                    *
   * Returns: none                                       *
   ******************************************************/

  void collidingWith (Plane p)
  {
    if (p.powerShield == true) 
    {
      if (dist (bx, by, p.x, p.y) < 74)
      {
        bx = -5000;
        by = -5000;
      }
    } else if (dist(bx, by, p.loonx, p.loony) < (balloonDiameter/2 + 4) && p.balloonRespawning == false)
    {
      p.lives--;
      p.balloonTime = millis();
      p.balloonRespawning = true;
      balloon.rewind();
      balloon.play();
    }
  }
}
