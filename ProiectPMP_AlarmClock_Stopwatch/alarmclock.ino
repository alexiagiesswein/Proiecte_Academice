#include <Wire.h>  
#include <LiquidCrystal_I2C.h>
#include <stdio.h>
#include <ctype.h>

LiquidCrystal_I2C lcd(0x3F,20, 4);


int start;
int active;
int prev = 0;

int hours = 0;
int mins = 0;

int alarmhours = 0;
int alarmmins = 0;


void setup()
{
  lcd.begin();
  lcd.backlight();        
  lcd.clear();            
  lcd.print("00:00");    
  lcd.setCursor(10, 0);
  lcd.print("00:00");
  lcd.setCursor(0, 1);
  lcd.print("Time");
  lcd.setCursor(10, 1);
  lcd.print("Alarm");
  
  pinMode(8, INPUT);
  pinMode(9, INPUT);
  pinMode(10, INPUT);
  pinMode(11, INPUT);
  pinMode(3, OUTPUT);
  
  digitalWrite(8, HIGH);
  digitalWrite(9, HIGH);
  digitalWrite(10, HIGH);
  digitalWrite(11, HIGH);
  digitalWrite(3, LOW);
  
  start = millis()/1000;
}

void loop()
{
  
  if(digitalRead(8) == LOW)
  {
    lcd.setCursor(10,1);
    lcd.print("Alarm");
    lcd.setCursor(10,0);
    if(digitalRead(11) == LOW)      
    {
     alarmmins++;
    } 
    else if (digitalRead(10) == LOW)
    {
      alarmhours++;
    }
     lcd.setCursor(10,0);

 
  if(alarmhours < 10)
  {
    lcd.print("0");
    lcd.print(alarmhours);
  }
  else
  {
    lcd.print(alarmhours);
  }
    
  lcd.print(":");
    
  if (alarmmins < 10)
  {
    lcd.print("0");
    lcd.print(alarmmins);
  }
  else
  {
      lcd.print(alarmmins);
  }


 if(alarmmins > 59)
     {
      alarmhours++;
      alarmmins = 0;
     } 
  if(alarmhours > 23)
     {
      alarmhours = 0; 
     }
 delay(200);

}
    
  if(digitalRead(9) == LOW)
  {
   lcd.setCursor(0,1);
   lcd.print("Time");
   lcd.setCursor(0,0); 
   if(digitalRead(11) == LOW)         
    {
     mins++;
    } 
   else if (digitalRead(10) == LOW)
    {
      hours++;
    }
  }
  
      active = (millis() / 1000) - start;
      if(prev < (active - 59))
      {
       mins++;
       prev = active;
      } 
      
      if(mins > 59)
     {
      hours++;
      mins = 0;
     } 
     
     if(hours > 23)
     {
      hours = 0; 
     }
    delay(200);
 
  lcd.setCursor(0,0);
  
  if(hours < 10)
  {
    lcd.print("0");
    lcd.print(hours);
  }
  else
  {
    lcd.print(hours);
  }
  lcd.print(":");
  if (mins < 10)
  {
    lcd.print("0");
      lcd.print(mins);
  }
  else
  {
      lcd.print(mins);
  }



if (alarmhours == hours && alarmmins == mins && alarmhours != 0)
  {
    digitalWrite(3, HIGH);
    delay(200);
    digitalWrite(3, LOW);
    delay(200);
  }
}
