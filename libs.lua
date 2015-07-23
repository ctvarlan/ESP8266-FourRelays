--The file named "stat" must be created first and uploaded on ESP8266
local moduleName = ...
local M = {}
_G[moduleName] = M
--------------------------------------------------------------------------------
function M.secret(p)
    --not yet
end
--------------------------------------------------------------------------------
function M.update()
local st=M.stat_read()
local stats = {}
stats[1],stats[2],stats[3],stats[4] = string.match(st,"(%a+),(%a+),(%a+),(%a+)")

	for k,v in ipairs(stats) do
		if (stats[k] == 'OFF') then
			gpio.write(rl[k], ZERO)
			tmr.delay(100)
		else
			gpio.write(rl[k], ONE)
			tmr.delay(100)
		end--if
    end--for
print("Update done")
end--function
--------------------------------------------------------------------------------
function M.stat_read()
--[2]
	file.open("stat","r")
	st=file.read()
	file.close()
	return st
end--stat_read()		[*]
--------------------------------------------------------------------------------
local function stat_write(s)    --this should be local
--[3]
	file.open("stat","w")
  file.write(s)
	file.close()
end--stat_write()		[*]
--------------------------------------------------------------------------------
function M.gpio_write(c, i)
--[5]
  local gpio_out
	local cmd
--[6]
  local old_stat = M.stat_read()
	local new_stat	--keeps the new status to be writen in "stat"
	local stats = {}
	stats[1],stats[2],stats[3],stats[4] = string.match(old_stat,"(%a+),(%a+),(%a+),(%a+)")
	
	if (c == "00") then	--reset
    for k,v in ipairs(rl) do
      tmr.delay(100)
      gpio.write(rl[k], ZERO)	--ZERO is the output value for inactivate the relay
    end--for
		for k,v in ipairs(stats) do
			stats[k]="OFF"
		end--for
    new_stat = table.concat(stats,',')
    stat_write(new_stat)
    print(new_stat)
    return M.cmd_format('0')
	elseif (c == '0' and c ~= "00") then
		cmd = "OFF"
		gpio_out = ZERO
	elseif (c == '1') then
		cmd = "ON"
		gpio_out = ONE
	end--if

	gpio.write(rl[tonumber(i)], gpio_out)
	stats[tonumber(i)] = cmd
	new_stat = table.concat(stats,',')
	stat_write(new_stat)

  gpio_out,cmd,old_stat,new_stat,stats = nil,nil,nil,nil,nil
    
  return M.cmd_format('1')
end--gpio_write()
--------------------------------------------------------------------------------
function M.cmd_format(qy)
--[7]
    local s = M.stat_read()
    local st = {}
    local r = ""
    st[1],st[2],st[3],st[4] = s:match("(%a+),(%a+),(%a+),(%a+)")
    
    for i=1,4 do
       r = r .."L"..i.."="..st[i].."&"
    end
    
    if (qy == '0') then
       return "R:"..r.."gR"
    elseif (qy == '2') then
       return "S:"..r:sub(1,r:len()-1)
    elseif (qy == '1') then
       return r.."err=%0"
    else
       return "err=99"
    end
    s,st,r=nil,nil,nil    
end--cmd_format()
--------------------------------------------------------------------------------
return M
