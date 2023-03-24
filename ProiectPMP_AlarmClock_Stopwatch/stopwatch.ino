#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x3F,20,4);

double time = 0;
double a = millis();
double c ;

void setup()
{
 lcd.begin();
 lcd.backlight();
 pinMode(8, INPUT);
 digitalWrite(8, HIGH);
 pinMode(9, INPUT);
 digitalWrite(9, HIGH);
 pinMode(2, OUTPUT);
 digitalWrite(2, LOW);
 digitalWrite(3, LOW);
 pinMode(3, OUTPUT);
}

void loop()
{
lcd.clear();
lcd.print("Press the button");

 if(digitalRead(8) == LOW)
 {
    lcd.clear();
    a = millis();

   while(digitalRead(9) == HIGH)
   {
   c = millis();
   time = (c - a) / 1000;
   lcd.print(time);
   lcd.setCursor(7,0);
   lcd.print("Seconds");
   lcd.setCursor(0,0);
   digitalWrite(2, HIGH);
   digitalWrite(3, LOW);
   }
   if(digitalRead(9) == LOW)
   {
     while(digitalRead(8) == HIGH)
     {
       lcd.setCursor(0,0);
       
       lcd.setCursor(11,0);
       lcd.print("");
       lcd.setCursor(0,0);
          digitalWrite(2, LOW);
          digitalWrite(3, HIGH);
     }
   }
 }
}




