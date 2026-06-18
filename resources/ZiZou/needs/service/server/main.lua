local InService    = {
	
}
local MaxInService = {}

function GetInServiceCount(name)
	return #InService[name]
end

RegisterServerEvent("player:serviceOn")
AddEventHandler("player:serviceOn", function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local job = xPlayer.job.name
if InService[job] == nil then
	InService[job] = {}
end
enableService(_source, job)
end)

RegisterServerEvent("player:serviceOff")
AddEventHandler("player:serviceOff", function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local job = xPlayer.job.name
    removeService(source, job)
end)


RegisterServerEvent('service:activateService')
AddEventHandler('service:activateService', function(name, max)
	InService[name] = {}
	MaxInService[name] = max
	TriggerClientEvent('esx:UpdateService', source, true)
end)

RegisterServerEvent('service:disableService')
AddEventHandler('service:disableService', function(name)
	InService[name][source] = nil
	TriggerClientEvent('esx:UpdateService', source, false)
end)

RegisterServerEvent('service:notifyAllInService')
AddEventHandler('service:notifyAllInService', function(notification, name)
	for k,v in pairs(InService[name]) do
		if v == true then
			TriggerClientEvent('service:notifyAllInService', k, notification, source)
		end
	end
end)

ESX.RegisterServerCallback('service:enableService', function(source, cb, name)
	enableService(source, name, cb)
end)

ESX.RegisterServerCallback('service:isInService', function(source, cb, name)
	local isInService = false

	if InService[name] ~= nil then
		if InService[name][source] then
			isInService = true
		end
	else
		print(('[service] [^3WARNING^7] A service "%s" is not activated'):format(name))
	end

	cb(isInService)
end)

ESX.RegisterServerCallback('service:isPlayerInService', function(source, cb, name, target)
	local isPlayerInService = false
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if InService[name][targetXPlayer.source] then
		isPlayerInService = true
	end

	cb(isPlayerInService)
end)

ESX.RegisterServerCallback('service:getInServiceList', function(source, cb, name)
	cb(InService[name])
end)

function removeService(player, job)
	if InService[job] == nil then
		InService[job] = {}
	end
    local xPlayer = ESX.GetPlayerFromId(player)
	if xPlayer then
		if InService[job] and InService[job][xPlayer.source] then
			InService[job][xPlayer.source] = nil
			TriggerClientEvent('esx:UpdateService', xPlayer.source, false)
            TriggerClientEvent('player:NotService', xPlayer.source)
			if #InService[job] == 0 and CheckIsVehicleDealer(job) then
				TriggerClientEvent("vehicleshop:ToggleAutoShop", -1, job, false)
			end
		end
    end
end

function enableService(source, name, cb)
	local inServiceCount = GetInServiceCount(name)
	InService[name][source] = true
	TriggerClientEvent("vehicleshop:ToggleAutoShop", -1, name, true)
	TriggerClientEvent('esx:UpdateService', source, true)
    TriggerClientEvent('player:InService', source)
	if cb then
		cb(true, MaxInService[name], inServiceCount)
	end
end

function IsSomeoneInService(society)
	return InService[society] and #InService[society] ~= 0
end