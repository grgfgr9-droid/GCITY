local VehicleModel = {}

local CurrentVehicle = {}
local CloseToVehicle = false

function openmenuvehicle()
  local x,y,z = table.unpack(ESX.PlayerData.cache.coords)
	local vehicle = GetClosestVehicle(x, y, z, 3.0, 0, 71)
  local globalplate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

 if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then

  if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) ~= ESX.PlayerData.cache.playerped then

	  local locked = GetVehicleDoorLockStatus(vehicle)
    if locked == 1 then
      CurrentVehicle = { vehicle = vehicle, model = GetEntityModel(vehicle), plate = globalplate, max = 200 }
      CloseToVehicle = true
      SetVehicleDoorOpen(vehicle, 5, false, false)
      ESX.TriggerServerCallback("truck:GetPlate", function(cb)
        CurrentVehicle.actualweight = cb.weight
        CurrentVehicle.item = cb.items
        CurrentVehicle.weapon = cb.weapons
        CurrentVehicle.black_money = cb.blackMoney
        CurrentVehicle.max = cb.max
        OpenTruckMenu()
        end, CurrentVehicle.plate, CurrentVehicle.model)
		else
			ESX.ShowNotification("Ce coffre est ~r~fermé.~s~")
    end
      
	else
	ESX.ShowNotification("Pas de ~r~véhicule~s~ à proximité.")
  end

 end
end

function OpenTruckMenu(type)

TruckMenu = {
    Base = { Title = "Coffre véhicule", HeaderColor = ESX.HeaderColor },
    Data = { currentMenu = "coffre vehicule" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "prendreobjet" then
        TruckMenu.Menu["prendre objet"].b = {}
        table.insert(TruckMenu.Menu["prendre objet"].b, {name = "Argent sale: ~r~"..ESX.Math.GroupDigits(CurrentVehicle.black_money).."$~s~", itemtype = "item_account", action = "withdraw", ask = "→", askX = true})

        for k,v in pairs(CurrentVehicle.item) do
         if v > 0 then
          for x,o in ipairs(ESX.PlayerData.inventory) do
            if o.name == k then
            local label = o.label
            table.insert(TruckMenu.Menu["prendre objet"].b, {name = label.." ("..v..")", itemtype = "item_standard", itemname = k, action = "withdraw", ask = "→", askX = true})
            end
          end
         end
        end
        
        for k,v in pairs(CurrentVehicle.weapon) do
        table.insert(TruckMenu.Menu["prendre objet"].b, {name = ESX.GetWeaponLabel(k) .." ("..v..")", itemtype = "item_weapon", itemname = k, action = "withdraw", ask = "→", askX = true})
        end
        OpenMenu("prendre objet")
        
      elseif btn.action == "deposerobjet" then
        TruckMenu.Menu["deposer objet"].b = {}
        for k,v in pairs(ESX.PlayerData.accounts) do
          if v.name == "black_money" then
             table.insert(TruckMenu.Menu["deposer objet"].b, {name = "Argent sale: ~r~"..ESX.Math.GroupDigits(v.money).."$~s~", itemtype = "item_account", itemname = "black_money", action = "deposit", ask = "→", askX = true})
          end
        end
        
        for k,v in pairs(ESX.PlayerData.inventory) do
          if v.count > 0 then
            table.insert(TruckMenu.Menu["deposer objet"].b, {name = v.label.." ("..v.count..")", itemtype = "item_standard", itemname = v.name, action = "deposit", ask = "→", askX = true})
          end
        end
        
        for k,v in ipairs(ESX.PlayerData.loadout) do
            table.insert(TruckMenu.Menu["deposer objet"].b, {name = v.label.." ("..v.ammo or "0" ..")", itemtype = "item_weapon", itemname = v.name, action = "deposit", ask = "→", askX = true})
        end
        OpenMenu("deposer objet")

      elseif btn.action == "deposit" then
        if btn.itemtype == "item_standard" then
          local amount = KeyboardInput("TRUCK_PUT", "Combien deposer ?", "", 4)
          if tonumber(amount) ~= nil then
            ESX.TriggerServerCallback("truck:PutItem", function(cb)
              if cb then
                if CurrentVehicle.item[btn.itemname] == nil then
                  CurrentVehicle.item[btn.itemname] = tonumber(amount)
                else
                  CurrentVehicle.item[btn.itemname] = CurrentVehicle.item[btn.itemname] + tonumber(amount)
                end
                CurrentVehicle.actualweight = CurrentVehicle.actualweight + tonumber(amount)
                CloseMenu()
                Citizen.Wait(500)
                OpenTruckMenu("deposit")
              end
            end, CurrentVehicle.plate, "item_standard", btn.itemname, tonumber(amount), CurrentVehicle.model)
          end

        elseif btn.itemtype == "item_weapon" then
          ESX.TriggerServerCallback("truck:PutItem", function(cb)
            if cb then
              if CurrentVehicle.weapon[btn.itemname] == nil then
                CurrentVehicle.weapon[btn.itemname] = 0
              else
                CurrentVehicle.weapon[btn.itemname] = CurrentVehicle.weapon[btn.itemname] + 0
              end
              CurrentVehicle.actualweight = CurrentVehicle.actualweight + 1
              CloseMenu()
              Citizen.Wait(500)
              OpenTruckMenu("deposit")
            end
          end, CurrentVehicle.plate, "item_weapon", btn.itemname, 0, CurrentVehicle.model)

        elseif btn.itemtype == "item_account" then
          local amount = KeyboardInput("TRUCK_PUT", "Combien deposer ?", "", 6)
          if tonumber(amount) ~= nil then
            ESX.TriggerServerCallback("truck:PutItem", function(cb)
              if cb then
                CurrentVehicle.black_money = CurrentVehicle.black_money + tonumber(amount)
                CloseMenu()
                Citizen.Wait(500)
                OpenTruckMenu("deposit")
              end
            end, CurrentVehicle.plate, "item_account", "black_money", tonumber(amount), CurrentVehicle.model)
          end
        end

      elseif btn.action == "withdraw" then
        if btn.itemtype == "item_standard" then
          local amount = KeyboardInput("TRUCK_GET", "Combien en prendre ?", "", 6)
            if tonumber(amount) ~= nil then
              ESX.TriggerServerCallback("truck:GetItem", function(cb)
                if cb then
                  CurrentVehicle.item[btn.itemname] = CurrentVehicle.item[btn.itemname] - tonumber(amount)
                  CurrentVehicle.actualweight = CurrentVehicle.actualweight - tonumber(amount)
                  CloseMenu()
                  Citizen.Wait(500)
                  OpenTruckMenu("withdraw")
                end
              end, CurrentVehicle.plate, "item_standard", btn.itemname, tonumber(amount))
            end

        elseif btn.itemtype == "item_weapon" then
          ESX.TriggerServerCallback("truck:GetItem", function(cb)
            if cb then
              CurrentVehicle.weapon[btn.itemname] = nil
              CurrentVehicle.actualweight = CurrentVehicle.actualweight - 1
              CloseMenu()
              Citizen.Wait(500)
              OpenTruckMenu("withdraw")
            end
          end, CurrentVehicle.plate, "item_weapon", btn.itemname, 0)

        elseif btn.itemtype == "item_account" then
          local amount = KeyboardInput("TRUCK_GET", "Combien en prendre ?", "", 6)
          if tonumber(amount) ~= nil then
            ESX.TriggerServerCallback("truck:GetItem", function(cb)
              if cb then
                CurrentVehicle.black_money = CurrentVehicle.black_money - tonumber(amount)
                CloseMenu()
                Citizen.Wait(500)
                OpenTruckMenu("withdraw")
              end
            end, CurrentVehicle.plate, "item_account", "black_money", tonumber(amount))
          end
        end

      end

    end
  },

  Menu = {
    ["coffre vehicule"] = {
      b = { 
        {name = "       -------------------- Poids: "..CurrentVehicle.actualweight.."/"..CurrentVehicle.max.." --------------------", action = "null"},
        {name = "Prendre un objet", action = "prendreobjet", ask = "→", askX = true},
        {name = "Deposer un objet", action = "deposerobjet", ask = "→", askX = true},
      }
    },
    ["prendre objet"] = {
      b = {}
    },
    ["deposer objet"] = {
      b = {}
    },
  }
}

CreateMenu(TruckMenu)

if type == "withdraw" then
  TruckMenu.Menu["prendre objet"].b = {}
  table.insert(TruckMenu.Menu["prendre objet"].b, {name = "Argent sale: ~r~"..ESX.Math.GroupDigits(CurrentVehicle.black_money).."$~s~", itemtype = "item_account", action = "withdraw", ask = "→", askX = true})

  for k,v in pairs(CurrentVehicle.item) do
   if v > 0 then
    for x,o in ipairs(ESX.PlayerData.inventory) do
      if o.name == k then
      local label = o.label
      table.insert(TruckMenu.Menu["prendre objet"].b, {name = label.." ("..v..")", itemtype = "item_standard", itemname = k, action = "withdraw", ask = "→", askX = true})
      end
    end
   end
  end
  
  for k,v in pairs(CurrentVehicle.weapon) do
  table.insert(TruckMenu.Menu["prendre objet"].b, {name = ESX.GetWeaponLabel(k) .." ("..v..")", itemtype = "item_weapon", itemname = k, action = "withdraw", ask = "→", askX = true})
  end
  OpenMenu("prendre objet")
elseif type == "deposit" then
  TruckMenu.Menu["deposer objet"].b = {}
  for k,v in pairs(ESX.PlayerData.accounts) do
    if v.name == "black_money" then
       table.insert(TruckMenu.Menu["deposer objet"].b, {name = "Argent sale: ~r~"..ESX.Math.GroupDigits(v.money).."$~s~", itemtype = "item_account", itemname = "black_money", action = "deposit", ask = "→", askX = true})
    end
  end
  
  for k,v in pairs(ESX.PlayerData.inventory) do
    if v.count > 0 then
      table.insert(TruckMenu.Menu["deposer objet"].b, {name = v.label.." ("..v.count..")", itemtype = "item_standard", itemname = v.name, action = "deposit", ask = "→", askX = true})
    end
  end
  
  for k,v in ipairs(ESX.PlayerData.loadout) do
      table.insert(TruckMenu.Menu["deposer objet"].b, {name = v.label.." ("..v.ammo or "0" ..")", itemtype = "item_weapon", itemname = v.name, action = "deposit", ask = "→", askX = true})
  end
  OpenMenu("deposer objet")
end

end

Citizen.CreateThread(function()
  while true do
  Citizen.Wait(250)
  if CloseToVehicle then
		local vehicle = GetClosestVehicle(ESX.PlayerData.cache.coords.x, ESX.PlayerData.cache.coords.y, ESX.PlayerData.cache.coords.z, 5.0, 0, 71)
		if DoesEntityExist(vehicle) then
			CloseToVehicle = true
		else
			CloseToVehicle = false
      CloseMenu()
      SetVehicleDoorShut(CurrentVehicle.vehicle, 5, false)
      CurrentVehicle = {}
    end
  else
  Citizen.Wait(500)
	end
  end
end)

RegisterNetEvent("truck:SetVehicleCL")
AddEventHandler("truck:SetVehicleCL", function(vehicle)
VehicleModel = vehicle
end)

RegisterCommand("+coffreveh", function()
 if not ESX.PlayerData.IsDead then
  TruckOpen = false
  openmenuvehicle()
 end
end, false)

RegisterKeyMapping("+coffreveh", "Coffre vehicule", "keyboard", "l")