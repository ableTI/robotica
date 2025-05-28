//motor: https://www.pololu.com/product/4861
//motor driver: https://www.pololu.com/product/2997

//Create the timers
IntervalTimer pwm_timer;
IntervalTimer enc_timer;

//define the pins
//If the motors are spinning incorectly, change pins not the drive function.
int led = 13;

int m1enA = 6;
int m1enB = 5;
int m1pwm1 = 4;
int m1pwm2 = 3;
int m1encoA = 32;
int m1encoB = 31;

int m3encoB = 23;

//PWM variables
int pwmacc = 100; //how accurate the PWM is, means you can enter value from 0 to the value of pwmacc
int PWMval1 = 0;  //value of the PWM1, means you can enter value from 0 to the value of pwmacc

//encoder variables
const int refreshrate = 50; //refresh rate of the encoder
volatile long oneENCcount = 0; //the amount of pulses from motor one encoder

double ONErpm = 0.00; //the amount of revolutions motor one makes per minute



void setup() {
  pinMode(m1enA, OUTPUT);
  pinMode(m1enB, OUTPUT);
  pinMode(m1pwm1, OUTPUT);
  pinMode(m1pwm2, OUTPUT);

  pwm_timer.begin(updatePWM, refreshrate); //speed at wich PWM is updated PWM
  enc_timer.begin(enc_refr, 50);  //refresh rate of the encoder

  attachInterrupt(digitalPinToInterrupt(m1encoA), AoneIRS, CHANGE); //calls void AoneIRS if there is a change of the stare of m1encoA
  attachInterrupt(digitalPinToInterrupt(m1encoB), BoneIRS, CHANGE); //ditto

  Serial.begin(9600);
  Serial.print("start");

}

void updatePWM() {
  //PWM one
  //if the entered valvue is less the zero set it to zero, because lower that zero is not posible
  if (PWMval1 < 0) {
    PWMval1 = 0;
  }
  //if the enterd value is higher than the maximum posible value, set it to max.
  if (PWMval1 > pwmacc) {
    PWMval1 = pwmacc;
  }
  //check if the counter has passed the PWM value, and turn of the motor based on that.
  if (counter1 < PWMval1) {
    digitalWrite(m1enA, HIGH);
  } else {
    digitalWrite(m1enA, LOW);
  }
  counter1++;

  if (counter1 >= pwmacc) {
    counter1 = 0;
  }
}

void AoneIRS(){
  oneENCcount++ //adds one to the count
}
void BoneIRS(){
  oneENCcount++ //dieselbe
}

void enc_refr(){
  //calculate RPM. It gets updated 48 times per rotation.
  ONErpm = (oneENCcount/48.00) * (60000000.00 / refreshrate)
  //reset the counting to zero for next cycle.
  oneENCcount = 0;
}
void PID(int speed){
  Serial.println(ONErpm);
  PWMval1 = ; //enter output from PID algorith here
  digitalWrite(m1enB, LOW);
  digitalWrite(m1pwm1, HIGH);
  digitalWrite(m1pwm2, LOW);
}

//the loop routine runs over and over again forever:
void loop() {
  drive(50); //speed value between 0-100
  Serial.println("Motor one is at: "+ ONErpm + " RPM.");
  delay(50);
}
