local VehicleShopNearData = {near = false, key = "", zones = {}}
AleardyStartedNearVehicleShops = false
local VehicleShopsMenuOpen = false
local SelectedVehicleShopData = { player = nil, model = nil}
local IsInShopMenu = false
local LastVehicles            = {}
local CurrentVehicleData      = nil
local CurrentMenu = nil
local DisableAutoShop = {}

local BlipsData = {
    ["car"] = {
        sprite = 326,
        scale = 0.5,
        color = 0,
        display = 4,
        asShortRange = true
    },
    ["plane"] = {
        sprite = 307,
        scale = 0.5,
        color = 0,
        display = 4,
        asShortRange = true
    }
}

RegisterNetEvent('vehicleshop:ToggleAutoShop')
AddEventHandler('vehicleshop:ToggleAutoShop', function(society, toggle)
    if toggle then
        DisableAutoShop[society] = true
    else
        DisableAutoShop[society] = false
    end
end)

Citizen.CreateThread(function()
    while not ESX.PlayerData.PassJoin do
        Wait(5)
    end
    while true do
        local breakNear = true
        for k, v in pairs(VehicleShops) do
            for key, value in pairs(v.zones) do 
                local continue = false
                if key == "boss" then
                    if k == ESX.PlayerData.job.name and ESX.PlayerData.job.grade_name == "boss" then
                        continue = true
                    end
                elseif key == "reseller" then
                    if k == ESX.PlayerData.job.name then
                        continue = true
                    end
                else
                    if key == "kataenter" then
                        if not DisableAutoShop[k] then
                            continue = true
                        end
                    else
                        continue = true
                    end
                end
                if continue then
                    if #(ESX.PlayerData.cache.coords - value) < 10 then
                        VehicleShopNearData.near = true
                        VehicleShopNearData.key = k
                        VehicleShopNearData.zones[key] = true
                        breakNear = false
                    else
                        VehicleShopNearData.zones[key] = false
                    end
                end
            end
        end
        if breakNear then
            VehicleShopNearData = {near = false, key = "", zones = {}}
        elseif not AleardyStartedNearVehicleShops then
            StartNearVehicleShop()
        end
        Wait(1000)
    end
end)

function DeleteShopInsideVehicles()
    while #LastVehicles > 0 do
        local vehicle = LastVehicles[1]

        ESX.Game.DeleteVehicle(vehicle)
        table.remove(LastVehicles, 1)
    end
end

function StartNearVehicleShop()
    if AleardyStartedNearVehicleShops then
        return
    end
    AleardyStartedNearVehicleShops = true
    Citizen.CreateThread(function()
        while VehicleShopNearData.near do
            if VehicleShops[VehicleShopNearData.key] then
                for k, v in pairs(VehicleShopNearData.zones) do
                    if VehicleShops[VehicleShopNearData.key].zones[k] then
                        if (#(ESX.PlayerData.cache.coords - VehicleShops[VehicleShopNearData.key].zones[k]) < 10) and (k ~= "katalog" and k ~= "spawn") and (k ~= "kataenter" or not DisableAutoShop[VehicleShopNearData.key]) then
                            
                            DrawMarker(ZiZouConfig.Marker.Markers.Marker.type, VehicleShops[VehicleShopNearData.key].zones[k], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ZiZouConfig.Marker.Markers.Marker.x, ZiZouConfig.Marker.Markers.Marker.y, ZiZouConfig.Marker.Markers.Marker.z, ZiZouConfig.Marker.Markers.Marker.r, ZiZouConfig.Marker.Markers.Marker.g, ZiZouConfig.Marker.Markers.Marker.b, ZiZouConfig.Marker.Markers.Marker.a, ZiZouConfig.Marker.Markers.Marker.rotate, false, 2, false, nil, nil, false)
   
                            
                            
                          --  DrawMarker(1, VehicleShops[VehicleShopNearData.key].zones[k], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                            if #(ESX.PlayerData.cache.coords - VehicleShops[VehicleShopNearData.key].zones[k]) < 1.5 and not CurrentMenu then
                                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acceder au menu.")
                                if IsControlJustReleased(1, 38) then        
                                    ManageVehicleShopsAction(VehicleShopNearData.key, k)
                                end
                            elseif #(ESX.PlayerData.cache.coords - VehicleShops[VehicleShopNearData.key].zones[k]) >= 1.5 and CurrentMenu and CurrentMenu == k then
                                VehicleShopsMenuOpen = false
                                CurrentMenu = nil
                                CloseMenu()
                            end
                        end
                    end
                end
            end
            Wait(5)
        end
        AleardyStartedNearVehicleShops = false
    end)
end

function ManageVehicleShopsAction(key, zone)
    if VehicleShops[key] and VehicleShops[key].zones[zone] then
        if zone == "boss" then
            if key == ESX.PlayerData.job.name and ESX.PlayerData.job.grade_name == "boss" then
                CurrentMenu = zone              
                OpenBossActionsMenu()
            end
        elseif zone == "reseller" then
            if key == ESX.PlayerData.job.name then
                CurrentMenu = zone               
                OpenResellerMenu()
            end
        elseif zone == "kataenter" then
            OpenKatalogMenu("katalog")
        end
    end
end

function OpenBossActionsMenu()
    VehShopBossActionsMenu = {
      Base = { Title = "Gestion", HeaderColor = {169, 187, 232} },
      Data = { currentMenu = "management" },
  
      Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
          if btn.action == "boss" then
              CloseMenu()
              Wait(10)
              OpenBossMenu(ESX.PlayerData.job.name, 1)
          elseif btn.action == "soldveh" then
              CloseMenu()
              Wait(10)
              OpenVehicleShopsCustomersList()
          end
      end
    },
  
    Menu = {
      ["management"] = {
          b = {
              {name = "Gestion Société", action = "boss", ask = "→", askX = true},
              {name = "Véhicules vendus", action = "soldveh", ask = "→", askX = true}
          }
      }
   }
  }

  CreateMenu(VehShopBossActionsMenu)
end

function OpenVehicleShopsCustomersList()
	ESX.TriggerServerCallback('vehicleshops:getSoldVehicles', function(customers)
		VehShopCustomersMenu = {
		  Base = { Title = "Clients", HeaderColor = {169, 187, 232} },
		  Data = { currentMenu = "customers" },
	  
		  Events = {
		  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			  --
		  end
		},
	  
		Menu = {
		  ["customers"] = {
			  b = {
				  
			  }
		  }
	   }
	  }

	  for i=1, #customers, 1 do
		  table.insert(VehShopCustomersMenu.Menu["customers"].b, {
			  name = customers[i].client .. ' | ' .. customers[i].model .. ' | ' .. customers[i].plate  .. ' | ' .. customers[i].soldby .. ' | ' .. customers[i].date,
			  action = 'null'
		  })
		  
	  end
	  
	  CreateMenu(VehShopCustomersMenu)
	end)
end

function OpenResellerMenu()
    ResellerMenu = {
		Base = { Title = "Menu Vendeur", HeaderColor = {255, 0, 0}},
		Data = { currentMenu = "menu vendeur " },

        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                if btn.action == "sell_vehicle" then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification("aucun joueur à proximité")
                        return
                    end

                    SelectedVehicleShopData.player = GetPlayerServerId(closestPlayer)
                    OpenKatalogMenu("seller")
                elseif btn.action == "coffre" then
                    CloseMenu()

                    TriggerEvent('coffre:OpenMenu', 1)
                elseif btn.action == "service" then
                    if CheckInService(true) then
                        TriggerServerEvent("player:serviceOff")
                    else
                        TriggerServerEvent("player:serviceOn")
                    end
                end
            end
        },
        
        Menu = {
            ["menu vendeur "] = {
                b = {
                    {name = "Vendre Vehicule", action = "sell_vehicle" },
                    {name = "Coffre",          action = "coffre" }
                }
            }
        }
    }
    CreateMenu(ResellerMenu)
end

function StartShopRestriction()
  
    Citizen.CreateThread(function()
        while IsInShopMenu do
            Citizen.Wait(1)
    
            DisableControlAction(0, 75,  true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)

end

function OpenKatalogMenu(katatype)
  
    IsInShopMenu = true

    local vehicleData = nil

    StartShopRestriction()
    CloseMenu()
    CurrentMenu = "katalog"
    local playerPed = ESX.PlayerData.cache.playerped

    local ActualVehShop = VehicleShopNearData.key
    FreezeEntityPosition(playerPed, true)
    SetEntityVisible(playerPed, false)
    SetEntityCoords(playerPed, VehicleShops[ActualVehShop].zones["katalog"].x, VehicleShops[ActualVehShop].zones["katalog"].y, VehicleShops[ActualVehShop].zones["katalog"].z)

    local vehiclesByCategory = {}
    local elements           = {}
    local firstVehicleData   = nil

    for i=1, #Categories, 1 do
        vehiclesByCategory[Categories[i].name] = {}
    end

    for i=1, #Vehicles, 1 do
        if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
            table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
        else
            print(('vehicleshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
        end
    end

    for i=1, #Categories, 1 do
        local category         = Categories[i]
        if category.type == VehicleShops[ActualVehShop].type then
            local categoryVehicles = vehiclesByCategory[category.name]
            local options          = {}

            for j=1, #categoryVehicles, 1 do
                local vehicle = categoryVehicles[j]

                if i == 1 and j == 1 then
                    firstVehicleData = vehicle
                end
                if katatype and katatype == "seller" then
                    table.insert(options, ('%s ~g~%s'):format(vehicle.name, ESX.Math.GroupDigits(vehicle.price) .. "$"))
                else
                    table.insert(options, ('%s ~g~%s'):format(vehicle.name, ESX.Math.GroupDigits(vehicle.price) .. "$"))
                end
            end

            table.insert(elements, {
            name   = category.label,
            category    = category.name,
            action = "buyveh",
            slidemax = options
            })
        end
    end

    BuyVehicleKataMenu = {
      Base = { Title = "Catalogue", HeaderColor = {255, 0, 0}},
      Data = { currentMenu = "catalogue " },
    
      Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
          if btn.action == "buyveh" then
            vehicleData = vehiclesByCategory[btn.category][btn.slidenum]
            OpenMenu("confirmation ")
          elseif btn.action == "yes" then
        if katatype and katatype == "seller" then
              ESX.TriggerServerCallback('vehicleshops:SendBuyRequest', function(hasEnoughMoney)
                  if hasEnoughMoney then
                      IsInShopMenu = false

                      DeleteShopInsideVehicles()

                      local playerPed = ESX.PlayerData.cache.playerped

                      FreezeEntityPosition(playerPed, false)
                      SetEntityVisible(playerPed, true)
                      SetEntityCoords(playerPed, VehicleShops[ActualVehShop].zones["kataenter"].x, VehicleShops[ActualVehShop].zones["kataenter"].y, VehicleShops[ActualVehShop].zones["kataenter"].z)

                      CloseMenu()
                      SelectedVehicleShopData.model = vehicleData.model
                  else
                      ESX.ShowNotification("vous n\avez pas assez d\'argent sur le compte de la societé")
                  end

              end, SelectedVehicleShopData.player, vehicleData.model, tonumber(amount))
        elseif katatype and katatype == "katalog" then
            ESX.TriggerServerCallback('vehicleshops:buyVehicle', function(hasEnoughMoney)
                if not hasEnoughMoney then
                    ESX.ShowNotification("vous n'avez pas assez d\'argent !")
                end
            end, ActualVehShop, vehicleData.model, tonumber(amount))
            IsInShopMenu = false

            DeleteShopInsideVehicles()

            local playerPed = ESX.PlayerData.cache.playerped

            FreezeEntityPosition(playerPed, false)
            SetEntityVisible(playerPed, true)
            SetEntityCoords(playerPed, VehicleShops[ActualVehShop].zones["reseller"].x, VehicleShops[ActualVehShop].zones["reseller"].y, VehicleShops[ActualVehShop].zones["reseller"].z)

            CloseMenu()
            SelectedVehicleShopData.model = vehicleData.model
        end
          end
        end,
        onExited = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide)
          DoScreenFadeOut(1000)
          Citizen.Wait(1000)
          DoScreenFadeIn(1000)
  
        DeleteShopInsideVehicles()
  
        local playerPed = ESX.PlayerData.cache.playerped
  
        FreezeEntityPosition(playerPed, false)

        if katatype and katatype == "seller" then
        SetEntityCoords(playerPed, VehicleShops[ActualVehShop].zones["reseller"].x, VehicleShops[ActualVehShop].zones["reseller"].y, VehicleShops[ActualVehShop].zones["reseller"].z)
        else
        SetEntityCoords(playerPed, VehicleShops[ActualVehShop].zones["kataenter"].x, VehicleShops[ActualVehShop].zones["kataenter"].y, VehicleShops[ActualVehShop].zones["kataenter"].z)
        end
        SetEntityVisible(playerPed, true)
  
        IsInShopMenu = false
        CurrentMenu = nil
        end,
        onButtonSelected = function(currentaMenu, k, j, btn, self)
          if not btn.category then return end
          vehicleData = vehiclesByCategory[btn.category][btn.slidenum]
        local playerPed   = ESX.PlayerData.cache.playerped
  
        DeleteShopInsideVehicles()
  
        ESX.Game.SpawnLocalVehicle(vehicleData.model, VehicleShops[ActualVehShop].zones["katalog"], 0, function(vehicle)
          table.insert(LastVehicles, vehicle)
          TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
          FreezeEntityPosition(vehicle, true)
        end)
        end,
        onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
          if not btn.category then return end

          vehicleData = vehiclesByCategory[btn.category][btn.slidenum]
        local playerPed   = ESX.PlayerData.cache.playerped
  
        DeleteShopInsideVehicles()
  
        ESX.Game.SpawnLocalVehicle(vehicleData.model, VehicleShops[ActualVehShop].zones["katalog"], 0, function(vehicle)
          table.insert(LastVehicles, vehicle)
          TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
          FreezeEntityPosition(vehicle, true)
        end)
        end
    },
    
    Menu = {
      ["catalogue "] = {
          b = {
          }
      },
      ["confirmation "] = {
          b = {
              {name = "Vous voulez confirmez ?", action = "nul"},
              {name = "Oui", action = "yes"},
              {name = "Non", action = "no"}
          }
      }
    }
  }
  
  BuyVehicleKataMenu.Menu["catalogue "].b = elements
  
  CreateMenu(BuyVehicleKataMenu)
end

