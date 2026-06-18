RegisterNetEvent('status:onEat')
AddEventHandler('status:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local plyPed = ESX.PlayerData.cache.playerped
			local plyCoords = GetEntityCoords(plyPed, false)
			local propHash = GetHashKey(prop_name)

			ESX.Game.SpawnObject(propHash, vector3(plyCoords.x, plyCoords.y, plyCoords.z + 0.2), function(object)
				AttachEntityToEntity(prop, plyPed, GetPedBoneIndex(plyPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
				SetModelAsNoLongerNeeded(propHash)

				ESX.Streaming.RequestAnimDict('mp_player_inteat@burger')

				TaskPlayAnim(plyPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
				RemoveAnimDict('mp_player_inteat@burger')
				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(plyPed)
				DeleteObject(prop)
			end)
		end)
	end
end)

RegisterNetEvent('status:onDrink')
AddEventHandler('status:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local plyPed = ESX.PlayerData.cache.playerped
			local plyCoords = GetEntityCoords(plyPed, false)
			local propHash = GetHashKey(prop_name)

			ESX.Game.SpawnObject(propHash, vector3(plyCoords.x, plyCoords.y, plyCoords.z + 0.2), function(object)
				AttachEntityToEntity(object, plyPed, GetPedBoneIndex(plyPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
				SetModelAsNoLongerNeeded(propHash)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink')

				TaskPlayAnim(plyPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
				RemoveAnimDict('mp_player_intdrink')
				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(plyPed)
				DeleteObject(object)
			end)
		end)
	end
end)

RegisterNetEvent('status:onDrinkAlcohol')
AddEventHandler('status:onDrinkAlcohol', function()
	if not IsAnimated then
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = ESX.PlayerData.cache.playerped
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, true)
			Citizen.Wait(10000)
			IsAnimated = false
			ClearPedTasksImmediately(playerPed)
		end)
	end
end)

RegisterNetEvent('status:onWeed')
AddEventHandler('status:onWeed', function()
	if not IsAnimated then
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = ESX.PlayerData.cache.playerped

			ESX.Streaming.RequestAnimSet("move_m@hipster@a")

			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, true)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedTasksImmediately(playerPed)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(playerPed, true)
			SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
			RemoveAnimSet("move_m@hipster@a")
			SetPedIsDrunk(playerPed, true)
		end)
	end
end)

RegisterNetEvent('status:onOpium')
AddEventHandler('status:onOpium', function()
	if not IsAnimated then
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = ESX.PlayerData.cache.playerped

			ESX.Streaming.RequestAnimSet("move_m@drunk@moderatedrunk")

			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, true)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedTasksImmediately(playerPed)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(playerPed, true)
			SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
			RemoveAnimSet("move_m@drunk@moderatedrunk")
			SetPedIsDrunk(playerPed, true)
		end)
	end
end)

RegisterNetEvent('status:onMeth')
AddEventHandler('status:onMeth', function()
	if not IsAnimated then
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = ESX.PlayerData.cache.playerped

			ESX.Streaming.RequestAnimSet("move_injured_generic")

			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, true)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedTasksImmediately(playerPed)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(playerPed, true)
			SetPedMovementClipset(playerPed, "move_injured_generic", true)
			RemoveAnimSet("move_injured_generic")
			SetPedIsDrunk(playerPed, true)
		end)
	end
end)

RegisterNetEvent('status:onCoke')
AddEventHandler('status:onCoke', function()
	if not IsAnimated then
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = ESX.PlayerData.cache.playerped

			ESX.Streaming.RequestAnimSet("move_m@hurry_butch@a")

			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, true)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedTasksImmediately(playerPed)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(playerPed, true)
			SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
			RemoveAnimSet("move_m@hurry_butch@a")
			SetPedIsDrunk(playerPed, true)
		end)
	end
end)

function DrunkEffect(level, start)
	Citizen.CreateThread(function()
		local playerPed = ESX.PlayerData.cache.playerped

		if start then
			DoScreenFadeOut(800)
			Citizen.Wait(1000)
		end

		if level == 0 then
			ESX.Streaming.RequestAnimSet("move_m@drunk@slightlydrunk")

			SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
			RemoveAnimSet("move_m@drunk@slightlydrunk")
		elseif level == 1 then
			ESX.Streaming.RequestAnimSet("move_m@drunk@moderatedrunk")

			SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
			RemoveAnimSet("move_m@drunk@moderatedrunk")
		elseif level == 2 then
			ESX.Streaming.RequestAnimSet("move_m@drunk@verydrunk")

			SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
			RemoveAnimSet("move_m@drunk@verydrunk")
		end

		SetTimecycleModifier("spectator5")
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)

		if start then
			DoScreenFadeIn(800)
		end
	end)
end

function OverdoseEffect()
	Citizen.CreateThread(function()
		local playerPed = ESX.PlayerData.cache.playerped

		SetEntityHealth(playerPed, 0)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0.0)
		SetPedIsDrug(playerPed, false)
		SetPedMotionBlur(playerPed, false)
	end)
end

function StopEffect()
	Citizen.CreateThread(function()
		local playerPed = ESX.PlayerData.cache.playerped

		DoScreenFadeOut(800)
		Citizen.Wait(1000)

		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0.0)
		SetPedIsDrunk(playerPed, false)
		SetPedMotionBlur(playerPed, false)

		DoScreenFadeIn(800)
	end)
end