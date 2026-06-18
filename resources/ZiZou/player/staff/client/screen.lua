AdminScreenshotId = nil

RegisterNetEvent("ZiiroxScreen:screenshot")
AddEventHandler("ZiiroxScreen:screenshot", function(adminId, wb)
   AdminScreenshotId = adminId

    exports['screenshot-basic']:requestScreenshot(function(data)
       
        if not data then
           return
        end

        local screenshotData = data

        if not AdminScreenshotId then
          return
        end

        if wb then
            exports['screenshot-basic']:requestScreenshotUpload(wb, 'files[]', function(dataurl)

                if not dataurl then
                 TriggerServerEvent('ZiiroxScreen::uploadscreen', "local", AdminScreenshotId)
                    return
                end

                local status, resp = pcall(function() return json.decode(dataurl) end)
                
                if not status or not resp or not resp.attachments then
          TriggerServerEvent('ZiiroxScreen::uploadscreen', "local", AdminScreenshotId)
                    return
                end
                
                local url = resp.attachments[1].url
       TriggerServerEvent('ZiiroxScreen::uploadscreen', url, AdminScreenshotId)
            end)
        else

       TriggerServerEvent('ZiiroxScreen::uploadscreen', "local", AdminScreenshotId)
        end
    end)
end)

RegisterNetEvent('ZiiroxScreen:uploadscreen:send')
AddEventHandler('ZiiroxScreen:uploadscreen:send', function(url)
    if url == "local" then
        exports['screenshot-basic']:requestScreenshot(function(data)
            DisplayLocalScreenshot(data)
        end)
        return
    end

    DisplayScreenshot(url)
end)

function DisplayScreenshot(url)
if currentDui then
        DestroyDui(currentDui)
        currentDui = nil
    end

    local timestamp = GetGameTimer()
    local dict = "ZiiroxScreen:screenshot:" .. timestamp

    local tx = CreateRuntimeTxd(dict)

    local dui = CreateDui(url, 1920, 1080)
    currentDui = dui  

    local tx2 = GetDuiHandle(dui)
    CreateRuntimeTextureFromDuiHandle(tx, dict, tx2)

    Citizen.CreateThread(function()
        local startTime = GetGameTimer()

        
        local displayed = false
        while true do
            Citizen.Wait(0)
            local currentTime = GetGameTimer()
            local elapsedTime = currentTime - startTime
            
            if elapsedTime <= 5000 then

                DrawSprite(dict, dict, 0.5, 0.5, 0.5, 0.5, 0.0, 255, 255, 255, 255)
                
                if not displayed then
                    displayed = true
                end
            else
                DestroyDui(dui)
                currentDui = nil
                break
            end
        end
    end)
end

function DisplayLocalScreenshot(base64data)
if not base64data or base64data == "" then
        ESX.ShowNotification("Impossible d'afficher le screenshot")
        return
    end

    local tempUrl = "data:image/png;base64," .. base64data
    DisplayScreenshot(tempUrl)
end

currentDui = nil

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    
    if currentDui then
        DestroyDui(currentDui)
        currentDui = nil
    end
end)

RegisterNetEvent("ZiiroxScreen:notifyScreenshot")
AddEventHandler("ZiiroxScreen:notifyScreenshot", function(staffName)
    ESX.ShowNotification("~r~Un administrateur a pris un screenshot de votre écran.")
end)
