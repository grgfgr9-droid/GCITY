RegisterServerEvent('license:show')
AddEventHandler('license:show', function(id, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local data = {}
	if type == 'idcard' then
		data = {
			firstname = xPlayer.getFirstName(),
			lastname = xPlayer.getLastName(),
			dob = xPlayer.getDOB()
		}
        TriggerClientEvent('license:show', id, type, data)
	elseif type == 'weapon' then
		local license = xPlayer.getLicense('weapon')
		if license then
            data = {
				has = true
			}
		else
			data = {
                has = false
            }
		end
            TriggerClientEvent('license:show', id, type, data)
    elseif type == 'car' then
        data = {has = true}
        TriggerClientEvent('license:show', id, type, data)
	end
    
end)

ESX.RegisterServerCallback('personal:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			})
		end

		cb(bills)
	end)
end)

ESX.RegisterServerCallback('personal:getKeys', function(source, cb)
	local ownedCars = {}
    
	local xPlayer = ESX.GetPlayerFromId(source)

	local playerVehicles = GetPlayerVehicles(xPlayer.getUUID())

    for k, v in pairs(playerVehicles) do 
		local vehicle = v.vehicle
		local model = (type(vehicle.model) == 'number' and vehicle.model or GetHashKey(vehicle.model))
		table.insert(ownedCars, {name = vehicle.model, plate = v.plate})
    end
	
	cb(ownedCars)
end)

RegisterServerEvent('personal:updateKey')
AddEventHandler('personal:updateKey', function(target, itemName)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	plate = itemName

	local uuid = sourceXPlayer.getUUID()
	local uuid_target = targetXPlayer.getUUID()

		MySQL.Async.execute("UPDATE owned_vehicles SET owner = @newplayer WHERE owner = @owner AND plate = @plate",
		{
			['@owner']		= uuid,
			['@newplayer']		= uuid_target,
			['@plate']		= plate
		})
		TriggerClientEvent('vehiclelock:UpdateOwners', target, plate)
		TriggerClientEvent("personal:AskForKeys", target)
		TriggerClientEvent("personal:AskForKeys", _source)
		UpdateGarageVehicleOwner(plate, sourceXPlayer.getUUID(), targetXPlayer.getUUID())
		TriggerClientEvent('esx:showNotification', source, 'Vous avez donné la clé à ' .. targetXPlayer.getFirstName() .. ' ' .. targetXPlayer.getLastName())
		TriggerClientEvent('esx:showNotification', target, 'Vous avez reçu la clé de ' .. plate)
end)