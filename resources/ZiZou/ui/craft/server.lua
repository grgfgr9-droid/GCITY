RegisterNetEvent('craft:verifierIngrédients')
AddEventHandler('craft:verifierIngrédients', function(itemName, quantiter)
    local xPlayer = ESX.GetPlayerFromId(source)
    quantiter = tonumber(quantiter)

    if not xPlayer or not quantiter or quantiter <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Quantité invalide')
        return
    end

    -- Trouver l'item dans la configuration
    local selectedItem = nil
    for _, item in pairs(ZiZouConfig.Item) do
        if item.name == itemName then
            selectedItem = item
            break
        end
    end

    if not selectedItem then
        TriggerClientEvent('esx:showNotification', source, 'Objet invalide')
        return
    end

    -- Vérifier si le joueur a tous les ingrédients
    local missingIngredients = {}
    for _, ingredient in pairs(selectedItem.ingredients) do
        local item = xPlayer.getInventoryItem(ingredient.name)
        
        -- Vérifier que l'item existe avant d'accéder à .count
        local itemCount = item and item.count or 0 
        
        if itemCount < (ingredient.quantity * quantiter) then
            table.insert(missingIngredients, ingredient.label .. " (x" .. (ingredient.quantity * quantiter - itemCount) .. ")")
        end
    end

    -- Si des ingrédients sont manquants, on renvoie un message d'erreur au client
    if #missingIngredients > 0 then
        local message = "Il vous manque :\n\n" .. table.concat(missingIngredients, "\n")
        TriggerClientEvent('esx:showNotification', source, message)
        return
    end

    -- Si tout est bon, on renvoie un signal pour que le client commence le processus
    TriggerClientEvent('craft:demarrerFabrication', source, itemName, quantiter)
end)


RegisterNetEvent('craft:fabriquer')
AddEventHandler('craft:fabriquer', function(itemName, quantiter)
    local xPlayer = ESX.GetPlayerFromId(source)
    quantiter = tonumber(quantiter)

    if not xPlayer or not quantiter or quantiter <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Quantité invalide')
        return
    end

    -- Trouver l'item dans la configuration
    local selectedItem = nil
    for _, item in pairs(ZiZouConfig.Item) do
        if item.name == itemName then
            selectedItem = item
            break
        end
    end

    if not selectedItem then
        TriggerClientEvent('esx:showNotification', source, 'Objet invalide')
        return
    end

    -- Retirer les ingrédients du joueur
    for _, ingredient in pairs(selectedItem.ingredients) do
        xPlayer.removeInventoryItem(ingredient.name, ingredient.quantity * quantiter)
    end

    -- Donner l'arme directement au joueur
    xPlayer.addWeapon(selectedItem.name, 0) -- Donne l'arme avec 1 munition par défaut

    -- Notification de succès
    TriggerClientEvent('esx:showNotification', source, 'Vous avez fabriqué une ~g~' .. selectedItem.label)
end)




RegisterNetEvent('craft:openMenu')
AddEventHandler('craft:openMenu', function()
    local src = source
    TriggerClientEvent('craft:envoieitems', src, ZiZouConfig.Item)
end)
