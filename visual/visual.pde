import deadpixel.keystone.*;
Keystone ks;
CornerPinSurface surface;
import themidibus.*;
import ddf.minim.*; 
PGraphics offscreen;
Minim minim; 
AudioInput in;
MidiBus myBus;
color backgroundCol=0;

ArrayList<See> see = new ArrayList();  // all note objects
ArrayList<Deeflat> dflat = new ArrayList(); // all notes that currently need to be added to notes
ArrayList<Dee> dee = new ArrayList();  // note values currently being released
ArrayList<Eeeflat> eflat = new ArrayList(); // note values (channel, pitch...) waiting to be released
ArrayList<Eee> eee = new ArrayList(); 
ArrayList<Eff> eff = new ArrayList(); 
ArrayList<Geeflat> gflat = new ArrayList(); // note values (channel, pitch...) waiting to be released
ArrayList<Gee> gee = new ArrayList(); 
ArrayList<Ayeflat> aflat = new ArrayList(); // note values (channel, pitch...) waiting to be released
ArrayList<Aye> aye = new ArrayList(); 
ArrayList<Beeflat> bflat = new ArrayList(); // note values (channel, pitch...) waiting to be released
ArrayList<Bee> bee = new ArrayList(); 

void setup() {
  size(1000, 1000, P3D);
  MidiBus.list();
  myBus = new MidiBus(this, "vs_output", -1); // Create a new MidiBus class with no input device and the "visuals" port as the output device.
  colorMode(HSB, 360, 100, 100);
  minim = new Minim(this); // Create a new Minim class for sound input
  in = minim.getLineIn();  // Enable
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(1000, 1000, 20);
  offscreen = createGraphics(1000, 1000, P3D);
}


void draw() {
  offscreen.beginDraw();
  offscreen.background(backgroundCol);
  for (int i = 0; i <see.size(); i++) {
    See c = see.get(i);
    c.update();
    if (c.time ==0) {
      see.remove(c);
    }
  }
  for (int i = 0; i <dflat.size(); i++ ) {
    Deeflat df=dflat.get(i);
    df.update();
    if (df.time ==0) {
      dflat.remove(df);
    }
  }
  for (int i = 0; i <dee.size(); i++ ) {
    Dee d=dee.get(i);
    d.update();
    if (d.time ==0) {
      dee.remove(d);
    }
  }
  for (int i = 0; i <eflat.size(); i++ ) {
    Eeeflat ef=eflat.get(i);
    ef.update();
    if (ef.time ==0) {
      eflat.remove(ef);
    }
  }
  for (int i = 0; i <eee.size(); i++ ) {
    Eee e=eee.get(i);
    e.update();
    if (e.time ==0) {
      eee.remove(e);
    }
  }
  for (int i = 0; i <eff.size(); i++ ) {
    Eff f=eff.get(i);
    f.update();
    if (f.time ==0) {
      eff.remove(f);
    }
  }
  for (int i = 0; i <gflat.size(); i++ ) {
    Geeflat gf=gflat.get(i);
    gf.update();
    if (gf.time ==0) {
      gflat.remove(gf);
    }
  }
  for (int i = 0; i <gee.size(); i++ ) {
    Gee g=gee.get(i);
    g.update();
    if (g.time ==0) {
      gee.remove(g);
    }
  }
  for (int i = 0; i <aflat.size(); i++ ) {
    Ayeflat af=aflat.get(i);
    af.update();
    if (af.time ==0) {
      aflat.remove(af);
    }
  }
  for (int i = 0; i <aye.size(); i++ ) {
    Aye a=aye.get(i);
    a.update();
    if (a.time ==0) {
      aye.remove(a);
    }
  }
  for (int i = 0; i <bflat.size(); i++ ) {
    Beeflat bf=bflat.get(i);
    bf.update();
    if (bf.time ==0) {
      bflat.remove(bf);
    }
  }
  for (int i = 0; i <bee.size(); i++ ) {
    Bee b=bee.get(i);
    b.update();
    if (b.time ==0) {
      bee.remove(b);
    }
  }
  offscreen.endDraw();
  background(0);
  surface.render(offscreen);
}
void randomColors() { // A function we use to change randomly the colors
  backgroundCol=color(random(100, 255), 50, 50); // Set a random color for the background with a hue from 127 to 255
}
void keyPressed() {
  switch(key) {
  case 'c':
    ks.toggleCalibration();
    break;

  case 'l':
    ks.load();
    break;

  case 's':
    ks.save();
    break;
  }
}

void controllerChange(int channel, int number, int value) {
  println();
  println(""+channel+""+number+""+value);
}

void noteOn(int channel, int pitch, int velocity) {
  println();  // uncomment to see all the incoming messages
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);

  int vel = velocity;
  int pit = pitch;
  myBus.sendNoteOn(channel, pitch, velocity);

  if ((channel==0)) {
    randomColors();
    //}else if((channel==0)&&(pitch==38)){ // Snare note will sellect the next shape
  } 
  //if (pitch==12 || pitch==24 ||pitch==36 || pitch==24 ||pitch==36|| pitch==48 ||pitch==72|| pitch==84 ||pitch==96) {
    if ((channel==1)) {
    see.add(new See(pitch));
  }
  //if (pitch==1 || pitch==13 ||pitch==25 || pitch==37 ||pitch==49|| pitch==61 ||pitch==73|| pitch==85 ||pitch==97) {
    if ((channel==2)) {
    dflat.add(new Deeflat(vel));
  }

  //if (pitch==2 || pitch==14 ||pitch==26 || pitch==38 ||pitch==50|| pitch==62||pitch==74|| pitch==86 ||pitch==98) {
    if ((channel==3)) {
    dee.add(new Dee(vel));
  }
  //if (pitch==3|| pitch==15 ||pitch==27 || pitch==39 ||pitch==51|| pitch==63 ||pitch==75|| pitch==87 ||pitch==99) {
    if ((channel==4)) {
    eflat.add(new Eeeflat(vel));
  }
  //if (pitch==4 || pitch==16 ||pitch==28 || pitch==40 ||pitch==52|| pitch==64||pitch==76|| pitch==88 ||pitch==100) {
    if ((channel==5)) {
    eee.add(new Eee(vel));
  }
  //if (pitch==5|| pitch==17 ||pitch==29 || pitch==41 ||pitch==53|| pitch==65 ||pitch==77|| pitch==89 ||pitch==101) {
    if ((channel==6)) {
    eff.add(new Eff(vel));
  }

  //if (pitch==6|| pitch==18 ||pitch==30 || pitch==42 ||pitch==54|| pitch==66 ||pitch==78|| pitch==90 ||pitch==102) {
    if ((channel==7)) {
    gflat.add(new Geeflat(vel));
  }

  //if (pitch==7 || pitch==19 ||pitch==31 || pitch==43 ||pitch==55|| pitch==67||pitch==79|| pitch==91 ||pitch==103) {
    if ((channel==8)) {
    gee.add(new Gee(vel));
  }
  //if (pitch==8|| pitch==20 ||pitch==32 || pitch==44 ||pitch==56|| pitch==68 ||pitch==80|| pitch==92 ||pitch==104) {
    if ((channel==9)) {
    aflat.add(new Ayeflat(vel));
  }

  //if (pitch==9 || pitch==21 ||pitch==33 || pitch==45 ||pitch==57|| pitch==69||pitch==81|| pitch==93 ||pitch==105) {
    if ((channel==10)) {
    aye.add(new Aye(vel));
  }
  //if (pitch==10|| pitch==22 ||pitch==34 || pitch==46 ||pitch==58|| pitch==70 ||pitch==82|| pitch==94 ||pitch==106) {
  //  bflat.add(new Beeflat(vel));
  //}

  //if (pitch==11 || pitch==23 ||pitch==35 || pitch==47 ||pitch==59|| pitch==71||pitch==82|| pitch==95 ||pitch==107) {
  //  bee.add(new Bee(vel));
  //}
}

class See {
  float x;
  float y;
  float size;
  int time;

  See(float size) {
    x = random(0, width);
    y=random(height);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(7);
    offscreen.stroke(13, 60, 85, alpha);
    x++;
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x+50, y+60);
    offscreen.vertex(x+70, y-30);
    offscreen.vertex(x*1.1, y*1.1);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}

class Deeflat {
  float x;
  float y;
  float size;
  int time;

  Deeflat(float size) {
    x = random(0, width/3);
    y=random(height/2);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(7);
    offscreen.stroke(13, 60, 85, alpha);
    x++;
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x+90, y+90);
    offscreen.vertex(x+120, y+90);
    offscreen.vertex(x+90, y+120);
    offscreen.vertex(x+35, y+120);
    offscreen.vertex(x+50, y+60);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}
class Dee {
  float x;
  float y;
  float size;
  int time;

  Dee(float size) {
    x = random(0, width/3);
    y=random(height);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(6);
    offscreen.stroke(17, 120, 153, alpha);
    offscreen.rect(x, y, size, size);
    size--;
    time--;
  }
}

class Eeeflat {
  float x;
  float y;
  float size;
  int time;

  Eeeflat(float size) {
    x = random(0, width/3);
    y=random(height/2);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    x--;
    y--;
    offscreen.noFill();
    offscreen.strokeWeight(3);
    offscreen.stroke(19, 149, 186, alpha);
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x+15, y+30);
    offscreen.vertex(x+30, y+30);
    offscreen.vertex(x+30, y+45);
    offscreen.vertex(x+60, y+60);

    offscreen.vertex(x+30, y+75);
    offscreen.vertex(x+30, y+90);
    offscreen.vertex(x+15, y+90);
    offscreen.vertex(x, y+120);
    offscreen.vertex(x-15, y+90);
    offscreen.vertex(x-30, y+90);
    offscreen.vertex(x-30, y+75);
    offscreen.vertex(x-60, y+60);
    offscreen.vertex(x-30, y+45);
    offscreen.vertex(x-30, y+30);
    offscreen.vertex(x-15, y+30);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}
class Eee {
  float x;
  float y;
  float size;
  int time;

  Eee(float size) {
    x = random(0, width/2);
    y=random(height);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(7);
    offscreen.stroke(13, 60, 85, alpha);
    x++;
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x+50, y+60);
    offscreen.vertex(x+70, y-30);
    offscreen.vertex(x*1.1, y*1.1);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}


class Eff {
  float x;
  float y;
  float size;
  int time;

  Eff(float size) {
    x = random(0, width/2);
    y=random(height);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(7);
    offscreen.stroke(162, 184, 108, alpha);
    x++;
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x+60, y);
    offscreen.vertex(x+90, y+30);
    offscreen.vertex(x+90, y+60);
    offscreen.vertex(x+60, y+90);
    offscreen.vertex(x, y+90);
    offscreen.vertex(x+30, y+60);
    offscreen.vertex(x+30, y+30);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}

class Geeflat {
  float x;
  float y;
  float size;
  int time;

  Geeflat(float size) {
    x = random(0, width);
    y=random(height/2);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(3);
    offscreen.stroke(235, 200, 68, alpha);
    x++;
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x-30, y+30);
    offscreen.vertex(x+20, y+50);
    offscreen.vertex(x+30, y-50);
    offscreen.vertex(x-30, y*1.3);
    offscreen.vertex(x*1.4, y+90); 
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}
class Gee {
  float x;
  float y;
  float size;
  int time;

  Gee(float size) {
    x = random(0, width);
    y=random(height);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(6);
    offscreen.stroke(236, 170, 56, alpha);
    x++;
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x, y+20);
    offscreen.vertex(x+20, y+40);
    offscreen.vertex(x, y+60);
    offscreen.vertex(x, y+40);
    offscreen.vertex(x-20, y+20);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}

class Ayeflat {
  float x;
  float y;
  float size;
  int time;

  Ayeflat(float size) {
    x = random(0, width);
    y=random(height/2);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(3);
    offscreen.stroke(239, 139, 44, alpha);
    x++;
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x*1.6, y+30);
    offscreen.vertex(x-30, y*1.3);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}
class Aye {
  float x;
  float y;
  float size;
  int time;

  Aye(float size) {
    x = random(0, width);
    y=random(height);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(7);
    offscreen.stroke(13, 60, 85, alpha);
    x++;
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x+50, y+60);
    offscreen.vertex(x+70, y-30);
    offscreen.vertex(x*1.1, y*1.1);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}
class Beeflat {
  float x;
  float y;
  float size;
  int time;

  Beeflat(float size) {
    x = random(0, width);
    y=random(height/2);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(2);
    offscreen.stroke(217, 78, 31, alpha);
    x--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x+15, y+30);
    offscreen.vertex(x+60, y);
    offscreen.vertex(x+45, y+45);
    offscreen.vertex(x+75, y+60);
    offscreen.vertex(x+45, y+75);
    offscreen.vertex(x+60, y+120);
    offscreen.vertex(x+15, y+90);
    offscreen.vertex(x, y+120);
    offscreen.vertex(x-15, y+90);
    offscreen.vertex(x-60, y+120);
    offscreen.vertex(x-45, y+75);
    offscreen.vertex(x-75, y+60);
    offscreen.vertex(x-45, y+45);
    offscreen.vertex(x-60, y);
    offscreen.vertex(x-15, y+30);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}
class Bee {
  float x;
  float y;
  float size;
  int time;

  Bee(float size) {
    x = random(0, width);
    y=random(height);
    this.size =size;
    time = 100;
  }
  void update() {
    float alpha = map(time, 0, 100, 0, 255);
    offscreen.noFill();
    offscreen.strokeWeight(4);
    offscreen.stroke(192, 46, 29, alpha);
    y--;
    offscreen.beginShape();
    offscreen.vertex(x, y);
    offscreen.vertex(x+10, y+10);
    offscreen.vertex(x+20, y-20);
    offscreen.vertex(x, y+10);
    offscreen.vertex(x-20, y+20);
    offscreen.vertex(x-10, y+10);
    offscreen.vertex(x, y);
    offscreen.endShape();
    time--;
  }
}