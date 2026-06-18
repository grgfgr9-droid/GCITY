local isRunningWorkaround = false

local vehicles = {}

Citizen.CreateThread(function()
	while not ESX.PlayerData.PassJoin do 
		Wait(0)
	end
    ESX.TriggerServerCallback('vehiclelock:GetOwnedVehicles', function(cb) 
	    if cb then
	 	    vehicles = cb
	    end
    end)
end)

function StartWorkaroundTask()
	if isRunningWorkaround then
		return
	end

	local timer = 0
	local playerPed = ESX.PlayerData.cache.playerped
	isRunningWorkaround = true

	while timer < 100 do
		Citizen.Wait(5)
		timer = timer + 1

		local vehicle = GetVehiclePedIsTryingToEnter(playerPed)

		if DoesEntityExist(vehicle) then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 2 then
				ClearPedTasks(playerPed)
			end
		end
	end

	isRunningWorkaround = false
end

function ToggleVehicleLock(myvehicle)
	local playerPed = ESX.PlayerData.cache.playerped
	local coords = GetEntityCoords(playerPed)
	local vehicle

	Citizen.CreateThread(function()
		StartWorkaroundTask()
	end)

	if vehicle then
		vehicle = myvehicle
	elseif IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords, 8.0, 0, 71)
	end

	if not DoesEntityExist(vehicle) then
		return
	end

	local OwnedPlate = false

	  if vehicles[string.lower(GetVehicleNumberPlateText(vehicle)):match( "^%s*(.-)%s*$" )] then
		OwnedPlate = true

		local dict = "anim@mp_player_intmenu@key_fob@"
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
		  Citizen.Wait(100)
		end

		TaskPlayAnim(ESX.PlayerData.cache.playerped, dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
		StopAnimTask = true
				
		local lockStatus = GetVehicleDoorLockStatus(vehicle)
	
		if lockStatus == 0 or lockStatus == 1 then -- unlocked
			SetVehicleDoorsLocked(vehicle, 2)
			PlayVehicleDoorCloseSound(vehicle, 1)
			SetVehicleLights(vehicle, 2)
            Wait(400)
            SetVehicleLights(vehicle, 0)
			ESX.ShowAdvancedNotification("Véhicule", "Gestion des portières", "Vous avez ~r~fermé~s~ le véhicule, le coffre est également ~r~fermé~s~.", "CHAR_MULTIPLAYER", 8)
		elseif lockStatus == 2 then -- locked
			SetVehicleDoorsLocked(vehicle, 1)
			SetVehicleLights(vehicle, 2)
            Wait(400)
            SetVehicleLights(vehicle, 0)
			PlayVehicleDoorOpenSound(vehicle, 0)
			ESX.ShowAdvancedNotification("Véhicule", "Gestion des portières", "Vous avez ~g~ouvert~s~ le véhicule, le coffre est également ~g~ouvert~s~.", "CHAR_MULTIPLAYER", 8)
		end

	  end

	if not OwnedPlate then
	ESX.ShowNotification("~r~Vous n'avez pas les clés de ce véhicule.~s~")
	end
	
end

RegisterNetEvent('vehiclelock:externalVehicleLock')
AddEventHandler('vehiclelock:externalVehicleLock', function(vehicle)
	if not ESX.PlayerData.IsDead then
		ToggleVehicleLock(vehicle)
	end
end)

RegisterNetEvent("vehiclelock:UpdateOwners")
AddEventHandler("vehiclelock:UpdateOwners", function(plate)
    vehicles[string.lower(plate):match( "^%s*(.-)%s*$" )] = true
end)

RegisterCommand("+lockveh", function()
 if not ESX.PlayerData.IsDead then
  ToggleVehicleLock()
 end
end, false)

RegisterKeyMapping("+lockveh", "Verouiller vehicule", "keyboard", "u")