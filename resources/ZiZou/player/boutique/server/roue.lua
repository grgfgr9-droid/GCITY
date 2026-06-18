local AleardyTookFree = {}
local Rolling = false
local DropTypes = {[1] = "epic", [2] = "rare", [3] = "common"}

ESX.RegisterServerCallback('store:RequestRoueStart', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    local authorise = false
    if xPlayer then
        if not Rolling then
            if not AleardyTookFree[xPlayer.getUUID()] then
                AleardyTookFree[xPlayer.getUUID()] = 1
                authorise = true
            elseif AleardyTookFree[xPlayer.getUUID()] and AleardyTookFree[xPlayer.getUUID()] > 0 then
                if xPlayer.getRank() == "vip" then
                    if AleardyTookFree[xPlayer.getUUID()] < 2 then
                        AleardyTookFree[xPlayer.getUUID()] = AleardyTookFree[xPlayer.getUUID()] + 1
                        authorise = true
                    end
                elseif xPlayer.getRank() == "diamond" then
                    if AleardyTookFree[xPlayer.getUUID()] < 3 then
                        AleardyTookFree[xPlayer.getUUID()] = AleardyTookFree[xPlayer.getUUID()] + 1
                        authorise = true
                    end
                end
            else
                if xPlayer.hasInventoryItem("roueticket") then
                    xPlayer.removeInventoryItem("roueticket", 1)
                    authorise = true
                else
                    cb("notfound")
                end
            end

            if authorise then
                cb("can")
                StartRoueRoll(source)
            end
        else
            cb("aleardy")
        end
    end
end)

function random(x, y)
    local u = 0;
    u = u + 1
    if x ~= nil and y ~= nil then
        return math.floor(x + (math.random(math.randomseed(os.time() + u)) * 999999 % y))
    else
        return math.floor((math.random(math.randomseed(os.time() + u)) * 100))
    end
end

function StartRoueRoll(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        Rolling = true
        SetTimeout(4000, function()
            local percentage = math.random(1, 3)
            local chance = math.random(1, 100)
            local droptype = nil
            local gift = { category = 1, item = 1 }
            local minimalChance = 4
            if chance <= minimalChance and xPlayer.getRank() ~= "default" then
                droptype = DropTypes[1]
                gift.category = StoreConfig.RoueDrops[DropTypes[1]]
                local rand = math.random(1, #gift.category)
                gift.item = gift.category[rand]
            elseif (chance > minimalChance and chance <= 30) or (chance > 80 and chance <= 100) or (chance <= minimalChance) then
                droptype = DropTypes[2]
                gift.category = StoreConfig.RoueDrops[DropTypes[2]]
                local rand = math.random(1, #gift.category)
                gift.item = gift.category[rand]
            else
                droptype = DropTypes[3]
                gift.category = StoreConfig.RoueDrops[DropTypes[3]]
                local rand = math.random(1, #gift.category)
                gift.item = gift.category[rand]
            end
            category = StoreConfig.RoueDrops[DropTypes[percentage]]
            local itemnumber = math.random(1, #category)
            local item = gift.item
            if item then
                if item.type == "account" then
                    if tonumber(item.amount) then
                        xPlayer.addAccountMoney(item.item, tonumber(item.amount))
                    end
                elseif item.type == "weapon" then
                    xPlayer.addWeapon(item.item, 0)
                elseif item.type == "vehicle" then
                    AssignVehicle(source, xPlayer.getUUID(), item.item, GeneratePlate(), item.native)
                elseif item.type == "storepoints" then
                    xPlayer.addStorePoints(tonumber(item.amount))
                end
                TriggerClientEvent("esx:showNotification", source, "Vous avez reçu : " .. item.name .. ", de la catégorie : " .. droptype)
            end
        end)
        SetTimeout(5000, function()
            Rolling = false
        end)
    end
end

Citizen.CreateThread(function()
    for caseName, caseData in pairs(StoreConfig.Case) do
        ESX.RegisterUsableItem(caseName, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)

            if xPlayer then
                xPlayer.removeInventoryItem(caseName, 1)
                TriggerClientEvent('store:useCase', source, caseName)

                local playerName = GetPlayerName(source)
                local playerUUID = xPlayer.getUUID()

                discordLog('caisse', "" .. playerName .. " (ID: " .. source .. ", UUID: " .. playerUUID .. ") a ouvert une " .. caseName .. ".")
            end
        end)
    end
end)


RegisterNetEvent('store:giveReward')
AddEventHandler('store:giveReward', function(caseName, reward)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if not xPlayer then return end
    
    local uuid = xPlayer.getUUID()
    local needReroll = false
    local rerollReason = ""

    if reward then
        if reward.money then
            xPlayer.addMoney(reward.money)
        
        elseif reward.black_money then
            xPlayer.addAccountMoney('black_money', reward.black_money)

        elseif reward.weapon then
            if xPlayer.hasWeapon(reward.weapon) then
                needReroll = true
                rerollReason = "cette arme"
            else
                xPlayer.addWeapon(reward.weapon, reward.amount or 250)
            end
      
        elseif reward.permweapon then
       
            if xPlayer.hasPermWeapon and xPlayer.hasPermWeapon(reward.permweapon) then
                needReroll = true
                rerollReason = "cette arme permanente"
            else
                if xPlayer.addPermWeapon then
                    xPlayer.addPermWeapon(reward.permweapon, reward.amount or 250)
                else
                    xPlayer.addWeapon(reward.permweapon, reward.amount or 250)
                end
            end
          
        elseif reward.vehicle then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local vehicleName = reward.vehicle
            
            TriggerClientEvent('store:getVehicleHash', _source, vehicleName, caseName, uuid)
            return

           
        elseif reward.bluecoins then
            if xPlayer.addStorePoints then
                xPlayer.addStorePoints(reward.bluecoins)
            else
                MySQL.Async.execute('UPDATE users SET store_points = store_points + @points WHERE identifier = @identifier', {
                    ['@points'] = reward.bluecoins,
                    ['@identifier'] = xPlayer.identifier
                })
            end
          
        elseif reward.vip then
    
            local currentRank = xPlayer.getRank()
            
            if currentRank == reward.vip then
                
                needReroll = true
                rerollReason = "ce VIP"
                TriggerClientEvent('store:rerollReward', _source, caseName, rerollReason)
            else
                
                local shouldReroll = false
       
                if (reward.vip == 'vip' and currentRank == 'diamond') then
               
                    shouldReroll = true
                end
                
                if shouldReroll then
                    needReroll = true
                    rerollReason = "un VIP supérieur"
                    TriggerClientEvent('store:rerollReward', _source, caseName, rerollReason)
                else
                    if ESX.SetRank then
                        ESX.SetRank(xPlayer.identifier, reward.vip, reward.expiration or 1)
                    else
                        local expiration = os.time() + (reward.expiration == 1 and 604800 or 2592000) 
                        MySQL.Async.execute('INSERT INTO user_ranks (identifier, rank, expire_at) VALUES (@identifier, @rank, @expire_at) ON DUPLICATE KEY UPDATE rank = @rank, expire_at = @expire_at', {
                            ['@identifier'] = xPlayer.identifier,
                            ['@rank'] = reward.vip,
                            ['@expire_at'] = expiration
                        })
                    end
                    TriggerClientEvent('esx:showNotification', _source, "~g~Tu as gagné " .. reward.label .. " !")
                end
            end
            return 
        end

        if needReroll then
            TriggerClientEvent('store:rerollReward', _source, caseName, rerollReason)
        else
            TriggerClientEvent('esx:showNotification', _source, "~g~Tu as gagné " .. reward.label .. " !")
        end
    end
end)

RegisterNetEvent('store:checkVehicleWithHash')
AddEventHandler('store:checkVehicleWithHash', function(vehicleName, vehicleHash, caseName, uuid)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND vehicle LIKE @model', {
        ['@owner'] = xPlayer.getUUID(),
        ['@model'] = '%"model":' .. vehicleHash .. '%'
    }, function(result)

        
        if result and #result > 0 then
            TriggerClientEvent('store:rerollReward', _source, caseName, "ce véhicule")
        else
            AssignVehicle(_source, uuid, vehicleName, GeneratePlate())
            TriggerClientEvent('esx:showNotification', _source, "~g~Tu as gagné un véhicule !")
        end
    end)
end)