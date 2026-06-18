local load = true

local tb = {}
local baseCoords = 29.8
local groundCoords = 29.392116928101

local isRolling = false

local roue, base, triangle, socle, veh, roueSpawn = nil,nil,nil,nil,false
local currentVehicleRewardModel = 'sultan'

local AntiSpamRoue = false

RegisterCommand("deleteroue", function()
    deleteRoue()
end)

RegisterCommand("spawnroue", function()
    GenerateRoue()
end)

function deleteRoue()
    DeleteEntity(triangle)
    triangle = nil
    DeleteEntity(base)
    base = nil
    DeleteEntity(socle)
    socle = nil
    DeleteEntity(veh)
    veh = nil
    DeleteEntity(roue)
    roue = nil
    roueSpawn = false
end


function startSpin()
    Citizen.CreateThread(function()
        local pos = 7
        SetEntityRotation(roue, 0, 0, 160.0, false, true);

        local deg = 0.0;
        local inc = 1;

        -- First step, increment speed
        for i = 1,200 do
            SetEntityRotation(roue, 0, -deg, 160.0, false, true);
            deg = deg + inc;

            if inc < 4 then
                inc = inc + 0.2;
            end

            Citizen.Wait(5);
        end

        while math.ceil((deg - ((inc / 0.01) / 2) % 360 - pos) % 360) >= 5 do
            SetEntityRotation(roue, 0, -deg, 160.0, false, true);
            deg = deg + inc;
            Citizen.Wait(5);
        end
        
        isRolling = false;
    end)
end


function GenerateRoue()
    -- Roue
    local model = GetHashKey('vw_prop_vw_luckywheel_02a')
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    roue = CreateObject(model, vector3(234.31323242188, -880.28216552734, (baseCoords)), false, false)
    -- Base
    model = GetHashKey("vw_prop_vw_luckywheel_01a")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    base = CreateObject(model, vector3(234.31323242188, -880.28216552734, (baseCoords-0.3)), false, false)
    -- Triangle
    model = GetHashKey("vw_prop_vw_jackpot_on")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    triangle = CreateObject(model, vector3(234.31323242188, -880.28216552734, (baseCoords+2.5)), false, false)
    -- Socle
    model = GetHashKey("vw_prop_vw_casino_podium_01a")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    socle = CreateObject(model, vector3(226.07943725586, -877.56732177734, 29.392116928101), false, false)
    SetEntityRotation(roue, GetEntityPitch(roue), GetEntityRoll(roue), 160.0, 3, 1)
    SetEntityRotation(base, GetEntityPitch(base), GetEntityRoll(base), 160.0, 3, 1)
    SetEntityRotation(triangle, GetEntityPitch(triangle), GetEntityRoll(triangle), 160.0, 3, 1)
    -- Véhicule
    model = GetHashKey(currentVehicleRewardModel)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    veh = CreateVehicle(model, vector3(226.07943725586, -877.56732177734, 29.592116928101), 90.0, false, false)
    FreezeEntityPosition(veh, true)
    SetVehicleDoorsLocked(veh, 2)
    SetEntityInvincible(veh, true)
    SetVehicleFixed(veh)
    SetVehicleDirtLevel(veh, 0.0)
    SetVehicleEngineOn(veh, true, true, true)
    SetVehicleLights(veh, 2)
    SetVehicleCustomPrimaryColour(veh, 33,33,33)
    SetVehicleCustomSecondaryColour(veh, 33,33,33)
    roueSpawn = true
end

Citizen.CreateThread(function()
    local rot = 1.0
    while true do
        if roueSpawn and socle and veh then
            rot = rot - 0.15
            SetEntityRotation(socle, GetEntityPitch(socle), GetEntityRoll(socle), rot, 3, 1)
            SetEntityHeading(veh, rot)
            Wait(5) -- Rotation fluide
        else
            Wait(1000) -- Réduction de la charge quand inutilisé
        end
    end
end)


Citizen.CreateThread(function()
    while not load do 
        Wait(0)
    end
    while true do
        local basePos = vector3(236.00059509277, -880.18023681641, 30.492071151733)
        local dist = GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, basePos, true)
        if roueSpawn then
            if dist > 150.0 then
                deleteRoue()
                Wait(2500)
            else
                if dist <= 2.0 and not isRolling then
                    ESX.ShowHelpNotification('~g~Roue de la Fortune ~n~~w~Appuie sur ~g~E~w~ pour tourner la roue') 
                    if IsControlJustPressed(0, 51) then
                        if not AntiSpamRoue then
                            AntiSpamRoue = true
                            Citizen.SetTimeout(5000, function()
                            AntiSpamRoue = false
                            end)
                        RequestRoueTourne()
                        else
                            ESX.ShowNotification("Veuillez attendre avant de relancer la roue")
                        end
                        
                    end
                end
            end
        else
            if dist < 150.0 then
                GenerateRoue()
            end
            Wait(2500)
        end
        Wait(5)
    end
end)

function RequestRoueTourne()
    local pos = ESX.PlayerData.cache.coords
    local basePos = vector3(236.00059509277, -880.18023681641, 30.492071151733)
    local dist = GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, basePos, true)
    ESX.TriggerServerCallback('store:RequestRoueStart', function(response)
        if response then
            if response == "can" then
                isRolling = true

                local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
                if IsPedMale(ESX.PlayerData.cache.playerped) then
                    _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
                end
                local lib, anim = _lib, 'enter_right_to_baseidle'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskGoStraightToCoord(ESX.PlayerData.cache.playerped,  basePos.x, basePos.y, (baseCoords),  1.0,  -1,  107.2,  0.0)
                    local hasMoved = false
                    while not hasMoved do
                        local coords = ESX.PlayerData.cache.coords
                        if coords.x >= (basePos.x - 0.01) and coords.x <= (basePos.x + 0.01) and coords.y >= (basePos.y - 0.01) and coords.y <= (basePos.y + 0.01) then
                            hasMoved = true
                        end
                        Citizen.Wait(0)
                    end
                    TaskPlayAnim(ESX.PlayerData.cache.playerped, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                    TaskPlayAnim(ESX.PlayerData.cache.playerped, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
                    startSpin()
                end)
            elseif response == "aleardy" then
                ESX.ShowNotification('Quelqu\'un est déjà entrain de tourner la roue !')
            elseif response == "notfound" then
                ESX.ShowNotification('Vous n\'avez pas de ticket !')
            end
        end
    end)
end

