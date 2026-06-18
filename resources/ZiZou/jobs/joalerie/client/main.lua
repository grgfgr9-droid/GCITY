local AlreadyMarkerJoal = false
local AlreadyStartJoal = false
local DataActionJoal = nil

local Zones = {
	JoalActions = {
		Pos   = vector3(228.1, 766.1, 203.7),
		Name  = "Point d'action",
		Type  = 0,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu."
	 },

	JewelFarm = {
		Pos   = vector3(-1023.8, 693.2, 160.2),
		Name  = "Récolte de bijoux",
		Type  = 1,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour recolter des bijoux."
	},
	
	SellFarm = {
		Pos   = vector3(-619.5, -228.9, 37.0),
		Name  = "Vente des bijoux",
		Type  = 1,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour vendre vos bijoux."
	},
	  
	VehicleSpawner = {
		Pos   = vector3(218.5, 756.8, 203.7),
		Name  = "Garage véhicule",
		Type  = 0,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule."
	},

	VehicleSpawnPoint = {
		Pos   = vector3(200.9, 781.9, 205.0),
		Name  = "Spawn point",
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = vector3(207.8, 767.7, 204.3),
		Name  = "Ranger son véhicule",
		Type  = 0,
		Text = "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule."
	}
}

function OpenJoalActionsMenu()
  JoalMenu = {
    Base = { Title = "Joalerie", HeaderColor = {130, 109, 68} },
    Data = { currentMenu = "joalerie" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "coffre" then
        CloseMenu()
        TriggerEvent("coffre:OpenMenu", 1)

      elseif btn.action == "cloakroom" then
        OpenMenu("vestiaire")

      elseif btn.action == "work" then
        TriggerServerEvent("player:serviceOn")
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
        OpenBossMenu("joal", 1)
      end

    end
  },

  Menu = {
    ["joalerie"] = {
      b = {
        {name = "Vestiaire Joalerie", action = "cloakroom", ask = "→", askX = true},
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
  table.insert(JoalMenu.Menu["joalerie"].b, {name = "Menu patrons", action = "boss"})
end

CreateMenu(JoalMenu)
end

function OpenVehicleSpawnerMenuJoal()
  JoalMenuVehicle = {
    Base = { Title = "Vehicule joalerie", HeaderColor = {130, 109, 68}},
    Data = { currentMenu = "joalerie" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "spawnveh" then
        ESX.Game.SpawnVehicle(btn.vehname, Zones.VehicleSpawner.Pos, 0, function(vehicle)
        local playerPed = ESX.PlayerData.cache.playerped
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
        local plate = "JOAL "..math.random(100, 900)
        SetVehicleNumberPlateText(vehicle, plate)
        TriggerServerEvent("vehiclelock:keyjob", plate)
        CloseMenu()
        end, "job")
      end
    end
  },

  Menu = {
    ["joalerie"] = {
      b = {
        {name = "Vehicule de travail", action = "spawnveh", vehname = "sandking", ask = "→", askX = true},
      }
    },
  }
}

CreateMenu(JoalMenuVehicle)
end


function StartJoalJob()
  if AlreadyStartJoal then
    return
  end
  AlreadyStartJoal = true
  Citizen.CreateThread(function()
  while ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "joal" do
    Citizen.Wait(5)

    local pedCoords = ESX.PlayerData.cache.coords
    local isInMarkerJoal = false
    local letSleepJoal = true

    for k,v in pairs(Zones) do
      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 15) and v.Type ~= -1 then
        letSleepJoal = false
        DrawMarker(1, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 209, 129, 219, 100, false, true, 2, false, false, false, false)
      end

      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 2) then
        isInMarkerJoal = true
        AlreadyMarkerJoal = true
        if DataActionJoal == nil then
          if v.Text then
          ESX.ShowHelpNotification(v.Text)
          end
        end

        if (IsControlJustReleased(1, 38)) and DataActionJoal == nil then
          if k == "JoalActions" then
            DataActionJoal = k
            OpenJoalActionsMenu()

          elseif k == "JewelFarm" then
            if not AntiSpamJobs then
              TriggerEvent("jobs:AntiSpam")
              DataActionJoal = k
              TriggerServerEvent("joal:startHarvest")
            end

          elseif k == "SellFarm" then
            if not AntiSpamJobs then
              TriggerEvent("jobs:AntiSpam")
              DataActionJoal = k
              TriggerServerEvent("joal:startSell")
            end
          
          elseif k == "VehicleSpawner" then
            DataActionJoal = k
            OpenVehicleSpawnerMenuJoal()

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

    if not isInMarkerJoal and AlreadyMarkerJoal then
      AlreadyMarkerJoal = false
      if DataActionJoal ~= nil and DataActionJoal == "JoalActions" then
        DataActionJoal = nil
        CloseMenu()

      elseif DataActionJoal ~= nil and DataActionJoal == "JewelFarm" then
        DataActionJoal = nil
        TriggerServerEvent("joal:stopHarvest")

      elseif DataActionJoal ~= nil and DataActionJoal == "SellFarm" then
        DataActionJoal = nil
        TriggerServerEvent("joal:stopSell")

      elseif DataActionJoal ~= nil and DataActionJoal == "VehicleSpawner" then
        DataActionJoal = nil
        CloseMenu()
      end
    end

    if letSleepJoal then
      Citizen.Wait(2500)
    end

  end
  AlreadyStartJoal = false
  end)
end

