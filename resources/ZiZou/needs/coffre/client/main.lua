function OpenGetStocksMenu(type)
    CoffreMenu = {
        Base = { Title = "Coffre", HeaderColor = {86, 97, 83} },
        Data = { currentMenu = "coffre" },
    
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
          if btn.action == "getItem" then
            local count = KeyboardInput("COFFRE_GET", "Combien en prendre ?", "", 3)
             if tonumber(count) ~= nil then
              TriggerServerEvent("coffre:getStockItem", btn.itemName, tonumber(count), type)
              CloseMenu()
              Citizen.Wait(500)
              OpenGetStocksMenu(type)
             end
          end
        end
      },
    
      Menu = {
        ["coffre"] = {
          b = {}
        },
      }
    }
    
    ESX.TriggerServerCallback("coffre:getStockItems", function(items)
    for i=1, #items, 1 do
     if items[i].count > 0 then
     table.insert(CoffreMenu.Menu["coffre"].b, {name = "x" ..items[i].count.. " " ..items[i].label, action = "getItem", itemName = items[i].name, ask = "→", askX = true})
     end
    end
    CreateMenu(CoffreMenu)
    end, type)
    end
    
    function OpenPutStocksMenu(type)
    CoffreMenu = {
        Base = { Title = "Coffre", HeaderColor = {86, 97, 83} },
        Data = { currentMenu = "coffre" },
    
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
          if btn.action == "putItem" then
            local count = KeyboardInput("COFFRE_PUT", "Combien en déposer ?", "", 3)
             if tonumber(count) ~= nil then
              TriggerServerEvent("coffre:putStockItems", btn.itemName, tonumber(count), type)
              CloseMenu()
              Citizen.Wait(500)
              OpenPutStocksMenu(type)
             end
          end
        end
      },
    
      Menu = {
        ["coffre"] = {
          b = {}
        },
      }
    }
    
    ESX.TriggerServerCallback("coffre:getPlayerInventory", function(inventory)
    for i=1, #inventory.items, 1 do
     local item = inventory.items[i]
      if item.count > 0 then
        table.insert(CoffreMenu.Menu["coffre"].b, {name = item.label.. " x" ..item.count, action = "putItem", itemName = item.name, ask = "→", askX = true})
      end
    end
    CreateMenu(CoffreMenu)
    end, type)
    end
    
    function OpenGetWeaponMenu(type)
    CoffreMenu = {
        Base = { Title = "Coffre", HeaderColor = {86, 97, 83} },
        Data = { currentMenu = "coffre" },
    
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
          if btn.action == "getWeapon" then
            ESX.TriggerServerCallback("coffre:removeArmoryWeapon", function()
                CloseMenu()
                Citizen.Wait(500)
                OpenGetWeaponMenu(type)
            end, btn.weaponName, btn.weaponAmmo, type)
          end
        end
      },
    
      Menu = {
        ["coffre"] = {
          b = {}
        },
      }
    }
    
    ESX.TriggerServerCallback("coffre:getArmoryWeapons", function(weapons)
    for i=1, #weapons, 1 do
     table.insert(CoffreMenu.Menu["coffre"].b, {name = "x"..weapons[i].ammo.." "..ESX.GetWeaponLabel(weapons[i].name), action = "getWeapon", weaponName = weapons[i].name, weaponAmmo = weapons[i].ammo, ask = "→", askX = true})
    end
    CreateMenu(CoffreMenu)
    end, type)
    
    end
    
    function OpenPutWeaponMenu(type)
    CoffreMenu = {
        Base = { Title = "Coffre", HeaderColor = {86, 97, 83} },
        Data = { currentMenu = "coffre" },
    
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
          if btn.action == "putWeapon" then
            ESX.TriggerServerCallback("coffre:addArmoryWeapon", function()
                CloseMenu()
                Citizen.Wait(500)
                OpenPutWeaponMenu(type)
            end, btn.weaponName, btn.weaponAmmo, type)
          end
        end
      },
    
      Menu = {
        ["coffre"] = {
          b = {}
        },
      }
    }
    
    local playerPed = ESX.PlayerData.cache.playerped
    local weaponList = ESX.PlayerData.loadout
    
    for i=1, #weaponList, 1 do
    local weaponHash = GetHashKey(weaponList[i].name)
    table.insert(CoffreMenu.Menu["coffre"].b, {name = weaponList[i].ammo .. 'x ' .. weaponList[i].label, action = "putWeapon", weaponName = weaponList[i].name, weaponAmmo = weaponList[i].ammo, ask = "→", askX = true})
    end
    CreateMenu(CoffreMenu)
    end
    
    AddEventHandler("coffre:OpenMenu", function(type)
        OpenCoffreMenu(type)
    end)
    function OpenCoffreMenu(type)
    local ped = ESX.PlayerData.cache.playerped
    if DoesEntityExist(ped) and not IsEntityDead(ped) then
    CloseMenu()
    
    CoffreMenu = {
        Base = { Title = "Coffre", HeaderColor = {86, 97, 83} },
        Data = { currentMenu = "coffre" },
    
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
          if btn.action == "deposer_objet" then
            CloseMenu()
            OpenPutStocksMenu(type)
          elseif btn.action == "prendre_objet" then
            CloseMenu()
            OpenGetStocksMenu(type)
          elseif btn.action == "deposer_arme" then
            CloseMenu()
            OpenPutWeaponMenu(type)
          elseif btn.action == "prendre_arme" then
            CloseMenu()
            OpenGetWeaponMenu(type)
          end
        end
      },
    
      Menu = {
        ["coffre"] = {
          b = {
            {name = "Déposer un objet", action = "deposer_objet", ask = "→", askX = true},
            {name = "Prendre un objet", action = "prendre_objet", ask = "→", askX = true}
          }
        },
      }
    }
    
    if ESX.PlayerData.job.name ~= "ambulance" then
    table.insert(CoffreMenu.Menu["coffre"].b, {name = "Déposer une arme", action = "deposer_arme", ask = "→", askX = true})
    table.insert(CoffreMenu.Menu["coffre"].b, {name = "Prendre une arme", action = "prendre_arme", ask = "→", askX = true})
    end
    
    CreateMenu(CoffreMenu)
  --  ESX.ShowNotification("Les Coffres sont temporairement désactivés !")
    
    end
    end