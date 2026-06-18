local IsHandcuffed = false
local IsShackles = false
local DragStatus = {}
DragStatus.IsDragged = false

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

RegisterNetEvent("ehandcuff:unrestrain")
AddEventHandler("ehandcuff:unrestrain", function()
if IsHandcuffed then
  local playerPed = ESX.PlayerData.cache.playerped
  IsHandcuffed = false
  ClearPedSecondaryTask(playerPed)
  SetEnableHandcuffs(playerPed, false)
  DisablePlayerFiring(playerPed, false)
  SetPedCanPlayGestureAnims(playerPed, true)
  DisplayRadar(true)
end
end)

RegisterNetEvent("ehandcuff:drag")
AddEventHandler("ehandcuff:drag", function(copID)
	if not IsHandcuffed then
		return
	end
	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId = tonumber(copID)
end)

RegisterNetEvent("ehandcuff:ZiZouVehicle")
AddEventHandler("ehandcuff:ZiZouVehicle", function()
	local playerPed = ESX.PlayerData.cache.playerped
	local coords = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent("ehandcuff:OutVehicle")
AddEventHandler("ehandcuff:OutVehicle", function()
	local playerPed = ESX.PlayerData.cache.playerped

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

RegisterNetEvent("ehandcuff:on")
AddEventHandler("ehandcuff:on", function()
	IsHandcuffed = not IsHandcuffed
	local playerPed = ESX.PlayerData.cache.playerped

	Citizen.CreateThread(function()
		if IsHandcuffed then
			RequestAnimDict("mp_arresting")
			while not HasAnimDictLoaded("mp_arresting") do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			DisplayRadar(false)
		else
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			DisplayRadar(true)
		end
	end)
end)

Citizen.CreateThread(function()
local playerPed
local targetPed
	while true do
		Citizen.Wait(5)
		if IsHandcuffed then
			playerPed = ESX.PlayerData.cache.playerped

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end

		else
		Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local playerPed = ESX.PlayerData.cache.playerped

		if IsHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also "enter"?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) ~= 1 then
				ESX.Streaming.RequestAnimDict("mp_arresting", function()
					TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
			
		else
		Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local playerPed = ESX.PlayerData.cache.playerped
		if IsShackles then
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover

			if IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) ~= 1 then
				ESX.Streaming.RequestAnimDict("mp_arresting", function()
					TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end

		else
		Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("handcuff:getarrested")
AddEventHandler("handcuff:getarrested", function(playerheading, playercoords, playerlocation)
	playerPed = ESX.PlayerData.cache.playerped
	SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
	local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(ESX.PlayerData.cache.playerped, x, y, z)
	SetEntityHeading(ESX.PlayerData.cache.playerped, playerheading)
	Citizen.Wait(250)
	LoadAnimDict("mp_arrest_paired")
	TaskPlayAnim(ESX.PlayerData.cache.playerped, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	IsHandcuffed = true
	IsShackles = false
	LoadAnimDict("mp_arresting")
	TaskPlayAnim(ESX.PlayerData.cache.playerped, "mp_arresting", "idle", 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent("handcuff:doarrested")
AddEventHandler("handcuff:doarrested", function()
	Citizen.Wait(250)
	LoadAnimDict("mp_arrest_paired")
	TaskPlayAnim(ESX.PlayerData.cache.playerped, "mp_arrest_paired", "cop_p2_back_right", 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
end) 

RegisterNetEvent("handcuff:douncuffing")
AddEventHandler("handcuff:douncuffing", function()
	Citizen.Wait(250)
	LoadAnimDict("mp_arresting")
	TaskPlayAnim(ESX.PlayerData.cache.playerped, "mp_arresting", "a_uncuff", 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(ESX.PlayerData.cache.playerped)
end)

RegisterNetEvent("handcuff:getuncuffed")
AddEventHandler("handcuff:getuncuffed", function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(ESX.PlayerData.cache.playerped, x, y, z)
	SetEntityHeading(ESX.PlayerData.cache.playerped, playerheading)
	Citizen.Wait(250)
	LoadAnimDict("mp_arresting")
	TaskPlayAnim(ESX.PlayerData.cache.playerped, "mp_arresting", "b_uncuff", 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = false
	IsShackles = false
	ClearPedTasks(ESX.PlayerData.cache.playerped)
end)