RegisterServerEvent('gouv:announce')
AddEventHandler('gouv:announce', function(message)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'gouv' then
        TriggerClientEvent('gouv:announce', -1, message)
    end
end)