inTrunk = false
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if inTrunk then
            local vehicle = GetEntityAttachedTo(ESX.PlayerData.cache.playerped)
            if DoesEntityExist(vehicle) or not IsPedDeadOrDying(ESX.PlayerData.cache.playerped) or not IsPedFatallyInjured(ESX.PlayerData.cache.playerped) then
                local coords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
                SetEntityCollision(ESX.PlayerData.cache.playerped, false, false)
                DrawText3D(coords, "[E] Sortir du coffre")

                if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                    SetEntityVisible(ESX.PlayerData.cache.playerped, false, false)
                else
                    if not IsEntityPlayingAnim(ESX.PlayerData.cache.playerped, "timetable@floyd@cryingonbed@base", 3) then
                        loadDict("timetable@floyd@cryingonbed@base")
                        TaskPlayAnim(ESX.PlayerData.cache.playerped, "timetable@floyd@cryingonbed@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
                        SetEntityVisible(ESX.PlayerData.cache.playerped, true, false)
                    end
                end
                if IsControlJustReleased(0, 38) and inTrunk then
                    SetCarBootOpen(vehicle)
                    SetEntityCollision(ESX.PlayerData.cache.playerped, true, true)
                    Wait(750)
                    inTrunk = false
                    DetachEntity(ESX.PlayerData.cache.playerped, true, true)
                    SetEntityVisible(ESX.PlayerData.cache.playerped, true, false)
                    ClearPedTasks(ESX.PlayerData.cache.playerped)
                    SetEntityCoords(ESX.PlayerData.cache.playerped, GetOffsetFromEntityInWorldCoords(ESX.PlayerData.cache.playerped, 0.0, -0.5, -0.75))
                    Wait(250)
                    SetVehicleDoorShut(vehicle, 5)
                end
            else
                SetEntityCollision(ESX.PlayerData.cache.playerped, true, true)
                DetachEntity(ESX.PlayerData.cache.playerped, true, true)
                SetEntityVisible(ESX.PlayerData.cache.playerped, true, false)
                ClearPedTasks(ESX.PlayerData.cache.playerped)
                SetEntityCoords(ESX.PlayerData.cache.playerped, GetOffsetFromEntityInWorldCoords(ESX.PlayerData.cache.playerped, 0.0, -0.5, -0.75))
            end
        else
        Wait(1000)
        end
    end
end)   

Citizen.CreateThread(function()
    while true do
        Wait(5)
        local vehicle = GetClosestVehicle(ESX.PlayerData.cache.coords, 5.0, 0, 71)
        if DoesEntityExist(vehicle) then
            local trunk = GetEntityBoneIndexByName(vehicle, "boot")
            if trunk ~= -1 then
                local coords = GetWorldPositionOfEntityBone(vehicle, trunk)
                if GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, coords, true) <= 1.5 then
                    if not inTrunk then
                        if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                            DrawText3D(coords, "[E] Se cacher dans le coffre")
                        else
                            DrawText3D(coords, "[E] Se cacher dans le coffre")
                        end
                    end
                    if IsControlJustReleased(0, 38) and not inTrunk then
                        Citizen.Wait(math.random(500, 2000))
                        local player = ESX.Game.GetClosestPlayer()
                        local playerPed = GetPlayerPed(player)
                        if DoesEntityExist(playerPed) then
                            if not IsEntityAttached(playerPed) or GetDistanceBetweenCoords(GetEntityCoords(playerPed), ESX.PlayerData.cache.coords, true) >= 5.0 then
                              if GetVehicleDoorLockStatus(vehicle) ~= 2 then
                                SetCarBootOpen(vehicle)
                                Wait(350)
                                AttachEntityToEntity(ESX.PlayerData.cache.playerped, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
                                loadDict("timetable@floyd@cryingonbed@base")
                                TaskPlayAnim(ESX.PlayerData.cache.playerped, "timetable@floyd@cryingonbed@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
                                Wait(50)
                                inTrunk = true
                                Wait(1500)
                                SetVehicleDoorShut(vehicle, 5)
                              else
                                ESX.ShowNotification("Ce coffre est ~r~fermé.~s~")
                              end
                            else
                                ESX.ShowNotification("Quelqu'un se cache déjà dans ce véhicule!")
                            end
                        end
                    end
                end
            end
        else
        Wait(1000)
        end
    end
end)

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end