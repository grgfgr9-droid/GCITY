local AlreadyMarkerBurger = false
local DataActionBurger = nil
local AutoBurger = true
local AntiSpamBurger = false


local Zones = {

    Farm = {
    Pos = vector3(343.36, -893.91, 28.34),
    Size  = {x = 2.0, y = 2.0, z = 2.0},
    Color = {r = 136, g = 243, b = 216},
    Name  = "Frigo",
    Type  = 1,
    Text = "Appuyez sur ~INPUT_CONTEXT~ pour acceder au frigo."
	  },
	
	  AutoBurger = {
    Pos =   vector3(-1194.06, -892.41, 12.89) ,
    Size  = {x = 4.0, y = 4.0, z = 1.0},
    Color = {r = 255, g = 0, b = 0},
    Name  = "AutoBurger",
    Type  = 1,
    Text = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu."
    },

    BossActions = {
    Pos =  vector3(196.55, 366.44, 106.18),
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 136, g = 243, b = 216},
    Name  = "Menu patrons",
    Type  = 1,
    Text = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu."
    },

    VehicleSpawner = {
    Pos  = vector3(341.0, -869.09, 29.30),
    Size = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 136, g = 243, b = 216},
    Name  = "Garage véhicule",
    Type  = 1,
    Text = "Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule."
	  },

    VehicleSpawnPoint = {
    Pos   = vector3(-1177.1, -881.9, 12.9),
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 136, g = 243, b = 216},
    Name  = "Spawn point",
    Type  = -1
    },

    VehicleDeleter = {
    Pos   = vector3(-1168.9, -895.9, 12.9),
    Size  = {x = 3.0, y = 3.0, z = 1.0},
    Color = {r = 136, g = 243, b = 216},
    Name  = "Ranger son véhicule",
    Type  = 0,
    Text = "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule."
    } 
}

function OpenKFCActionsMenu()
  KfcMenu = {
    Base = { Title = "KFC", HeaderColor = {199, 155, 80} },
    Data = { currentMenu = "kintaki" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "coffre" then
        
        CloseMenu()
        Citizen.Wait(500)
        TriggerEvent("coffre:OpenMenu", 1)

      elseif btn.action == "cloakroom" then
        OpenMenu("vestiaire")

      elseif btn.action == "work" then
        TriggerServerEvent("player:serviceOn")
        CloseMenu()

      elseif btn.action == "civil" then
        TriggerServerEvent("player:serviceOff")
        CloseMenu()

      elseif btn.action == "boss" then
        CloseMenu()
        OpenBossMenu("kintaki", 1)
      end

    end
  },

  Menu = {
    ["kintaki"] = {
      b = {
        {name = "Vestiaire KFC", action = "cloakroom", ask = "→", askX = true},
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
  table.insert(KfcMenu.Menu["kintaki"].b, {name = "Menu patrons", action = "boss"})
end

CreateMenu(KfcMenu)
end

function OpenVehicleSpawnerMenuKFC()
  KfcMenuVehicle = {
    Base = { Title = "Vehicule kfc", HeaderColor = {199, 155, 80} },
    Data = { currentMenu = "kintaki" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "spawnveh" then
        ESX.Game.SpawnVehicle(model, Zones.VehicleSpawnPoint.Pos, Zones.VehicleSpawnPoint.Heading, function(vehicle)
        local playerPed = ESX.PlayerData.cache.playerped
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
        local plate = "KFC" ..math.random(100, 900)
        plate = string.gsub(plate, " ", "")
        SetVehicleNumberPlateText(vehicle, plate)
        TriggerServerEvent("vehiclelock:preterkey", plate)
        CloseMenu()
        end, "job")
      end
    end
  },

  Menu = {
    ["kintaki"] = {
      b = {
        {name = "KFC", action = "spawnveh", vehname = "stalion2", ask = "→", askX = true},
      }
    },
  }
}

CreateMenu(KfcMenuVehicle)
end

function OpenKFCMenu()
  KfcMenu = {
    Base = { Title = "KFC", HeaderColor = {199, 155, 80} },
    Data = { currentMenu = "kintaki" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "billing" then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 2.0 then
          local montant = KeyboardInput("ESX_BILLING", "Montant de la facture", "", 4)
          if montant ~= nil and tonumber(montant) >= 1 and tonumber(montant) <= 10000 then
            TriggerServerEvent("billing:sendBill", GetPlayerServerId(closestPlayer), "kintaki", "Facture: KFC", tonumber(montant), true)
          end
        else
          ESX.ShowNotification("Aucun joueur à proximité.")
        end
      end
    end
  },

  Menu = {
    ["kintaki"] = {
      b = {
        {name = "Faire une facture", action = "billing", ask = "→", askX = true},
      }
    },
  }
}

CreateMenu(KfcMenu)
end

function OpenFrigoMenuBurger()
BurgerMenuFrigo = {
    Base = { Title = "Frigo Kintanki", HeaderColor = {199, 155, 80} },
    Data = { currentMenu = "kintaki" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)

      if AntiSpamBurger then
        return
      else
        AntiSpamBurger = true
        Citizen.SetTimeout(1000, function()
        AntiSpamBurger = false
        end)
      end

      if btn.action == "buy" then
        if ESX.PlayerData.job.name == "kintaki" then
          TriggerServerEvent("kfc:giveEmployes", btn.itemname)
        else
          TriggerServerEvent("kfc:giveEat", btn.itemname)
        end
      end
    end
  },

  Menu = {
    ["kintaki"] = {
      b = {
        {name = "Burger ~g~10$~s~", action = "buy", itemname = "burger", ask = "→", askX = true},
        {name = "Sandwich poulet ~g~5$~s~", action = "buy", itemname = "sandwich", ask = "→", askX = true},
        {name = "Powerade ~g~10$~s~", action = "buy", itemname = "powerade", ask = "→", askX = true},
        {name = "Fanta ~g~5$~s~", action = "buy", itemname = "fanta", ask = "→", askX = true},
        {name = "Eau ~g~5$~s~", action = "buy", itemname = "water", ask = "→", askX = true},
      }
    },
  }

}

CreateMenu(BurgerMenuFrigo)
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  local pedCoords = ESX.PlayerData.cache.coords
  local isInMarkerBurger = false
  local letSleepBurger = true
  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "kintaki" and AutoBurger == false then
    for k,v in pairs(Zones) do
      if AlreadyMarkerBurger or (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 10) and v.Type ~= -1 and v.Name ~= "AutoBurger" then
        letSleepBurger = false
        DrawMarker(1, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 4.0, 4.0, 1.0, 199, 155, 80, 100, false, true, 2, false, false, false, false)
      end

      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 2) then
        isInMarkerBurger = true
        AlreadyMarkerBurger = true
        if DataActionBurger == nil then
          ESX.ShowHelpNotification(v.Text)
        end

        if (IsControlJustPressed(1, 38)) and DataActionBurger == nil then
          if k == "BossActions" then
            
            DataActionBurger = k
            OpenKFCActionsMenu()

          elseif k == "Farm" then
            DataActionBurger = k
            OpenFrigoMenuBurger()

          elseif k == "VehicleSpawner" then
            DataActionBurger = k
            OpenVehicleSpawnerMenuBurger()

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

    if not isInMarkerBurger and AlreadyMarkerBurger then
      AlreadyMarkerBurger = false
      if DataActionBurger ~= nil and DataActionBurger == "BossActions" then
        DataActionBurger = nil
        
        CloseMenu()

      elseif DataActionBurger ~= nil and DataActionBurger == "Farm" then
        DataActionBurger = nil
        
        CloseMenu()

      elseif DataActionBurger ~= nil and DataActionBurger == "Cloakrooms" then
        DataActionBurger = nil
        
        CloseMenu()

      elseif DataActionBurger ~= nil and DataActionBurger == "VehicleSpawner" then
        DataActionBurger = nil
        
        CloseMenu()
      end
    end

  elseif AutoBurger == true then
    
    for k,v in pairs(Zones) do
      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 10) and k == "AutoBurger" then
        letSleepBurger = false
        DrawMarker(1, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 4.0, 4.0, 1.0, 185, 50, 50, 100, false, true, 2, false, false, false, false)
      end

      if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 2) and k == "AutoBurger" then
        isInMarkerBurger = true
        AlreadyMarkerBurger = true
        if DataActionBurger == nil then
          ESX.ShowHelpNotification(v.Text)
        end

        if (IsControlJustPressed(1, 38)) and DataActionBurger == nil and k == "AutoBurger" then
          if k == "AutoBurger" then
            
            DataActionBurger = k
            OpenFrigoMenuBurger()
          end

        end
      end
    end
  end

  if not isInMarkerBurger and AlreadyMarkerBurger then
    AlreadyMarkerBurger = false
    if DataActionBurger ~= nil and DataActionBurger == "AutoBurger" then
      DataActionBurger = nil
      
      CloseMenu()
    end
  end

  if letSleepBurger then
    Citizen.Wait(2500)
  end

end
end)

