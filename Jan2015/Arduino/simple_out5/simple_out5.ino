int led=13;
int light=12;
int pump=11;

int forceLight=-1;
int forceWater=-1;

unsigned long hour = 3600000;
int Hclk=0;
unsigned long days=1;


float HoursLight=14;

int waterIntHours=6;
unsigned long waterTime=50000;

int watered=-1;

unsigned long clk=millis();
unsigned long Wclk=0;

int incomingByte = 0;   // for incoming serial data

void setup() {
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);  
  Serial.begin(9600);
  Serial.print("Hours of Daylight: ");
  Serial.println(HoursLight);
  Serial.print("Watering Interval (hours): ");
  Serial.println(waterIntHours);
  Serial.print("Watering Time (mS): ");
  Serial.println(waterTime);
  Serial.println();
  Serial.println();
  Serial.println("Send a/s to move clock, d/f to change day length, g/h to change duration of watering," );
  Serial.println("j/k to change watering interval, q/w/e to force on/none/off lights, i/o/p to force on/none/off pump" );
}
void checkHour(){
  if (millis()>clk+hour || millis()<clk){
    Hclk=Hclk+1;
    clk=millis();
    Serial.print("Hours into Day: ");
    Serial.println(Hclk);  
  } 
  if(Hclk==24){
    Hclk=0;
    days=days+1;
    Serial.print("Day: ");
    Serial.println(days);
  }
  if(Hclk<0)Hclk=23;
}

void checkLight(){
  if(forceLight!=0 &&(Hclk<HoursLight || forceLight==1)){
    digitalWrite(light,HIGH);
  }
  else {
    digitalWrite(light,LOW);
  }
}

void checkWater(){
  if(Hclk%waterIntHours==0 && watered==-1){                      //begin watering
    watered=0;
    Wclk=millis();
    Serial.println("pump on");
  }
  
  if (forceWater!=0 && (watered==0 || forceWater==1)){           //still watering
    digitalWrite(pump,HIGH);
  }
  else digitalWrite(pump,LOW);
  
  if(watered==0 && (millis() > Wclk+waterTime || millis()<Wclk)){  //done watering
    Serial.println("pump off");
    watered=1;
  }
  
  if(Hclk%waterIntHours!=0){                                     //reset watering
    watered=-1; 
  }
}

void loop() {
  checkHour();
  checkLight();
  checkWater();
  checkSerial();             
}
void checkSerial(){

        // send data only when you receive data:
        if (Serial.available() > 0) {
                // read the incoming byte:
                incomingByte = Serial.read();
                if(incomingByte == 97) moveClockF();           //a
                else if(incomingByte == 115) moveClockB();     //s
                else if(incomingByte == 100) moreLight();      //d
                else if(incomingByte == 102) lessLight();      //f
                else if(incomingByte == 103) moreWater();      //g
                else if(incomingByte == 104) lessWater();      //h
                else if(incomingByte == 106) WaterMoreOften(); //j
                else if(incomingByte == 107) WaterLessOften(); //k  
                else if(incomingByte == 113) forceLightOn();   //q
                else if(incomingByte == 119) forceLightNone(); //w
                else if(incomingByte == 101) forceLightOff();  //e
                else if(incomingByte == 105) forcePumpOn();    //i
                else if(incomingByte == 111) forcePumpNone();  //o
                else if(incomingByte == 112) forcePumpOff();   //p
                else{
                  Serial.print("I received: ");
                  Serial.println(incomingByte, DEC); 
                }
        }  
}
void moveClockF(){
  Hclk=Hclk+1;
  Serial.print("Hours into Day: ");
  Serial.println(Hclk);  
}
void moveClockB(){
  Hclk=Hclk-1;
  Serial.print("Hours into Day: ");
  Serial.println(Hclk);  
}
void moreLight(){
  HoursLight=HoursLight+1;
  Serial.print("Hours of Light: ");
  Serial.println(HoursLight);  
}
void lessLight(){
  HoursLight=HoursLight-1;
  Serial.print("Hours of Light: ");
  Serial.println(HoursLight);  
}
void moreWater(){
  waterTime=waterTime+1000;
  Serial.print("mS of Water: ");
  Serial.println(waterTime);  
}
void lessWater(){
  waterTime=waterTime-1000;
  Serial.print("mS of Water: ");
  Serial.println(waterTime);  
}
void WaterMoreOften(){
  waterIntHours=waterIntHours-1;
  Serial.print("Hours between watering: ");
  Serial.println(waterIntHours);  
}
void WaterLessOften(){
  waterIntHours=waterIntHours+1;
  Serial.print("Hours between watering: ");
  Serial.println(waterIntHours);  
}
void forceLightOn(){
  forceLight=1;
  Serial.println("forcing light on");  
}
void forceLightNone(){
  forceLight=-1;
  Serial.println("not forcing light");  
}
void forceLightOff(){
  forceLight=0;
  Serial.println("forcing light off");  
}
void forcePumpOn(){
  forceWater=1;
  Serial.println("forcing pump on");
}
void forcePumpNone(){
  forceWater=-1;
  Serial.println("not forcing pump");
}
void forcePumpOff(){
  forceWater=0;
  Serial.println("forcing pump off");
}
