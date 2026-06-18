local housesStates = {}
local playersResell = {}

Citizen.CreateThread(function()
    for _,house in pairs(robberiesConfiguration.houses) do
        table.insert(housesStates, {state = true, robbedByID = nil})
    end
end)

RegisterServerEvent("ESXrob:callThePolice")
AddEventHandler("ESXrob:callThePolice", function(houseIndex)
    local authority = robberiesConfiguration.houses[houseIndex].authority
    local xPlayers = ESX.GetPlayers()
    if housesStates[houseIndex] and housesStates[houseIndex].robbedByID == source then
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == 'police' then
            TriggerClientEvent("ESXrob:initializePoliceBlip",xPlayers[i], houseIndex, robberiesConfiguration.houses[houseIndex].policeBlipDuration)
        end
    end
    end
end)

RegisterServerEvent("ESXrob:pickupObject")
AddEventHandler("ESXrob:pickupObject", function(houseIndex, objectName)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if robberiesConfiguration.items[objectName] and robberiesConfiguration.houses[houseIndex] and housesStates[houseIndex] then
        if housesStates[houseIndex].robbedByID == _source then
            for k, v in pairs(robberiesConfiguration.houses[houseIndex].objects) do
                if v.object == objectName then 
                    if #(GetEntityCoords(GetPlayerPed(_source)) - v.position) <= 10 then
                        SetTimeout(1000 * robberiesConfiguration.items[objectName].timeToTake, function()
                            if not playersResell[_source] then
                                playersResell[_source] = {}
                            end
                            if not playersResell[_source][objectName] then
                                playersResell[_source][objectName] = robberiesConfiguration.items[objectName].resellerValue
                            end
                        end)
                    end
                end
            end
        end
    end

end)

RegisterServerEvent("ESXrob:sync")
AddEventHandler("ESXrob:sync", function(houseIndex)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer and #(GetEntityCoords(GetPlayerPed(_source)) - robberiesConfiguration.reseller.randomizeLocation.vector) <= 10 then
        if housesStates[houseIndex] and housesStates[houseIndex].robbedByID == _source then
            housesStates[houseIndex].robbedByID = 0
            local resellTotal = 0
            for k, v in pairs(playersResell[_source]) do
                resellTotal = resellTotal + v
            end
            xPlayer.addAccountMoney("black_money", resellTotal)
            xPlayer.showNotification("Félicitations tu as reçus ~r~"..resellTotal.."$ ~s~grace aux objects que tu as volé! Je te recontacterai")
        end
    end

end)

RegisterServerEvent("ESXrob:getHousesStates")
AddEventHandler("ESXrob:getHousesStates", function()
    local _src = source
    TriggerClientEvent("ESXrob:getHousesStates", _src, housesStates)
end)

RegisterServerEvent("ESXrob:getHousesStatess")
AddEventHandler("ESXrob:getHousesStatess", function()
    local _src = source
    TriggerClientEvent("ESXrob:getHousesStatess", _src, housesStates)
end)


ESX.RegisterServerCallback('ESXrob:canRob', function(source, cb, houseIndex)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	local cops = 0

    if housesStates[houseIndex] and housesStates[houseIndex].state then
	    for i = 1, #xPlayers, 1 do
		    local Player = ESX.GetPlayerFromId(xPlayers[i])
		    if Player and Player.job.name == 'police' then
			    cops = cops + 1
		    end
	    end

        if cops > 0 then
            if #(GetEntityCoords(GetPlayerPed(_source)) - robberiesConfiguration.houses[houseIndex].outdoorVector) <= 10 then
                housesStates[houseIndex].state = false
                housesStates[houseIndex].robbedByID = _source
                SetTimeout(21600000, function()
                    housesStates[houseIndex].state = true
                    housesStates[houseIndex].robbedByID = 0
                end)
                cb(true)
                return
            end
        else
            xPlayer.showNotification("Il n'y a pas assez de policiers en ville !")
        end
    else
        xPlayer.showNotification("Cette maison a été récemment cambriolée, repassez plus tard.")
    end

    cb(false)
end)



