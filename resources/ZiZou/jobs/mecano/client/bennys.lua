local AlreadyMarkerBennys = false
local DataActionBennys = nil



local Zones = {

	BennysActions = {
	  Pos   = vector3(-206.7, -1341.7, 33.8),
	  Size  = { x = 1.5, y = 1.5, z = 1.0 },
	  Color = { r = 204, g = 204, b = 0 },
	  Type  = 1,
	  Text = 'Appuyez sur ~INPUT_CONTEXT~ pour acceder au menu.'
	},

}


  
function OpenBennysActionsMenu()
	BennysActionsMenu = {
		Base = { Title = "Benny's", HeaderColor = {132, 203, 250} },
		Data = { currentMenu = "bennys" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		  if btn.action == 'coffre' then
			CloseMenu()
			Wait(100)
			TriggerEvent("coffre:OpenMenu", 1)
		elseif btn.action == 'boss' then
			CloseMenu()
			Wait(100)
			OpenBossMenu('bennys', 1)
		  end
		end
	  },
	
	  Menu = {
		["bennys"] = {
		  b = {
			{name = "Coffre", action = "coffre", ask = "→", askX = true}
		  }
		},
	  }
	}

	if ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(BennysActionsMenu.Menu["bennys"].b, {name = 'Menu patrons', action = 'boss', ask = "→", askX = true})
	end
	
	CreateMenu(BennysActionsMenu)
end

local AlreadyStartBennys = false

function StartBennysJob()
  if AlreadyStartBennys then
    return
  end
  AlreadyStartBennys = true
  Citizen.CreateThread(function()
  while ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bennys' do
    Citizen.Wait(5)

    local pedCoords = ESX.PlayerData.cache.coords
    local isInMarkerBennys = false
    local letSleepBennys = true

    for k,v in pairs(Zones) do
      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 10) and v.Type ~= -1 then
        letSleepBennys = false
        DrawMarker(1, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 111, 13, 190, 100, false, true, 2, false, false, false, false)
      end

      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 2) then
        isInMarkerBennys = true
        AlreadyMarkerBennys = true
        if DataActionBennys == nil then
          ESX.ShowHelpNotification(v.Text)
        end

        if (IsControlJustReleased(1, 38)) and DataActionBennys == nil then
          if k == 'BennysActions' then
            
            OpenBennysActionsMenu()
          end
        end
      end
    end

    if not isInMarkerBennys and AlreadyMarkerBennys then
      AlreadyMarkerBennys = false
      if DataActionBennys ~= nil and DataActionBennys == 'BennysActions' then
        
        DataActionBennys = nil
        CloseMenu()
      end
    end

    if letSleepBennys then
      Citizen.Wait(2500)
    end

  end
  AlreadyStartBennys = false
  end)
end

function OpenBennysMenu()
	MechanicMenu = {
		Base = { Title = "Benny's", HeaderColor = {132, 203, 250} },
		Data = { currentMenu = "bennys" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		  if btn.action == "billing" then
		  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  if closestPlayer ~= -1 and closestDistance <= 2.0 then
		   local montant = KeyboardInput("ESX_TIME", 'Montant de la facture', "", 6)
		   if montant ~= nil and tonumber(montant) >= 1 and tonumber(montant) <= 5000000 then
			TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'bennys', 'Facture: Bennys', tonumber(montant), true)
		end
		  end
		  elseif btn.action == "repare" then
			TriggerEvent('Repair')
		  elseif btn.action == "clean" then
			TriggerEvent('Clean')
		  elseif btn.action == "impound" then
			TriggerEvent('Impound')
		  end  
		end
	  },
	
	  Menu = {
		["bennys"] = {
		  b = {
			{name = "Faire une facture", action = "billing", ask = "→", askX = true},
			{name = "Reparer vehicule", action = "repare", ask = "→", askX = true},
			{name = "Nettoyer vehicule", action = "clean", ask = "→", askX = true},
			{name = "Mettre vehicule en fourriere", action = "impound", ask = "→", askX = true}
		  }
		},
	  }
	}
	
	CreateMenu(MechanicMenu)
	end

RegisterNetEvent('Impound')
AddEventHandler('Impound', function()
	local playerPed = ESX.PlayerData.cache.playerped

		if IsPedSittingInAnyVehicle(playerPed) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				ESX.ShowNotification('Vehicule ~r~mis en fourrière.~s~')
				ESX.Game.DeleteVehicle(vehicle)
			else
				ESX.ShowNotification('Vous devez être assis du ~r~côté conducteur!~s~')
			end
		else
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				ESX.ShowNotification('Vehicule ~r~mis en fourrière.~s~')
				ESX.Game.DeleteVehicle(vehicle)
			else
				ESX.ShowNotification('Vous devez être ~r~près d\'un véhicule~s~ pour le mettre en fourrière')
			end
		end
end)

RegisterNetEvent('Repair')
AddEventHandler('Repair', function()
	local playerPed = ESX.PlayerData.cache.playerped
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
		Citizen.CreateThread(function()
			Citizen.Wait(20000)

			SetVehicleDirtLevel(vehicle, 0.0)
			SetVehicleFixed(vehicle)
			SetVehicleDeformationFixed(vehicle)
			SetVehicleUndriveable(vehicle, false)
			SetVehicleEngineOn(vehicle, true, true)
			ClearPedTasksImmediately(playerPed)

			ESX.ShowNotification('Véhicule ~g~réparé~s~')
			isBusy = false
		end)
	end
end)

RegisterNetEvent('Clean')
AddEventHandler('Clean', function()
	local playerPed = ESX.PlayerData.cache.playerped
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		Citizen.CreateThread(function()
			Citizen.Wait(10000)

			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(playerPed)

			ESX.ShowNotification('Véhicule ~g~néttoyé~s~')
			isBusy = false
		end)
	else
		ESX.ShowNotification('Aucun véhicule à proximité.')
	end
end)

