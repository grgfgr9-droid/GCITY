local chantierState = false
local ServiceChantier = false

local menuChantier = {
    Base = { Title = "Chantier", HeaderColor = {255, 255, 255} },
    Data = { currentMenu = "Options" },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
            if btn.action == "start" then
                TriggerServerEvent('zizou:prisedeservice')
                ServiceChantier = true
                Chantier()
            elseif btn.action == "stop" then
                TriggerServerEvent('zizou:findeservice')
                ServiceChantier = false
                RemoveBlip(blip) -- Supprimer le blip si le service s'arrête
            end
        end
    },
    Menu = {
        ["Options"] = {
            b = {
                { name = "Prendre son service", action = "start", ask = "→", askX = true },
                { name = "Quitter son service", action = "stop", ask = "→", askX = true }
            }
        }
    }
}

function OpenMenuChantier()
    CreateMenu(menuChantier)
end

local blip = nil

function Chantier()
    if ServiceChantier then
        if blip ~= nil then
            RemoveBlip(blip)
        end
        local posfe = ZiZouConfig.ConfigChantier.PointRecolte[math.random(1, #ZiZouConfig.ConfigChantier.PointRecolte)]
        blip = AddBlipForCoord(posfe.x, posfe.y, posfe.z)
        SetBlipSprite(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Point de réparation')
        EndTextCommandSetBlipName(blip)
        recoltechantier(posfe) -- Redémarrer la boucle
    else
        RemoveBlip(blip)
    end
end

function recoltechantier(posfe)
  CreateThread(function()
      print("🔄 La fonction recoltechantier tourne") -- Debug

      while ServiceChantier do
          Wait(0) -- Mettre 0 pour éviter un délai trop long

          local playerCoords = GetEntityCoords(PlayerPedId())
          local distance = #(playerCoords - vector3(posfe.x, posfe.y, posfe.z))

          print("📍 Distance au point : ", distance) -- Debug distance

          if distance <= 5 then
              ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~p~travailler~s~")

              if IsControlJustPressed(1, 38) then
                  print("✅ Bouton pressé") -- Si ce print ne s'affiche pas, la touche n'est pas reconnue

                  FreezeEntityPosition(PlayerPedId(), true)
                  TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HAMMERING", 0, true)
                  Wait(4000)
                  FreezeEntityPosition(PlayerPedId(), false)
                  ClearPedTasks(PlayerPedId())

                  print("💰 Envoi du paiement")
                  TriggerServerEvent('zizou:paiementchantier')

                  Chantier() -- Génère un nouveau point
              end
          end
          Wait(500)
      end
  end)
end



CreateThread(function()
    while true do
        local Timer = 500
        local plyCoords = GetEntityCoords(PlayerPedId())
        local dist = #(plyCoords - vector3(-509.526, -1001.674, 22.550))
        if dist <= 5.0 then
            Timer = 0
            DrawMarker(1, -509.526, -1001.674, 22.550, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu chantier")
            if IsControlJustPressed(1, 51) then
                OpenMenuChantier()
            end
        end
        Wait(Timer)
    end
end)

