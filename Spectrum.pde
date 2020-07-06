
class Spectrum {  
    int items;
    float EASING;
    float[] decays;
    FFT fft;
    int bufferSize = 1024;
    float sampleRate = 44100.0;
    
  
    Spectrum() {
      
      
      items = 64;
      EASING = 0.09;
      decays = new float[items];
      
      fft = new FFT(bufferSize, sampleRate);
      
      for (int x = 0; x < items; x ++) {
         decays[x] = 0.0; 
      }
        
     }
  
    void show(AudioBuffer mix) {
      
        
       if (mix != null) { fft.forward(mix); } //singe line

      
       float block = width/items;
       
       float val;
       for (int i = 0; i < items; i++) {
         
         
         decays[i] += (fft.getBand(i) - decays[i])*EASING;
         val = decays[i];
         
         val *= pow(2,i*0.02);
      
         fill(color(155, 89, 182,val*3));
         rect(i*block,200,block,val*2);
          
       }
    }
    
    //display from values
    void tester() {
        String line;
        try {
          line = csvReader.readLine(); 
        } catch (IOException e) {
           line = null;
        }      
         
        if (line == null) { exit();}
        
        String[] linevalues = line.split(",");
        if (linevalues.length != 64) {
           return; 
        }
        
        Float[] floatValues = new Float[items];
        for (int i =0; i < items; i++) {
           floatValues[i] = Float.parseFloat(linevalues[i]);
        }
        
        //draw lines
        float block = width/items;
       
       float val;
       for (int i = 0; i < items; i++) {
         
         
         decays[i] += (floatValues[i] - decays[i])*EASING;
         val = decays[i];
         
         val *= pow(2,i*0.02);
      
         fill(color(155, 89, 182,val*3));
         rect(i*block,200,block,val*2);
        
      
        }
        
        saveFrame("./music_data/"+filename + "/frame######.png");
    }
    
    void write(AudioBuffer mix) {
        if (mix != null) { fft.forward(mix); }
        
        
        for (int i=0;i<items;i++) {
          output.print(fft.getBand(i));
          output.print(",");
        }
        
        output.println();
    }
    
  
}
