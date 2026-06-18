
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        TriggerClientEvent("toggleStatusUI", -1, false)
        TriggerClientEvent("toggleStatusUI", -1, true)
    end
end)

RegisterServerEvent('updateStatus')
AddEventHandler('updateStatus', function(status)
    TriggerClientEvent('updateStatus', -1, status)
end)
