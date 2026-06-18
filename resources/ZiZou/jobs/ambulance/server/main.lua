local appels = {}
local callid = 0
local LegalWeapons = {
    ["weapon_snspistol"] = true,
    ["weapon_vintagepistol"] = true,
    ["weapon_pistol50"] = true,
    ["weapon_bat"] = true,
    ["weapon_smg"] = true
}

TriggerEvent('society:registerSociety', 'ambulance', "Ambulance", 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'private'})

ESX.RegisterUsableItem("medikit", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('ambulance:heal', source, 'small', false)
    xPlayer.removeItem("medikit", 1)
end)

ESX.RegisterUsableItem("bandage", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('ambulance:heal', source, 'big', false)
    xPlayer.removeItem("bandage", 1)
end)

RegisterServerEvent('ambulance:giveItem')
AddEventHandler('ambulance:giveItem', function(item)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'ambulance' then
        if item == 'medikit' or item == 'bandage' then
            if not xPlayer.canCarryItem(item, 1) then 
				TriggerClientEvent('esx:showNotification', _source, 'Votre inventaire est plein')
				return
			end
          xPlayer.addInventoryItem(item, 1)
        end
    end
end)

RegisterServerEvent('ambulance:removeItem')
AddEventHandler('ambulance:removeItem', function(item)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeItem(item, 1)
end)

RegisterServerEvent('ambulance:setDead')
AddEventHandler('ambulance:setDead', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.setDead(true)
    xPlayer.triggerEvent('esx:updateDeath', true)
end)

RegisterServerEvent('ambulance:requestRespawnHopital')
AddEventHandler('ambulance:requestRespawnHopital', function(early)
    local xPlayer = ESX.GetPlayerFromId(source)
    local _early = early

    if xPlayer.IsDead then
        -- Le joueur garde tout ce qu'il avait avant la mort, aucune suppression d'armes ou d'argent
        xPlayer.setDead(false)
        xPlayer.triggerEvent('esx:updateDeath', false)
    end
end)


RegisterServerEvent('ambulance:revive')
AddEventHandler('ambulance:revive', function(target, isStaff)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer and xTarget and (xPlayer.job.name == 'ambulance' or xPlayer.getGroup() ~= 'user') and xTarget.IsDead then 
        local sharedAccount = GetSharedAccount("society_ambulance")
    if sharedAccount and not isStaff then
        if xTarget.getMoney() >= 15000 then
            xTarget.removeMoney(15000)
            sharedAccount.addMoney(15000)
            xTarget.showNotification("Vous avez payé une facture de ~g~" .. 15000 .. "~s~$")
        elseif xTarget.getMoney() > 0 then
            xTarget.removeMoney(xTarget.getMoney())
            sharedAccount.addMoney(xTarget.getMoney())
            xTarget.showNotification("Vous avez payé une facture de ~g~" .. xTarget.getMoney() .. "~s~$")
        end
    end
        if appels[target] and appels[target].tookby ~= 0 then
            local xMedic = ESX.GetPlayerFromId(appels[target].tookby)
            if xMedic then
                xMedic.showNotification("La personne a été réanimée !")
            end
        end
        xTarget.setDead(false)
        TriggerClientEvent('ambulance:revive', target)
        xTarget.triggerEvent('esx:updateDeath', false)
        xTarget.setEat(100)
        xTarget.setDrink(100)
        TriggerClientEvent("esx:SyncMyPlayer", target, xTarget.getStatus(), xTarget.getTime())
    end
end)

RegisterServerEvent('ambulance:healsmall')
AddEventHandler('ambulance:healsmall', function(target)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local quantity = xPlayer.getInventoryItem('bandage').count
    if xPlayer.job.name == 'ambulance' then 
        if quantity > 0 then
            xPlayer.removeInventoryItem('bandage', 1)
            local sharedAccount = GetSharedAccount("society_ambulance")
    if sharedAccount then
        if xTarget.getMoney() >= 5000 then
            xTarget.removeMoney(5000)
            sharedAccount.addMoney(5000)
            xTarget.showNotification("Vous avez payé une facture de ~g~" .. 5000 .. "~s~$")
        elseif xTarget.getMoney() > 0 then
            xTarget.removeMoney(xTarget.getMoney())
            sharedAccount.addMoney(xTarget.getMoney())
            xTarget.showNotification("Vous avez payé une facture de ~g~" .. xTarget.getMoney() .. "~s~$")
        end
    end
            TriggerClientEvent('ambulance:heal', target, 'small', false)
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de bandages sur vous')
        end
    end
    
end)

RegisterServerEvent('ambulance:healbig')
AddEventHandler('ambulance:healbig', function(target)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local quantity = xPlayer.getInventoryItem('medikit').count
    if xPlayer.job.name == 'ambulance' then
        if quantity > 0 then
            xPlayer.removeInventoryItem('medikit', 1)
            local sharedAccount = GetSharedAccount("society_ambulance")
    if sharedAccount then
        if xTarget.getMoney() >= 7500 then
            xTarget.removeMoney(7500)
            sharedAccount.addMoney(7500)
            xTarget.showNotification("Vous avez payé une facture de ~g~" .. 7500 .. "~s~$")
        elseif xTarget.getMoney() > 0 then
            xTarget.removeMoney(xTarget.getMoney())
            sharedAccount.addMoney(xTarget.getMoney())
            xTarget.showNotification("Vous avez payé une facture de ~g~" .. xTarget.getMoney() .. "~s~$")
        end
    end
            TriggerClientEvent('ambulance:heal', target, 'big', false)
        else 
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de bandages sur vous')
        end
    end
end)

RegisterServerEvent('ambulance:sendCall')
AddEventHandler('ambulance:sendCall', function(position)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    callid = callid + 1
    appels[_source] = {source = _source, pos = position, callid = callid, timeat = os.time(), tookby = 0}
end)

RegisterServerEvent('ambulance:TakeCall')
AddEventHandler('ambulance:TakeCall', function(playerid)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if appels[playerid] then
        appels[playerid].tookby = _source
    end
    
end)

ESX.RegisterServerCallback('ambulance:getCalls', function(source, cb)
    local xMedic = ESX.GetPlayerFromId(source)
    local FormatedAppels = {}
    if xMedic and xMedic.job.name == "ambulance" then
    for k, v in pairs(appels) do
        local xPlayer = ESX.GetPlayerFromId(v.source)

        if xPlayer and xPlayer.IsDead and v.tookby == 0 and ESX.GetPlayerFromId(v.tookby) then
            FormatedAppels[v.source] = {source = v.source, pos = v.pos, callid = v.callid, timeago = os.time() - v.timeat}
        else
            appels[v.source] = nil
        end
    end
    end
    cb(FormatedAppels)
end)

ESX.RegisterServerCallback('ambulance:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)
