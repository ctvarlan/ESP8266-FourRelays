--FourRelay/init.lua
--save-it as init.lua for normal use
--save-it as init_.lua for test use and run it manualy

wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')')
ssid = "your-SSID"
pswd = "your-PSWD"

-- wifi config start
wifi.sta.config(ssid,pswd)

file_to_do = "webServer.lua"

dofile("config.lc")
--[10]
tmr.alarm(2,10000,1, function() 
          gpio.write(led.b,ONE)
          tmr.delay(100000)
          gpio.write(led.b,gpio.LOW)
end)
     
tmr.alarm(0, 5000, 1, function()
   ip = wifi.sta.getip()
   if ip=="0.0.0.0" or ip==nil then
      print("connecting to AP...")
   else
      tmr.stop(0)
      print("IP = "..wifi.sta.getip())
	  dofile(file_to_do)
   end
end)
