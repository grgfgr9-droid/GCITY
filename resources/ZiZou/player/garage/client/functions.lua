local GarageCam = nil
local GarageVehicle = nil
local actuveh = nil
local LastVehicles            = {}

function StartGarageSpawner(type, zone)
    if type == "garage" then
        
        Citizen.CreateThread(function()
            CloseMenu(true)
            OpenGarageMenu(type, zone)
        end)        
    end
end

function SpawnVehicle(vehicle, zone)
    local garage = zone["zones"]["spawner"]
    CloseMenu(true)
    ESX.TriggerServerCallback("garage:SpawnVehicle", function(success, vehicle, props)
      if success then
        Wait(500)
        local veh = NetworkGetEntityFromNetworkId(vehicle)
        NetworkRequestControlOfEntity(veh)
        local timeout = 10
          while not NetworkHasControlOfEntity(veh) and timeout > 0 do
            Wait(100)
            timeout = timeout - 1
          end
          ESX.Game.SetVehicleProperties(veh, props)
          TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, veh, -1)
          SetVehicleNumberPlateText(veh, props.plate)
      else
        ESX.ShowNotification("Impossible de sortir le véhicule")
      end
     end, vehicle.plate, {
      x = garage.x,
      y = garage.y,
      z = garage.z + 1
    })
end

function OpenPoundMenu(zone)
    FourriereMenu = {
        Base = { Title = "Fourriere", HeaderColor = {140, 32, 48} },
        Data = { currentMenu = "fourriere" },
    
        Events = {
          onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
            if btn.action == "fourriereveh" then
              ESX.TriggerServerCallback("garage:checkMoney", function(hasEnoughMoney)
                  if hasEnoughMoney then
                    SpawnVehicle(btn.vehicle, zone)
                    CloseMenu()
                  else
                    ESX.ShowNotification("Vous n'avez pas assez d'argent.")					
                  end
              end, 250)
            end
        end
        },
    }
    
      FourriereMenu.Menu = {}
      FourriereMenu.Menu["fourriere"] = {}
      FourriereMenu.Menu["fourriere"].b = {}	
    
      ESX.TriggerServerCallback("garage:getVehicles", function(vehicles)
       for k,v in pairs(vehicles) do
        if v.state == false then
          if zone.type == v.type then
        local nomvoituremodele = GetDisplayNameFromVehicleModel(v.model)
        FourriereMenu.Menu["fourriere"].b[k] = {name = nomvoituremodele.." - 100$", vehicle = v.vehicle, action = "fourriereveh", ask = "→", askX = true}
          end
        end
       end
       CreateMenu(FourriereMenu)
      end, zone.type)
end

function GarageDeleteVehicle()
    if ESX.PlayerData.cache.invehicle then
      local vehicleProps = ESX.Game.GetVehicleProperties(ESX.PlayerData.cache.vehicle)
      local current = GetPlayersLastVehicle(ESX.PlayerData.cache.playerped, true)
      if GetPedInVehicleSeat(ESX.PlayerData.cache.vehicle, -1) == ESX.PlayerData.cache.playerped then
        local vehicleProps = ESX.Game.GetVehicleProperties(ESX.PlayerData.cache.vehicle)
      ESX.TriggerServerCallback("garage:stockvehicle", function(valid)
        if valid then
            DeleteEntity(ESX.PlayerData.cache.vehicle)
            ESX.ShowNotification("Votre véhicule est rentré.", "success")
        else
          ESX.ShowNotification("Vous ne pouvez pas rentrer un véhicules que vous ne possédez pas.", "error")
        end
      end, vehicleProps)
      end
    end
  end

  function OpenGarageMenu(type, zone)
    CloseMenu(true)

    local searchQuery = ""
    local allVehicles = {} 

    GarageMenu = {
        Base = { Title = "Garage", HeaderColor = {55, 93, 153} },
        Data = { currentMenu = "garage" },

        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                if btn.action == "spawnveh" then
                    if btn.state == true then
                        DeleteGaragePreviwVehicles()
                        local vehprops = btn.vehicle
                        vehprops.plate = string.upper(btn.plate)
                        SpawnVehicle(btn.vehicle, zone)
                    else
                        ESX.ShowNotification("Votre véhicule n'est pas rentré.")
                    end
                elseif btn.action == "search" then
                    
                    local msg = KeyboardInput("GARAGE_SEARCH", "Entrez le nom ou la plaque du véhicule", "", 15)
                    if msg and msg ~= "" then
                        searchQuery = string.lower(msg) 
                    else
                        searchQuery = "" 
                    end
                    UpdateVehicleList() 
                end
            end,

            onButtonSelected = function(currentMenu, k, j, btn, self)
                PreviewGarageVehicle(btn, zone)
            end,

            onExited = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide)
                DeleteGaragePreviwVehicles()
            end
        },

        Menu = {
            ["garage"] = {
                b = {
                    { name = "Rechercher un véhicule", slidemax = {"Nom", "Plaque"}, action = "search" } -- Bouton de recherche
                }
            }
        }
    }

   
    function UpdateVehicleList()
        
      GarageMenu.Menu["garage"].b = {
        { name = "Rechercher un véhicule", slidemax = {"Nom", "Plaque"}, action = "search" }, -- Bouton de recherche
        { name = "               -----------------------------------------------", itemtype = "null", itemname = "separator" } -- Ligne de séparation centrée
    }
    
        for _, v in pairs(allVehicles) do
            local nomVehicule = GetDisplayNameFromVehicleModel(v.model)
            local plate = v.plate
            local LabelVeh = v.state and "~g~Rentré" or "~r~Sorti"

         
            if searchQuery == "" or string.find(string.lower(nomVehicule), searchQuery, 1, true) or string.find(string.lower(plate), searchQuery, 1, true) then
                table.insert(GarageMenu.Menu["garage"].b, { 
                    name = nomVehicule .. " - " .. plate, 
                    vehicle = v.vehicle, 
                    state = v.state, 
                    plate = plate, 
                    action = "spawnveh", 
                    ask = LabelVeh, 
                    askX = true 
                })
            end
        end

        
        CloseMenu(true) 
        CreateMenu(GarageMenu)
    end

    ESX.TriggerServerCallback("garage:getVehicles", function(vehicles)
        allVehicles = vehicles
        UpdateVehicleList() 
    end)
end



function PreviewGarageVehicle(btn, zone)
    local vehicleData = btn
      DeleteGaragePreviwVehicles()
      if not vehicleData.vehicle then return end
      ESX.Game.SpawnLocalVehicle(vehicleData.vehicle.model, {
        x = zone["zones"]["spawner"].x,
        y = zone["zones"]["spawner"].y,
        z = zone["zones"]["spawner"].z
      }, 100, function(vehicle)
        ESX.Game.SetVehicleProperties(vehicle, vehicleData.vehicle)
        table.insert(LastVehicles, vehicle)
        SetEntityAlpha(vehicle, 51, false)
        SetEntityAlpha(ESX.PlayerData.cache.playerped, 51, false)
        TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, vehicle, -1)
        FreezeEntityPosition(vehicle, true)
      end)
end

function DeleteGaragePreviwVehicles()
    while #LastVehicles > 0 do
      local vehicle = LastVehicles[1]
      ESX.Game.DeleteVehicle(vehicle)
      table.remove(LastVehicles, 1)
    end
    SetEntityAlpha(ESX.PlayerData.cache.playerped, 255, false)
  end