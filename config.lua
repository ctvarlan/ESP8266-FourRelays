port 		= 4000

rl          = {}
led         = {}
Header200 = "HTTP/1.1 200 OK\r\n"..
            "Server: NodeLua\r\n"..
            "Content-Type: text/html\r\n"..
            "Connection: close\r\n"..
            "Cache-Control: no-cache\r\n"..
            "\r\n"

libs = require("libs")      --[8]
ONE   = gpio.HIGH
ZERO  = gpio.LOW

--gpio =  {[0]=3,[1]=10,[2]=4,[3]=9,[4]=2,[5]=1,[9]=11,[10]=12,[12]=6,[13]=7,[14]=5,[15]=8,[16]=0}
rl = {[1]=3,[2]=4,[3]=2,[4]=1,}
led.g = 6
led.b = 7
led.r = 8

gpio.mode(rl[1],gpio.OUTPUT)
gpio.mode(rl[2],gpio.OUTPUT)
gpio.mode(rl[3],gpio.OUTPUT)
gpio.mode(rl[4],gpio.OUTPUT)

gpio.write(rl[1],ONE)
gpio.write(rl[2],ONE)
gpio.write(rl[3],ONE)
gpio.write(rl[4],ONE)

gpio.mode(led.g,gpio.OUTPUT)
gpio.mode(led.b,gpio.OUTPUT)
gpio.mode(led.r,gpio.OUTPUT)
-- On the development board it is an RGB LED that stays on at power up
-- The next three code lines shut off the RGB LED
gpio.write(led.g,ZERO)
gpio.write(led.b,ZERO)
gpio.write(led.r,ZERO)
--------------------------------------------------------------------------------
--some other configs come here

print("Config done")
