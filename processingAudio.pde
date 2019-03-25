import arb.soundcipher.*;
SoundCipher sc = new SoundCipher(this);
SCScore score = new SCScore();
int nota = 0;
int instrument = 0;
boolean stopped;

// Tetris
float[] pitches = {70,65,66,68,66,65,63,63,66,70,68,66,65,66,68,70,66,63,63,63,65,66,68,71,75,73,71,70,66,70,68,66,65,65,66,68,70,66,63,63,0,70,65,66,68,66,65,63,63,66,70,68,66,65,66,68,70,66,63,63,63,65,66,68,71,75,73,71,70,66,70,68,66,65,65,66,68,70,66,63,63,0,70,66,68,65,66,63,62,65,0,70,66,68,65,66,70,75,74,0};
float[] dynamics = {100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,0,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,0,100,100,100,100,100,100,100,100,0,100,100,100,100,100,100,100,100,0};
float[] durations = {1,0.5,0.5,1,0.5,0.5,1,0.5,0.5,1,0.5,0.5,1.5,0.5,1,1,1,1,0.5,0.5,0.5,0.5,1.5,0.5,1,0.5,0.5,1.5,0.5,1,0.5,0.5,1,0.5,0.5,1,1,1,1,1,1,1,0.5,0.5,1,0.5,0.5,1,0.5,0.5,1,0.5,0.5,1.5,0.5,1,1,1,1,0.5,0.5,0.5,0.5,1.5,0.5,1,0.5,0.5,1.5,0.5,1,0.5,0.5,1,0.5,0.5,1,1,1,1,1,1,2,2,2,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2};

public void setup() {
  noLoop();  // Stop draw from playing by frames
  size(700,700);
  background(0);
  noStroke();
  
  // Set parameters of tempo and first instrument
  score.tempo(180);
  sc.instrument(8);
  
  // Add callback listener and callback to play notes 
  score.addCallbackListener(this);
  for(int i = 0; i < pitches.length; i++) {
    score.addCallback(i,1);
  }
  startStop();
}

public void draw() {
  // Play note
  sc.playNote(pitches[nota],dynamics[nota],durations[nota]);
  
  // Draw circles
  float size = random (25, 100);
  float x = random(width);
  float y = random(150,height);
  
  for (float ring = size; ring >= 0; ring -= random(2, 10)) {
    fill(random(256), random(256), random(256));
    ellipse(x, y, ring, ring);
  }
  
  // Change notes
  nota++;
  if(nota == pitches.length) nota = 0;
  textSize(20);
  fill(255);
  text("a) Press up or down arrows to change the instrument\nb) Use the spacebar to stop the music",120,20);
}

// Control when to play the next note
void handleCallbacks(int callbackID) {
  sc.instrument(instrument);
  print("instrument " + instrument + "\n");
  redraw();
}

void startStop() {
  if(stopped) {
    score.stop();
  } else {
    // Play to the infinity and beyond
    score.play(-1);
  }
}

// Control the instrument dynamically
void keyPressed() {
  
  // Arrows
  if(key == CODED) {
    if(keyCode == UP) {
      if(instrument + 1 < 127) instrument++;
      else instrument = 0;
    }
    if(keyCode == DOWN) {
      if(instrument - 1 > -1) instrument--;
      else instrument = 127;
    }
  }
  
  // Spacebar
  if(key == ' ') {
      stopped = !stopped;
      startStop();
    }
}
