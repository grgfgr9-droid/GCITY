OwnedVehicles = {}

ESX.RegisterServerCallback('garage:getVehicles', function(source, cb)
	local ownedCars = {}
    
	local xPlayer = ESX.GetPlayerFromId(source)
	for _,v in pairs(OwnedVehicles) do
		if v.owner == xPlayer.getUUID() then
		local vehicle = v.vehicle
		local model = (type(vehicle.model) == 'number' and vehicle.model or GetHashKey(vehicle.model))
		table.insert(ownedCars, {vehicle = vehicle, model = model, state = v.state, plate = v.plate, type = v.type})
		end
	end
	cb(ownedCars)
end)

ESX.RegisterServerCallback('garage:checkMoney', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('garage:SpawnVehicle', function(source, cb, plate, coords)
	local vehicle = GetGarageVehicle(plate)
	local vehicleProps = vehicle.vehicle
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and vehicle then
		if vehicle.owner == xPlayer.getUUID() then
	        local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")
	        local veh = Citizen.InvokeNative(CreateAutomobile, vehiclemodel, vector3(coords.x, coords.y, coords.z), 0.0, true, true)
	        cb(veh ~= nil, NetworkGetNetworkIdFromEntity(veh), vehicleProps)
	        vehicle.state = false
		else
			SendAntiCheatLog(source, "Attempt to bypass garage securities")
	    end
	end
end)

ESX.RegisterServerCallback('garage:stockvehicle', function(source, cb, vehicleProps)
	local vehplate = vehicleProps.plate
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	local failed = true

	for k, v in pairs(OwnedVehicles) do
		if v.plate == vehplate and v.owner == xPlayer.getUUID() then
			OwnedVehicles[k].state = true
			cb(true)
			failed = false
			break
		end
	end

	if failed then
		cb(false)
	end
end)

function GetGarageVehicle(plate)
	if plate then
		for k, v in pairs(OwnedVehicles) do
			if string.lower(v.plate):match( "^%s*(.-)%s*$" ) == string.lower(plate):match( "^%s*(.-)%s*$" ) then
				return v
			end
	    end
	end
	return nil
end

function GetPlayerVehicles(uuid)
	local VehiclesList = {}
	if uuid then
		for k, v in pairs(OwnedVehicles) do
			if v.owner == uuid then
				table.insert(VehiclesList, v)
			end
	    end
	end
	return VehiclesList
end

function RemoveGarageVehicle(plate)
	if plate then
		for k, v in pairs(OwnedVehicles) do
			if string.lower(v.plate):match( "^%s*(.-)%s*$" ) == string.lower(plate):match( "^%s*(.-)%s*$" ) then
				table.remove(OwnedVehicles, k)
				break
			end
	    end
	end
end

function InsertGarageVehicle(data)
	if data then
		table.insert(OwnedVehicles, data)
	end
end

function UpdateGarageVehicle(plate, data)
	if plate and data then
		for k, v in pairs(OwnedVehicles) do
			if string.lower(v.plate):match( "^%s*(.-)%s*$" ) == string.lower(plate):match( "^%s*(.-)%s*$" ) then
				OwnedVehicles[k] = data
				break
			end
	    end
	end
end

function UpdateGarageVehicleOwner(plate, originalowner, owner)
	if plate and owner then
		for k, v in pairs(OwnedVehicles) do
			if string.lower(v.plate):match( "^%s*(.-)%s*$" ) == string.lower(plate):match( "^%s*(.-)%s*$" ) and v.owner == originalowner then
				OwnedVehicles[k].owner = owner
				break
			end
	    end
	end
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {}, function(result)
		for k, v in pairs(result) do 
			InsertGarageVehicle({ owner = v.owner, plate = v.plate, vehicle = json.decode(v.vehicle), type = v.type, state = true})
        end
	end)
end)

