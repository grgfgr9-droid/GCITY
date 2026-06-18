Citizen.CreateThread(function()
    for k, v in pairs(Mechanics) do 
        TriggerEvent('society:registerSociety', k, v.label, 'society_' .. k, 'society_' .. k, 'society_' .. k, {type = 'private'})
    end
end)