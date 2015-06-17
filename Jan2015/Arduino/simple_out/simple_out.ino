int led=13;
int light=12;
int pump=11;

int msInHour=1000*60*60;
float HoursLight=14;

int waterIntHours=6;
int waterTime=20*1000;


unsigned long clk=millis();
unsigned long Wclk=millis();


void setup() {
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);  
  Serial.begin(9600);
}

void checkDay(){
  if(millis()<clk+1000){
    digitalWrite(light,HIGH);
  }
  else {
    digitalWrite(light,LOW);
  }
  if(millis()>clk+4000||millis()<clk){
    clk=millis();
  }
}
void checkWater(){
  if(millis()<Wclk+2000){
    digitalWrite(pump,HIGH);
  }
  else {
    digitalWrite(pump,LOW);
  }
  if(millis()>Wclk+4000||millis()<Wclk){
    Wclk=millis();
  }
}

void loop() {
  checkDay();
  checkWater();
  
  
  analogWrite(13,255*float(float((millis()-clk))/4000));  
  delay(2000);              
  analogWrite(13,255*float(float((millis()-Wclk))/4000));  
  delay(2000);              
  analogWrite(13,0);    
  delay(2000);              
}
