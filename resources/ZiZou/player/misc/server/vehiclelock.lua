ESX.RegisterServerCallback('vehiclelock:GetOwnedVehicles', function (source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    local OwnedCars = {}
	local playerVehicles = GetPlayerVehicles(xPlayer.getUUID())

    for k, v in pairs(playerVehicles) do 
        OwnedCars[string.lower(v.plate):match( "^%s*(.-)%s*$" )] = true
    end
    cb(OwnedCars)
end)

RegisterServerEvent('vehiclelock:preterkey')
AddEventHandler('vehiclelock:preterkey', function(plate)
    TriggerClientEvent('vehiclelock:UpdateOwners', source, plate)
end)