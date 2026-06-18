local handsUp = false

-- HandsUP
RegisterCommand("+handsUp", function()
if not ESX.PlayerData.IsDead then
  local ped = ESX.PlayerData.cache.playerped
  if handsup then
    if DoesEntityExist(ped) then
      Citizen.CreateThread(function()
      RequestAnimDict("random@mugging3")
      while not HasAnimDictLoaded("random@mugging3") do
        Citizen.Wait(100)
      end

      if handsup then
        handsup = false
        ClearPedSecondaryTask(ped)
      end
      end)
    end
  else
    if DoesEntityExist(ped) then
      Citizen.CreateThread(function()
      RequestAnimDict("random@mugging3")
      while not HasAnimDictLoaded("random@mugging3") do
        Citizen.Wait(100)
      end

      if not handsup then
        handsup = true
        TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
      end
      end)
    end
  end
end
end, false)

-- Ragdoll
RegisterCommand("+ragdoll", function()
if not ESX.PlayerData.IsDead then
local myPed = ESX.PlayerData.cache.playerped
SetPedToRagdoll(myPed, 5000, 5000, 0, 0, 0, 0)
ResetPedRagdollTimer(myPed)
end
end, false)

local handsup = false
local crouched = false


RegisterCommand("+crouch", function()
  DisableControlAction(1, 36, true)
	DisableControlAction(2, 36, true)
    local ped = ESX.PlayerData.cache.playerped
    if not ESX.PlayerData.IsDead and not IsPauseMenuActive() then 
    RequestAnimSet( "move_ped_crouched" )

    while (not HasAnimSetLoaded( "move_ped_crouched" )) do 
        Citizen.Wait(100)
    end 

    if (crouched == true )then 
        ResetPedMovementClipset( ped, 0 )
        crouched = false 
    elseif (crouched == false) then
        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
        crouched = true 
    end 
end
end)

RegisterCommand("+crossarms", function()
    local ped = ESX.PlayerData.cache.playerped
    if not ESX.PlayerData.IsDead and not IsPauseMenuActive() then 
    if not handsup then
        TaskPlayAnim(ESX.PlayerData.cache.playerped, "amb@world_human_hang_out_street@female_arms_crossed@base", "base", 8.0, 8.0, -1, 50, 0, false, false, false)
        handsup = true
    else
        handsup = false
        ClearPedTasks(ESX.PlayerData.cache.playerped)
    end
end
end)

-- Menu perso
RegisterCommand("+menuperso", function()
  if not ESX.PlayerData.IsDead then
  OpenPersonalMenu()
  end
end, false)

-- Menu Illegal
RegisterCommand("+menuillegal", function()
  if not ESX.PlayerData.IsDead then
    OpenGangActionsMenu()
  end
end, false)

RegisterKeyMapping("animmenu", "Menu animations", "keyboard", "f3")
RegisterKeyMapping("+menuperso", "Menu personnel", "keyboard", "f5")
RegisterKeyMapping("radio", "Radio", "keyboard", "f9")
RegisterKeyMapping("+menuillegal", "Menu Illegal", "keyboard", "f7")
RegisterKeyMapping("+handsUp", "Lever les mains", "keyboard", "i")
RegisterKeyMapping("+ragdoll", "Tomber par terre", "keyboard", "numpad5")
RegisterKeyMapping("+stopanim", "Arreter animation", "keyboard", "x")
RegisterKeyMapping("+crouch", "S'accroupir", "keyboard", "lcontrol")
RegisterKeyMapping("+crossarms", "Croiser les bras", "keyboard", "b")
--RegisterKeyMapping("+vipmenu", "Vip Menu", "keyboard", "f11")
--[[local disableShuffle = true

function disableSeatShuffle(flag)
    disableShuffle = flag
end

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if disableShuffle and IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(vehicle, 0) == ped and GetIsTaskActive(ped, 165) then
                SetPedIntoVehicle(ped, vehicle, 0)
            end
        end
        Citizen.Wait(500) -- Réduction de la fréquence des vérifications
    end
end)

-- MONTER A L'ARRIERE DU VEHICULE
local doors = {
    {"seat_dside_f", -1},
    {"seat_pside_f", 0},
    {"seat_dside_r", 1},
    {"seat_pside_r", 2}
}

function VehicleInFront(ped)
    local pos = GetEntityCoords(ped)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Retrait du délai pour meilleure réactivité
        local ped = PlayerPedId()
        if IsControlJustReleased(0, 23) and not running and GetVehiclePedIsIn(ped, false) == 0 then
            local vehicle = VehicleInFront(ped)
            if vehicle then
                running = true
                local plyCoords = GetEntityCoords(ped, false)
                local nearestDoor, minDistance = nil, 2.0 -- Ajout d'une distance limite pour éviter les erreurs
                for _, door in ipairs(doors) do
                    local doorBone = GetEntityBoneIndexByName(vehicle, door[1])
                    if doorBone ~= -1 then
                        local doorPos = GetWorldPositionOfEntityBone(vehicle, doorBone)
                        local distance = #(plyCoords - doorPos) -- Utilisation d'une soustraction vectorielle pour optimiser
                        if distance < minDistance then
                            nearestDoor, minDistance = door[2], distance
                        end
                    end
                end
                if nearestDoor then
                    TaskEnterVehicle(ped, vehicle, -1, nearestDoor, 1.5, 1, 0)
                end
                Citizen.Wait(500) 
                running = false
            end
        end
    end
end)

Citizen.CreateThread(function()
  local seatKeys = {
      [157] = -1, 
      [158] = 0,  
      [160] = 1,  
      [164] = 2   
  }
  Citizen.Wait(1000)
  while true do
      Citizen.Wait(10)
      local ped = PlayerPedId()
      local vehicle = GetVehiclePedIsIn(ped, false)
      if vehicle ~= 0 and GetEntitySpeed(vehicle) * 3.6 <= 50.0 then 
          for key, seat in pairs(seatKeys) do
              if IsControlJustReleased(0, key) then
                  SetPedIntoVehicle(ped, vehicle, seat)
                  Citizen.Wait(500) 
                  break
              end
          end
      end
  end
end)
]]