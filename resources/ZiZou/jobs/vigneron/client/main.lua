local AlreadyMarkerVigne = false
local AlreadyStartVigne = false
local DataActionVigne = nil

local Zones = {
	RaisinFarm = {
		Pos   = vector3(-1809.6, 2210.1, 90.6),
		Name  = "Récolte de raisin",
		Type  = 1,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour recolter du raisin."
	},

  -- TraitementRaisin = {
	-- 	Pos   = vector3(-3.826, 3.157, 70.0),
	-- 	Name  = "Traitement du raisin",
	-- 	Type  = 1,
	-- 	Text = 'Appuyez sur ~INPUT_CONTEXT~ pour traiter le raisin.'
	-- },
	
	-- SellFarm = {
	-- 	Pos   = vector3(275.0, 6.7, 78.2),
	-- 	Name  = "Vente des produits",
	-- 	Type  = 1,
	-- 	Text = "Appuyez sur ~INPUT_CONTEXT~ pour vendre."
	-- },

	VigneronActions = {
		Pos   = vector3(-1912.3, 2072.8, 139.3),
		Name  = "Point d'action",
		Type  = 0,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu."
	 },
	  
	VehicleSpawner = {
		Pos  = vector3(-1889.6, 2050.0, 139.9),
		Name  = "Garage véhicule",
		Type  = 0,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule."
	},

	VehicleSpawnPoint = {
		Pos   = vector3(-1903.9, 2058.3, 139.7),
		Name  = "Spawn point",
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = vector3(-1913.5, 2030.5, 139.7),
		Name  = "Ranger son véhicule",
		Type  = 0,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule."
	}
}

function OpenVigneActionsMenu()
  VigneMenu = {
    Base = { Title = "Vigneron", HeaderColor = {116, 50, 140} },
    Data = { currentMenu = "vigne" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "coffre" then
        CloseMenu()
        TriggerEvent("coffre:OpenMenu", 1)

      elseif btn.action == "cloakroom" then
        OpenMenu("vestiaire")

      elseif btn.action == "work" then
        TriggerServerEvent("player:serviceOn")
        ESX.TriggerServerCallback("skin:getPlayerSkin", function(skin, jobSkin)
        if skin.sex == 0 then
          TriggerEvent("loadClothes", skin, jobSkin.skin_male)
        else
          TriggerEvent("loadClothes", skin, jobSkin.skin_female)
        end
        end)
        CloseMenu()

      elseif btn.action == "civil" then
        TriggerServerEvent("player:serviceOff")
        ESX.TriggerServerCallback("skin:getPlayerSkin", function(skin, jobSkin)
        local model = nil

        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(100)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent("loadSkin", skin)
        TriggerEvent("esx:restoreLoadout")
        end)
        CloseMenu()

      elseif btn.action == "boss" then
        CloseMenu()
        OpenBossMenu("vigneron", 1)
      end

    end
  },

  Menu = {
    ["vigne"] = {
      b = {
        {name = "Vestiaire vigneron", action = "cloakroom", ask = "→", askX = true},
        {name = "Coffre entreprise", action = "coffre", ask = "→", askX = true},
      }
    },
    ["vestiaire"] = {
      b = {
        {name = "Tenue civil", action = "civil", ask = "→", askX = true},
        {name = "Tenue de travail", action = "work", ask = "→", askX = true},
      }
    },
  }
}

if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == "boss" then
  table.insert(VigneMenu.Menu["vigne"].b, {name = "Menu patrons", action = "boss"})
end

CreateMenu(VigneMenu)
end

function OpenVehicleSpawnerMenuVigne()
  VigneMenuVehicle = {
    Base = { Title = "Vehicule vigneron", HeaderColor = {116, 50, 140} },
    Data = { currentMenu = "vigneron" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "spawnveh" then
        ESX.Game.SpawnVehicle(btn.vehname, Zones.VehicleSpawnPoint.Pos, Zones.VehicleSpawnPoint.Heading, function(vehicle)
        local playerPed = ESX.PlayerData.cache.playerped
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
        local plate = "VIG "..math.random(100, 900)
        SetVehicleNumberPlateText(vehicle, plate)
        TriggerServerEvent("vehiclelock:keyjob", plate)
        CloseMenu()
        end, "job")
      end
    end
  },

  Menu = {
    ["vigneron"] = {
      b = {
        {name = "Vehicule de travail", action = "spawnveh", vehname = "bison3", ask = "→", askX = true},
      }
    },
  }
}

CreateMenu(VigneMenuVehicle)
end

function StartVigneronJob()
  if AlreadyStartVigne then
    return
  end
  AlreadyStartVigne = true
  Citizen.CreateThread(function()
  while ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "vigneron" do
    Citizen.Wait(5)

    local pedCoords = ESX.PlayerData.cache.coords
    local isInMarkerVigne = false
    local letSleepVigne = true

    for k,v in pairs(Zones) do
      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 25) and v.Type ~= -1 then
        letSleepVigne = false
        DrawMarker(1, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 116, 50, 140, 100, false, true, 2, false, false, false, false)
      end

      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 2) then
        isInMarkerVigne = true
        AlreadyMarkerVigne = true
        if DataActionVigne == nil then
            if v.Text then
                ESX.ShowHelpNotification(v.Text)
            end
        end

        if (IsControlJustReleased(1, 38)) and DataActionVigne == nil then
          if k == "VigneronActions" then
            DataActionVigne = k
            OpenVigneActionsMenu()

          elseif k == "RaisinFarm" then
            if not AntiSpamJobs then
              if CheckInService() then
                TriggerEvent("jobs:AntiSpam")
                DataActionVigne = k
                TriggerServerEvent("vigneron:startHarvest", k)
              end
            end

          elseif k == "TraitementRaisin" then
            if not AntiSpamJobs then
              if CheckInService() then
                TriggerEvent("jobs:AntiSpam")
                DataActionVigne = k
                TriggerServerEvent("vigneron:startTransform", k)
              end
            end

          elseif k == "SellFarm" then
            if not AntiSpamJobs then
              if CheckInService() then
                TriggerEvent("jobs:AntiSpam")
                DataActionVigne = k
                TriggerServerEvent("vigneron:startSell", k)
              end
            end

          elseif k == "VehicleSpawner" then
            if CheckInService() then
            DataActionVigne = k
            OpenVehicleSpawnerMenuVigne()
            end

          elseif k == "VehicleDeleter" then
            local playerPed = ESX.PlayerData.cache.playerped
            local coords = GetEntityCoords(playerPed)
            if IsPedInAnyVehicle(playerPed,  false) then
              local vehicle, distance = ESX.Game.GetClosestVehicle({
                x = coords.x,
                y = coords.y,
                z = coords.z
              })

              if distance ~= -1 and distance <= 1.0 then
                ESX.Game.DeleteVehicle(vehicle)
              end
            end

          end
        end
      end
    end

    if not isInMarkerVigne and AlreadyMarkerVigne then
      AlreadyMarkerVigne = false
      if DataActionVigne ~= nil and DataActionVigne == "VigneronActions" then
        DataActionVigne = nil
        CloseMenu()

      elseif DataActionVigne ~= nil and DataActionVigne == "RaisinFarm" then
        DataActionVigne = nil
        TriggerServerEvent("vigneron:stopHarvest")

      elseif DataActionVigne ~= nil and DataActionVigne == "TraitementRaisin" then
        DataActionVigne = nil
        TriggerServerEvent("vigneron:stopTransform")

      elseif DataActionVigne ~= nil and DataActionVigne == "SellFarm" then
        DataActionVigne = nil
        TriggerServerEvent("vigneron:stopSell")

      elseif DataActionVigne ~= nil and DataActionVigne == "VehicleSpawner" then
        DataActionVigne = nil
        CloseMenu()
      end
    end

    if letSleepVigne then
      Citizen.Wait(2500)
    end

  end
  AlreadyStartVigne = false
  end)
end

