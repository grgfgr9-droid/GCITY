-- Global

ESX.RegisterServerCallback('coffre:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb({items = xPlayer.inventory})
end)

-- Items

RegisterServerEvent('coffre:getStockItem')
AddEventHandler('coffre:getStockItem', function(itemName, count, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = ''
    if type == 1 then
        job = xPlayer.job.name
    elseif type == 2 then
        job = xPlayer.job2.name
    end
    local inventory = GetSharedInventory('society_' .. job)
    if inventory then
        local inventoryItem = inventory.getItem(itemName)

        if inventoryItem.count >= count and inventoryItem.count > 0 then
            if xPlayer.canCarryItem(itemName, count) then
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                xPlayer.showNotification('Vous avez récupéré ' .. count .. 'x ' .. itemName)
                
                -- Envoi d'un log Discord
                discordLog("coffre", xPlayer.getName() .. " - " .. xPlayer.getUUID() .. " a retiré " .. count .. "x " .. itemName .. " du coffre de " .. job)
            else
                xPlayer.showNotification('Vous n\'avez pas assez de place dans votre inventaire !')
            end
        else
            xPlayer.showNotification('Quantité Invalide')
        end
    end
end)


ESX.RegisterServerCallback('coffre:getStockItems', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)
    local job = ''
    if type == 1 then
        job = xPlayer.job.name
    elseif type == 2 then
        job = xPlayer.job2.name
    end
	local inventory = GetSharedInventory('society_' .. job)
	if inventory then
		cb(inventory.items)
	end
end)

RegisterServerEvent('coffre:putStockItems')
AddEventHandler('coffre:putStockItems', function(itemName, count, type)
	local xPlayer = ESX.GetPlayerFromId(source)
    local job = ''
    if type == 1 then
        job = xPlayer.job.name
    elseif type == 2 then 
        job = xPlayer.job2.name
    end
	local inventory = GetSharedInventory('society_' .. job)
	if inventory then
		local sourceItem = xPlayer.getInventoryItem(itemName)

		if sourceItem.count >= count and count > 0 then
			if inventory then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification('Vous avez déposé ' .. count .. 'x ' .. itemName)

			discordLog("coffre", xPlayer.getName() .. " - " .. xPlayer.getUUID() .. " a déposé " .. count .. "x " .. itemName .. " du coffre de " .. job)
			end
		else
			xPlayer.showNotification('Quantité Invalide')
		end
	end
end)

-- Weapons

ESX.RegisterServerCallback('coffre:getArmoryWeapons', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)
    local job = ''
    if type == 1 then
        job = xPlayer.job.name
    elseif type == 2 then
        job = xPlayer.job2.name
    end
	local store = GetSharedDataStore('society_' .. job)
	if store then
		local weapons = store.get('weapons') or {}
		cb(weapons)
	end
end)

ESX.RegisterServerCallback('coffre:addArmoryWeapon', function(source, cb, weaponName, weaponAmmo, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = ''
    if type == 1 then
        job = xPlayer.job.name
    elseif type == 2 then
        job = xPlayer.job2.name
    end

    if xPlayer.hasWeapon(weaponName) then
        local store = GetSharedDataStore('society_' .. job)
        if store then
            local weapons = store.get('weapons') or {}
            weaponName = string.upper(weaponName)

            table.insert(weapons, {
                name = weaponName,
                ammo = weaponAmmo
            })

            xPlayer.removeWeapon(weaponName)
            store.set('weapons', weapons)

            -- Log Discord ici
            local playerName = xPlayer.getName()
            local playerUUID = xPlayer.getUUID()
            local message = string.format("%s - %s a ajouté %s avec %d munitions à l'armurerie de %s", playerName, playerUUID, weaponName, weaponAmmo, job)
            discordLog("coffre", message)

            cb()
        end
    else
        xPlayer.showNotification('Vous ne possédez pas cette arme !')
        cb()
    end
end)

ESX.RegisterServerCallback('coffre:removeArmoryWeapon', function(source, cb, weaponName, weaponAmmo, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = ''
    if type == 1 then
        job = xPlayer.job.name
    elseif type == 2 then
        job = xPlayer.job2.name
    end

    if not xPlayer.hasWeapon(weaponName) then
        local store = GetSharedDataStore('society_' .. job)
        if store then
            local weapons = store.get('weapons') or {}
            weaponName = string.upper(weaponName)

            for i = 1, #weapons, 1 do
                if weapons[i].name == weaponName and weapons[i].ammo == weaponAmmo then
                    table.remove(weapons, i)

                    store.set('weapons', weapons)
                    xPlayer.addWeapon(weaponName, weaponAmmo)

                    -- Log Discord ici
                    local playerName = xPlayer.getName()
                    local playerUUID = xPlayer.getUUID()
                    local message = string.format("%s - %s a retiré %s avec %d munitions de l'armurerie de %s", playerName, playerUUID, weaponName, weaponAmmo, job)
                    discordLog("coffre", message)

                    break
                end
            end

            cb()
        end
    else
        xPlayer.showNotification('Vous possédez déjà cette arme !')
        cb()
    end
end)