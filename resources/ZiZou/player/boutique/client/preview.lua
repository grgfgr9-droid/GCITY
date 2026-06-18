local IsInPreviewStore = false
local doBreakPreview = false
local LastVehicles            = {}

PreviewConfig = {}
PreviewConfig.Zones = {
    Katalog = {
        Pos     = { x = -144.5, y = -593.44, z = 211.28 },
        Size    = { x = 1.5, y = 1.5, z = 1.0 },
        Heading = 177.28,
        Type    = 27,
      }
}

function DeleteStorePreviewVehicles()
    while #LastVehicles > 0 do
      local vehicle = LastVehicles[1]
      ESX.Game.DeleteVehicle(vehicle)
      table.remove(LastVehicles, 1)
    end
end

function StartBoutiquePreview()
    if not ESX.PlayerData.safezone then ESX.ShowNotification("Vous devez être en safe zone pour faire ceci !") return end
    IsInPreviewStore = true
    doBreakPreview = false
    local lastPlayerCoords = ESX.PlayerData.cache.coords

    VehMenu = {
        Base = { Title = "Boutique", HeaderColor = {255, 0, 0}, Blocked = true},
        Data = { currentMenu = "Vehicules" },
      
        Events = {
          onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
            if btn.action == 'vehicles' then
                OpenMenu("Vehicules")
            elseif btn.action == 'goback' then
                CloseMenu(true)
                FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
                SetEntityVisible(ESX.PlayerData.cache.playerped, true)
                doBreakPreview = true
                DeleteStorePreviewVehicles()
                ESX.Game.Teleport(ESX.PlayerData.cache.playerped, lastPlayerCoords)
            elseif btn.action == 'buyitem' then
                TriggerServerEvent('store:buyItem', btn.type, btn.item, "zebi")
                CloseMenu(true)
                FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
                SetEntityVisible(ESX.PlayerData.cache.playerped, true)
                doBreakPreview = true
                DeleteStorePreviewVehicles()
                ESX.Game.Teleport(ESX.PlayerData.cache.playerped, lastPlayerCoords)
            end
        end,
		onButtonSelected = function(currentaMenu, k, j, btn, self)
            local coords = ESX.PlayerData.cache.coords
            local vehicletodel = GetClosestVehicle(coords, 2.0, 0, 71)
		    if vehicletodel then
			ESX.Game.DeleteVehicle(vehicletodel)
		    end
			if btn.item then
				doBreakPreview = true
                Wait(7)
                doBreakPreview = false
                local coords = ESX.PlayerData.cache.coords
             
                   DeleteStorePreviewVehicles()
             
                   ESX.Game.SpawnLocalVehicle(btn.item, {
                    x = PreviewConfig.Zones.Katalog.Pos.x,
                    y = PreviewConfig.Zones.Katalog.Pos.y,
                    z = PreviewConfig.Zones.Katalog.Pos.z
                  }, PreviewConfig.Zones.Katalog.Heading, function(vehicle)
                     table.insert(LastVehicles, vehicle)
                     TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, vehicle, -1)
                     FreezeEntityPosition(vehicle, true)
                     Citizen.CreateThread(function()
                        local heading = PreviewConfig.Zones.Katalog.Heading
                        while not doBreakPreview do
                            Wait(5)
                            heading = heading + 1
                            SetEntityHeading(vehicle, heading)
                        end
                    end)
                   end)
			else
                
                FreezeEntityPosition(ESX.PlayerData.cache.playerped, true)
                SetEntityVisible(ESX.PlayerData.cache.playerped, false)
                doBreakPreview = true
                local coords = ESX.PlayerData.cache.coords
                   if ESX.PlayerData.cache.invehicle then
                        ESX.Game.DeleteVehicle(ESX.PlayerData.cache.vehicle)
                    end
			end 
		end
      },
      
      Menu = {
        ["Vehicules"] = {
            b = {
            }
        }
      }
    }
    VehMenu.Menu["Vehicules"].b = {
        {name = 'Revenir en arrière', action = 'goback'}
    }

    for _,item in ipairs(StoreConfig.Vehicles) do
    table.insert(VehMenu.Menu["Vehicules"].b, {name = item.name, item = item.data.NameVehicle, type = 'vehicle', action = 'buyitem', ask = '~r~' .. item.data.Point .. ' ~b~' .. ZiZouConfig.StorePointsName, askX = true})
    end

    CreateMenu(VehMenu)

    FreezeEntityPosition(ESX.PlayerData.cache.playerped, true)
    SetEntityVisible(ESX.PlayerData.cache.playerped, false)
    SetEntityCoords(ESX.PlayerData.cache.playerped, PreviewConfig.Zones.Katalog.Pos.x, PreviewConfig.Zones.Katalog.Pos.y, PreviewConfig.Zones.Katalog.Pos.z)
end