function ManageGangAction(key)
    if not Gangs[ESX.PlayerData.job2.name] then return end
    if key == "cars" then
        CloseMenu()
        InGangMenu = true
        OpenGangVehiclesMenu()
    elseif key == "boss" then
        if ESX.PlayerData.job2.grade_name == "boss" or ESX.PlayerData.job2.grade_name == "bras-droit" then
            OpenBossMenu(ESX.PlayerData.job2.name, 2)
        end
    elseif key == "datastore" then
        TriggerEvent("coffre:OpenMenu", 2)
    end
end

function OpenGangActionsMenu()
    if not Gangs[ESX.PlayerData.job2.name] then return end
    GangActionsMenu = {
        Base = { Title = "Illegal", HeaderColor = { 255, 255, 255 } },
        Data = { currentMenu = "illegal" },
        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 1.0 then
                if not ESX.PlayerData.safe then
                 if btn.action == "search" then
                  if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "mp_arresting", "idle", 3) and IsPedOnFoot(GetPlayerPed(closestPlayer)) then
                   CloseMenu()
                   StartBodySearch(GetPlayerServerId(closestPlayer))
                  else
                   ESX.ShowNotification("Impossible de fouiller une personne qui n'est pas menottée ou qui est dans un véhicule.")
                  end
                 elseif btn.action == "handcuff" then
                    if ESX.PlayerData.safezone then ESX.ShowNotification("Vous ne pouvez pas faire ceci en safe zone") return end
                  if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "random@mugging3", "handsup_standing_base", 3) and IsPedOnFoot(GetPlayerPed(closestPlayer)) then
                       TriggerServerEvent("handcuff:on", GetPlayerServerId(closestPlayer))
                  else 
                   ESX.ShowNotification('La Personne n\'a pas les mains levées')
                  end
                 elseif btn.action == "unhandcuff" then
                    if ESX.PlayerData.safezone then ESX.ShowNotification("Vous ne pouvez pas faire ceci en safe zone") return end
                  if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "mp_arresting", "idle", 3) then
                   TriggerServerEvent("handcuff:off", GetPlayerServerId(closestPlayer))
                  else
                   ESX.ShowNotification("Cette personne n'est pas menottée.")
                  end
                 elseif btn.action == "drag" then
                    if ESX.PlayerData.safezone then ESX.ShowNotification("Vous ne pouvez pas faire ceci en safe zone") return end
                   TriggerServerEvent("handcuff:drag", GetPlayerServerId(closestPlayer))
                 elseif btn.action == "invehicle" then
                    if ESX.PlayerData.safezone then ESX.ShowNotification("Vous ne pouvez pas faire ceci en safe zone") return end
                   TriggerServerEvent("handcuff:ZiZouVehicle", GetPlayerServerId(closestPlayer))
                 elseif btn.action == "outvehicle" then
                    if ESX.PlayerData.safezone then ESX.ShowNotification("Vous ne pouvez pas faire ceci en safe zone") return end
                   TriggerServerEvent('handcuff:OutVehicle', GetPlayerServerId(closestPlayer))
                 end
                else
                 ESX.ShowNotification("Impossible en Zone Safe.")
                end
                else
                 ESX.ShowNotification("Personne à proximité.")
                end
               end
        },
        Menu = {
            ["illegal"] = {
                b = {
                    {name = "Ligoter", action = "handcuff", ask = "→", askX = true},
                    {name = "Liberer", action = "unhandcuff", ask = "→", askX = true},
                    {name = "Kidnapper", action = "drag", ask = "→", askX = true},
                    {name = "Fouiller", action = "search", ask = "→", askX = true},
                    {name = "Jeter dans véhicule", action = "invehicle", ask = "→", askX = true},
                    {name = "Sortir du véhicule", action = "outvehicle", ask = "→", askX = true}
                }
            }
        }
    }

    CreateMenu(GangActionsMenu)
end

function OpenGangVehiclesMenu()
    if not Gangs[ESX.PlayerData.job2.name] then return end
    local playerPed = ESX.PlayerData.cache.playerped
    local gangprefix = string.upper(string.sub(ESX.PlayerData.job2.name, 0, 4))
    GangVehiclesMenu = {
        Base = { Title = "Vehicules", HeaderColor = { 255, 255, 255 } },
        Data = { currentMenu = "garage" },
        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                if btn.action == "delveh" then

                    local found = false

                    local plate = GetVehicleNumberPlateText(ESX.PlayerData.cache.vehicle)
                    local prefix = string.upper(string.sub(plate, 0, 4))
                    if prefix == gangprefix then
                        ESX.Game.DeleteVehicle(ESX.PlayerData.cache.vehicle)
                        TriggerEvent('esx:showNotification', 'Le véhicule à bien été rangé.')
                        found = true
                        CloseMenu()
                    end

                    if not found then
                        TriggerEvent('esx:showNotification', 'Vous ne pouvez pas ranger ce véhicule.')
                    end
                elseif btn.action == "garage" then
                    GangVehiclesMenu.Menu["vehicules"].b = {}
                    for k, v in pairs(GangVehicles[Gangs[ESX.PlayerData.job2.name].type]) do
                        table.insert(GangVehiclesMenu.Menu["vehicules"].b, { name = v.label, model = v.model, action = "spawnveh", ask = "→", askX = true })
                    end
                    OpenMenu('vehicules')
                elseif btn.action == "spawnveh" then
                    ESX.Game.SpawnVehicle(btn.model, ESX.PlayerData.cache.coords, ESX.PlayerData.cache.heading, function(vehicle)
                        local plate = gangprefix .. ' ' .. math.random(100, 900)
                        local gangcolor = Gangs[ESX.PlayerData.job2.name].color
                        SetVehicleCustomPrimaryColour(vehicle, gangcolor[1], gangcolor[2], gangcolor[3])
                        SetVehicleNumberPlateText(vehicle, plate)
                        TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, vehicle, -1)
                        TriggerServerEvent("vehiclelock:preterkey", plate)
                        ESX.ShowNotification('Votre véhicule a été sorti.')
                        CloseMenu()
                    end, "gang")
                end
            end,
            onExited = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide)
                InGangMenu = false
            end
        },
        Menu = {
            ["garage"] = {
                b = {}
            },
            ["vehicules"] = {
                b = {}
            }
        }
    }

    if ESX.PlayerData.cache.invehicle then
        table.insert(GangVehiclesMenu.Menu["garage"].b, { name = 'Ranger le véhicule', action = 'delveh', ask = "→", askX = true })
    else
        table.insert(GangVehiclesMenu.Menu["garage"].b, { name = 'Sortir un véhicule', action = 'garage', ask = "→", askX = true })
    end

    CreateMenu(GangVehiclesMenu)
end



