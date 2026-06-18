local PlayersInJail = {}
local JailStations = {
    ["policestation1"] = {coords = vector3(487.2, -1014.2, 25.2), distance = 2},
    ["policestation2"] = {coords = vector3(483.9, -1014.2, 25.2), distance = 2},
    ["policestation3"] = {coords = vector3(481.0, -1014.2, 25.2), distance = 2},
    ["sheriffstation1"] = {coords = vector3(487.2, -1014.2, 25.2), distance = 2},
    ["sheriffstation2"] = {coords = vector3(483.9, -1014.2, 25.2), distance = 2},
    ["sheriffstation3"] = {coords = vector3(481.0, -1014.2, 25.2), distance = 2},
    ["federal"] = {coords = vector3(1643.7, 2530.9, 44.5), distance = 80},
    ["staff"] = {coords = vector3(-2178.37, 5190.43, 15.99), distance = 100},
}

function JailPlayer(source, station, time)
    local xPlayer = ESX.GetPlayerFromId(source) 
    if xPlayer then
        ESX.SyncPlayer(xPlayer)
        xPlayer.setJailStation(station)
        xPlayer.setJailTime(tonumber(time))
        PlayersInJail[xPlayer.source] = true
        TriggerClientEvent('esx:setJailStatus', source, station, time)
    end
end

function UnJailPlayer(source)
    local xPlayer = ESX.GetPlayerFromId(source) 
    if xPlayer then
        ESX.SyncPlayer(xPlayer)
        xPlayer.setJailStation(nil)
        xPlayer.setJailTime(0)
        TriggerClientEvent('esx:setJailStatus', source, nil, 0)
    end
end




AddEventHandler("esx:playerLoaded", function(source, xPlayer)
	if xPlayer then
        if xPlayer.jail.station and xPlayer.jail.time > 0 then
            PlayersInJail[xPlayer.source] = true
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local tasks = {}
        for k, v in pairs(PlayersInJail) do
            table.insert(tasks, function()
        local xPlayer = ESX.GetPlayerFromId(k)
        if xPlayer then
            if xPlayer.jail.time > 0 and xPlayer.jail.station then
                if xPlayer.jail.station == "staff" and GetPlayerRoutingBucket(xPlayer.source) ~= 99999 then
                    SetPlayerRoutingBucket(xPlayer.source, 99999)
                end
                local PlayerPed = GetPlayerPed(xPlayer.source)
                local playerCoords = GetEntityCoords(PlayerPed)
                if #(playerCoords - JailStations[xPlayer.jail.station].coords) > JailStations[xPlayer.jail.station].distance then
                    SetEntityCoords(PlayerPed, JailStations[xPlayer.jail.station].coords.x, JailStations[xPlayer.jail.station].coords.y, JailStations[xPlayer.jail.station].coords.z)
                end
            else
                local PlayerPed = GetPlayerPed(xPlayer.source)
                if GetPlayerRoutingBucket(xPlayer.source) ~= 0  then
                    SetPlayerRoutingBucket(xPlayer.source, 0)
                end
                xPlayer.setJailTime(0)
                TriggerClientEvent('esx:setJailStatus', k, nil, 0)
                xPlayer.setJailStation(nil)
                xPlayer.showNotification("Vous sortez de prison dans quelques instants !")
                PlayersInJail[xPlayer.source] = nil
                SetEntityCoords(PlayerPed, 426.5, -978.4, 30.7)
            end
        else
            PlayersInJail[k] = nil
        end
    end)
        end
        Async.parallelLimit(tasks, 4, function(results) end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(60 * 1000)
        local tasks = {}
        for k, v in pairs(PlayersInJail) do
            table.insert(tasks, function()
            local xPlayer = ESX.GetPlayerFromId(k)
            if xPlayer.jail.station then
                if xPlayer.jail.station then
                    local PlayerPed = GetPlayerPed(xPlayer.source)
                    if xPlayer.jail.time > 0 then
                        local newJail = xPlayer.jail.time - 1
                        if newJail <= 0 then
                            xPlayer.setJailTime(0)
                            xPlayer.setJailStation(nil)
                        else
                            xPlayer.setJailTime(newJail)
                            TriggerClientEvent('esx:updateJailTime', k, newJail)
                            xPlayer.showNotification("Il vous reste " .. newJail .. " minutes en prison !")
                        end
                    else
                        if xPlayer.jail.station == "staff" and GetPlayerRoutingBucket(xPlayer.source) ~= 0 then
                            SetPlayerRoutingBucket(xPlayer.source, 0)
                        end
                        xPlayer.setJailTime(0)
                        xPlayer.setJailStation(nil)
                        if PlayersInJail[xPlayer.source] then
                            PlayersInJail[xPlayer.source] = false
                        end
                    end
                end

                if xPlayer.jail.time > 0 and not xPlayer.jail.station then
                    xPlayer.jail.time = 0
                end
            end
            end)
        end
        Async.parallelLimit(tasks, 4, function(results) end)
    end
end)