CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false
local PlayerSpawned = false

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    if not PauseVSync then
    CurrentWeather = NewWeather
    blackout = newblackout
    if lastWeather ~= CurrentWeather then
        lastWeather = CurrentWeather
        SetWeatherTypeOverTime(CurrentWeather, 15.0)
        Citizen.Wait(15000)
    end
    SetBlackout(blackout)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(lastWeather)
    SetWeatherTypeNow(lastWeather)
    SetWeatherTypeNowPersist(lastWeather)
    if lastWeather == 'XMAS' then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
    end
end)

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

RegisterNetEvent("esx:passjoin")
AddEventHandler("esx:passjoin", function()
	PlayerSpawned = true
    TriggerServerEvent('vSync:requestSync')
    Citizen.CreateThread(function()
        local hour = 0
        local minute = 0
        local lastTimeUpdate = 0  -- Temps du dernier recalcul des heures/minutes
        local timeInterval = 250  -- Intervalle pour mettre à jour le temps (en ms)
    
        while true do
            Citizen.Wait(100)
    
            if not PauseVSync then
                local newBaseTime = baseTime
    
                -- Vérification du temps écoulé
                if GetGameTimer() - 500 > timer then
                    newBaseTime = newBaseTime + 0.25
                    timer = GetGameTimer()
                end
    
                -- Application du freeze time
                if freezeTime then
                    timeOffset = timeOffset + baseTime - newBaseTime
                end
    
                -- Mise à jour de la base du temps
                baseTime = newBaseTime
    
                -- Mise à jour de l'heure et des minutes à un intervalle régulier
                if GetGameTimer() - lastTimeUpdate >= timeInterval then
                    hour = math.floor(((baseTime + timeOffset) / 60) % 24)
                    minute = math.floor((baseTime + timeOffset) % 60)
                    NetworkOverrideClockTime(hour, minute, 0)
                    lastTimeUpdate = GetGameTimer()  -- Mettre à jour le dernier temps d'update
                end
            else
                Citizen.Wait(1000)  -- Attente plus longue lorsque le jeu est en pause
            end
        end
    end)
    
end)

-- Display a notification above the minimap.
function ShowNotification(text, blink)
    if blink == nil then blink = false end
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(blink, false)
end

RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message, blink)
    ShowNotification(message, blink)
end)
