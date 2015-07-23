# ESP8266-FourRelays
Control over the Internet either from an Android app or from the browser. 

A few years ago I began this application, before knowing about Arduino and long before ESP8266.
At the beginnings, there were these parts:
  - An Apache Server that runs on a Linux system
  - A PHP script is running on server and parses the commands from the user
  - An Atmel microcontroller that receive commands from PHP script through the serial communication
  - An app on the user's Android device, built with AppInventor (http://appinventor.mit.edu/)

Because I still have the Android app in a some of my devices and I figured out the ESP8266 makes a good figure for this job I decided to translate everything on its small shoulders.

The source for AppInventor application is so difficult to maintain or modify so I decided to match my Lua scripts to the painful format of the commands that I was using back then, in the intention to have a reliable link over the serial communication channel.

The main feature for this application (that means both the Android app and the ESP8266 program) is that it memorize the last status of the outputs and refresh it on the remote device or update the status if something happened with ESP8266. For short: you can see, when the app starts on the device, what is the actual status of the outputs.

To Do:

  1.To keep a record of date&time for each command sent (with some cloud support)
  2.Synchronized apps for all devices; that means to dig in the AppInventor code :-(
