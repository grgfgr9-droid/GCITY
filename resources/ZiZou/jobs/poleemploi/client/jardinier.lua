local jardinierState = false
local blip = nil

local menuJardinier = {
    Base = { Title = "Jardinier", HeaderColor = {255, 255, 255} },
    Data = { currentMenu = "Options" },
    Events = {
        onSelected = function(self, _, btn)
            if btn.action == "start" then
                TriggerServerEvent('zizou:prisedeservice')
                jardinierState = true
                ServiceJardinier()
            elseif btn.action == "stop" then
                TriggerServerEvent('zizou:findeservice')
                jardinierState = false

                -- Suppression des entités et du blip
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                    blip = nil
                end
                if DoesEntityExist(car) then
                    DeleteEntity(car)
                end
                if DoesEntityExist(herbe) then
                    DeleteEntity(herbe)
                end
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

function OpenMenuJardinier()
    CreateMenu(menuJardinier)
end

function ServiceJardinier()
    TriggerEvent('esx:spawnVehicle', 'mower')
    spawnJardinierMarker()
end

function spawnJardinierMarker()
    if not jardinierState then return end -- Empêcher la création du blip si le joueur n'est plus en service

    local posfe = ZiZouConfig.ConfigJardinier.PointRecolte[math.random(1, #ZiZouConfig.ConfigJardinier.PointRecolte)]

    -- Suppression de l'ancien blip s'il existe
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end

    -- Création d'un nouveau blip
    blip = AddBlipForCoord(posfe.x, posfe.y, posfe.z)
    SetBlipSprite(blip, ZiZouConfig.ConfigJardinier.Jardinier.BlipsAleatoire.model)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, ZiZouConfig.ConfigJardinier.Jardinier.BlipsAleatoire.taille)
    SetBlipColour(blip, ZiZouConfig.ConfigJardinier.Jardinier.BlipsAleatoire.couleur)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Zone de tonte")
    EndTextCommandSetBlipName(blip)

    Citizen.CreateThread(function()
        while jardinierState do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - vector3(posfe.x, posfe.y, posfe.z))

            if distance < 10.0 then
                Citizen.Wait(5)
                DrawMarker(1, posfe.x, posfe.y, posfe.z - 1.0, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.2, 0, 255, 0, 150, false, false, 2, false, nil, nil, false)

                if distance < 2.5 then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    if vehicle ~= 0 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer à tondre la pelouse")

                        if IsControlJustPressed(0, 38) then
                            ESX.ShowNotification("Vous commencez à tondre la pelouse...")
                            FreezeEntityPosition(vehicle, true)
                            Citizen.Wait(5000)
                            FreezeEntityPosition(vehicle, false)
                            ESX.ShowNotification("Tonte terminée ! Vous avez été payé.")

                            TriggerServerEvent('zizou:paiementjardinier')

                            -- Suppression de l'ancien blip et création d'un nouveau point
                            if DoesBlipExist(blip) then
                                RemoveBlip(blip)
                            end
                            spawnJardinierMarker() -- Recréation immédiate d'un nouveau blip
                            return -- On quitte le thread proprement
                        end
                    else
                        ESX.ShowNotification("Vous devez être dans un véhicule pour tondre la pelouse.")
                    end
                end
            else
                Citizen.Wait(500)
            end
        end
    end)
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'jardinier' then 
            local plyCoords = GetEntityCoords(PlayerPedId())
            local dist = Vdist(plyCoords, ZiZouConfig.ConfigJardinier.Jardinier.Position.pos.x, ZiZouConfig.ConfigJardinier.Jardinier.Position.pos.y, ZiZouConfig.ConfigJardinier.Jardinier.Position.pos.z)

            if dist <= 5.0 then
                Timer = 0
                DrawMarker(
                    ZiZouConfig.ConfigEmploie.Position.Emploie.marker, 
                    ZiZouConfig.ConfigJardinier.Jardinier.Position.pos.x, 
                    ZiZouConfig.ConfigJardinier.Jardinier.Position.pos.y, 
                    ZiZouConfig.ConfigJardinier.Jardinier.Position.pos.z, 
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
                    ZiZouConfig.ConfigEmploie.LargeurX, 
                    ZiZouConfig.ConfigEmploie.LargeurY, 
                    ZiZouConfig.ConfigEmploie.LargeurZ, 
                    ZiZouConfig.ConfigEmploie.colorR, 
                    ZiZouConfig.ConfigEmploie.colorG, 
                    ZiZouConfig.ConfigEmploie.colorB, 
                    ZiZouConfig.ConfigEmploie.Opacity, 
                    ZiZouConfig.ConfigEmploie.MarkerSaute, 
                    true, 2, 
                    ZiZouConfig.ConfigEmploie.MarkerTourne, 
                    nil, nil, false
                )
                
                ESX.ShowHelpNotification(ZiZouConfig.ConfigJardinier.Jardinier.Position.text)
                
                if IsControlJustPressed(1, 51) then
                    OpenMenuJardinier()
                end
            end
        end 
        Wait(Timer)
    end
end)

CreateThread(function()
    local hash = GetHashKey("s_m_m_movspace_01")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end
    local ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_movspace_01", -1357.418, 124.2668, 55.23864, 3.348044, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
end)
