--read the "stat" file and update the gpio-s accordingly:
libs.update()

srv=net.createServer(net.TCP)
local msg = ""

srv:listen(port,function(conn)
    conn:on("receive", function(client,request)
        print("\nRequest:\n"..request)	--[ctv]
        _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
------[begin] For test purposes        
        if (method ~= nil) then
            print("m: "..method)    --[ctv]
        end--if
        
        if (path ~= nil) then
            print("p: "..path)      --[ctv]
            --if there is a need for authentication or for encryption then
            --the 'path' might be used for this purpose to embed a key
        end--if
        
        if (vars ~= nil) then
            print("v: "..vars)      --[ctv]
        end--if
------[end] For test purposes
        if(method == nil) then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end--if
        
        local _GET = {}
        if (vars ~= nil) then
        getTime(vars)
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end--for
        end--if
        
        if (_GET.q == '2') then
            msg=libs.cmd_format(_GET.q)
        elseif(_GET.q == '0') then  -- reset
        	msg = libs.gpio_write('00','0')	
        elseif(_GET.q == '1') then
            idx = tonumber(string.match(vars,'%d',5))
        	if(string.match(vars,'OFF') == 'OFF')then
        		msg = libs.gpio_write('0',idx)
        	elseif(string.match(vars,'ON') == 'ON')then
        		msg = libs.gpio_write('1',idx)
            else
                msg = "err=99"
        	end -- if(string.match OFF)
        else
        	msg = "Unknown error."
        end
        print("Done")
--------------------------------------------------------------------------------
        client:send(Header200)
        client:send(msg);
        client:close();
        collectgarbage();
        print(node.heap())
    end)
end)
