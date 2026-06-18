local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local NoSpam = false
local AntiSpamStuck = false
local TimeRea = 0
local WaitForDeathCheck = 0

local DrawDistance = 10.0
local Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

local BleedoutTimer = 10 * 60 * 1000

local Vehicles = { 'dodgeems', 'ambulance' }
local Helico = { 'buzzard2' }

local RespawnPoint = { coords = vector3(294.824, -579.551, 44.185), heading = 173.876 }

local Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(313.319, -591.295, 42.284),
			sprite = 61,
			scale  = 0.5,
			color  = 8
		},

		AmbulanceActions = {
			vector3(299.024, -598.464, 42.284)
		},

		Pharmacies = {
			vector3(311.356, -562.883, 42.284)
		},

		Vehicles = {
			{
				Spawner = vector3(292.183, -593.305, 43.107),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(294.189, -576.825, 42.197), heading = 227.6, radius = 4.0 },
					{ coords = vector3(291.050, -587.595, 42.192), heading = 227.6, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(341.816, -580.652, 74.164),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.386, -588.244, 73.164), heading = 142.7, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			{
				From = vector3(339.562, -584.210, 73.164),
				To = { coords = vector3(331.424, -574.423, 42.284), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(332.791, -569.681, 42.284),
				To = { coords = vector3(342.022, -590.877, 73.164), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(360.514, -591.982, 27.661),
				To = { coords = vector3(328.337, -600.839, 42.284), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

		},

	}
}

local Tenues = {
		male = {
			['tshirt_1'] = 44,  ['tshirt_2'] = 3,
			['torso_1'] = 380,   ['torso_2'] = 0,
			['decals_1'] = 95,   ['decals_2'] = 0,
			['arms'] = 85,
			['pants_1'] = 130,   ['pants_2'] = 0,
			['shoes_1'] = 117,   ['shoes_2'] = 0,
			['chain_1'] = 69,    ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 33,  ['tshirt_2'] = 0,
			['torso_1'] = 353,   ['torso_2'] = 0,
			['decals_1'] = 102,   ['decals_2'] = 0,
			['arms'] = 109,
			['pants_1'] = 120,   ['pants_2'] = 0,
			['shoes_1'] = 113,   ['shoes_2'] = 0,
			['chain_1'] = 22,    ['chain_2'] = 0
		}
}

function OpenAmbulanceActionsMenu()
AmbulanceActionMenu = {
    Base = { Title = "Ambulance", HeaderColor = {255, 0, 102} },
    Data = { currentMenu = "ambulance" },

    Events = {
	onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "cloakroom" then
		OpenMenu("vestiaire")

	  elseif btn.action == "coffre" then
		TriggerEvent("coffre:OpenMenu", 1)

	  elseif btn.action == "boss" then
		CloseMenu()
		OpenBossMenu("ambulance", 1)

	  elseif btn.action == "civil" then
		TriggerServerEvent("player:serviceOff")
		ESX.ShowNotification("Vous n'êtes plus en service.")
		TriggerEvent('caruiskinchanger:loadSkin', ESX.PlayerData.skin)
		CloseMenu()

	  elseif btn.action == "work" then
		TriggerServerEvent("player:serviceOn")
		ESX.ShowNotification("Vous avez pris votre service.")
		setUniformAmbulance(ESX.PlayerData.cache.playerped)
		CloseMenu()

	  end
    end
  },

  Menu = {
    ["ambulance"] = {
      b = {
		{name = "Vestiaire ambulance", action = "cloakroom", ask = "→", askX = true},
		{name = "Coffre entreprise", action = "coffre", ask = "→", askX = true},
      }
	},
	["vestiaire"] = {
      b = {
		{name = "Tenu civil", action = "civil", ask = "→", askX = true},
		{name = "Tenue ambulancier", action = "work", ask = "→", askX = true},
      }
    },
  }
}

if ESX.PlayerData.job.grade_name == "boss" then
table.insert(AmbulanceActionMenu.Menu["ambulance"].b, {name = "Menu patrons", action = "boss"})
end

CreateMenu(AmbulanceActionMenu)

end

function FastTravel(coords, heading)
	local playerPed = ESX.PlayerData.cache.playerped

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		local playerCoords = ESX.PlayerData.cache.coords
		local letSleepAmbulance, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum

		for hospitalNum,hospital in pairs(Hospitals) do

			-- Ambulance Actions
			for k,v in ipairs(hospital.AmbulanceActions) do
				local distance = GetDistanceBetweenCoords(playerCoords, v, true)

				if distance < DrawDistance then
					DrawMarker(Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Marker.x, Marker.y, Marker.z, Marker.r, Marker.g, Marker.b, Marker.a, false, false, 2, Marker.rotate, nil, nil, false)
					letSleepAmbulance = false
				end

				if distance < Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
				end
			end

			-- Pharmacies
			for k,v in ipairs(hospital.Pharmacies) do
				local distance = GetDistanceBetweenCoords(playerCoords, v, true)

				if distance < DrawDistance then
					DrawMarker(Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Marker.x, Marker.y, Marker.z, Marker.r, Marker.g, Marker.b, Marker.a, false, false, 2, Marker.rotate, nil, nil, false)
					letSleepAmbulance = false
				end

				if distance < Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
				end
			end

			-- Vehicle Spawners
			for k,v in ipairs(hospital.Vehicles) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleepAmbulance = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
				end
			end

			-- Helicopter Spawners
			for k,v in ipairs(hospital.Helicopters) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleepAmbulance = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
				end
			end

			-- Fast Travels
			for k,v in ipairs(hospital.FastTravels) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

				if distance < DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleepAmbulance = false
				end

				if distance < v.Marker.x then
					FastTravel(v.To.coords, v.To.heading)
				end
			end

		end

		-- Logic for exiting & entering markers
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

			if
				(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('ambulance:hasExitedMarker', LastHospital, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

			TriggerEvent('ambulance:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('ambulance:hasExitedMarker', LastHospital, LastPart, LastPartNum)
		end

		if letSleepAmbulance then
		Citizen.Wait(1000)
		end

	 else
	 Citizen.Wait(5000)
	 end
  end
end)

AddEventHandler('ambulance:hasEnteredMarker', function(hospital, part, partNum)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		if part == 'AmbulanceActions' then
			CurrentAction = part
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour acceder aux ~y~Actions ambulances~s~.'
			CurrentActionData = {}
		elseif part == 'Pharmacy' and ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			CurrentAction = part
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la pharmacie.'
			CurrentActionData = {}
		elseif part == 'Vehicles' and ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			CurrentAction = part
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder aux ~y~Actions des véhciules~s~.'
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Helicopters' and ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			CurrentAction = part
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder aux ~y~Actions de l\'hélicoptère~s~.'
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'FastTravelsPrompt' and ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			local travelItem = Hospitals[hospital][part][partNum]
			CurrentAction = part
			CurrentActionMsg = travelItem.Prompt
			CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
		end
	end
end)

AddEventHandler('ambulance:hasExitedMarker', function(hospital, part, partNum)

CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)
			if IsControlJustReleased(0, 38) then

				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'Pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenuAmbu('car', CurrentActionData.hospital, 'Vehicles', CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenVehicleSpawnerMenuAmbu('helicopter', CurrentActionData.hospital, 'Helicopters', CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				end

				CurrentAction = nil
			end
		else
		Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('ambulance:Revive')
AddEventHandler('ambulance:Revive', function(closestPlayer)
  IsBusy = true
		   local closestPlayerPed = GetPlayerPed(closestPlayer)
		   if IsPedDeadOrDying(closestPlayerPed, 1) and NoSpam == false then
			   NoSpam = true
			   local playerPed = ESX.PlayerData.cache.playerped

			   ESX.ShowNotification('Réanimation en cours...')
			   local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

			   for i=1, 15, 1 do
				   Citizen.Wait(900)
				   ESX.Streaming.RequestAnimDict(lib, function()
					   TaskPlayAnim(ESX.PlayerData.cache.playerped, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
				   end)
			   end

			   TriggerServerEvent('ambulance:revive', closestPlayer)
			   Citizen.Wait(500)
			   ESX.ShowNotification('Réanimation terminé.')
			   Citizen.Wait(1000)
			   NoSpam = false
		   else
			   ESX.ShowNotification('N\'est pas inconscient!')
		   end
	   IsBusy = false
end)

RegisterNetEvent('ambulance:SoigneSmall')
AddEventHandler('ambulance:SoigneSmall', function(closestPlayer)
	ESX.TriggerServerCallback('ambulance:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)
			local health = GetEntityHealth(closestPlayerPed)

			if health > 0 then
				local playerPed = ESX.PlayerData.cache.playerped

				IsBusy = true
				ESX.ShowNotification('Vous soignez...')
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(10000)
				ClearPedTasks(playerPed)

				TriggerServerEvent('ambulance:removeItem', 'bandage')
				TriggerServerEvent('ambulance:heal', GetPlayerServerId(closestPlayer), 'small')
				ESX.ShowNotification('vous soignez...')
				IsBusy = false
			else
				ESX.ShowNotification('N\'est pas inconscient!')
			end
		else
			ESX.ShowNotification('Vous n\'avez pas de ~b~bandage~s~.')
		end
	end, 'bandage')
end)

RegisterNetEvent('ambulance:SoigneBig')
AddEventHandler('ambulance:SoigneBig', function(closestPlayer)
	ESX.TriggerServerCallback('ambulance:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)
			local health = GetEntityHealth(closestPlayerPed)

			if health > 0 then
				local playerPed = ESX.PlayerData.cache.playerped

				IsBusy = true
				ESX.ShowNotification('Vous soignez...')
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(10000)
				ClearPedTasks(playerPed)

				TriggerServerEvent('ambulance:removeItem', 'medikit')
				TriggerServerEvent('ambulance:heal', GetPlayerServerId(closestPlayer), 'big')
				ESX.ShowNotification('Terminé!')
				IsBusy = false
			else
				ESX.ShowNotification('N\'est pas inconscient')
			end
		else
			ESX.ShowNotification('Vqous n\'avez pas de ~b~kit de soin~s~.')
		end
	end, 'medikit')
end)

RegisterNetEvent('ambulance:ZiZouVehicle')
AddEventHandler('ambulance:ZiZouVehicle', function()
	local playerPed = ESX.PlayerData.cache.playerped
	local coords    = GetEntityCoords(playerPed)

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
			end
		end
	end
end)

function OpenVehicleSpawnerMenuAmbu(type, station, part, partNum)
	local playerCoords = ESX.PlayerData.cache.coords
	local playerPed = ESX.PlayerData.cache.playerped

	AmbuVehicleMenu = {
		Base = { Title = "Garage", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "garage ems" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == "garage" then
				AmbuVehicleMenu.Menu["garage"].b = {}
				if type == 'car' then
				table.insert(AmbuVehicleMenu.Menu["garage"].b, {name = 'Dodge', model = 'dodgeems', action = "spawnveh"})
                table.insert(AmbuVehicleMenu.Menu["garage"].b, {name = 'Ambulance', model = 'ambulance', action = "spawnveh"})
				else
				table.insert(AmbuVehicleMenu.Menu["garage"].b, {name = 'buzzard', model = 'buzzard2', action = "spawnveh"})
				end
				OpenMenu('garage')
			elseif btn.action == "spawnveh" then
				local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPointAmbulance(station, part, partNum)

				ESX.Game.SpawnVehicle(btn.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
					local plate = 'AMBU'..math.random(100, 900)
					plate = string.gsub(plate, " ", "")
					SetVehicleNumberPlateText(vehicle, plate)
					local playerPed = ESX.PlayerData.cache.playerped
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					TriggerServerEvent("vehiclelock:preterkey", plate)
					ESX.ShowNotification('Votre véhicule a été sorti.')
					CloseMenu()
				end, "job")
			elseif btn.action == "delveh" then
				local playerPed = ESX.PlayerData.cache.playerped
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local hash = GetEntityModel(vehicle)  
				local truck = Vehicles
				local found = false
	
				for i=1, #truck, 1 do
				if hash == GetHashKey(truck[i]) then
				ESX.Game.DeleteVehicle(vehicle)
				TriggerEvent('esx:showNotification', 'Le véhicule à bien été rangé.')
				found = true
				CloseMenu()
				end
				end 
	
			   if not found then
			   TriggerEvent('esx:showNotification', 'Vous ne pouvez pas ranger ce véhicule.')
			   end
			end
		end
	  },
	
	  Menu = {
		["garage ems"] = {
			b = {

			}
		},
		["garage"] = {
			b = {
			  
			}
		}
	 }
	}

	if IsPedInAnyVehicle(playerPed, false) then
		table.insert(AmbuVehicleMenu.Menu["garage ems"].b, {name = 'Ranger le véhicule', action = 'delveh'})
	  else
		table.insert(AmbuVehicleMenu.Menu["garage ems"].b, {name = 'Sortir un véhicule', action = 'garage'})
	  end
	
	CreateMenu(AmbuVehicleMenu)

end


function GetAvailableVehicleSpawnPointAmbulance(hospital, part, partNum)
	local spawnPoints = Hospitals[hospital][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification('La sortie du garage est obstruée!')
		return false
	end
end

function OpenPharmacyMenu()
	PharmacyMenu = {
		Base = { Title = "Pharmacie", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "pharmacie" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == "buy" then
				TriggerServerEvent('ambulance:giveItem', btn.value)
			end
		end
	  },
	
	  Menu = {
		["pharmacie"] = {
			b = {
				{name = 'Prendre ~b~medikit', value = 'medikit', action = "buy"},
				{name = 'Prendre ~b~bandage', value = 'bandage', action = "buy"}
			}
		}
	 }
	}
	
	CreateMenu(PharmacyMenu)
end

RegisterNetEvent('ambulance:heal')
AddEventHandler('ambulance:heal', function(healType, quiet)
	local playerPed = ESX.PlayerData.cache.playerped
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification('Vous avez été soigné.')
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if ESX.PlayerData.IsDead then
			DisableControlAction(0, 288, true) -- F1
			--DisableControlAction(0, 289, true) -- F2
			DisableControlAction(0, 170, true) -- F3
			DisableControlAction(0, 167, true)
			DisableControlAction(0, 249, true)
			EnableControlAction(0, 166, true)
			DisableControlAction(0, 23, true)
			DisableControlAction(0, 311, true) -- Inventory (K)
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 303, true)
		else
		Citizen.Wait(2500)
		end
	end
end)

function PlayerDied()
TriggerServerEvent("ambulance:setDead")
AttempLogDeath()
Citizen.CreateThread(function()
	while not ESX.PlayerData.IsDead do
		Wait(0)
	end
	CloseMenu()
	StartDeathTimer()
	SendDistressSignalLoop()
	ESX.ShowNotification("Appuyez sur X pour appeler une ambulance.")
end)
end

RegisterNetEvent('ambulance:useItem')
AddEventHandler('ambulance:useItem', function(itemName)
	

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = ESX.PlayerData.cache.playerped

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
			
			if not ESX.PlayerData.IsDead then 
			TriggerEvent('ambulance:heal', 'big', true)
			ESX.ShowNotification('Vous avez utilisé 1x kit de soin')
			end
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = ESX.PlayerData.cache.playerped

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('ambulance:heal', 'small', true)
			ESX.ShowNotification('Vous avez utilisé 1x bandage')
		end)
	end
end)

function SendDistressSignalLoop()
 Citizen.CreateThread(function()
  local timer = BleedoutTimer
  while timer > 0 and ESX.PlayerData.IsDead do
    Citizen.Wait(5)
    timer = timer - 30

    if IsControlJustReleased(1, 73) then
      local plyPos = GetEntityCoords(ESX.PlayerData.cache.playerped, true)
      TriggerServerEvent("ambulance:sendCall", {x = plyPos.x, y = plyPos.y, z = plyPos.z})
      ESX.ShowNotification("Un signal a été envoyé à toutes les unités disponibles!")
      Citizen.CreateThread(function()
       Citizen.Wait(1000 * 60 * 5)
       if ESX.PlayerData.IsDead then
        ESX.ShowNotification("Appuyez sur X pour appeler une ambulance.")
        SendDistressSignalLoop()
       end
      end)
      break
    end
  end
 end)
end

function formatTimer(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
    local respawnTimer = ESX.Math.Round(BleedoutTimer / 1000)
    local allowRespawn = respawnTimer / 2
    local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringPlayerName("~r~Vous etes dans le coma")
    EndTextCommandScaleformString()
    EndScaleformMovieMethod()

    PlaySoundFrontend(-1, "TextHit", "WastedSounds", true)

    Citizen.CreateThread(function()
        while respawnTimer > 0 and ESX.PlayerData.IsDead do
            Citizen.Wait(1000)
            if respawnTimer > 0 then
            respawnTimer = respawnTimer - 1
            end
        end
    end)

    Citizen.CreateThread(function()
        while respawnTimer > 0 and ESX.PlayerData.IsDead do
            Citizen.Wait(2)

            SetTextFont(4)
            SetTextScale(0.0, 0.5)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextCentre(true)

            local text = (("Réapparition dans ~b~%s minutes et %s secondes~s~"):format(formatTimer(respawnTimer)))

            if respawnTimer <= allowRespawn then
                text = text .. '\n' .. "Appuyez sur [~b~E~w~] pour réapparaître"
                if IsControlJustReleased(0, 38) then
                    PlayerRevived(true)
                    break
                end
            end

            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName(text)
            EndTextCommandDisplayText(0.5, 0.8)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end

        if respawnTimer <= 0 then
            PlayerRevived(false)
        end
    end)
end

function PlayerRevived(early)
	local _early = early
TriggerEvent("ehandcuff:unrestrain")
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
				local formattedCoords = {
				x = RespawnPoint.coords.x,
				y = RespawnPoint.coords.y,
				z = RespawnPoint.coords.z
				}
	
				RespawnPed(ESX.PlayerData.cache.playerped, formattedCoords, RespawnPoint.heading)
				Citizen.Wait(500)
				FreezeEntityPosition(ESX.PlayerData.cache.playerped, true)
				Citizen.Wait(1000)
				FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
				SetEntityVisible(ESX.PlayerData.cache.playerped, true)
	
				StopScreenEffect("DeathFailOut")
				DoScreenFadeIn(1000)
				TriggerEvent("frame:Rea")	
				TriggerServerEvent("ambulance:requestRespawnHopital", _early)
	end)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
	TriggerEvent('esx:onPlayerSpawn')
end

HasBeanKilled = false
Citizen.CreateThread(function()
	while not PassJoin do
		Wait(0)
	end
	Wait(2000)
 while true do
  Citizen.Wait(1000)
  local ped = ESX.PlayerData.cache.playerped
  if WaitForDeathCheck == 0 and DoesEntityExist(ped) and IsEntityDead(ped) and not ESX.PlayerData.IsDead then
	HasBeanKilled = true
	PlayerDied()
else
	Wait(1000)
  end
  if WaitForDeathCheck > 0 then
	WaitForDeathCheck = WaitForDeathCheck - 1
  elseif WaitForDeathCheck < 0 then
	WaitForDeathCheck = 0
  end
 end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	while not PassJoin do
		Wait(0)
	end
	if xPlayer.IsDead then
		Wait(5000)
		SetEntityHealth(ESX.PlayerData.cache.playerped, 0)
		ESX.ShowNotification('Vous vous êtes déconnectés en étant coma')
	end
end)

RegisterNetEvent("ambulance:revive")
AddEventHandler("ambulance:revive", function()
	local playerPed = ESX.PlayerData.cache.playerped
	local coords = GetEntityCoords(playerPed)
	ESX.ShowNotification("Vous venez de vous faire réanimé")
	WaitForDeathCheck = 5
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(100)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		HasBeanKilled = false
		RespawnPed(playerPed, formattedCoords, 0.0)
		StopScreenEffect("DeathFailOut")
		DoScreenFadeIn(800)
		TriggerEvent("ehandcuff:unrestrain")
		TriggerEvent("frame:Rea")
	end)
end)

RegisterCommand("stuck", function()
if ESX.PlayerData.IsDead then
  if not AntiSpamStuck then
    AntiSpamStuck = true
    Citizen.SetTimeout(30000, function()
	AntiSpamStuck = false
    end)
    if not IsEntityPlayingAnim(ESX.PlayerData.cache.playerped, "mp_arresting", "idle", 3) then
      ClearPedTasksImmediately(ESX.PlayerData.cache.playerped)
    end
  end
end
end)

function setUniformAmbulance(playerPed)
	TriggerEvent('caruiskinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Tenues.male ~= nil then
				TriggerEvent('caruiskinchanger:loadClothes', skin, Tenues.male)
			else
				ESX.ShowNotification('Il n\'y a pas d\'uniforme à votre taille...')
			end
		else
			if Tenues.female ~= nil then
				TriggerEvent('caruiskinchanger:loadClothes', skin, Tenues.female)
			else
				ESX.ShowNotification('Il n\'y a pas d\'uniforme à votre taille...')
			end

		end
	end)
end

function formatTimeAmbulance(time)
	local minutes = math.floor( time / 60 )
	local hours = math.floor( minutes / 60 )
	local seconds = time % 60
	
	local timeDisplay = string.format( "%02d:%02d:%02d", hours, minutes, seconds )
    return timeDisplay
end

function OpenAmbulanceMenu()
AppelsOption = {"Prendre l'appel", "Supprimer l'appel"}
AmbulanceMenu = {
    Base = { Title = "Ambulance", HeaderColor = {255, 0, 102} },
    Data = { currentMenu = "ambulance" },

    Events = {
	onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
	 if btn.action == "appels" then
		ESX.TriggerServerCallback("ambulance:getCalls", function(appels)
		  for k, v in pairs(appels) do
			table.insert(AmbulanceMenu.Menu["appels"].b, {name = "Appels numéro ".. v.callid .. " - " .. formatTimeAmbulance(v.timeago) .. " - " .. ESX.Math.Round((CalculateTravelDistanceBetweenPoints(
				ESX.PlayerData.cache.coords.x,
				ESX.PlayerData.cache.coords.y,
				ESX.PlayerData.cache.coords.z,
				v.pos.x,
				v.pos.y,
				v.pos.z
		) / 1000)) .. " km", action = "Appels", numAppel = v.source, PosAppels = v.pos, slidemax = AppelsOption})
		  end
		OpenMenu("appels")
		end)
		return
	 end

	 if btn.action == "Appels" then
	  SetNewWaypoint(tonumber(btn.PosAppels.x), tonumber(btn.PosAppels.y))
	  TriggerServerEvent("ambulance:TakeCall", tonumber(btn.numAppel))
	  CloseMenu()
	 else

	 local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	 if closestPlayer ~= -1 and closestDistance <= 2.0 then
      if btn.action == "revive" then
	    TriggerEvent('ambulance:Revive', GetPlayerServerId(closestPlayer))
	  elseif btn.action == "small_bless" then
		TriggerServerEvent('ambulance:healsmall', GetPlayerServerId(closestPlayer))
	  elseif btn.action == "big_bless" then
		TriggerServerEvent('ambulance:healbig', GetPlayerServerId(closestPlayer))
	  elseif btn.action == "invehicle" then
		TriggerServerEvent('ambulance:ZiZouVehicle', GetPlayerServerId(closestPlayer))
	  end
	 else
	   ESX.ShowNotification("Personne à proximité.")
	 end
	end
    end
  },

  Menu = {
    ["ambulance"] = {
      b = {
		{name = "Réanimer", action = "revive", ask = "→", askX = true},
		{name = "Soigner blessure légère", action = "small_bless", ask = "→", askX = true},
		{name = "Soigner grosse blessure", action = "big_bless", ask = "→", askX = true},
		{name = "Voir les appels en attente", action = "appels", ask = "→", askX = true}
      }
	},
	["appels"] = {
      b = {}
    },
  }
}

CreateMenu(AmbulanceMenu)
end