RegisterServerEvent('handcuff:unrestrain')
AddEventHandler('handcuff:unrestrain', function(player)
    if player ~= -1 then   
        if not CheckPlayersCoordsBetweenEachOther(source, player, 10) then DropPlayer(source, "Pas Bien de Trigger mec") return end
        TriggerClientEvent('ehandcuff:unrestrain', player)
    end
end)
RegisterServerEvent('handcuff:on')
AddEventHandler('handcuff:on', function(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    if player ~= -1 then
        if not CheckPlayersCoordsBetweenEachOther(source, player, 10) then DropPlayer(source, "Pas Bien de Trigger mec") return end
        TriggerClientEvent('ehandcuff:on', player)
    end
end)
RegisterServerEvent('handcuff:off')
AddEventHandler('handcuff:off', function(player)
    if player ~= -1 then 
        if not CheckPlayersCoordsBetweenEachOther(source, player, 10) then DropPlayer(source, "Pas Bien de Trigger mec") return end
        TriggerClientEvent('ehandcuff:unrestrain', player)
    end
end)
RegisterServerEvent('handcuff:drag')
AddEventHandler('handcuff:drag', function(player)
    if player ~= -1 then 
        if not CheckPlayersCoordsBetweenEachOther(source, player, 10) then DropPlayer(source, "Pas Bien de Trigger mec") return end
        TriggerClientEvent('ehandcuff:drag', player, source)
    end
end)
RegisterServerEvent('handcuff:ZiZouVehicle')
AddEventHandler('handcuff:ZiZouVehicle', function(player)
    if player ~= -1 then 
        if not CheckPlayersCoordsBetweenEachOther(source, player, 10) then DropPlayer(source, "Pas Bien de Trigger mec") return end
        TriggerClientEvent('ehandcuff:ZiZouVehicle', player)
    end
end)
RegisterServerEvent('handcuff:OutVehicle')
AddEventHandler('handcuff:OutVehicle', function(player)
    if player ~= -1 then 
        if not CheckPlayersCoordsBetweenEachOther(source, player, 10) then DropPlayer(source, "Pas Bien de Trigger mec") return end
        TriggerClientEvent('ehandcuff:OutVehicle', player)
    end
end)

RegisterServerEvent('handcuff:confiscatePlayerItem')
AddEventHandler('handcuff:confiscatePlayerItem', function(player, type, name, amount)
    if player ~= -1 then 
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(player)
        
        if CheckIsPolice(xPlayer.job.name) then
            if type == "item_account" then
                local account = xTarget.getAccount(name)

                if amount > 0 and account.money >= amount then
                    xTarget.removeAccountMoney(name, amount)
                    xTarget.showNotification(xPlayer.identity.firstname .. " " .. xPlayer.identity.lastname .. " vous a confisqué ~r~" .. amount .. "$~s~")
                    xPlayer.addAccountMoney(name, amount)
                    xPlayer.showNotification("Vous avez confisqué ~r~" .. amount .. "$~s~ à " .. xTarget.identity.firstname .. " " .. xTarget.identity.lastname)

                    -- Log Discord pour confisquer de l'argent
                    local playerName = xPlayer.getName()
                    local playerUUID = xPlayer.getUUID()
                    local targetName = xTarget.getName()
                    local targetUUID = xTarget.getUUID()
                    local message = string.format("%s - %s a confisqué %d$ à %s - %s pour le type 'item_account'", playerName, playerUUID, amount, targetName, targetUUID)
                    discordLog("fouille", message)
                end
            elseif type == "item_weapon" then
                if xTarget.hasWeapon(name) then
                    xTarget.removeWeapon(name)
                    xTarget.showNotification(xPlayer.identity.firstname .. " " .. xPlayer.identity.lastname .. " vous a confisqué " .. ESX.GetWeaponLabel(name))
                    xPlayer.addWeapon(name, 0)
                    xPlayer.showNotification("Vous avez confisqué " .. ESX.GetWeaponLabel(name) .. " à " .. xTarget.identity.firstname .. " " .. xTarget.identity.lastname)

                    -- Log Discord pour confisquer une arme
                    local playerName = xPlayer.getName()
                    local playerUUID = xPlayer.getUUID()
                    local targetName = xTarget.getName()
                    local targetUUID = xTarget.getUUID()
                    local message = string.format("%s - %s a confisqué %s à %s - %s pour le type 'item_weapon'", playerName, playerUUID, ESX.GetWeaponLabel(name), targetName, targetUUID)
                    discordLog("fouille", message)
                end
            elseif type == "item_standard" then
                local item = xTarget.getInventoryItem(name)

                if item.count > 0 and item.count >= amount then
                    xTarget.removeInventoryItem(name, amount)
                    xTarget.showNotification(xPlayer.identity.firstname .. " " .. xPlayer.identity.lastname .. " vous a confisqué " .. amount .. "x" .. item.label)
                    xPlayer.addInventoryItem(name, amount)
                    xPlayer.showNotification("Vous avez confisqué " .. amount .. "x" .. item.label .. " à " .. xTarget.identity.firstname .. " " .. xTarget.identity.lastname)

                    -- Log Discord pour confisquer un item standard
                    local playerName = xPlayer.getName()
                    local playerUUID = xPlayer.getUUID()
                    local targetName = xTarget.getName()
                    local targetUUID = xTarget.getUUID()
                    local message = string.format("%s - %s a confisqué %dx %s à %s - %s pour le type 'item_standard'", playerName, playerUUID, amount, item.label, targetName, targetUUID)
                    discordLog("fouille", message)
                end
            end
        end
    end
end)
