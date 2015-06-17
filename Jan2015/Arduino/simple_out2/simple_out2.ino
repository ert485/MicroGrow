int led=13;
int light=12;
int pump=11;

int msInHour=1000*60*60;
float HoursLight=14;

int waterIntHours=6;
int waterTime=20*1000;


unsigned long clk=millis();
unsigned long Wclk=millis();

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

void checkDay(){
  if(millis()<clk+HoursLight*msInHour){
    digitalWrite(light,HIGH);

  }
  else {
    digitalWrite(light,LOW);

  }
  if(millis()>clk+24*msInHour||millis()<clk){
    clk=millis();
  }
}
void checkWater(){
  if(millis()<Wclk+waterTime){
    digitalWrite(pump,HIGH);

  }
  else {
    digitalWrite(pump,LOW);

  }
  if(millis()>Wclk+waterIntHours*msInHour||millis()<Wclk){
    Wclk=millis();
  }
}

void loop() {
  checkDay();
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
                if(incomingByte == 97) moveClock(-1);
                else if(incomingByte == 115) moveClock(-1);
                else if(incomingByte == 100) Serial.println("d");
                else if(incomingByte == 102) Serial.println("f");
                else if(incomingByte == 103) Serial.println("g");
                else if(incomingByte == 104) Serial.println("h");
                else{
                  Serial.print("I received: ");
                  Serial.println(incomingByte, DEC); 
                }
        }  
}
void moveClock(int a){
  if(clk+a*msInHour>0) clk=clk+a*msInHour;
  else Serial.println("clock can't go back");
  Serial.print("Hours into Day: ");
  Serial.println(millis()-clk);
}
