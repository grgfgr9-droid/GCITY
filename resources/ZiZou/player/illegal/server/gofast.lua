local GoFastTimeout = {}
local CurrentGoFasts = {}

ESX.RegisterServerCallback('gofast:RequestGoFast', function(source, cb, gofasttype)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerPed = GetPlayerPed(_source)
    local playerCoords = GetEntityCoords(playerPed)
    local GoData = GoFastData[tostring(gofasttype)]
    local xPlayers = ESX.GetPlayers()
    if xPlayer then
        if GoData and not CurrentGoFasts[xPlayer.getUUID()] and #(playerCoords - GoFastZones["pickup"].coords) < 10 then
            local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")
	        local veh = Citizen.InvokeNative(CreateAutomobile, GetHashKey(GoData.vehicle), vector3(GoFastZones["pickup"].coords.x, GoFastZones["pickup"].coords.y, GoFastZones["pickup"].coords.z), 0.0, true, true)
            if veh then
            CurrentGoFasts[xPlayer.getUUID()] = {startedat = os.time(), type = gofasttype}
            for i = 1, #xPlayers do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        
                if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
                    TriggerClientEvent("gofast:initializePoliceBlip", xPlayers[i], gofasttype)
                end
            end
            SetTimeout(GoData.time * 60 * 1000, function()
                if CurrentGoFasts[xPlayer.getUUID()] then
                    TriggerClientEvent("gofast:cancelled", _source)
                    CurrentGoFasts[xPlayer.getUUID()] = nil
                end
            end)
            else
                cb(false)
            end
            cb(veh ~= nil, NetworkGetNetworkIdFromEntity(veh))
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('gofast:RequestDelivery', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerPed = GetPlayerPed(_source)
    local playerCoords = GetEntityCoords(playerPed)
    if xPlayer and CurrentGoFasts[xPlayer.getUUID()] then
        local GoData = GoFastData[tostring(CurrentGoFasts[xPlayer.getUUID()].type)]
        if GoData and #(playerCoords - GoData.delivery) < 10 then
            CurrentGoFasts[xPlayer.getUUID()] = nil
            xPlayer.addAccountMoney("black_money", GoData.reward)
            xPlayer.showNotification("Félicitations, t'a reçu ~r~" .. GoData.reward .. "$~s~") 
            
            -- Envoi d'un log Discord
            discordLog("gofast_delivery", xPlayer.getName() .. " - " .. xPlayer.getUUID() .. " a livré un GoFast et a reçu : " .. GoData.reward .. "$ en argent sale.")
            
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
    cb(false)
end)

