local npcs = {}
local blips = {}

RegisterNetEvent("assassinEvent:spawnPedStealth")
AddEventHandler("assassinEvent:spawnPedStealth", function(id, pos, model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(100)
    end
    
    local found, spawnPos = GetNthClosestVehicleNode(pos.x, pos.y, pos.z, 1, 0, 0, 0)
    if found then
        local ped = CreatePed(4, GetHashKey(model), spawnPos.x, spawnPos.y, spawnPos.z, pos.h, true, true)
        TaskWanderStandard(ped, 10.0, 10)
        Wait(5000)
        TaskGoToCoordAnyMeans(ped, pos.x, pos.y, pos.z, 1.0, 0, 0, 786603, 0)
        SetPedCombatAttributes(ped, 46, true)
        SetPedCombatAbility(ped, 2)
        SetPedAsEnemy(ped, true)
        GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 250, false, true)
        TaskCombatHatedTargetsAroundPed(ped, 50.0)
        npcs[id] = ped

        -- Ajouter un blip sur la carte
        local blip = AddBlipForEntity(ped)
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 1)
        SetBlipScale(blip, 0.8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Cible")
        EndTextCommandSetBlipName(blip)
        blips[id] = blip
    end
end)

RegisterNetEvent("assassinEvent:endEvent")
AddEventHandler("assassinEvent:endEvent", function()
    for _, ped in pairs(npcs) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    for _, blip in pairs(blips) do
        RemoveBlip(blip)
    end
    npcs = {}
    blips = {}
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        for id, ped in pairs(npcs) do
            if DoesEntityExist(ped) and IsEntityDead(ped) then
                TriggerServerEvent("assassinEvent:pedKilled", id)
                npcs[id] = nil
                if blips[id] then
                    RemoveBlip(blips[id])
                    blips[id] = nil
                end
            end
        end
    end
end)
