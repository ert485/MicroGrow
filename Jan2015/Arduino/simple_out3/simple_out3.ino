int led=13;
int light=12;
int pump=11;

unsigned long hour = 3000;
int Hclk=0;
int days=0;


float HoursLight=14;

int waterIntHours=6;
unsigned long waterTime=1*1000;

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
  Serial.println();
  Serial.println();
  Serial.println("Send a/s to move clock, d/f to change day length, g/h to change watering interval" );
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
  if(Hclk<HoursLight){
    digitalWrite(light,HIGH);
  }
  else {
    digitalWrite(light,LOW);
  }
}

void checkWater(){
  if(Hclk%waterIntHours==0 && watered==-1){
    //Serial.println("pump on");
    watered=0;
    Wclk=millis();
  }
  if(millis()<Wclk+waterTime && millis()>Wclk && watered==0){
    digitalWrite(pump,HIGH);
        //Serial.println("pump on");
  }
  else{
    digitalWrite(pump,LOW);
    //if (watered==0 && millis()<Wclk+waterTime) Serial.println("pump off");    
    watered==-1;
  }
  if(Hclk%waterIntHours!=0){
    watered=-1; 
  }
}

void loop() {
  checkHour();
  checkLight();
  checkWater();
  checkSerial();
  //analogWrite(13,255*float(float((millis()-clk))/4000));  
  //delay(1000);              
  //analogWrite(13,255*float(float((millis()-Wclk))/4000));  
  //delay(1000);              
  //analogWrite(13,0);    
  //delay(2000);              
}
void checkSerial(){

        // send data only when you receive data:
        if (Serial.available() > 0) {
                // read the incoming byte:
                incomingByte = Serial.read();
                if(incomingByte == 97) moveClockF();
                else if(incomingByte == 115) moveClockB();
                else if(incomingByte == 100) moreLight();
                else if(incomingByte == 102) lessLight();
                else if(incomingByte == 103) moreWater();
                else if(incomingByte == 104) lessWater();
                else if(incomingByte == 106) WaterMoreOften();
                else if(incomingByte == 107) WaterLessOften();
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
