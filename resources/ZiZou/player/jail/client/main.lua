local inJail = false
local jailTime = 0
local jailStation = nil
local secondsCounter = 0

-- Registering events to sync with server
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    -- Check if player is in jail when they load in
    ESX.TriggerServerCallback('esx:getPlayerData', function(data)
        if data.jail and data.jail.time > 0 and data.jail.station then
            inJail = true
            jailTime = data.jail.time
            jailStation = data.jail.station
            secondsCounter = 0
        end
    end)
end)

-- Event to update jail status
RegisterNetEvent('esx:setJailStatus')
AddEventHandler('esx:setJailStatus', function(station, time)
    if station and time > 0 then
        inJail = true
        jailTime = time
        jailStation = station
        secondsCounter = 0
    else
        inJail = false
        jailTime = 0
        jailStation = nil
        secondsCounter = 0
    end
end)

-- Event to update jail time (sync with server)
RegisterNetEvent('esx:updateJailTime')
AddEventHandler('esx:updateJailTime', function(time)
    jailTime = time
    secondsCounter = 0
    
    if time <= 0 then
        inJail = false
        jailTime = 0
        jailStation = nil
    end
end)

-- Loop to display jail time and handle client-side countdown
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
        if inJail and jailTime > 0 then
            -- Increment seconds counter
            secondsCounter = secondsCounter + 1
            
            -- If 60 seconds have passed, decrement jailTime by 1
            if secondsCounter >= 60 then
                -- Reset counter but don't update jailTime here
                -- We'll rely on server sync for the official time
                secondsCounter = 0
            end
            
            -- Calculate display time
            local remainingSeconds = (jailTime * 60) - secondsCounter
            local remainingMinutes = math.ceil(remainingSeconds / 60)
            
            -- Calculate days, hours, minutes for display
            local days = math.floor(remainingMinutes / 1440)
            local hours = math.floor((remainingMinutes - (days * 1440)) / 60)
            local minutes = remainingMinutes - (days * 1440) - (hours * 60)
            
            -- Format text based on time units
            local timeText = "Temps Restant : "
            
            if days > 0 then
                timeText = timeText .. days .. " jours, "
            end
            
            if hours > 0 or days > 0 then
                timeText = timeText .. hours .. " heures, "
            end
            
            timeText = timeText .. minutes .. " minutes"
            
            DrawSub(timeText, 1000)
        end
    end
end)