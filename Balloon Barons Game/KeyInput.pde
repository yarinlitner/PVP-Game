/*** keyPressed ***************************************
 * Purpose: Checks if specific keys were pressed for   *  
 * movement and shooting. Plays relative sounds        *
 * Parameters: none                                    *
 * Returns: none                                       *
 ******************************************************/

void keyPressed ()
{
  if (key == 'w' || key == 'W')
    keys [0] = true;
  if (key == 'a' || key == 'A')
    keys [1] = true;
  if (key == 's' || key == 'S')
    keys [2] = true;
  if (key == 'd' || key == 'D')
    keys [3] = true;
  if (key == 'q' || key == 'Q') {
    keys [8] = true;
    if (keys [8] == true && p1.ammo > 0 && screen == 1)
    {
      pew.rewind();
      pew.play();
    }
    if (keys [8] == true && p1.ammo == 0 && screen == 1)
    {
      dryFire.rewind();
      dryFire.play();
    }
  }
  if (key == 'm' || key == 'M') {
    keys [9] = true;
    if (keys [9] == true && p2.ammo > 0 && screen == 1)
    {
      pew.rewind();
      pew.play();
    }
    if (keys [9] == true && p2.ammo == 0 && screen == 1)
    {
      dryFire.rewind();
      dryFire.play();
    }
  }
  if (key == 'r' || key == 'R')
    keys [10] = true;
  if (keys [10] == true && p1.ammo < 10 && screen == 1)
  {
    reload.rewind();
    reload.play();
  }
  if (key == 'j' || key == 'J')
    keys [11] = true;
  if (keys [11] == true && p2.ammo < 10 && screen == 1)
  {
    reload.rewind();
    reload.play();
  }
  if (key == CODED)
  {
    if (keyCode == UP)
      keys [4] = true;
    if (keyCode == LEFT)
      keys [5] = true;
    if (keyCode == DOWN)
      keys [6] = true;
    if (keyCode == RIGHT)
      keys [7] = true;
  }
}
/*** keyReleased ***************************************
 * Purpose: Checks if the keys were released for       *  
 * movement and shooting                               *
 * Parameters: none                                    *
 * Returns: none                                       *
 ******************************************************/

void keyReleased()
{
  if (key == 'w' || key == 'W')
    keys [0] = false;
  if (key == 'a' || key == 'A')
    keys [1] = false;
  if (key == 's' || key == 'S')
    keys [2] = false;
  if (key == 'd' || key == 'D')
    keys [3] = false;
  if (key == 'q' || key == 'Q')
    keys [8] = false;
  if (key == 'm' || key == 'M')
    keys [9] = false;
  if (key == 'r' || key == 'R')
    keys [10] = false;
  if (key == 'j' || key == 'J')
    keys [11] = false;
  if (key == CODED)
  {
    if (keyCode == UP)
      keys [4] = false;
    if (keyCode == LEFT)
      keys [5] = false;
    if (keyCode == DOWN)
      keys [6] = false;
    if (keyCode == RIGHT)
      keys [7] = false;
  }
}
/*** mousePressed *************************************
 * Purpose: Checks if the user presses on various      *
 * buttons. Directs them to a new screen               *
 * Parameters: none                                    *
 * Returns: none                                       *
 ******************************************************/

void mousePressed()
{
  if (screen == 0 && mouseX >= 482 && mouseX <= 718 && mouseY >= 320 && mouseY <= 436)
  {
    vidCount = 0;
    screen = 4;
  }
  if (screen == 0 && mouseX >= 482 && mouseX <= 718 && mouseY >= 456 && mouseY <= 570)
  {
    screen = 2;
  }
  if (screen == 2 && mouseX>=1015 && mouseY>=34 && mouseX<= 1176 && mouseY<=124)
    screen = 0;
  if (screen == 3 && mouseX > width/2 - 125 && mouseX < width/2 +75 && mouseY > height/2 - 50 && mouseY < height/2 + 25)
  {
    screen = 0;
    p1.lives = 3;
    p2.lives = 3;
    p1.ammo = 10;
    p2.ammo = 10;
    p1.powerShield = false;
    p2.powerShield = false;
    p1.x = 100;
    p2.x = width - 100;
    p1.y = height/2;
    p2.y = height/2;
    p1.vel = minVel;
    p2.vel = minVel;
    p1.angle = 0;
    p2.angle = 180;
    powerups[0].powerActive = false;
    powerups[1].powerActive = false;
    for (int i = 0; i < 20; i ++)
    {
      bullets1[i].active = false;
      bullets2[i].active = false;
      bullets1[i].bx = -1000;
      bullets1[i].by = -1000;
      bullets2[i].bx = -1000;
      bullets2[i].by = -1000;
    }
    inGame.pause();
    inGame.rewind();
    odzmain.play();
    vidCount = 0;
  }
}
