local safezones = {
    -- Parkings & Pounds
    ["parking central"] = {coords = {x = 205.62, y = -927.62, z = 29.06}, radius = 200},
    ["parking pole emploi"] = {coords = {x = -326.0, y = -879.6, z = 30.0}, radius = 100},
    ["parking ville nord"] = {coords = {x = 71.795, y = 23.907, z = 68.364}, radius = 50},
    ["parking nord"] = {coords = {x = 1698.0, y = 3602.2, z = 34.5}, radius = 50},
    ["parking plage"] = {coords = {x = -1523.191, y = -451.017, z = 34.596}, radius = 50},
    ["parking sud"] = {coords = {x = 437.8140, y = -1958.572, z = 21.957}, radius = 50},
    ["fourriere sud"] = {coords = {x = 491.520, y = -1332.836, z = 28.334}, radius = 100},
    ["fourriere nord"] = {coords = {x = 1177.590, y = 2651.501, z = 36.809}, radius = 100},
    -- Jobs
    ["chantier"] = {coords = {x = -484.5, y = -994.9, z = 22.5}, radius = 200},
    ["recolte vigneron"] = {coords = {x = -1809.6, y = 2210.1, z = 90.6}, radius = 100},
    ["traitement vigneron"] = {coords = {x = -3.826, y = 3.157, z = 70.0}, radius = 25},
    ["vente vigneron"] = {coords = {x = 275.0, y = 6.7, z = 78.2}, radius = 50},
    ["recolte tabac"] = {coords = {x = 2886.9, y = 4609.4, z = 46.9}, radius = 100},
    ["traitement tabac"] = {coords = {x = 987.0, y = -144.4, z = 73.2}, radius = 100},
    ["vente tabac"] = {coords = {x = 68.9, y = 127.1, z = 78.2}, radius = 100},
    -- Others
    ["spawn"] = {coords = {x = -554.63, y = -645.33, z = 33.23}, radius = 50},
    ["concessionaire"] = {coords = {x = -789.0, y = -225.5, z = 37.0}, radius = 100},
    ["bennys"] = {coords = {x = -205.592, y = -1310.479, z = 31.311}, radius = 100},
    ["comico"] = {coords = {x = 447.452, y = -992.327, z = 24.420}, radius = 100},
    ["hopital"] = {coords = {x = 315.755, y = -591.371, z = 42.284}, radius = 100},
    ["hopital interior"] = {coords = {x = 253.151, y = -1366.496, z = 21.347}, radius = 100},
    ["prison"] = {coords = {x = 1643.759, y = 2530.987, z = 44.564}, radius = 100},
    ["banque pc"] = {coords = {x = 151.811, y = -1040.959, z = 28.374}, radius = 100},
    ["agence immo"] = {coords = {x = -138.5, y = -634.9, z = 168.8}, radius = 25},
    ["front agence immo"] = {coords = {x = -220.0, y = -569.0, z = 34.6}, radius = 100},
    ["superette centre"] = {coords = {x = 33.3, y = -1345.3, z = 28.4}, radius = 100},

    ---
    ["casinodehors"] = {coords = {x = 923.55, y = 47.62, z = 81.11}, radius = 100},
    ["casinodededans"] = {coords = {x = 1097.85, y = 214.31, z = -49.00}, radius = 200},
}


local notifications = {
    enter = false,
    exit = false
}

local FirstNotif = true

local inSafeZone = false

Citizen.CreateThread(function()
  local clothescount = 0
  local ammucount = 0
  local accessoriescount = 0
  for k, v in pairs(ShopsLocations) do
    if v.type == "clothes" then
      clothescount = clothescount + 1
      safezones[v.type .. clothescount] = {coords = v.coords, radius = 50}

    elseif v.type == "weashop" then
      ammucount = ammucount + 1
      safezones[v.type .. ammucount] = {coords = v.coords, radius = 50}
    elseif v.type == "accessories" then
      accessoriescount = accessoriescount + 1
      safezones[v.type .. accessoriescount] = {coords = v.coords, radius = 100}
    end
  end
end)

Citizen.CreateThread(function()
  while not ESX.PlayerData.PassJoin do
    Wait(100)
  end
    while true do
        Wait(500)
        local player = ESX.PlayerData.cache.playerped
        local playercoords = GetEntityCoords(player, true)
        local radius = 0
        local distance = 0
        
        for k,v in pairs(safezones) do
            distance = Vdist(v.coords.x, v.coords.y, v.coords.z, playercoords.x, playercoords.y, playercoords.z)
            radius = v.radius
            if distance <= radius then
                break
            end
        end

        if distance <= radius then
            if not notifications.enter then
                ToggleSafeZone(true)
                notifications.enter = true
                notifications.exit = false
            end
        else
            if not notifications.exit then
                ToggleSafeZone(false, notifications.enter)
                notifications.exit = true
                notifications.enter = false
            end
        end  

        if (inSafeZone and ESX.PlayerData.group == "user") or ESX.PlayerData.jail.time > 0 or ESX.PlayerData.AFK then
            local ped = ESX.PlayerData.cache.playerped
            local player = ESX.PlayerData.cache.playerped
            local vehicle = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
                if IsPedArmed(ped, 7) then
                    SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
                end
                SetPlayerCanDoDriveBy(PlayerId(), false)
                if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(PlayerId())) then
                    SetEntityInvincible(vehicle, true)
                end
            else
                SetPlayerCanDoDriveBy(PlayerId(), true)
        end
    end
end)

function ToggleSafeZone(toggle, aleardyentered)
    local player = ESX.PlayerData.cache.playerped
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
    inSafeZone = toggle
      if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(PlayerId())) then
        SetEntityInvincible(vehicle, toggle)
      end
      SetPedCanBeKnockedOffVehicle(player, 1)
      SetEntityInvincible(player, toggle)
      NetworkSetFriendlyFireOption(not toggle)
      if toggle then
        TriggerEvent('nui:on')
        ESX.PlayerData.safezone = true
        if ESX.PlayerData.group == "user" then
        SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
        end
      else
        if aleardyentered then
          ESX.PlayerData.safezone = false
        TriggerEvent('nui:off')
        TriggerEvent('nui:on2')
        Wait(3000)
        TriggerEvent('nui:off2')
        end
      end
end

Citizen.CreateThread(function()
  while not ESX.PlayerData.PassJoin do
    Wait(100)
  end
    while true do
     Citizen.Wait(5)
     if (inSafeZone and ESX.PlayerData.group == "user") or ESX.PlayerData.jail.time > 0 or ESX.PlayerData.AFK then
       local player = ESX.PlayerData.cache.playerped
       DisableControlAction(2, 37, true)
       DisablePlayerFiring(player, true)
       DisableControlAction(0, 106, true)
       DisableControlAction(0, 140, true)
       DisableControlAction(0, 142, true)
       DisableControlAction(0, 257, true)
       DisableControlAction(0, 24, true)
       if IsDisabledControlJustPressed(2, 37)
       or IsDisabledControlJustPressed(0, 106)
       or IsDisabledControlJustPressed(0, 142)
       or IsDisabledControlJustPressed(0, 24)
       or IsDisabledControlJustPressed(0, 257) then
      if inSafeZone then
       ESX.ShowNotification("Vous ne pouvez pas faire ceci en safe zone.", "error")
      end
       SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
       end
     else
     Citizen.Wait(1000)
     end
    end
end)

Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5000)
     for _,player in ipairs(GetActivePlayers()) do
       if GetPlayerPed(player) ~= ESX.PlayerData.cache.playerped then
         local ped = ESX.PlayerData.cache.playerped
         local everyone = GetPlayerPed(player)
         local everyoneveh = GetVehiclePedIsUsing(everyone)
         if IsPedInAnyVehicle(everyone, false) then
           SetEntityNoCollisionEntity(ped, everyoneveh, false)
           SetEntityNoCollisionEntity(everyoneveh, ped, false)
         else
           SetEntityNoCollisionEntity(ped, everyone, false)
         end
       end
     end
    end
end)