local validResourceList

local TimeWithoutCall = {}

local function collectValidResourceList()
    validResourceList = {}
    for i=0,GetNumResources()-1 do
        validResourceList[GetResourceByFindIndex(i)] = true
    end
end

function AnticheatPlayerJoined(source)
    TimeWithoutCall[source] = 0
end

local function StartStopperThread()
    CreateThread(function()
        while true do
            Wait(7500)
            for k, v in pairs(TimeWithoutCall) do
                if TimeWithoutCall[k] >= 2 then
                    SendAntiCheatLog(k, "Tried to stop resource : " .. TimeWithoutCall[k], false)
                else
                    TimeWithoutCall[k] = (TimeWithoutCall[k] or 0) + 1
                end
                Wait(5)
            end
        end
    end)
end

--StartStopperThread()

collectValidResourceList()

AddEventHandler("onResourceListRefresh", collectValidResourceList) 

RegisterServerEvent(ACConfig.Name .. ":checkResources")
AddEventHandler(ACConfig.Name .. ":checkResources", function(givenList)
    for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
            SendAntiCheatLog(source, "Unautorized Resource : " .. resource, true)
            DropPlayer(source, ACConfig.Name .. " : Une resource non autorisée a été detectée, Si vous pensez que c'est une erreur, merci de le signaler à un développeur")
            break
        end
    end
end)

RegisterServerEvent(ACConfig.Name .. ":checkWeapon")
AddEventHandler(ACConfig.Name .. ":checkWeapon", function(weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    if weapon then
        local weaponName = weapon.name
        if string.lower(weaponName) == "weapon_snspistol_mk2" and xPlayer.getGroup() ~= "user" then return end
        if not xPlayer.hasWeapon(string.lower(weaponName)) and not xPlayer.hasPermWeapon(string.lower(weaponName)) then
            SendAntiCheatLog(source, "Weapon Give : " .. weaponName, true)
        end
    end
end)

--[[RegisterServerEvent("ac:clientDetect")
AddEventHandler("ac:clientDetect", function(reason, value)
    local src = source

    if reason == "SuperJump" then
        print("🚨 [ALERT] SuperJump détecté sur l'ID :", src, " | Hauteur :", value)

        -- Envoie un log (à remplacer par ton propre système de log)
        SendAntiCheatLog(src, "[DETECTION] SuperJump détecté | Hauteur : " .. value, true)

        -- Kick le joueur immédiatement
        DropPlayer(src, "Cheat détecté: SuperJump activé.")
    end
end)
RegisterServerEvent("anticheat:detectSuperJump")
AddEventHandler("anticheat:detectSuperJump", function()
    local src = source
    print("🚨 [DETECTION] SuperJump détecté sur l'ID :", src)

    -- Envoie un log (ajoute ton système de logs si besoin)
    SendAntiCheatLog(src, "[DETECTION] SuperJump Activé", true)

    -- Kick immédiatement le joueur
    DropPlayer(src, "Cheat détecté: SuperJump activé.")
end)

RegisterServerEvent("anticheat:detectNoClip")
AddEventHandler("anticheat:detectNoClip", function(reason)
    local src = source
    SendAntiCheatLog(src, "Attempt to NoClip", true) 
    DropPlayer(src, "Cheat détecté: NoClip activé.")
end)
]]


RegisterServerEvent(ACConfig.Name .. ":CheckWeaponKillAll") 
AddEventHandler(ACConfig.Name .. ":CheckWeaponKillAll", function(weaponhash) 
    if weaponhash == -1569615261 then
        SendAntiCheatLog(source, "KillAll", true)
    end
end)

Citizen.CreateThread(function()
    Wait(5000)
    if ACConfig.Enable then
    RegisterAnticheatEvents()
    if ACConfig.RateLimit.Enable then
        RegisterRateLimit()
    end
    loadAnticheatBanList()
    StartAnticheat()
    end
end)
