/*********************************************************
 *  Name: Yarin Litner, Avery Thomsen, Jaxon Croth        *
 *  Course: ICS 3U 02  Pd. 2                              *
 *  Summative Assignment                                  *
 *  Purpose: "Balloon Barons" is a two player game that   *
 *  is played on one computer. This game is designed so   *
 *  the two players control their own planes with the     *
 *  objective of shooting the other opponent down         *
 *  Due Date: May 24, 2019                                *
 *********************************************************/
int sz = 30;
int planeWidth = 80;
int balloonDiameter = 28;
float minVel = 1;
float maxVel = 10;
int screen = 0;
float vidCount = 0;
int spawnRate;
PFont myFont;
PImage plane;
PImage plane2;
PImage shield;
PImage exMag;
PImage instructions;
PImage menu2;
boolean [] keys;
Plane p1;
Plane p2;
Power [] powerups = new Power [2];
Bullet [] bullets1 = new Bullet [20];
Bullet [] bullets2 = new Bullet [20];
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer pew;
AudioPlayer dryFire;
AudioPlayer reload;
AudioPlayer balloon;
AudioPlayer countdownNew;
AudioPlayer powersound;
AudioPlayer odzmain;
AudioPlayer inGame;
/*** Variable Dictionary *******************************
 * sz - size of the power ups                           *
 * shield - image of the shield ability                 *
 * exMag - image of the ammo ability                    *
 * instructions - image for the instructions screen     *
 * menu2 - image for the main menu screen               *
 * myFont - font for countdown and ending screen        *
 * keys - array of any specified key inputs             *
 * planeWidth - radius of each plane                    *
 * balloonDiamter - Radius of each balloon              *
 * minvel - minimum velocity                            *
 * maxvel - maximum velocity                            *
 * dir - direction                                      *
 * spawnRate - the probability of a power up spawning   *
 * plane - Player One image                             *
 * plane2 - Player Two image                            *
 * screen - decalres what screen should be displayed    *
 * vidCount - keeps track of the countdown screen       *
 * pew - Sound when firing cannon                       *
 * dryFire - Sound when out of ammunition               * 
 * reload - Sound when player is reloading              *
 * balloon - Sound when balloon is popped               *
 * countdownNew - Starting countdown recording          *
 * powersound - Sound when player picks up ability      *
 * odzmain - Main menu soundtrack                       *
 * inGame - In game music track                         *
 *******************************************************/

void setup()
{
  minim = new Minim(this);
  odzmain = minim.loadFile ("odzmain.mp3");

  menu2 = loadImage("balloonmenunew.png");
  instructions = loadImage ("ballooninstructions.png");
  for (int i = 0; i < 20; i ++)
  {
    bullets1[i] = new Bullet ();
    bullets2[i] = new Bullet ();
  }
  size(1200, 800);
  plane = loadImage("Plane.png");
  plane2 = loadImage("plane2new.gif");
  shield = loadImage("security.png");
  exMag = loadImage("bullet.png");
  keys = new boolean [12];
  for (int i = 0; i < 2; i++)
    powerups [i] = new Power ();
  pew = minim.loadFile ("gunfire.mp3");
  dryFire = minim.loadFile ("dryfire.mp3");
  reload = minim.loadFile ("reload.mp3");
  balloon = minim.loadFile ("balloon.mp3");
  countdownNew = minim.loadFile ("ballooncountdown.mp3");
  powersound = minim.loadFile ("powersound.mp3");
  inGame = minim.loadFile ("inGame.mp3");
  p1 = new Plane (100, height/2, 0, 1);
  p2 = new Plane (width - 100, height/2, 180, 2);
}

void draw()
{
  imageMode (CENTER);
  if (screen == 0)
  {
    odzmain.play();
    image(menu2, width/2, height/2, width, height);
  } else if (screen == 1)
  {
    odzmain.pause();
    inGame.play();
    if (p1.lives > 0 && p2.lives > 0)
    {
      background (#503EF7);
      fill(#FA0011);
      strokeWeight(3);
      stroke(0);
      ellipse (100, height/2, 100, 100);
      fill(#2517FA);
      ellipse (width - 100, height/2, 100, 100);
      for (int i = 0; i < 2; i++)
      {
        powerups[i].spawnIt();
        powerups[i].powerDisplay();
        powerups[i].powerCollision(p1);
        powerups[i].powerCollision(p2);
      }
      for (int i = 0; i < 2; i++)
      {
        powerups[i].powerCollision(p1);
        powerups[i].powerCollision(p2);
      }
      imageMode (CENTER);
      pushMatrix();
      p1.changeDirOne();
      p1.speed ();
      translate (p1.x, p1.y);
      rotate (-radians(p1.angle));
      image(plane, 0, 0, planeWidth, planeWidth);
      p1.boundary();
      p1.collision(p2);
      if (p1.powerShield == true)
      {
        noStroke();
        fill(#359EED, 125);
        ellipse (0, 0, planeWidth + balloonDiameter + 25, planeWidth + balloonDiameter + 25);
        if (millis() - p1.shieldTime > 5000)
          p1.powerShield = false;
      }  
      popMatrix();
      p1.drawBalloon();
      pushMatrix();
      p2.changeDirTwo();
      p2.speed ();
      p2.boundary();
      translate (p2.x, p2.y);
      rotate (-radians(p2.angle));
      image(plane2, 0, 0, planeWidth, planeWidth);
      if (p2.powerShield == true)
      {
        noStroke();
        fill(#359EED, 125);
        ellipse (0, 0, planeWidth + balloonDiameter + 25, planeWidth + balloonDiameter + 25);
        if (millis() - p2.shieldTime > 5000)
          p2.powerShield = false;
      }  
      popMatrix();
      p2.drawBalloon();
      if (p1.reloading == true)
      {
        p1.reload();
      }
      if (p2.reloading == true)
      {
        p2.reload();
      }
      for (int i = 0; i < 20; i ++)
      {
        if (bullets1[i].bulletActive())
        {
          fill (100);
          bullets1[i].drawBullet();
          bullets1[i].movement();
          fill (0);
          bullets1[i].drawBullet();
          print(bullets1[i].bx + "   ");
          bullets1[i].collidingWith(p2);
        }
        if (bullets2[i].bulletActive())
        {
          fill (100);
          bullets2[i].drawBullet();
          bullets2[i].movement();
          fill (0);
          bullets2[i].drawBullet();
          bullets2[i].collidingWith(p1);
        }
      }
      fill (255);
      rect(0, height-100, width, 10000);
      stroke(0);
      line (width/2, height, width/2, height - 100);
      p1.HUD();
      p2.HUD();
    }
    if (p1.lives == 0 || p2.lives == 0)
    {
      screen = 3;
    }
  } else if (screen == 2)
  {
    imageMode(CENTER);
    image (instructions, width/2, height/2, width, height);
  } else if (screen == 4)
  {
    if (vidCount == 0)
    {
      odzmain.pause();
      odzmain.rewind();
      background(0);
      textSize(64);
      textAlign(CENTER);
      fill(#901393);
      countdownNew.rewind();
      countdownNew.play();
      text("~Get Ready~", width/2, height/2);
      vidCount ++;
    } 
    if (countdownNew.isPlaying() == false && vidCount == 1)
    {
      screen = 1;
    }
  } else if (screen == 3)
  {
    background(255);
    textFont(myFont);
    textAlign(CENTER);
    textSize(56);
    text("~ Victory ~", width/2, height/2 - 100);
    textSize(46);
    if (p1.lives == 0)
    {
      text("Player 2 has won!", width/2, (height/2) + 100);
    }
    if (p2.lives == 0)
    {
      text("Player 1 has won!", width/2, (height/2) + 100);
    }
    text("Play Again", width/2, height/2);
    noFill();
    strokeWeight(3);
    stroke(0);
    rect (width/2 - 125, height/2 - 50, 250, 75);
  }
}
