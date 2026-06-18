AddEventHandler("onClientResourceStop", function(a)
    TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Resource Stop")
end)

AddEventHandler("onResourceStop", function(a)
    TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Resource Stop")
end)
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function encac(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

RegisterNetEvent(ACConfig.Name.. ":clientScreen")
AddEventHandler(ACConfig.Name.. ":clientScreen", function(touche)
    exports['screenshot-basic']:requestScreenshotUpload(ZiZouConfig.Webhook.ScreenShot.Discord, 'files[]', function(data)
        local resp = json.decode(data)
        if resp and resp.attachments and resp.attachments[1] then
            local screenshotUrl = resp.attachments[1].url
            TriggerServerEvent(ACConfig.Name.. ":clientScreens", encac(screenshotUrl), touche)
        else
            print("^1[ERROR] Response doesn't contain 'attachments' field or the file is missing.")
        end
    end)
end)
