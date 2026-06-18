SpawnCheck = {
    vehicles = {},
    peds = {},
    fire = {},
    particules = {},
    kills = {},
    events = {}
}
 
function RegisterAnticheatEvents()
    AddEventHandler('entityCreating', function(entity)
        local entitymodel = GetEntityModel(entity)
        local _src = NetworkGetEntityOwner(entity)
        local _entitytype = GetEntityPopulationType(entity)
        local type = GetEntityPopulationType(entity)
        if type > 0 and type < 7 then
            return
        end
        CancelEvent()
        if ACConfig.BlacklistedModels[tostring(entitymodel)] then
            if tostring(entitymodel) ~= tostring(115168927) then
                SendAntiCheatLog(_src, "Blacklist entity spawn hash :".. entitymodel, true)
            end
            return
        end
        if GetEntityType(entity) == 2 then
            if _entitytype == 6 or _entitytype == 7 then
                CancelEvent()
            end
        elseif GetEntityType(entity) == 1 then
            if _entitytype == 6 or _entitytype == 7 then
                if not SpawnCheck.peds[_src] then SpawnCheck.peds[_src] = {} end
                if #SpawnCheck.peds[_src] > 3 then
                    if _src and tonumber(_src) then
                        SendAntiCheatLog(tonumber(_src), "Mass Peds")
                        DropPlayer(tonumber(_src), ACConfig.Name .. " : Mass Peds")
                    end
                    CancelEvent()
                else
                    table.insert(SpawnCheck.peds[_src], entity) 
                end
            end
        end
    end)
    
    AddEventHandler('ptFxEvent', function(sender, data)
        SpawnCheck.particules[sender] = (SpawnCheck.particules[sender] or 0) + 1
        if SpawnCheck.particules[sender] > 4 then
            SendAntiCheatLog(sender, "Mass Particles")
            DropPlayer(tonumber(sender), ACConfig.Name .. " : Mass Particles")
        end
        CancelEvent()
    end)

    AddEventHandler("clearPedTasksEvent", function(source, data)
        if data.immediately then
            SendAntiCheatLog(source, "Clear Ped Tasks (Immediatly)", true)
        end
    end)
    
    AddEventHandler('explosionEvent', function(sender, data)
        CancelEvent()
    end)
    
    AddEventHandler('fireEvent', function(sender, data)
        CancelEvent()
    end)
    
    AddEventHandler('startProjectileEvent', function(sender, data)
        if not ACConfig.WhiteListedProjectiles[tostring(data.projectileHash)] then
        CancelEvent()
        SendAntiCheatLog(sender, "Projectile", true)
        end
    end)

    AddEventHandler("giveWeaponEvent", function(sender, data)
        SendAntiCheatLog(sender, "Attempt to Give Weapon", true)
        CancelEvent()
    end)

    AddEventHandler("RemoveWeaponEvent", function(sender, data)
        SendAntiCheatLog(sender, "Attempt to Remove Weapon", true)
        CancelEvent()
    end)

    AddEventHandler("RemoveAllWeaponsEvent", function(sender, data)
        SendAntiCheatLog(sender, "Attempt to Remove Weapon ALL", true)
        CancelEvent()
    end)

    AddEventHandler('weaponDamageEvent', function (sender, data)
        if data.damageType == 3 then
            local xPlayer = ESX.GetPlayerFromId(sender)
            
            if tostring(data.weaponType) ~= tostring(2725352035) then
                if xPlayer then
                    if ACConfig.WeaponList[data.weaponType] then
                        if string.lower(ACConfig.WeaponList[data.weaponType].name) == "weapon_snspistol_mk2" and xPlayer.getGroup() ~= "user" then
                            CancelEvent()
                            return
                        end
                        if not xPlayer.hasWeapon(string.lower(ACConfig.WeaponList[data.weaponType].name)) and not xPlayer.hasPermWeapon(string.lower(ACConfig.WeaponList[data.weaponType].name)) then
                            SendAntiCheatLog(sender, "Attempt to shoot with a gave weapon : " .. ACConfig.WeaponList[data.weaponType].name, true)
                            CancelEvent()
                            return
                        end
                    end
                else 
                    DropPlayer(sender, 'Resource Stoppée.')
                    return
                end
            end
        end

        if data.willKill then
            if SpawnCheck.kills[sender] ~= 'ban' then
                if SpawnCheck.kills[sender] ~= nil then
                    if SpawnCheck.kills[sender] == 5 then
                        SpawnCheck.kills[sender] = 'ban'
                        SendAntiCheatLog(sender, "Killed more than 5 players in 10 seconds")
                        DropPlayer(sender, 'Désynchronisation avec le serveur ou Cheat detecté.')
                    else
                        SpawnCheck.kills[sender] = SpawnCheck.kills[sender] + 1
                    end
                else
                    SpawnCheck.kills[sender] = 1
                end
            end
        end
    end)

    RefreshEntitiesCount()
end

function RegisterRateLimit()
end

AddEventHandler('playerDropped', function(reason)
    if SpawnCheck.events[source] then
        SpawnCheck.events[source] = nil
    end
end)
  
function RefreshEntitiesCount()
    SpawnCheck = {
        vehicles = {},
        peds = {},
        fire = {},
        particules = SpawnCheck.particules,
        kills = {},
        events = SpawnCheck.events
    }
    SetTimeout(10000, RefreshEntitiesCount)
end

