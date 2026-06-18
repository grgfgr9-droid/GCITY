RegisterServerEvent('store:buyItem')
AddEventHandler('store:buyItem', function(Type, Item, weapontype)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local item = Item
    local type = Type
    local uuid = xPlayer.getUUID()

    if type == 'weapon' then
        for k, v in pairs(StoreConfig.Weapons) do
            if item == v.NameWeapon then
                if tonumber(xPlayer.getStorePoints()) >= tonumber(v.Point) then
                    if weapontype == 'normal' then
                        if not xPlayer.hasWeapon(v.NameWeapon) then
                            xPlayer.removeStorePoints(tonumber(v.Point))
                    xPlayer.addWeapon(v.NameWeapon, 250)
                    TriggerClientEvent('esx:showNotification', _source,  'Merci pour votre Achat !')
                        else
                            TriggerClientEvent('esx:showNotification', _source,  'Vous avez déjà cette arme !')
                        end
                    elseif weapontype == 'perm' then
                      if not xPlayer.hasPermWeapon(v.NameWeapon) then
                        xPlayer.removeStorePoints(tonumber(v.Point))
                       xPlayer.addPermWeapon(v.NameWeapon, 250)
                       TriggerClientEvent('esx:showNotification', _source,  'Merci pour votre Achat !')
                      else
                        TriggerClientEvent('esx:showNotification', _source,  'Vous avez déjà cette arme !')

                      end
                    end
                    TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a acheté l\'arme [' .. weapontype .. '] ' .. v.NameWeapon)
                else
                    TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de fonds pour acheter ceci !')
                end
            break
        end
    end

    elseif type == 'vehicle' then
        for k, v in pairs(StoreConfig.Vehicles) do
            if item == v.data.NameVehicle then
                if tonumber(xPlayer.getStorePoints()) >= tonumber(v.data.Point) then
                    xPlayer.removeStorePoints(tonumber(v.data.Point))
                    TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a acheté le véhicule ' .. item)
                    AssignVehicle(_source, uuid, v.data.NameVehicle, GeneratePlate())
                    TriggerClientEvent('esx:showNotification', _source,  'Merci pour votre Achat !')
                else
                    TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de fonds pour acheter ceci !')
                end
            end
        end
    elseif type == 'pack' then


        if tonumber(xPlayer.getStorePoints()) >= tonumber(StoreConfig.Packs[Item].price) then
        xPlayer.removeStorePoints(tonumber(StoreConfig.Packs[Item].price))
        TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a acheté le pack ' .. item)
        for k, v in pairs(StoreConfig.Packs[Item].loots) do

            if v.type == 'weapon' then
                xPlayer.addWeapon(v.item, v.amount)
            elseif v.type == 'vehicle' then
                AssignVehicle(_source, uuid, v.item, GeneratePlate())
            elseif v.type == 'item' then
                xPlayer.addInventoryItem(v.item, v.amount)
            elseif v.type == 'money' then
                if v.item == 'black_money' then
                    xPlayer.addAccountMoney(v.item, v.amount)
                elseif v.item == 'money' then
                    xPlayer.addMoney(v.amount)
                end
            end
        end    
    end 


    elseif type == "rank" then
        local RanksPrices = {["vip"] = 1000, ["diamond"] = 2000}
        local rankPrice = RanksPrices[item]
        if tonumber(xPlayer.getStorePoints()) >= tonumber(rankPrice) then
            xPlayer.removeStorePoints(tonumber(rankPrice))
            ESX.SetRank(xPlayer.identifier, item, 2)
            TriggerClientEvent('esx:showNotification', _source,  'Merci pour votre Achat !')
            TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a acheté le grade ' .. item)
        else
            TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de fonds pour acheter ceci !')
        end
    end
    
end)

function AssignVehicle(source, uuid, model, plate, native)
    local vehiclehash = GetHashKey(model)
    if vehiclehash and uuid then
    local vehicleprops = {model = vehiclehash, plate = plate}
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = uuid,
		['@plate']   = plate,
		['@vehicle'] = json.encode(vehicleprops)
	}, function (rowsChanged)
        if not GetGarageVehicle(plate) then
            InsertGarageVehicle({ owner = uuid, plate = plate, vehicle = vehicleprops, type = "car", state = true})
        end
        if source and source ~= 0 and ESX.GetPlayerFromId(source) then
		TriggerClientEvent('esx:announce', source, '~y~Boutique', 'Véhicule acheté : ~b~' .. string.upper(model) .. '~w~ de plaque ~b~' .. plate .. '~s~ !', 2)
        end
    end)
    end
end

RegisterServerEvent('store:achatCaisse')
AddEventHandler('store:achatCaisse', function(caisseName, caissePoint)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local playerPoints = xPlayer.getStorePoints() 
    if playerPoints >= caissePoint then
        xPlayer.removeStorePoints(caissePoint)  
        xPlayer.addInventoryItem(caisseName, 1)
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheté une ' .. caisseName)
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de ' .. ZiZouConfig.StorePointsName)
    end
end)