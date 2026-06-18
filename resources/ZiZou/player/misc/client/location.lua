local menuOpenLocation = false
local HasAlreadyEnteredMarkerLocation = false
local AlreadyLocvehicles = {}
local pricecolor = "~g~"
local ActuallyStartedFloatLocation = false
local LastVehicles            = {}


-- TODO : Rank implementation

local locations = {
    ["spawn"] = {
      point =   vector3(-555.01, -645.85, 32.23),
      spawnheading = 186,
      Vehicles = {
        {name = "Faggio ~g~1000$", spawnname = "faggio", prix = 1000, action = "spawn", vip = false},
        {name = "Panto ~g~1500$", spawnname = "panto", prix = 1500, action = "spawn", vip = false}        
      }
    },
    ["plane"] = {
      point = vector3(-983.9, -3001.2, 12.9),
      spawnheading = 150,
      Vehicles = {
        {name = "Dodo ~g~5000$", spawnname = "dodo", prix = 5000, action = "spawn", vip = false},
        {name = "Velum ~g~6000$", spawnname = "velum2", prix = 6000, action = "spawn", vip = false},
        {name = "Nimbus ~g~7500$", spawnname = "nimbus", prix = 7500, action = "spawn", vip = false},
        {name = "Luxor ~g~10000$", spawnname = "luxor", prix = 10000, action = "spawn", vip = false}      
      }
    },
    ["helico"] = {
      point = vector3(-735.0, -1455.9, 4.0),
      spawnheading = 150,
      Vehicles = {
        {name = "buzzard ~g~5000$", spawnname = "buzzard2", prix = 5000, action = "spawn", vip = false},
      }
    },
    --[[["boat"] = {
      point = vector3(-1631.1, -1149.1, 0.3),
      spawnheading = 150,
      Vehicles = {
        {name = "Faggio ~g~500$", spawnname = "faggio", prix = 500, action = "spawn", vip = false},
        {name = "Panto ~g~1000$", spawnname = "panto", prix = 1000, action = "spawn", vip = false}        
      }
    },]]
  ["bicycles1"] = {
      point = vector3(292.229, -193.093, 60.570),
      spawnheading = 0,
      Vehicles = {
        {name = "Bmx ~g~200$", spawnname = "bmx", prix = 200, action = "spawn", vip = false},
        {name = "Scorcher ~g~500$", spawnname = "scorcher", prix = 500, action = "spawn", vip = false},
        {name = "Velo Trial ~g~750$", spawnname = "tribike3", prix = 750, action = "spawn", vip = false}        
      }
  }, 
  ["bicycles2"] = {
      point = vector3(155.608, -998.386, 28.354),
      spawnheading = 0,
      Vehicles = {
        {name = "Bmx ~g~200$", spawnname = "bmx", prix = 200, action = "spawn", vip = false},
        {name = "Scorcher ~g~500$", spawnname = "scorcher", prix = 500, action = "spawn", vip = false},
        {name = "Velo Trial ~g~750$", spawnname = "tribike3", prix = 750, action = "spawn", vip = false}        
      }
  },
  ["bicycles3"] = {
      point = vector3(735.9658203125,-1203.9626464844,26.588882446289),
      spawnheading = 0,
      Vehicles = {
        {name = "Bmx ~g~200$", spawnname = "bmx", prix = 200, action = "spawn", vip = false},
        {name = "Scorcher ~g~500$", spawnname = "scorcher", prix = 500, action = "spawn", vip = false},
        {name = "Velo Trial ~g~750$", spawnname = "tribike3", prix = 750, action = "spawn", vip = false}        
      }
  },
  ["bicycles4"] = {
      point = vector3(-926.17504882812,-802.38226318359,14.920928955078),
      spawnheading = 0,
      Vehicles = {
        {name = "Bmx ~g~200$", spawnname = "bmx", prix = 200, action = "spawn", vip = false},
        {name = "Scorcher ~g~500$", spawnname = "scorcher", prix = 500, action = "spawn", vip = false},
        {name = "Velo Trial ~g~750$", spawnname = "tribike3", prix = 750, action = "spawn", vip = false}        
      }
  },
  ["bicycles5"] = {
      point = vector3(-1342.3837890625,-1412.5201416016,3.3134489059448),
      spawnheading = 0,
      Vehicles = {
        {name = "Bmx ~g~200$", spawnname = "bmx", prix = 200, action = "spawn", vip = false},
        {name = "Scorcher ~g~500$", spawnname = "scorcher", prix = 500, action = "spawn", vip = false},
        {name = "Velo Trial ~g~750$", spawnname = "tribike3", prix = 750, action = "spawn", vip = false}        
      }
  },
  ["bicycles6"] = {
      point = vector3(830.09985351562,-255.79614257812,64.845817565918),
      spawnheading = 0,
      Vehicles = {
        {name = "Bmx ~g~200$", spawnname = "bmx", prix = 200, action = "spawn", vip = false},
        {name = "Scorcher ~g~500$", spawnname = "scorcher", prix = 500, action = "spawn", vip = false},
        {name = "Velo Trial ~g~750$", spawnname = "tribike3", prix = 750, action = "spawn", vip = false}        
      }
  },
  ["bicycles7"] = {
      point = vector3(492.82116699219,5591.267578125,793.43695068359),
      spawnheading = 0,
      Vehicles = {
        {name = "Bmx ~g~200$", spawnname = "bmx", prix = 200, action = "spawn", vip = false},
        {name = "Scorcher ~g~500$", spawnname = "scorcher", prix = 500, action = "spawn", vip = false},
        {name = "Velo Trial ~g~750$", spawnname = "tribike3", prix = 750, action = "spawn", vip = false}        
      }
  }
}


Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5)
   
     local pedCoords = ESX.PlayerData.cache.coords
     local isInMarkerLocation = false
     local letSleepLocation = true
     for k,v in pairs(locations) do
        if (GetDistanceBetweenCoords(pedCoords, v.point.x, v.point.y, v.point.z, true) < 10) then
          letSleepLocation = false
            if not menuOpenLocation then
              DrawMarker(ZiZouConfig.Marker.Markers.Marker.type, v.point.x, v.point.y, v.point.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ZiZouConfig.Marker.Markers.Marker.x, ZiZouConfig.Marker.Markers.Marker.y, ZiZouConfig.Marker.Markers.Marker.z, ZiZouConfig.Marker.Markers.Marker.r, ZiZouConfig.Marker.Markers.Marker.g, ZiZouConfig.Marker.Markers.Marker.b, ZiZouConfig.Marker.Markers.Marker.a, ZiZouConfig.Marker.Markers.Marker.rotate, false, 2, false, nil, nil, false)
          --  DrawMarker(1, v.point.x, v.point.y, v.point.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 255, 255, 255, 155, false, true, 2, false, false, false, false)
            end
            if not ActuallyStartedFloatLocation then
                Citizen.CreateThread(function()
                    ActuallyStartedFloatLocation = true
                    while ActuallyStartedFloatLocation do
                        Wait(25)
                    end
                    ActuallyStartedFloatLocation = false
                end)
            end
            if (GetDistanceBetweenCoords(pedCoords, v.point.x, v.point.y, v.point.z, true) < 2) then
                isInMarkerLocation = true
                HasAlreadyEnteredMarkerLocation = true
                if not menuOpenLocation then
                  ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu de location.")
                end
                if IsControlJustPressed(1, 38) and not menuOpenLocation then
                  CloseMenu()
                  if k == "helico" or k == "plane" and ESX.PlayerData.time < 120 then ESX.ShowNotification("Vous ne pouve pas louer ce genre de véhicule pour l'instant, vous devez atteindre 2 heures de jeu") return end
                  openlocmenu(k)
                  menuOpenLocation = true
                end
              end
        else
            ActuallyStartedFloatLocation = false
        end
     end
   
     if not isInMarkerLocation and HasAlreadyEnteredMarkerLocation and not menuOpenLocation then
       HasAlreadyEnteredMarkerLocation = false
       CloseMenu()
     end
   
     if letSleepLocation then
       Citizen.Wait(2500)
     end
    end
end)



function openlocmenu(point)
  LocationMenu = {
    Base = { Title = "Location", HeaderColor = {57, 57, 57}},
    Data = { currentMenu = "accueil" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
        if btn.action == 'spawn' then
          if AlreadyLocvehicles[btn.spawnname] then ESX.ShowNotification('Vous avez déjà loué ce véhicule !', "error") return end
          ESX.TriggerServerCallback('location:CheckMoney', function(cb) 
            if cb then
                DeleteLocationPreviwVehicles()
              ESX.Game.SpawnVehicle(btn.spawnname, locations[point].point, locations[point].spawnheading, function(vehicle)
                TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, vehicle, -1)
                local plate = 'LOC ' .. math.random(100, 999) 
                SetVehicleNumberPlateText(vehicle, plate)
                AlreadyLocvehicles[btn.spawnname] = true
                CloseMenu()
              end, "location")
            else
              ESX.ShowNotification('Vous n\'avez pas assez d\'argent pour louer ce véhicule !', "error")
            end
          end, btn.prix)
        end
      end,
      onExited = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide)
        DeleteLocationPreviwVehicles()
        menuOpenLocation = false
      end,
      onButtonSelected = function(currentaMenu, k, j, btn, self)
        PreviewLocationVehicle(btn, locations[point].point)
      end
    }, 
    Menu = {
      ['accueil'] = {
        b = {
          
        }
      }
    }
  }

  LocationMenu.Menu['accueil'].b = locations[point].Vehicles

  CreateMenu(LocationMenu)
end

local BlipsData = {
  ["spawn"] = {
    sprite = 512,
    color = 55,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Spawn"
  },
  ["plane"] = {
    sprite = 307,
    color = 28,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Avions"
  },
  ["helico"] = {
    sprite = 43,
    color = 29,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Helicos"
  },
  ["boat"] = {
    sprite = 455,
    color = 18,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Bateaux"
  },
  ["bicycles1"] = {
    sprite = 127,
    color = 11,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Vélos"
  },
  ["bicycles2"] = {
    sprite = 127,
    color = 11,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Vélos"
  },
  ["bicycles3"] = {
    sprite = 127,
    color = 11,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Vélos"
  },
  ["bicycles4"] = {
    sprite = 127,
    color = 11,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Vélos"
  },
  ["bicycles5"] = {
    sprite = 127,
    color = 11,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Vélos"
  },
  ["bicycles6"] = {
    sprite = 127,
    color = 11,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Vélos"
  },
  ["bicycles7"] = {
    sprite = 127,
    color = 11,
    display = 4,
    scale = 0.5,
    setBlipAsShortRange = true,
    label = "Location Vélos"
  }
}

Citizen.CreateThread(function()
  for k,v in pairs(locations) do
   local blip = AddBlipForCoord(v.point.x, v.point.y, v.point.z)
   local blipdata = BlipsData[k]
   SetBlipSprite (blip, blipdata.sprite)
   SetBlipDisplay(blip, blipdata.display)
   SetBlipScale  (blip, blipdata.scale)
   SetBlipColour (blip, blipdata.color)
   SetBlipAsShortRange(blip, true)
 
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString(blipdata.label)
   EndTextCommandSetBlipName(blip)
  end
 end)

 function PreviewLocationVehicle(btn, zone)
      local playerPed   = ESX.PlayerData.cache.playerped
      if IsPedInAnyVehicle(playerPed,  false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        ESX.Game.DeleteVehicle(vehicle)
    end
      DeleteLocationPreviwVehicles()
      if not btn.spawnname then return end
      ESX.Game.SpawnLocalVehicle(btn.spawnname, {
        x = zone.x,
        y = zone.y,
        z = zone.z
      }, 100, function(vehicle)
        table.insert(LastVehicles, vehicle)
        SetEntityAlpha(vehicle, 150, false)
        SetEntityAlpha(ESX.PlayerData.cache.playerped, 150, false)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        FreezeEntityPosition(vehicle, true)
        SetVehicleUndriveable(vehicle, true)
      end)
end

function DeleteLocationPreviwVehicles()
    while #LastVehicles > 0 do
      local vehicle = LastVehicles[1]
      ESX.Game.DeleteVehicle(vehicle)
      table.remove(LastVehicles, 1)
    end
    SetEntityAlpha(ESX.PlayerData.cache.playerped, 255, false)
  end