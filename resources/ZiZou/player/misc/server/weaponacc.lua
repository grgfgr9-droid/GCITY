local weaponacclist = {
    'clip',
    'silencieux',
    'grip',
    'yusuf',
    'flashlight'
}

Citizen.CreateThread(function()
    for k, v in pairs(weaponacclist) do
        ESX.RegisterUsableItem(v, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            if v == 'clip' then
            xPlayer.removeInventoryItem(v, 1)
            end
            TriggerClientEvent('accessories:use', source, v)
        end)
    end
end)