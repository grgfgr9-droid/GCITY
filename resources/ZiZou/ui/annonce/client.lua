RegisterNetEvent("ZiZouANNONCESEND")
AddEventHandler("ZiZouANNONCESEND", function(param, message)
    local data = {
        action = "displayAnnonce",  
        message = message
    }
    if type(param) == "number" and param > 0 then
        data.radius = param
    end

    SendNUIMessage(data)
end)

SetNuiFocus(false, false)
