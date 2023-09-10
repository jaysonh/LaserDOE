// the number of the LED pin
const int ledPin1 = 16;  // 16 corresponds to 
const int ledPin2 = 17;  // 16 corresponds to GPIO16
const int ledPin3 = 18;  // 16 corresponds to GPIO16

// setting PWM properties
const int freq = 5000;
const int ledChannel1 = 0;
const int ledChannel2 = 1;
const int ledChannel3 = 2;
const int resolution = 8;

int r = 0;
int g = 0;
int b = 0;

char *ptr = NULL;
char *strings[3];


void setup(){
  Serial.begin(230400);
  Serial.setTimeout(50);
  
  // configure LED PWM functionalitites
  ledcSetup(ledChannel1, freq, resolution);
  ledcSetup(ledChannel2, freq, resolution);
  ledcSetup(ledChannel3, freq, resolution);
  
  // attach the channel to the GPIO to be controlled
  ledcAttachPin(ledPin1, ledChannel1);
  ledcAttachPin(ledPin2, ledChannel2);
  ledcAttachPin(ledPin3, ledChannel3);
}
 
void loop()
{
    recvData(); 
    
    ledcWrite(ledChannel1, r);
    ledcWrite(ledChannel2, g);
    ledcWrite(ledChannel3, b);
   
}

void recvData()
{
  if (Serial.available()) { // Check if there is data available to read
    String recvString = Serial.readString(); // Read the string from Serial
    recvString.trim();
    if(recvString.length() > 0)
    {    
      int numCommas = countCommas(recvString);
      if( numCommas == 2)
      {
          char delimiter[] = ","; // Delimiter string
          char* token = strtok(const_cast<char*>(recvString.c_str()), delimiter);

          int cols[3];
          int indx=0;
          while (token != NULL) {
            cols[indx] = atoi(token);
            indx++;
            
            token = strtok(NULL, delimiter);
          }
          //Serial.println(String(cols[0]) + "," + String(cols[1]) + "," + String(cols[2]));

          r=cols[0];
          g=cols[1];
          b=cols[2];
      }
    }
  }
}

int countCommas(const String& str) {
  int commaCount = 0;
  
  for (size_t i = 0; i < str.length(); i++) {
    if (str.charAt(i) == ',') {
      commaCount++;
    }
  }
  
  return commaCount;
}
