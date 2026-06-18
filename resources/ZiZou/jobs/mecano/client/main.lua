local isNearMechanic = false
local nearMechanic = nil
local isMechanic = false
local AleardyStartedMechanics = false
local AleardyStartedNearMechanic = false
local MechanicsMenuOpen = ""

local BlipsData = {
    ["cosmetics"] = {
        sprite = 72,
        scale = 0.5,
        color = 4,
        display = 4,
        asShortRange = true
    },
    ["upgrades"] = {
        sprite = 446,
        scale = 0.5,
        color = 5,
        display = 4,
        asShortRange = true
    }
}

local MarkersData = {}



function StartMechanics()
    while not ESX.PlayerData.PassJoin do
        Wait(5)
    end
    if AleardyStartedMechanics then 
        return
    end
    isMechanic = true
    AleardyStartedMechanics = true
    Citizen.CreateThread(function()
        while isMechanic do
            if Mechanics[ESX.PlayerData.job.name] then
				for key, value in pairs(Mechanics[ESX.PlayerData.job.name].zones) do 
					if #(ESX.PlayerData.cache.coords - value) < 10 then
						isNearMechanic = true
						nearMechanic = Mechanics[ESX.PlayerData.job.name]
						Found = true
					end
				end
            else
                isMechanic = false
                isNearMechanic = false
                nearMechanic = nil
                break
            end
            if isNearMechanic and not AleardyStartedNearMechanic then
                StartNearMechanic()
            end
            Wait(2500)
        end
        isMechanic = false
        isNearMechanic = false
        nearMechanic = nil
        AleardyStartedMechanics = false
    end)
end

function StartNearMechanic()
    if AleardyStartedNearMechanic then
        return
    end
    AleardyStartedNearMechanic = true
    Citizen.CreateThread(function()
        while isNearMechanic do
            if Mechanics[ESX.PlayerData.job.name] then
				for key, value in pairs(Mechanics[ESX.PlayerData.job.name].zones) do 
					if key ~= "lscustom" then
                        DrawMarker(1, value, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 30, 30, 30, 200, false, true, 2, false, false, false, false)
					end
                if #(ESX.PlayerData.cache.coords - value) < 2 and MechanicsMenuOpen == "" then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acceder au menu.")
                    if IsControlJustReleased(1, 38) then  
						if key == "actions" then      
							MechanicsMenuOpen = "actions"              
                            OpenMechanicsActionsMenu()
						elseif key == "lscustom" then
							MechanicsMenuOpen = "lscustom"
							OpenLSCustomMenu(Mechanics[ESX.PlayerData.job.name].type)
						end
                    end
                elseif #(ESX.PlayerData.cache.coords - value) >= 2 and MechanicsMenuOpen == key then
                    MechanicsMenuOpen = ""
                    CloseMenu()
                end
			    end
            end
            Wait(5)
        end
        AleardyStartedNearMechanic = false
    end)
end

function OpenMechanicsActionsMenu()
	MechanicsActionsMenu = {
		Base = { Title = "Mecano", HeaderColor = {132, 203, 250} },
		Data = { currentMenu = "mechanics" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		  if btn.action == 'coffre' then
			CloseMenu()
			Wait(100)
			TriggerEvent("coffre:OpenMenu", 1)
		elseif btn.action == 'boss' then
			CloseMenu()
			Wait(100)
			OpenBossMenu(ESX.PlayerData.job.name, 1)
		  end
		end,
        onExited = function()
            MechanicsMenuOpen = ""
        end
	  },
	
	  Menu = {
		["mechanics"] = {
		  b = {
			{name = "Coffre", action = "coffre", ask = "→", askX = true}
		  }
		},
	  }
	}

	if ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(MechanicsActionsMenu.Menu["mechanics"].b, {name = 'Menu patrons', action = 'boss', ask = "→", askX = true})
	end
	
	CreateMenu(MechanicsActionsMenu)
end

function OpenMechanicsMenu()
	MechanicMenu = {
		Base = { Title = "Mecano", HeaderColor = {132, 203, 250} },
		Data = { currentMenu = "mechanics" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		  if btn.action == "billing" then
		  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  if closestPlayer ~= -1 and closestDistance <= 2.0 then
		   local montant = KeyboardInput("ESX_TIME", 'Montant de la facture', "", 6)
		   if montant ~= nil and tonumber(montant) >= 1 and tonumber(montant) <= 5000000 then
			TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name, 'Facture: ' .. Mechanics[ESX.PlayerData.job.name].label, tonumber(montant), true)
		end
		  end
		  elseif btn.action == "repare" then
			TriggerEvent('Repair')
		  elseif btn.action == "clean" then
			TriggerEvent('Clean')
		  end  
		end
	  },
	
	  Menu = {
		["mechanics"] = {
		  b = {
			{name = "Faire une facture", action = "billing", ask = "→", askX = true},
			{name = "Reparer vehicule", action = "repare", ask = "→", askX = true},
			{name = "Nettoyer vehicule", action = "clean", ask = "→", askX = true}
		  }
		},
	  }
	}
	
	CreateMenu(MechanicMenu)
end

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
