local AlreadyMarkerTabac = false
local AlreadyStartTabac = false
local DataActionTabac = nil

local Zones = {
  TabacActions = {
  Pos   = vector3(2349.91, 3143.82, 47.30),
	Type  = 23,
	Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu." 
  },

  RecolteTabac = {
  Pos   = vector3(2348.8, 3141.46, 47.30),
	Name  = "Recolte du tabac",
	Type  = 1,
	Text = "Appuyez sur ~INPUT_CONTEXT~ pour récolter du tabac." 
  },

  TransformTabac = {
  Pos   = vector3(2353.97, 3139.07, 47.30),
	Name  = "Traitement du tabac",
	Type  = 1,
	Text = "Appuyez sur ~INPUT_CONTEXT~ pour traiter le tabac." 
  },

  VehicleSpawner = {
	Pos  = vector3(2327.9, 3141.36, 47.15),
	Name  = "Garage véhicule",
	Type  = 0,
	Text = "Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule."
	},

  VehicleDeleter = {
  Pos   = vector3(2365.87, 3122.69, 47.30),
	Type  = 0,
	Text = "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule." 
  },

  SellMalbora = {
  Pos   = vector3(2340.65, 3125.93, 47.30),
  Name  = "Vente des malboras",
	Type  = 1,
	Text = "Appuyez sur ~INPUT_CONTEXT~ pour vendre." 
  },
}

function OpenTabacActionsMenu()
  TabacMenu = {
    Base = { Title = "Tabac", HeaderColor = {130, 109, 68} },
    Data = { currentMenu = "tabac" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "coffre" then
        CloseMenu()
        TriggerEvent("coffre:OpenMenu", 1)

      elseif btn.action == "cloakroom" then
        OpenMenu("vestiaire")

      elseif btn.action == "work" then
        TriggerServerEvent("player:serviceOn")
        --[[ESX.TriggerServerCallback("skin:getPlayerSkin", function(skin, jobSkin)
        if skin.sex == 0 then
          TriggerEvent("loadClothes", skin, jobSkin.skin_male)
        else
          TriggerEvent("loadClothes", skin, jobSkin.skin_female)
        end
        end)]]
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
        OpenBossMenu("tabac", 1)
      end

    end
  },

  Menu = {
    ["tabac"] = {
      b = {
        {name = "Vestiaire tabac", action = "cloakroom", ask = "→", askX = true},
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
  table.insert(TabacMenu.Menu["tabac"].b, {name = "Menu patrons", action = "boss"})
end

CreateMenu(TabacMenu)
end

function OpenVehicleSpawnerMenuTabac()
  TabacMenuVehicle = {
    Base = { Title = "Vehicule tabac", HeaderColor = {130, 109, 68}},
    Data = { currentMenu = "tabac" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "spawnveh" then
        ESX.Game.SpawnVehicle(btn.vehname, Zones.VehicleSpawner.Pos, 0, function(vehicle)
        local playerPed = ESX.PlayerData.cache.playerped
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
        local plate = "TABA "..math.random(100, 900)
        SetVehicleNumberPlateText(vehicle, plate)
        TriggerServerEvent("vehiclelock:keyjob", plate)
        CloseMenu()
        end, "job")
      end
    end
  },

  Menu = {
    ["tabac"] = {
      b = {
        {name = "Vehicule de travail", action = "spawnveh", vehname = "gburrito", ask = "→", askX = true},
      }
    },
  }
}

CreateMenu(TabacMenuVehicle)
end


function StartTabacJob()
  if AlreadyStartTabac then
    return
  end
  AlreadyStartTabac = true
  Citizen.CreateThread(function()
  while ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "tabac" do
    Citizen.Wait(5)

    local pedCoords = ESX.PlayerData.cache.coords
    local isInMarkerTabac = false
    local letSleepTabac = true

    for k,v in pairs(Zones) do
      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 15) and v.Type ~= -1 then
        letSleepTabac = false
        DrawMarker(1, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 130, 109, 68, 100, false, true, 2, false, false, false, false)
      end

      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 2) then
        isInMarkerTabac = true
        AlreadyMarkerTabac = true
        if DataActionTabac == nil then
          if v.Text then
          ESX.ShowHelpNotification(v.Text)
          end
        end

        if (IsControlJustReleased(1, 38)) and DataActionTabac == nil then
          if k == "TabacActions" then
            DataActionTabac = k
            OpenTabacActionsMenu()

          elseif k == "RecolteTabac" then
            if not AntiSpamJobs then
              --if CheckInService() then
              TriggerEvent("jobs:AntiSpam")
              DataActionTabac = k
              TriggerServerEvent("tabac:startHarvest")
              --end
            end

          elseif k == "TransformTabac" then
            if not AntiSpamJobs then
             -- if CheckInService() then
              TriggerEvent("jobs:AntiSpam")
              DataActionTabac = k
              TriggerServerEvent("tabac:startTransform")
              --end
            end

          elseif k == "SellMalbora" then
            if not AntiSpamJobs then
             -- if CheckInService() then
              TriggerEvent("jobs:AntiSpam")
              DataActionTabac = k
              TriggerServerEvent("tabac:startSell")
             -- end
            end
          
          elseif k == "VehicleSpawner" then
           -- if CheckInService() then
            DataActionTabac = k
            OpenVehicleSpawnerMenuTabac()
          --  end

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

    if not isInMarkerTabac and AlreadyMarkerTabac then
      AlreadyMarkerTabac = false
      if DataActionTabac ~= nil and DataActionTabac == "TabacActions" then
        DataActionTabac = nil
        CloseMenu()

      elseif DataActionTabac ~= nil and DataActionTabac == "RecolteTabac" then
        DataActionTabac = nil
        TriggerServerEvent("tabac:stopHarvest")

      elseif DataActionTabac ~= nil and DataActionTabac == "TransformTabac" then
        DataActionTabac = nil
        TriggerServerEvent("tabac:stopTransform")

      elseif DataActionTabac ~= nil and DataActionTabac == "SellMalbora" then
        DataActionTabac = nil
        TriggerServerEvent("tabac:stopSell")

      elseif DataActionTabac ~= nil and DataActionTabac == "VehicleSpawner" then
        DataActionTabac = nil
        CloseMenu()
      end
    end

    if letSleepTabac then
      Citizen.Wait(2500)
    end

  end
  AlreadyStartTabac = false
  end)
end



RegisterNetEvent("tabac:onSmokeCig")
AddEventHandler("tabac:onSmokeCig", function()
  TaskStartScenarioInPlace(ESX.PlayerData.cache.playerped, "WORLD_HUMAN_SMOKING", 0, 1)
end)