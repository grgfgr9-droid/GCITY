local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local IsMenuOpen = false
local LastZone                = nil

local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil

local PlayerData              = {}
local GUI = {}
GUI.Time                      = 0

Citizen.CreateThread(function ()

  while not ESX do 
    Wait(0)
  end

  ESX.TriggerServerCallback('vehicleshop:getCategories', function (categories)
    Categories = categories
  end)

  ESX.TriggerServerCallback('vehicleshop:getVehicles', function (vehicles)
    Vehicles = vehicles
  end)
end)

function DeleteKatalogVehicles()
  while #LastVehicles > 0 do
    local vehicle = LastVehicles[1]
    ESX.Game.DeleteVehicle(vehicle)
    table.remove(LastVehicles, 1)
  end
end

function OpenKataMenu()
  IsInShopMenu = true

  CloseMenu()


  FreezeEntityPosition(ESX.PlayerData.cache.playerped, true)
  SetEntityVisible(ESX.PlayerData.cache.playerped, false)
  SetEntityCoords(ESX.PlayerData.cache.playerped, CatalogueConfig.Zones.ShopInside.Pos.x, CatalogueConfig.Zones.ShopInside.Pos.y, CatalogueConfig.Zones.ShopInside.Pos.z)

  local vehiclesByCategory = {}
  local elements           = {
  }
  local firstVehicleData   = nil

  for i=1, #Categories, 1 do
    vehiclesByCategory[Categories[i].name] = {}
  end

  for i=1, #Vehicles, 1 do
    table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
  end

  for i=1, #Categories, 1 do
    local category         = Categories[i]
    local categoryVehicles = vehiclesByCategory[category.name]
    local options          = {}

    for j=1, #categoryVehicles, 1 do
      local vehicle = categoryVehicles[j]

      if i == 1 and j == 1 then
        firstVehicleData = vehicle
      end

      table.insert(options, vehicle.name .. ' ')
    end

    table.insert(elements, {
      name   = category.label,
      category    = category.name,
      type = "vehicle",
      slidemax = options
    })
  end

  KataMenu = {
    Base = { Title = "Catalogue", HeaderColor = {255, 0, 0}},
    Data = { currentMenu = "catalogue " },
  
    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      end,
      onExited = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)

      DeleteKatalogVehicles()

      FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)

     SetEntityCoords(ESX.PlayerData.cache.playerped, CatalogueConfig.Zones.Katalog.Pos.x, CatalogueConfig.Zones.Katalog.Pos.y, CatalogueConfig.Zones.Katalog.Pos.z)
        SetEntityVisible(ESX.PlayerData.cache.playerped, true)

      IsInShopMenu = false
      end,
      onButtonSelected = function(currentaMenu, k, j, btn, self)
        DeleteKatalogVehicles()
        if not btn.category then return end
        if btn.type and btn.type == "confirmation" then return end
        if btn.type and btn.type == "paymentchoice" then return end
        local vehicleData = vehiclesByCategory[btn.category][btn.slidenum]

      ESX.Game.SpawnLocalVehicle(vehicleData.model, {
        x = CatalogueConfig.Zones.ShopInside.Pos.x,
        y = CatalogueConfig.Zones.ShopInside.Pos.y,
        z = CatalogueConfig.Zones.ShopInside.Pos.z
      }, CatalogueConfig.Zones.ShopInside.Heading, function(vehicle)
        table.insert(LastVehicles, vehicle)
        TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, vehicle, -1)
        FreezeEntityPosition(vehicle, true)
      end)
      end,
      onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
        DeleteKatalogVehicles()
       if not btn.category then return end
      local vehicleData = vehiclesByCategory[btn.category][btn.slidenum]

      ESX.Game.SpawnLocalVehicle(vehicleData.model, {
        x = CatalogueConfig.Zones.ShopInside.Pos.x,
        y = CatalogueConfig.Zones.ShopInside.Pos.y,
        z = CatalogueConfig.Zones.ShopInside.Pos.z
      }, CatalogueConfig.Zones.ShopInside.Heading, function(vehicle)
        table.insert(LastVehicles, vehicle)
        TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, vehicle, -1)
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
			}
		}
  }
}

KataMenu.Menu["catalogue "].b = elements

CreateMenu(KataMenu)
end

-- Draw Marker / Control Listener
Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5)
   
     local pedCoords = ESX.PlayerData.cache.coords
     local isInMarker = false
     local letSleep = true
   
     for k,v in pairs(CatalogueConfig.Zones) do
       if v.Type ~= -1 and (GetDistanceBetweenCoords(pedCoords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) then
         letSleep = false
         DrawMarker(1, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, CatalogueConfig.MarkerColor.r, CatalogueConfig.MarkerColor.g, CatalogueConfig.MarkerColor.b, 100, false, true, 2, false, false, false, false)
        end
   
       if v.Type ~= -1 and GetDistanceBetweenCoords(pedCoords, v.Pos.x, v.Pos.y, v.Pos.z, true) < ((v.Size.x + v.Size.x) / 2) then
         HasAlreadyEnteredMarker = true
         isInMarker = true
         ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
         if IsControlJustPressed(1, 38) then
          if k == 'Katalog' then
            OpenKataMenu()
            HasAlreadyEnteredMarker = false
          end
  
         end
       end
     end
   
     if not isInMarker and HasAlreadyEnteredMarker and IsMenuOpen then
       HasAlreadyEnteredMarker = false
       CloseMenu()
     end
   
     if letSleep then
       Citizen.Wait(5000)
     end
    end
end)