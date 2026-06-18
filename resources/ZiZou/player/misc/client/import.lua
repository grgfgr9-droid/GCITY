ESX = nil

Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj 
	end)
end)

RegisterNetEvent('esx:updateDeath')
AddEventHandler('esx:updateDeath', function(isdead)
	ESX.PlayerData.IsDead = isdead
end)

RegisterNetEvent('esx:updateLicenses')
AddEventHandler('esx:updateLicenses', function(licenses)
	ESX.PlayerData.licenses = licenses
end)

RegisterNetEvent('esx:updateIdentity')
AddEventHandler('esx:updateIdentity', function(identity)
	ESX.PlayerData.identity = identity
end)

RegisterNetEvent('esx:updateSkin')
AddEventHandler("esx:updateSkin", function(newskin)
	if newskin then
	ESX.PlayerData.skin = newskin
	end
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight)
	 ESX.PlayerData.maxWeight = newMaxWeight 
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count, showNotification)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job2 = job
end)

RegisterNetEvent('esx:setRank')
AddEventHandler('esx:setRank', function(rank, expiration)
	ESX.PlayerData.rank = rank
	ESX.PlayerData.expiration = expiration
end)

RegisterNetEvent('esx:setStorePoints')
AddEventHandler('esx:setStorePoints', function(storepoints)
	ESX.PlayerData.storepoints = storepoints
end)

-- Loadout

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo, loadout)
	ESX.PlayerData.loadout = loadout
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName, loadout)
	ESX.PlayerData.loadout = loadout
end)

-- Perma Loadout

RegisterNetEvent('esx:addPermWeapon')
AddEventHandler('esx:addPermWeapon', function(weaponName, ammo, permloadout)
	ESX.PlayerData.permloadout = permloadout
end)

RegisterNetEvent('esx:removePermWeapon')
AddEventHandler('esx:removePermWeapon', function(weaponName, permloadout)
	ESX.PlayerData.permloadout = permloadout
end)