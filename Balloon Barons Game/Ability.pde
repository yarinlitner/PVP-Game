/*** Power *********************************************
 * Purpose: Spawns various powerups throughout the game,*
 * with different abilities and limited by how often    *
 * they spawn.                                          *  
 * Variables:                                           *
 * powerActive - returns true if an ability is spawned  *
 * powerx - x location of the power up                  *
 * powery - y location of the power up                  *
 * spawnType - type of ability spawned                  *
 * secondPassed - calculates the timing for the spawning*
 *******************************************************/
class Power
{
  boolean powerActive = false;
  float powerx = -3000;
  float powery = -3000;
  int spawnType;
  int secondPassed = second();
  /*** powerCollision ***********************************
   * Purpose: checks if a plane comes in contact with an *
   * ability                                             *
   * Parameters: other                                   *
   * Returns: none                                       *
   ******************************************************/

  void powerCollision(Plane other)
  {
    if (powerActive == true)
    {
      if (dist(powerx, powery, other.x, other.y) < ((sz+10) + other.rad))
      {
        powerActive = false;
        if (spawnType == 0)
        {
          other.powerShield = true;
          other.shieldTime = millis();
          powersound.rewind();
          powersound.play();
        } else if (spawnType == 1)
        {
          other.ammo = 20;
          powersound.rewind();
          powersound.play();
        }
      }
    }
  }
  /*** spawnIt ******************************************
   * Purpose: Spawns(displays) powerups depending if they* 
   * are active or not (used)                            *
   * Parameters: none                                    *
   * Returns: none                                       *
   ******************************************************/

  void spawnIt()
  {
    if (powerActive == false)
    {

      if (second() % 2 == 0 && secondPassed != second())
      {
        spawnRate = (int) random (1, 11);
      }

      if (spawnRate == 1)
      {
        powerActive = true;
        spawnType  = (int) random(2);
        do
        {
          powerx = (int) random (30, width - 30);
          powery = (int) random (30, height - 30);
        } 
        while (dist (powerx, powery, p1.x, p1.y) < 80 && dist (powerx, powery, p2.x, p2.y) < 80 && powery > height - 150 );
      }
    }
    secondPassed = second ();
    spawnRate = -5;
  }
  /*** powerDisplay ***********************************
   * Purpose: Displays powerups                          *
   * Parameters: none                                    *
   * Returns: none                                       *
   ******************************************************/
  void powerDisplay()
  {
    if (powerActive == true)
    {
      if (spawnType == 0)
      {
        strokeWeight(1);
        stroke(0);
        noFill();
        fill(#E30707, 127);
        ellipse(powerx, powery, sz + 10, sz + 10);
        image (shield, powerx, powery, sz, sz);
      } else if (spawnType ==1 )
      {
        strokeWeight(1);
        stroke(0);
        noFill();
        fill(#E30707, 127);
        ellipse(powerx, powery, sz + 10, sz + 10);
        image (exMag, powerx, powery, sz, sz);
      }
    }
  }
}
