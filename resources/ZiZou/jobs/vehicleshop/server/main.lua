Citizen.CreateThread(function()
    for k, v in pairs(VehicleShops) do 
        TriggerEvent('society:registerSociety', k, v.label, 'society_' .. k, 'society_' .. k, 'society_' .. k, {type = 'private'})
    end
end)

ESX.RegisterServerCallback('vehicleshops:SendBuyRequest', function (source, cb, target, vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local societyAccount = nil
    local vehiclemodel = vehicle
    local valid = false
    local VehiclePrice = 0
    for k, v in pairs(Vehicles) do
        if string.lower(v.model) == string.lower(vehicle) then
            VehiclePrice = v.price
            break
        end
    end
    if xPlayer and xTarget then
        if CheckIsVehicleDealer(xPlayer.job.name) then
            societyAccount = GetSharedAccount('society_' .. xPlayer.job.name)
            if societyAccount then
                if VehiclePrice < societyAccount.money then
                    SendBillToPlayer(xPlayer.source, xTarget.source, 'society_' .. xPlayer.job.name, "VehicleShop : " .. vehiclemodel, VehiclePrice, function()
                        local societyAccount = GetSharedAccount('society_' .. xPlayer.job.name)
                        if societyAccount then
                            societyAccount.removeMoney(VehiclePrice)
                            societyAccount.addMoney(VehiclePrice / 2)
                            local plate = GeneratePlate()
                            VehicleShopAssignVehicle(xTarget.source, xTarget.getUUID(), vehiclemodel, plate, VehicleShops[xPlayer.job.name].type)
                            local dateNow = os.date('%Y-%m-%d %H:%M')
                        
                            MySQL.Async.execute('INSERT INTO vehicle_sold (client, model, plate, soldby, date, society) VALUES (@client, @model, @plate, @soldby, @date, @society)', {
                                ['@client'] = xTarget.getName(),
                                ['@model'] = vehiclemodel,
                                ['@plate'] = plate,
                                ['@soldby'] = xPlayer.getName(),
                                ['@date'] = dateNow,
                                ['@society'] = xPlayer.job.name
                            })
                            ESX.SavePlayer(xPlayer)
                        end
                    end)
                    valid = true                    
                end
            end
        end
    end
    if valid then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('vehicleshops:buyVehicle', function (source, cb, society, vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehiclemodel = vehicle
    local _society = society
    local valid = false
    local VehiclePrice = 0
    for k, v in pairs(Vehicles) do
        if string.lower(v.model) == string.lower(vehicle) then
            VehiclePrice = v.price
            break
        end
    end
    if xPlayer then
        if VehiclePrice < xPlayer.getMoney() then
            local societyAccount = GetSharedAccount('society_' .. _society)
            if societyAccount then
                xPlayer.removeMoney(VehiclePrice)
                societyAccount.addMoney(VehiclePrice / 2)
                ESX.SavePlayer(xPlayer)
                local plate = GeneratePlate()
                VehicleShopAssignVehicle(xPlayer.source, xPlayer.getUUID(), vehiclemodel, plate, VehicleShops[_society].type)
                local dateNow = os.date('%Y-%m-%d %H:%M')
                        
                MySQL.Async.execute('INSERT INTO vehicle_sold (client, model, plate, soldby, date, society) VALUES (@client, @model, @plate, @soldby, @date, @society)', {
                    ['@client'] = xPlayer.getName(),
                    ['@model'] = vehiclemodel,
                    ['@plate'] = plate,
                    ['@soldby'] = "Automatic",
                    ['@date'] = dateNow,
                    ['@society'] = _society
                })
        end
            valid = true
        end
    end
    if valid then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('vehicleshops:getSoldVehicles', function (source, cb)

	MySQL.Async.fetchAll('SELECT * FROM vehicle_sold', {}, function(result)
		cb(result)
	end)
end)

function VehicleShopAssignVehicle(source, uuid, model, plate, vehtype)
    local vehiclehash = GetHashKey(model)
    if vehiclehash and uuid then
    local vehicleprops = {model = vehiclehash, plate = plate}
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)',
	{
		['@owner']   = uuid,
		['@plate']   = plate,
		['@vehicle'] = json.encode(vehicleprops),
        ['@type']    = vehtype
	}, function (rowsChanged)
        if not GetGarageVehicle(plate) then
            InsertGarageVehicle({ owner = uuid, plate = plate, vehicle = vehicleprops, type = vehtype, state = true})
        end
        if source and source ~= 0 and ESX.GetPlayerFromId(source) then
		    TriggerClientEvent('esx:showNotification', source, 'Vous avez reçu : ~b~' .. string.upper(model) .. '~w~ de plaque ~b~' .. plate .. '~s~ !')
        end
    end)
    end
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
			generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))

			if not isPlateTaken(generatedPlate) then
				doBreak = true
			end

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function isPlateTaken(plate) 
		return GetGarageVehicle(plate) ~= nil
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end