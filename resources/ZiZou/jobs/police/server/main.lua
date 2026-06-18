TriggerEvent('society:registerSociety', 'police', 'police', 'society_police', 'society_police', 'society_police', {type = 'public'})

local HelpBlips = {}
local actualhelpid = 0

ESX.RegisterServerCallback('policejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = PoliceWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if CheckIsPolice(xPlayer.job.name) then

	if selectedWeapon then
		xPlayer.addWeapon(weaponName, 100)
		cb(true)
    else
        cb(false)
	end
end
end)

ESX.RegisterServerCallback('policejob:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	local firstname = xPlayer.identity.firstname
	local lastname  = xPlayer.identity.lastname
	local sex       = xPlayer.identity.sex
	local dob       = xPlayer.identity.dob
	local height    = xPlayer.identity.height
	local data = {
		name      = GetPlayerName(target),
		job       = xPlayer.job.label,
		grade     = xPlayer.job.grade_label,
		inventory = xPlayer.inventory,
		accounts  = xPlayer.accounts,
		weapons   = xPlayer.loadout,
		firstname = firstname,
		lastname  = lastname,
		sex       = sex,
		dob       = dob,
		height    = height
	}

	TriggerEvent('status:getStatus', target, 'drunk', function(status)
		if status ~= nil then
			data.drunk = math.floor(status.percent)
		end
	end)
cb(data)
end)

RegisterServerEvent("policejob:askForHelp")
AddEventHandler("policejob:askForHelp", function(thetype)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local _thetype = thetype

	if xPlayer and CheckIsPolice(xPlayer.job.name) then
		actualhelpid = actualhelpid + 1
		local helpid = actualhelpid
		HelpBlips[helpid] = xPlayer.identifier
		for i=1, #xPlayers, 1 do
			local xSelectedPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if CheckIsPolice(xSelectedPlayer.job.name) then
					TriggerClientEvent('esx:showNotification', xPlayers[i], "[" .. xPlayer.identity.firstname .. " " .. xPlayer.identity.lastname .. "] " .. "J'ai besoin de renforts !")
					TriggerClientEvent('policejob:receiveHelpBlip', xPlayers[i], helpid, GetEntityCoords(GetPlayerPed(xPlayer.source)), xPlayer.identity.firstname .. " " .. xPlayer.identity.lastname, _thetype)
					local time = 30 * 1000
					if thetype == "normal" then
						time = 50 * 1000
					elseif thetype == "high" then
						time = 60 * 1000
					end
					SetTimeout(time, function()
						TriggerClientEvent("policejob:removeHelpBlip", xPlayers[i], helpid)
					end)
			end
		end
	end
end)

RegisterServerEvent("policejob:RequestVehicleInfos")
AddEventHandler("policejob:RequestVehicleInfos", function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _plate = plate
	local vehicle = GetGarageVehicle(_plate)

	if xPlayer and CheckIsPolice(xPlayer.job.name) then
		if vehicle then
			local PlayerData = ESX.RegistredPlayers[vehicle.owner]
			local identity = json.decode(PlayerData.identity)
			if PlayerData then
			    xPlayer.showNotification("Plaque : " .. _plate .. "\nPropriétaire : " .. identity.firstname .. " " .. identity.lastname)
			end
		end
	end
end)

RegisterServerEvent("policejob:jailPlayer")
AddEventHandler("policejob:jailPlayer", function(target, station, time)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if target ~= -1 and xPlayer and CheckIsPolice(xPlayer.job.name) then
		if tonumber(time) > 0 then
			JailPlayer(target, station, time)
		elseif tonumber(time) == 0 then
			UnJailPlayer(target)
		end
	end
end)
