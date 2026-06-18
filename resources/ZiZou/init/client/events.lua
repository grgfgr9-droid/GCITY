local ProtectedEvents = {}

local _TriggerServerEvent = TriggerServerEvent

RegisterNetEvent("esx:receiveProtectedEvents")
AddEventHandler("esx:receiveProtectedEvents", function(events)
    ProtectedEvents = events
end)

TriggerServerEvent = function(event, ...)
    if ProtectedEvents[event] then
        _TriggerServerEvent(ProtectedEvents[event].name, tonumber(ProtectedEvents[event].token), ...)
    else
        _TriggerServerEvent(event, ...)
    end
end

