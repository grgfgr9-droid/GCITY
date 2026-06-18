local debugProps, sitting, lastPos, currentSitCoords, currentScenario = {}

if SitConfig.Debug then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)

			for i=1, #debugProps, 1 do
				local coords = GetEntityCoords(debugProps[i])
				local hash = GetEntityModel(debugProps[i])
				local id = coords.x .. coords.y .. coords.z
				local model = 'unknown'

				for i=1, #SitConfig.Interactables, 1 do
					local seat = SitConfig.Interactables[i]

					if hash == GetHashKey(seat) then
						model = seat
						break
					end
				end

				local text = ('ID: %s~n~Hash: %s~n~Model: %s'):format(id, hash, model)

				ESX.Game.Utils.DrawText3D({
					x = coords.x,
					y = coords.y,
					z = coords.z + 2.0
				}, text, 0.5)
			end

			if #debugProps == 0 then
				Citizen.Wait(500)
			end
		end
	end)
end

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)

		if sitting and not IsPedUsingScenario(ESX.PlayerData.cache.playerped, currentScenario) then
			wakeup()
		end
	end
end)]]

function wakeup()
	ClearPedTasks(ESX.PlayerData.cache.playerped)

	sitting = false

	SetEntityCoords(ESX.PlayerData.cache.playerped, lastPos)
	FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)

	TriggerServerEvent('sit:leavePlace', currentSitCoords)
	currentSitCoords, currentScenario = nil, nil
end

function sit(object, modelName, data)
	local pos = GetEntityCoords(object)
	local objectCoords = pos.x .. pos.y .. pos.z

	ESX.TriggerServerCallback('sit:getPlace', function(occupied)
		if occupied then
			ESX.ShowNotification('Cette place est prise...')
		else
			lastPos, currentSitCoords = ESX.PlayerData.cache.coords, objectCoords

			TriggerServerEvent('sit:takePlace', objectCoords)
			FreezeEntityPosition(object, true)

			currentScenario = data.scenario
			TaskStartScenarioAtPosition(ESX.PlayerData.cache.playerped, currentScenario, pos.x, pos.y, pos.z - data.verticalOffset, GetEntityHeading(object) + 180.0, 0, true, true)
			Citizen.Wait(1000)
			sitting = true
		end
	end)
end

RegisterCommand("+sit", function()
	if IsInputDisabled(0) and IsPedOnFoot(ESX.PlayerData.cache.playerped) then
		if sitting then
			wakeup()
		else
			local object, distance = ESX.Game.GetClosestObject(SitConfig.Interactables)

			if SitConfig.Debug then
				table.insert(debugProps, object)
			end

			if distance < 1.5 then
				local hash = GetEntityModel(object)

				for k,v in pairs(SitConfig.Sitable) do
					if GetHashKey(k) == hash then
						sit(object, k, v)
						break
					end
				end
			end
		end
	end
end, false)
