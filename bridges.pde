import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;
AudioMetaData meta;
Spectrum spectrum;

PFont nbold;
PFont nlight;
PrintWriter output;
BufferedReader csvReader;
String line;
String filename = "infra";
Boolean isClosed = false;

void setup() {
    size(1280,720);
    
    minim = new Minim(this);
    player = minim.loadFile(filename + ".mp3",1024);
    meta = player.getMetaData(); //meta data
    
    
    fft = new FFT(player.bufferSize(),player.sampleRate());
    
    //spec
    spectrum = new Spectrum();
    
    csvReader = createReader("./music_data/" + filename + ".txt");
    
    output = createWriter("./music_data/"+filename + ".txt");
    
    
    //fonts
    nbold = createFont("nbold.otf",32);
    nlight = createFont("nlight.otf",32);
    
   //play after loading
   player.play(); //this is a different thread.
    
}

void draw() {
    //this is main processing thread.
  
    background(250);
    stroke(40);
    strokeWeight(4);
    textSize(20);
    noStroke();
    textSize(20);
        
    
    
    //gui
    textFont(nbold);
    fill(#181818);
    text("infra turbo pigcart racer",100,100);
    textFont(nlight);
    text("deadmau5",100,150);
    

    if ( player.isPlaying()) {
       spectrum.write(player.mix); 
    } 
    else {
      //OnlyOnce.
      if (!isClosed) {
         output.flush();
         output.close();
         isClosed = true;
      }
      
       spectrum.tester();  
    }
    
    //spectrum.show(player.mix);
    
        
}

void keyPressed() {
  
    if (key == ' ') {
        output.flush();
        output.close();
        exit();
    }
    
}
