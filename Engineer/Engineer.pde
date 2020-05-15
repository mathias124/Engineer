//Lavet Af Mathias Alexander Friis Schrader
Partikel par;
float hastighed;
float vinkel;
float scale;
int hvis;
int Niveau;
PImage Engineer;
PFont Titelfont;
PFont LilleTitel;
import controlP5.*;
ControlP5 cp5;

void setup() {
  size(1640, 860);
  par = new Partikel(new PVector(width/2, 50));
  Engineer=loadImage("Engineerene.JPG");
  Titelfont=createFont("SuperScript",56);
  LilleTitel=createFont("SuperScript",30);
  smooth();
  Niveau=0;

  genstart();
 

}
void genstart(){


}

void draw() {
  simulator();
  update();
  runner();
  //background(0);
  par.addParticle();
  par.kor();
  if(Niveau==0) {
    image(Engineer,-500,-403);
    fill(255,149,10);
    textAlign(CENTER);
  textFont(Titelfont);
  text("Aperaturlig Videnskab", -215 , -355);
 textFont(LilleTitel);
 fill(255);
  text("Tryk hvilken som helst tast for at starte spillet",25,285);
  if(keyPressed==true){
    Niveau=1;
    background(134,134,134,134);
    
  }
  
  }
  
}
// Vinkel simulator der ændre vinkel hvis under 2 * pi. 
void runner(){
vinkel+=hastighed;
if(vinkel > TWO_PI ) {
  hvis++;
  vinkel-=TWO_PI;
}
}
void simulator(){
  if(Niveau==1){
  vinkel=0;
scale=130;
hastighed=.05;
hvis=0;
textSize(50);
  fill(42,67,157);
  text("Velkommen til Aperaturlig Videnskab",790,50);
  cp5= new ControlP5(this);
  cp5.addSlider("Loadingbar")//tilføjer loadingbar i hjørnet.
  .setRange(0,100)
  .setPosition(-205,315)
  .setSize(450,85);
  }
 
  

}//Prøver at lave sliding bar.
void controlEvent(ControlEvent theEvent){
  if(theEvent.isController()) {
    print("control even from:" +theEvent.getController().getName());
 println(",value;"+theEvent.getController().getValue());
 if(theEvent.getController().getName()=="Loadingbar") {
 float value = theEvent.getController().getValue();
 value=frameCount*10+value;
 
 }
}
  
}
//opdatere så den kan lave cirkler senere hen.
void update(){
translate(width/2,height/2);

}

//////////////////////////////////////////////////////////////////////////////
//Herunder en class med dens egenskaber og dens brug i forhold til ArrayList.
class Partikel {
  ArrayList<Particle> particles;
  PVector oprindelseposition;

  Partikel(PVector pos) {
    oprindelseposition = pos.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(oprindelseposition));
  }

  void kor() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.kor();
      if (p.erdendead()) {
        particles.remove(i);
      }
    }
  }
}


//////////////////////////////////////////////////////

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float livafcirkel;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-4, 4), random(-4, 2));
    position = l.copy();
    livafcirkel = 255.0;
  }

  void kor() {
  if(Niveau==1){
    update();
    display();
  }
  }
  //opdatere position
  void update() {  
    velocity.add(acceleration);
    position.add(velocity);
    livafcirkel -= 5.0;
  
  }

  //dens endelige udkom
  void display() {
    float b= random(0,255);
    stroke(b, livafcirkel,94);
    fill(b-livafcirkel, livafcirkel,94-livafcirkel);
    ellipse(position.x-230, position.y-35, 12, 12);
    float cosvaerdi= scale*cos(vinkel);
    float sinvaerdi = scale*sin(vinkel);
    //ellipse(cosvaerdi,sinvaerdi,15,15);
    //position.x=cosvaerdi;
    //position.y=sinvaerdi;
    ellipse(cosvaerdi,sinvaerdi,17,17);
  }
  

  // er denne partikel ud af brug? (gør så den fader away efter efter den når 0.
  boolean erdendead() {
    if (livafcirkel < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
