RegisterServerEvent('kfc:giveEat')
AddEventHandler('kfc:giveEat', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer.canCarryItem(item, 1) then 
        TriggerClientEvent('esx:showNotification', source, 'Votre inventaire est plein')
        return
    end

    if item == 'burger' then
        if xPlayer.getMoney() >= 10 then
            xPlayer.removeMoney(10)
            xPlayer.addInventoryItem('burger', 1)
        end
    elseif item == 'sandwich' then
        if xPlayer.getMoney() >= 5 then
            xPlayer.removeMoney(5)
            xPlayer.addInventoryItem('sandwich', 1)
        end
    elseif item ==  'powerade' then
        if xPlayer.getMoney() >= 10 then
            xPlayer.removeMoney(10)
            xPlayer.addInventoryItem('powerade', 1)
        end
    elseif item == 'fanta' then
        if xPlayer.getMoney() >= 5 then
            xPlayer.removeMoney(5)
            xPlayer.addInventoryItem('fanta', 1)
        end
    end
end)