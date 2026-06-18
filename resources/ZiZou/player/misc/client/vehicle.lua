link = 'aucune'
timecode = "Bientot mdr"
VideoPlaying = false
local carpos = vector3(0, 0, 0)
volume = 0.5

CarRadios = {}

--[[RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
ESX.TriggerServerCallback('esx:RequestCarRadios', function(radios)
  CarRadios = radios
end)
end)]]
    
    local kmh = 1.9
    local mph = 1.33693629
    local carspeed = 0
    local driftmode = false
    local speed = kmh
    local drift_speed_limit = 70.0

    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(100)
            if driftmode then
    
                if IsPedInAnyVehicle(ESX.PlayerData.cache.playerped, false) then
    
                    CarSpeed = GetEntitySpeed(GetVehiclePedIsIn(ESX.PlayerData.cache.playerped,false)) * speed
    
                    if GetPedInVehicleSeat(GetVehiclePedIsIn(ESX.PlayerData.cache.playerped,false), -1) == ESX.PlayerData.cache.playerped then
    
                        if CarSpeed <= drift_speed_limit then  
    
                            if IsControlPressed(1, 21) then
                                SetVehicleReduceGrip(GetVehiclePedIsIn(ESX.PlayerData.cache.playerped,false), true)
                            else
                                SetVehicleReduceGrip(GetVehiclePedIsIn(ESX.PlayerData.cache.playerped,false), false)
                            end
                        end
                    end
                end
            end
        end
    end)

    RegisterCommand("+driftmode", function(source, args, raw)
      driftmode = not driftmode
    
                if driftmode then
                    ESX.ShowNotification("~g~Drift mode activé~s~.")
                else
                    ESX.ShowNotification("~r~Drift mode désactivé~s~.")
                end
    end, false)

    RegisterKeyMapping("+driftmode", "Mode Drift", "keyboard", "l")
  
    
    RegisterCommand("shuffle", function(source, args, raw)
    TriggerEvent("SeatShuffle")
    end, false)
    
    Citizen.CreateThread(function()
     while true do
      Citizen.Wait(2)
      if DoesEntityExist(GetVehiclePedIsTryingToEnter(ESX.PlayerData.cache.playerped)) then
        local veh = GetVehiclePedIsTryingToEnter(ESX.PlayerData.cache.playerped)
        local pedd = GetPedInVehicleSeat(veh, -1)
        if pedd then
          SetPedCanBeDraggedOut(pedd, false)
        end
      else
        Citizen.Wait(500)
      end
     end
    end)

Citizen.CreateThread(function()
    while true do
     Citizen.Wait(2500)
     if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name ~= nil then
       local playerPed = ESX.PlayerData.cache.playerped
       local coords = GetEntityCoords(playerPed)
       local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
       local carModel = GetEntityModel(veh)
       if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
         local plate = GetVehicleNumberPlateText(veh)
         local prefix = string.upper(string.sub(plate, 0, 4))
         if prefix == "POLI" and ESX.PlayerData.job.name ~= "police" and ESX.PlayerData.job.name ~= "doa" then
           ESX.ShowNotification("Un véhicule de police n'est pas réservée aux civils.")
           SetVehicleUndriveable(veh, true)
           SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
         elseif prefix == "BCSO" and ESX.PlayerData.job.name ~= "sheriff" and ESX.PlayerData.job.name ~= "doa" then
            ESX.ShowNotification("Un véhicule de BCSO n'est pas réservée aux civils.")
            SetVehicleUndriveable(veh, true)
            SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
         elseif prefix == "AMBU" and ESX.PlayerData.job.name ~= "ambulance" then
           ESX.ShowNotification("Un véhicule d'ambulance n'est pas réservée aux civils.")
           SetVehicleUndriveable(veh, true)
           SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
         elseif prefix == "TAXI" and ESX.PlayerData.job.name ~= "taxi" then
           ESX.ShowNotification("Un véhicule de taxi n'est réservée qu'aux taxis.")
           SetVehicleUndriveable(veh, true)
           SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
        end
       end
    end
end
end)


Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   if DoesEntityExist(GetVehiclePedIsTryingToEnter(ESX.PlayerData.cache.playerped)) then
     local veh = GetVehiclePedIsTryingToEnter(ESX.PlayerData.cache.playerped)
     local pedd = GetPedInVehicleSeat(veh, -1)
     if pedd then
       SetPedCanBeDraggedOut(pedd, false)
     end
   else
     Citizen.Wait(500)
   end
  end
 end)

-- Car Radio


--[[Citizen.CreateThread(function()
  while true do
   Citizen.Wait(0)
      --local playerpos = GetEntityCoords(playerPed)
      if VideoPlaying then
      if IsPedInAnyVehicle(ESX.PlayerData.cache.playerped, false) then
      local vehicle = GetVehiclePedIsIn(ESX.PlayerData.cache.playerped, false)
      local dst = GetDistanceBetweenCoords(GetEntityCoords(vehicle, false), carpos, true)
      if dst > 2 then
      carpos = GetEntityCoords(vehicle, false)
      TriggerServerEvent('esx:UpdateCarRadio', "carradio_" .. ESX.PlayerData.identifier, 'pos', carpos)
      end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
      NearZone = false
      local pPed = ESX.PlayerData.cache.playerped
      local pCoords = GetEntityCoords(pPed)
      for k,v in pairs(CarRadios) do

          local dst = GetDistanceBetweenCoords(pCoords, v.pos, true)
          if not NearZone then
              if dst < v.dst then
                  NearZone = true
                  if soundExists(v.name) then
                      Resume(v.name)
                  else
                      PlayUrlPos(v.name, v.link, v.max, v.pos, true)
                      setVolumeMax(v.name, v.max)
                      Distance(v.name, v.dst)
                      print("Ambience "..v.name.." created and ^2started")
                  end
              else
                  if soundExists(v.name) then
                      if not isPaused(v.name) then
                          Pause(v.name)
                      end
                  end
              end
              if v.pos and v.pos.x and v.pos.y and v.pos.z then
                Position(v.name, v.pos)
              end
          end
      end

      if not NearZone then
          Wait(350)
      else
          Wait(0)
      end
  end
end)

function OpenCarRadioMenu()
  CarRadioMenu = {
      Base = { Title = "Radio Voiture", HeaderColor = {143, 17, 21} },
      Data = { currentMenu = "radio" },
      Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
          if btn.action == 'stopmusic' then
            StopCarVideo()
          elseif btn.action == 'volume' then
            local volume = KeyboardInput("ESX_CARRADIO", "Volume de la video", "", 3)
             if tonumber(volume) then
                --setVolume("radio_music", volume / 100)
                --TriggerServerEvent('esx:UpdateCarRadio', "carradio_" .. ESX.PlayerData.identifier, 'max', volume / 100)
              end
          end
          --ESX.ShowNotification('Bientôt disponible les enfants !')
      end
    },
  
    Menu = {
      ["radio"] = {
        b = {
          {name = "Vidéo Youtube : ".. link, action = "null", ask = "→", askX = true},
          {name = "Avancement de la video : " .. timecode, action = "changetimecode", ask = "→", askX = true},
          {name = "Changer de vidéo", action = "changemusic", ask = "→", askX = true},
          {name = "Arrêter la vidéo", action = "stopmusic", ask = "→", askX = true},
          {name = "Régler le volume", action = "volume", ask = "→", askX = true},
        }
      },
    }
  }
  CreateMenu(CarRadioMenu)
end

function StopCarVideo()
  if VideoPlaying then
    Destroy("radio_music")
    VideoPlaying = false
    link = 'aucune'
  end
end

Citizen.CreateThread(function()
  print('test')
end)

RegisterCommand("setcarvideo", function(source, args, rawCommand)
  if IsPedInAnyVehicle(ESX.PlayerData.cache.playerped, false) then
  if args[1] then
    local prefix = string.sub(args[1], 0, 32)
    if prefix == 'https://www.youtube.com/watch?v=' then
      --link = args[1]
      Destroy("carradio_" .. ESX.PlayerData.identifier)
      TriggerServerEvent('esx:DeleteCarRadio', "carradio_" .. ESX.PlayerData.identifier)
      local vehicle = GetVehiclePedIsIn(ESX.PlayerData.cache.playerped, false)
      local carposition = GetEntityCoords(vehicle, false)
      TriggerServerEvent('esx:InsertCarRadio', carposition, args[1])
      VideoPlaying = true
    else
      ESX.ShowNotification('Lien Invalide')
    end
  else
    ESX.ShowNotification('Lien Invalide')
  end
else 
  ESX.ShowNotification('Vous devez être dans un véhicule pour faire ceci')
end
end, false)

RegisterNetEvent("esx:UpdateCarRadios")
AddEventHandler("esx:UpdateCarRadios", function(radios)
  CarRadios = radios
end)

RegisterCommand("+carradio", function()
Destroy("radio_music")
local link = KeyboardInput("ESX_CARRADIO", "Lien de la video", "", 99999999)
if link ~= nil then
  PlayUrl("radio_music", 'https://www.youtube.com/watch?v=' .. link, 0.2, false)
end
OpenCarRadioMenu()
--ESX.ShowNotification('Bienôt disponible !')
end, false)]]