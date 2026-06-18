ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

function OpenShopForPlayer(source, shopType)
    local filteredItems = {}
    for _, item in pairs(Config.Items) do
        if item.shop == shopType then
            table.insert(filteredItems, item)
        end
    end

    TriggerClientEvent('shop:openMenu', source, filteredItems, shopType)
end

RegisterServerEvent('shop:requestItems')
AddEventHandler('shop:requestItems', function(shopType)
    local _source = source
    OpenShopForPlayer(_source, shopType)
end)

RegisterServerEvent('shop:checkMoney')
AddEventHandler('shop:checkMoney', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local total = tonumber(data.total)
    local items = data.items

    if xPlayer.getMoney() >= total then
        local canBuy = true

        for _, item in pairs(items) do
            if item.type == "weapon" and xPlayer.hasWeapon(item.itemName) then
                TriggerClientEvent('esx:showNotification', src, "Vous possédez déjà cette arme.")
                canBuy = false
                break -- Arrêter la boucle si l'achat est impossible
            end
        end

        if canBuy then
            xPlayer.removeMoney(total) -- Retrait unique du total après validation

            for _, item in pairs(items) do
                print(('[SHOP] Traitement de l\'item: %s | Type: %s | Quantité: %d'):format(item.itemName, item.type, item.quantity))

                if item.type == "item" then
                    xPlayer.addInventoryItem(item.itemName, item.quantity)

                elseif item.type == "weapon" then
                    xPlayer.addWeapon(item.itemName, item.quantity)

                elseif item.type == "props" then
                    MySQL.Async.execute('INSERT INTO players_props (UniqueID, data, name) VALUES (@UniqueID, @data, @name)', {
                        ['@UniqueID'] = xPlayer.identifier,
                        ['@data'] = json.encode({label = item.label, name = item.itemName, owner = xPlayer.identifier, count = item.quantity}),
                        ['@name'] = item.itemName
                    })
                else
                    print('[SHOP] Type inconnu: ', item.type)
                end
            end

            -- Notification et confirmation après tous les achats
            TriggerClientEvent('shop:checkoutResult', src, true)
            TriggerClientEvent('esx:showNotification', src, ('Vous avez acheté des articles pour ~g~%d$'):format(total))

        else
            TriggerClientEvent('shop:checkoutResult', src, false)
        end

    else
        TriggerClientEvent('shop:checkoutResult', src, false)
        TriggerClientEvent('esx:showNotification', src, 'Vous n\'avez pas assez d\'argent.')
    end
end)

