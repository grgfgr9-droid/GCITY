local seatsTaken = {}

RegisterNetEvent('sit:takePlace')
AddEventHandler('sit:takePlace', function(objectCoords)
	seatsTaken[objectCoords] = true
end)

RegisterNetEvent('sit:leavePlace')
AddEventHandler('sit:leavePlace', function(objectCoords)
	if seatsTaken[objectCoords] then
		seatsTaken[objectCoords] = nil
	end
end)

ESX.RegisterServerCallback('sit:getPlace', function(source, cb, objectCoords)
	cb(seatsTaken[objectCoords])
end)
