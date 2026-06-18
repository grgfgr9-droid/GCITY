--[[CarRadios = {}

RegisterServerEvent('esx:UpdateCarRadio')
AddEventHandler('esx:UpdateCarRadio', function(key, element, value)
    local xPlayer = ESX.GetPlayerFromId(source)
    if element == 'pos' then
        CarRadios[key].pos = value
    elseif element == 'max' then
        CarRadios[key].max = value
    end
    TriggerClientEvent('esx:UpdateCarRadios', -1, CarRadios)
end)

RegisterServerEvent('esx:DeleteCarRadio')
AddEventHandler('esx:DeleteCarRadio', function(key)
    local xPlayer = ESX.GetPlayerFromId(source)
    if CarRadios[key] ~= nil then
        CarRadios[key] = nil
    end  
    TriggerClientEvent('esx:UpdateCarRadios', -1, CarRadios)
end)

RegisterServerEvent('esx:InsertCarRadio')
AddEventHandler('esx:InsertCarRadio', function(position, link)
    local xPlayer = ESX.GetPlayerFromId(source)

    if CarRadios["carradio_" .. xPlayer.identifier] == nil then
        CarRadios["carradio_" .. xPlayer.identifier] = {name = "carradio_" .. xPlayer.identifier, link = link, dst = 50.0, starting = 50.0, pos = position, max = 0.5}
        print("carradio_" .. xPlayer.identifier)
    end

    --table.insert(CarRadios, {name = "carradio_" .. xPlayer.identifier, link = link, dst = 15.0, starting = 50.0, pos = position, max = 0.5})
    --TriggerClientEvent('esx:UpdateRadioPosition', -1, 'carradio_' .. xPlayer.identifier, position)

    TriggerClientEvent('esx:UpdateCarRadios', -1, CarRadios)
end)

ESX.RegisterServerCallback('esx:RequestCarRadios', function(source, cb)
    cb(CarRadios)
end)]]