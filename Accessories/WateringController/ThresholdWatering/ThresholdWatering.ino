int pumpTime=6000; 
unsigned long pumpDelay=60000;

int state1=1; //0: waiting for full wet  //1: waiting for full dry

int fullWet=700; //thresholds out of 1000
int fullDry=100;

int pump1=0; //pump takes two pins (draws 60 mA) (terrible idea but no extra transistor)
int pump2=1;

int AIn[7]={1,-1,-1,-1,-1,-1}; //pins for analog input
//[0] is moisture sensor (P2)

int AInValue[7]={0,0,0,0,0,0};

void pumpOn(){
  digitalWrite(pump1, HIGH);
  digitalWrite(pump2, HIGH);
}
void pumpOff(){
  digitalWrite(pump1, LOW);
  digitalWrite(pump2, LOW);
}
void ARead(int APin){
   AInValue[APin]=analogRead(AIn[APin]);
}

void setup() {       
  pinMode(pump1, OUTPUT); 
  pinMode(pump2, OUTPUT); 
  pumpOff();
  
  pinMode(AIn[0], INPUT); 
  
  pinMode(3, INPUT);  
  pinMode(4, INPUT);
  pinMode(5, INPUT); 
}


void loop() {
  ARead(0);
  if (state1==0 && AInValue[0]<fullWet){
    pumpOn();
    delay(pumpTime);
    pumpOff();  
    delay(pumpDelay);
  }
  if (AInValue[0]>fullWet) state1=1;
  if (state1==1 && AInValue[0]<fullDry){
    state1=0;
  }
}
