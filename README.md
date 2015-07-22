# ESP8266-FourRelays
Control over the Internet either from an Android app or from browser. 

A few years ago I begun this application, before knowing about Arduino and long before ESP8266.
At the beginning there were these parts:
  - A Linux system that runs an Apache Web Server
  - A php script that parse the data from the user
  - An Atmel microcontroller that receive commands from php script through the serial communication
  - An app on the user Android device, built with AppInventor

Because I still have the Android app in a some of my devices and I figured out the ESP8266 makes a good figure for this job I decided to translate everything on its small shoulders.

I lost the sourse for AppInventor application so I had to match my lua scripts to the painfull format of the commands that I was using back then, in the intention to a reliable link over the serial communication channel.
