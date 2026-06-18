local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH", "PICKUP_WEAPON_RAYCARBINE"}
local HeartBeats = 0
local blkey = {121, 178, 10, 11}
local ClearHeartBeat = true
local isDetected = false

Citizen.CreateThread(function()
    if ACConfig.Enable then
        StartAC()
    end
end)

function StartAC()
 
    --StartHeartBeatThread()
    if ACConfig.EnableChecks then
        if ACConfig.ServerType.ESX then
           while not ESX.PlayerLoaded do 
            Wait(0)
           end 
        end
    if ACConfig.EnableChecks.Weapons and ACConfig.ServerType then
        StartWeaponCheck()
    end
    if ACConfig.EnableChecks.CarSpawn then
        StartCarSpawnCheck()
    end
    if ACConfig.EnableChecks.Others then
        StartSomeChecks()
        if ACConfig.EnableChecks.Others.WeaponDrops then
            RemoveWeaponDrops()
        end
        if ACConfig.EnableChecks.Others.GodMode then
            StartGodModeCheck()
        end
        if ACConfig.EnableChecks.Others.AntiEngineDestroy then
            StartAntiEngineDestroy()
        end
    end
    end
end


function StartHeartBeatThread()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            if ESX.PlayerData.PassJoin then
            HeartBeats = HeartBeats - 1
            end
            if HeartBeats < -2 then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Attempt to stop resource : pouf")
                break
            end
            Citizen.CreateThread(function()
                SendHeartBeat()
            end)
            if ClearHeartBeat and HeartBeats > 0 then
                HeartBeats = 0
            end
            Wait(2500)
        end
    end)
end

function SendHeartBeat()
    exports.pouf:checkStop()
    ClearHeartBeat = false
end

function ZiZoucheckStop()
    HeartBeats = HeartBeats + 1
end

function StartWeaponCheck()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            Citizen.Wait(5000)
            local PedWeapons = {}
            local weapon = GetSelectedPedWeapon(ESX.PlayerData.cache.playerped)
            if weapon ~= GetHashKey("weapon_unarmed") and weapon ~= 0 then
                local weaponData = ESX.GetWeaponFromHash(weapon)
                TriggerServerEvent(ACConfig.Name .. ":checkWeapon", weaponData)
            end 
        end
    end)
end

function StartCarSpawnCheck()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            Citizen.Wait(500)
            for vehicle in EnumerateVehicles() do
                local handle = GetEntityScript(vehicle)
				if handle and not ACConfig.WhiteListedResources[handle] then
                    Delete(vehicle)
                    TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Car spawn")
                    break
				end
            end
        end
    end)
end
Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()

        if IsPedArmed(player, 6) then
            -- Si armé, on bloque les coups de crosse
            DisableControlAction(0, 140, true) -- R
            DisableControlAction(0, 141, true) -- Q
            DisableControlAction(0, 142, true) -- clic gauche de près
            Wait(0) -- continuer en temps réel pendant que c'est actif
        else
            -- Si pas armé, on peut se permettre de dormir un peu
            Wait(500)
        end
    end
end)


function StartSomeChecks()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            Citizen.Wait(250) 
            
            local ped = ESX.PlayerData.cache.playerped
            if ACConfig.EnableChecks.Others.Spectator and NetworkIsInSpectatorMode() and ESX.PlayerData.group == "user" then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Spectator Mode")
                break
            end
            if ACConfig.EnableChecks.Others.ThermalVision and GetUsingseethrough() then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Thermal Vision")
                break
            end
            if ACConfig.EnableChecks.Others.NightVision and GetUsingnightvision() then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Night Vision")
                break
            end
            if ACConfig.EnableChecks.texturenamebl then
                local textureLoaded = true
                for _, textureName in pairs(ACConfig.EnableChecks.Others.texturename) do
                    if not HasStreamedTextureDictLoaded(textureName) then
                        textureLoaded = false
                        break  
                    end
                end
                if textureLoaded then
                    break
                end
            end
        end
    end)    
end

function StartGodModeCheck()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            Wait(1000)  
            CheckPlayerProofs()
        end
    end)
end

function CheckPlayerProofs()
    local retval, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof = GetEntityProofs(ESX.PlayerData.cache.playerped)
    if bulletProof == 1 or fireProof == 1 or explosionProof == 1 or collisionProof == 1 or meleeProof == 1 or steamProof == 1 or p7 == 1 or drownProof == 1 then
        TriggerServerEvent(ACConfig.Name .. ":clientDetect", "God Mode")
    end
end


function RemoveWeaponDrops()
    for a = 1, #pickupList do
		N_0x616093ec6b139dd9(PlayerId(), GetHashKey(pickupList[a]), false)
    end
end

function StartAntiEngineDestroy()
    Citizen.CreateThread(function()
        while ACConfig.Enable do 
            Wait(5000)
            local ped = ESX.PlayerData.cache.playerped
            if IsPedSittingInAnyVehicle(ped) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                if GetVehicleEngineHealth(vehicle) <= 500 then
                    if not GetIsVehicleEngineRunning(vehicle) then
                        SetVehicleEngineOn(vehicle, true, false, true)
                        SetVehicleUndriveable(vehicle, false)
                    end
                    SetVehicleEngineHealth(vehicle, 1000.0)
                else
                    Wait(2500)
                end
            else
                Wait(2500)
            end
        end
    end)
end

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Vérifie toutes les secondes

        local playerPed = PlayerPedId()

        if IsPedJumping(playerPed) then
            Citizen.Wait(500) -- Attendre pour mesurer la hauteur du saut
            local height = GetEntityHeightAboveGround(playerPed)

            if height > 4.0 then -- Ajuste selon tes tests
                print("🚨 [DETECTION] SuperJump détecté !")
                TriggerServerEvent("anticheat:detectSuperJump") -- Alerte le serveur
            end
        end
    end
end)
]]

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) 

        local playerPed = PlayerPedId()

        if IsPedJumping(playerPed) then
            Citizen.Wait(500)
            local height = GetEntityHeightAboveGround(playerPed)

            if ESX.PlayerData.group ~= "user" then
                return 
            end

            if height > 4.0 and IsPedFalling(playerPed) then
                print("🚨 [DETECTION] SuperJump détecté !")
                TriggerServerEvent("anticheat:detectSuperJump")
            end
        end
    end
end)


local isSpawnProtection = true
local detectionsIgnored = 3 

Citizen.CreateThread(function()
    local firstCoords = GetEntityCoords(PlayerPedId())

    Citizen.Wait(10000)
    isSpawnProtection = false

    while true do
        Citizen.Wait(3000) 

        local playerPed = PlayerPedId()
        local secondCoords = GetEntityCoords(playerPed)
        local z = GetEntityHeightAboveGround(playerPed)
        local position = #(firstCoords - secondCoords)

        if not isSpawnProtection and ESX.PlayerData.group == "user" then
            if (position ~= 0.0 and z ~= 0.0) and (position > 35 or z > 35) then
                if detectionsIgnored > 0 then
                    detectionsIgnored = detectionsIgnored - 1
                else
                    TriggerServerEvent("anticheat:detectNoClip", "Déplacement rapide ou hauteur anormale")
                end
            end
        end

        firstCoords = secondCoords
    end
end)
]]
--[[Citizen.CreateThread(function()
    local playerPed = PlayerPedId()
    local lastCamRotation = 0.0
    local lastCamDistance = 0.0
    local detectionTime = 3000  
    local tolerance = 1.5  
    local checkDelay = 1000  
    local maxCamDistance = 15.0 

    Citizen.Wait(10000)
    isSpawnProtection = false

    while true do
        Citizen.Wait(checkDelay)

        local camCoords = GetGameplayCamCoord()  
        local playerCoords = GetEntityCoords(playerPed) 
        local camDistance = #(camCoords - playerCoords)  
        local camRotation = GetGameplayCamRot(0) 

        if camDistance > maxCamDistance or math.abs(camRotation.x - lastCamRotation) > tolerance then

            Citizen.Wait(detectionTime)

            local newCamCoords = GetGameplayCamCoord()
            local newCamDistance = #(newCamCoords - playerCoords)

            if newCamDistance > maxCamDistance then
                print('Freecam activée !')  

            end
        end

        lastCamRotation = camRotation.x
        lastCamDistance = camDistance
    end
end)

]]