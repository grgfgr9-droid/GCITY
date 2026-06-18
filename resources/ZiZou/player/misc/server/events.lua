--[[local events = {}

RegisterServerEvent("events:JoinEvent")
AddEventHandler("events:JoinEvent", function(event)
    local xPlayer = ESX.GetPlayerFromId(source)
    local SelectedEvent = events[event]
    if xPlayer and SelectedEvent then
        if SelectedEvent.date < os.time() then
            if not SelectedEvent.whitelisted then

            elseif SelectedEvent.whitelist[xPlayer.getUUID()] then

            else
                xPlayer.showNotification("Vous n'êtes pas authorisé à participer à cet event !")
            end
        else
            xPlayer.showNotification("L'event est programmé pour plus tard !")
        end
    end
end)

function JoinEvent(player, event)
    local xPlayer = player
    local SelectedEvent = event

    if xPlayer and SelectedEvent then

    end
end]]