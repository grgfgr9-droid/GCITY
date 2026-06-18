local reports = {}
local callid = 0

RegisterServerEvent('admin:setJob')
AddEventHandler('admin:setJob', function(player, job, grade, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(player)
    if xPlayer.getGroup() ~= 'user' then
        TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a mis job : " .. job .." grade : " .. grade .. " type : " .. type .. " " .. GetPlayerName(player) .. " ( "  .. player .. ' - ' .. xTarget.getUUID() .. " )")
        if type == 1 then
        xTarget.setJob(job, grade)
        elseif type == 2 then
        xTarget.setJob2(job, grade)
        end
    else
        print('Attempt to Admin SetJob ' .. xPlayer.getUUID())
    end
end)

RegisterServerEvent('admin:MakePlayerRegister')
AddEventHandler('admin:MakePlayerRegister', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        local playerGroup = xPlayer.getGroup()

        if playerGroup == "admin" or playerGroup == "owner" or playerGroup == "purple"then
            TriggerClientEvent("esx:MakeMeRegister", target)
        else
            xPlayer.showNotification("Vous n'avez pas la permission d'utiliser cette commande.")
        end
    end
end)

local staffOnDuty = {}

RegisterServerEvent('admin:Service')
AddEventHandler('admin:Service', function(toggle)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        staffOnDuty[source] = toggle
        if toggle then
           -- TriggerClientEvent('esx:showNotification', source, "Vous êtes en service", "info")
        else
           -- TriggerClientEvent('esx:showNotification', source, "Vous n'êtes plus en service", "info")
        end
    end
end)


RegisterServerEvent('admin:JailPlayer')
AddEventHandler('admin:JailPlayer', function(target, time, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer and xTarget and xPlayer.getGroup() ~= "user" then
        if tonumber(time) > 0 then
        JailPlayer(target, "staff", time)
        TriggerClientEvent('esx:announce', target, "Jail", "Vous avez été jail par " .. GetPlayerName(source) .. " pour " .. reason, 2)
        TriggerEvent('esx:sendLog', "jail", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a jail " .. GetPlayerName(target) .. " ( "  .. target .. ' - ' .. xTarget.getUUID() .. " ) pour " .. reason .. " pedant " .. time .. " minutes")
        else
            UnJailPlayer(target)
            TriggerClientEvent('esx:announce', target, "Jail", "Vous avez été unjail par " .. GetPlayerName(source), 2)
            TriggerEvent('esx:sendLog', "jail", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a unjail " .. GetPlayerName(target) .. " ( "  .. target .. ' - ' .. xTarget.getUUID() .. " )")
        end
    end
end)

RegisterNetEvent("admin:SetInvisibleMode")
AddEventHandler("admin:SetInvisibleMode", function(state)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.set("invisible", state) -- Stocke l'invisibilité dans ESX

    TriggerClientEvent("admin:ApplyInvisibleMode", src, state) -- Envoie au client
end)


ESX.RegisterServerCallback('admin:GetActivePlayers', function(source, cb)
    local xPlayers = ESX.GetPlayers()
    local players = {}
    local completed = 0 -- Nombre de requêtes terminées

    if #xPlayers == 0 then -- Si aucun joueur, on renvoie directement une liste vide
        return cb(players)
    end

    for _, v in pairs(xPlayers) do
        local xPlayer = ESX.GetPlayerFromId(v)
        local coloraddon = ''
        local isInvisible = xPlayer.get("invisible") or false -- Vérifie si le joueur est invisible

        -- Récupération du temps de jeu
        MySQL.Async.fetchScalar('SELECT time FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.getIdentifier()
        }, function(result)
            local playerTime = result or 0
            local nameTag = ''

            if playerTime < 30 then
                nameTag = '[NEW]'
            end

            -- Attribution de la couleur selon le grade
            if xPlayer.getGroup() == 'owner' then
                coloraddon = '~l~'
            elseif xPlayer.getGroup() == 'responsable' then
                coloraddon = '~o~'
            elseif xPlayer.getGroup() == 'admin' then
                coloraddon = '~r~'
            elseif xPlayer.getGroup() == 'purple' then
                coloraddon = '~p~'
            elseif xPlayer.getGroup() == 'superadmin' then
                coloraddon = '~y~'
            elseif xPlayer.getGroup() == 'modo' then
                coloraddon = '~b~'
            elseif xPlayer.getGroup() == 'user' then
                coloraddon = '~w~'
            end

            local staffStatus = ""
            if xPlayer.getGroup() ~= "user" and staffOnDuty[v] then
                staffStatus = "[En service]"
            end

            -- Ajoute le joueur seulement s'il N'EST PAS invisible
            if not isInvisible then
                table.insert(players, {
                    id = v,
                    name = coloraddon .. nameTag .. "["..v .. " | " .. xPlayer.getUUID() .."] "..xPlayer.getName() .. " ".. staffStatus,
                    uuid = xPlayer.getUUID(),
                    group = xPlayer.getGroup(),
                    addoncolor = coloraddon,
                    invisible = isInvisible
                })
            end

            -- Vérifie si toutes les requêtes SQL sont terminées
            completed = completed + 1
            if completed == #xPlayers then
                cb(players) -- Exécute le callback seulement après toutes les requêtes SQL
            end
        end)
    end
end)



RegisterServerEvent('zizou:sendAnnonce')
AddEventHandler('zizou:sendAnnonce', function(type, message, author, staffOnly)
    local _src = source  -- ID du joueur appelant l'événement

    -- Si la requête provient de la console (source == 0)
    if _src == 0 then
        -- Annonce depuis la console
        if type == "PetiteAnnonce" then
            TriggerClientEvent('txcl:showAnnouncement', -1, message, author)  -- Envoie au client
        else
            TriggerClientEvent('zizou:displayWarnOnScreen', -1, type, message)  -- Autre type d'annonce
        end
    else
        -- Vérifie les permissions via ESX (vérification du grade, ici 'admin' par exemple)
        local xPlayer = ESX.GetPlayerFromId(_src)
        if xPlayer and (xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'owner'or xPlayer.getGroup() == 'purple') then
            if type == "PetiteAnnonce" then
                if staffOnly then
                    -- Send to all except 'user'
                    for _, playerId in ipairs(ESX.GetPlayers()) do
                        local targetPlayer = ESX.GetPlayerFromId(playerId)
                        if targetPlayer.getGroup() ~= 'user' then
                            TriggerClientEvent('txcl:showAnnouncement', playerId, message, author)
                        end
                    end
                else
                    -- Send to everyone
                    TriggerClientEvent('txcl:showAnnouncement', -1, message, author)
                end
            else
                -- Si c'est une annonce normale, envoie à tous les joueurs
                TriggerClientEvent('zizou:displayWarnOnScreen', -1, type, message)  -- Envoie au client
            end
        else
            -- Si l'utilisateur n'a pas les droits
            TriggerClientEvent('esx:showNotification', _src, '~r~Tu n\'as pas la permission !')
        end
    end
end)

RegisterServerEvent('zizoustaff:SetGPS')
AddEventHandler('zizoustaff:SetGPS', function(targetSource)
    local targetPlayer = GetPlayerPed(targetSource)
    if targetPlayer then
        local coords = GetEntityCoords(targetPlayer)
        TriggerClientEvent('zizoustaff:ReceiveGPS', source, coords) -- Envoie les coordonnées au joueur qui a utilisé la commande
    else
        print("Erreur: Impossible de trouver le joueur cible.")
    end
end)

RegisterServerEvent("staff:Teleport1")
AddEventHandler("staff:Teleport1", function(type, targetPlayer)
    local src = source -- ID du joueur qui exécute la commande
    local targetPed = GetPlayerPed(targetPlayer)
    
    if not targetPed or targetPed == 0 then
        TriggerClientEvent("esx:showNotification", src, "Le joueur cible est introuvable.")
        return
    end

    if type == "goto" then
        local targetCoords = GetEntityCoords(targetPed)
        TriggerClientEvent("staff:Teleport1", src, "goto", targetCoords.x, targetCoords.y, targetCoords.z)

    elseif type == "bring" then
        local staffPed = GetPlayerPed(src)
        local staffCoords = GetEntityCoords(staffPed)
        TriggerClientEvent("staff:Teleport1", targetPlayer, "bring", staffCoords.x, staffCoords.y, staffCoords.z)

    elseif type == "bringback" then
        TriggerClientEvent("staff:Teleport1", targetPlayer, "bringback")

    elseif type == "tppc" then -- Téléportation au Parking Central
        local parkingCoords = vector3(215.76, -810.12, 30.73) -- Coordonnées du Parking Central (modifiables)
        TriggerClientEvent("staff:Teleport1", targetPlayer, "goto", parkingCoords.x, parkingCoords.y, parkingCoords.z)
    end
end)



RegisterServerEvent('esx:adminannounce')
AddEventHandler('esx:adminannounce', function(title, msg, time, staffOnly)
    local xPlayer = ESX.GetPlayerFromId(source)

if staffOnly then
    for _, playerId in ipairs(ESX.GetPlayers()) do
        local targetPlayer = ESX.GetPlayerFromId(playerId)
        if targetPlayer.getGroup() ~= 'user' then
            TriggerClientEvent('esx:announce', playerId, title, msg, time)
        end
    end
else
    TriggerClientEvent('esx:announce', -1, title, msg, time)
end

end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    local timeremaining = eventData.secondsRemaining / 60
    --TriggerClientEvent('esx:announce', -1, '~y~Reboot', 'reboot automatique dans ' .. ESX.Math.Round(timeremaining) .. ' minutes', 2)
    if eventData.secondsRemaining == 60 then
        print("1 minute before restart... saving all players!")
        ESX.SavePlayers(function()
        end)
    end
end)


RegisterServerEvent('admin:TeleportPlayerToMe')
AddEventHandler('admin:TeleportPlayerToMe', function(target, coords)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    TriggerClientEvent('admin:teleport', target, coords.x, coords.y, coords.z)
    end
end)

RegisterServerEvent('admin:GoToPlayer')
AddEventHandler('admin:GoToPlayer', function(target)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(target) then
    local xTarget = ESX.GetPlayerFromId(tonumber(target))
    local sourceped = GetPlayerPed(_source)
    local playerped = GetPlayerPed(tonumber(target))
	local playercoords = GetEntityCoords(playerped)
    if xPlayer.getGroup() ~= 'user' then
        if xTarget then
            SetEntityCoords(sourceped, playercoords.x, playercoords.y, playercoords.z) 
            --TriggerClientEvent("admin:toggleNoclip", _source)
        end
    end
    end
end)

RegisterServerEvent('admin:SendMessageToPlayer')
AddEventHandler('admin:SendMessageToPlayer', function(target, msg)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        if target then
           TriggerClientEvent('admin:receivemessage', target, msg)
        end
    end
end)

RegisterServerEvent('admin:WipeArme')
AddEventHandler('admin:WipeArme', function(target, reason)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() ~= 'user' then
        if xTarget then
            local RemoveList = {}
            for k, v in pairs(xTarget.getLoadout()) do
                table.insert(RemoveList, v.name)
            end
            xTarget.removeWeapons(RemoveList)
            TriggerClientEvent('esx:announce', xTarget.source, '~y~Wipe', 'Vous avez été wipe arme pour ' .. reason, 2)
            TriggerEvent('esx:sendLog', "staff", GetPlayerName(xPlayer.source) .. " ( "  .. xPlayer.source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a wipe arme " .. GetPlayerName(xTarget.source) .. " ( "  .. xTarget.source .. ' - ' .. xTarget.getUUID() .. " ) pour " .. reason)
        end
    end
end)


ESX.RegisterServerCallback('esx:retrievePlayers', function(playerId, cb) 
    local players = {}
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local playercolor = 0 

      
        if xPlayer.getGroup() == 'owner' then
            playercolor = 2 
        elseif xPlayer.getGroup() == 'responsable' then
            playercolor = 15 
        elseif xPlayer.getGroup() == 'superadmin' then
            playercolor = 12
        elseif xPlayer.getGroup() == 'admin' then
            playercolor = 6 
        elseif xPlayer.getGroup() == 'purple' then
            playercolor = 21 
        elseif xPlayer.getGroup() == 'modo' then
            playercolor = 9
        else
            playercolor = 0 
        end

      
        local invisible = xPlayer.get("invisible") or false  

       
        if invisible then
            playercolor = 0
        end

        table.insert(players, {
            id = xPlayers[i],
            group = xPlayer.getGroup(),
            source = xPlayer.source,
            job = xPlayer.getJob().name,
            job2 = xPlayer.getJob2().name,
            name = xPlayer.getName(),
            uuid = xPlayer.getUUID(),
            color = playercolor,
            invisible = invisible 
        })
    end

    cb(players)
end)


RegisterServerEvent('admin:sendReport')
AddEventHandler('admin:sendReport', function(reason, playername)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local numreport = #reports + 1
    if not reports[source] then
        reports[source] = {num = numreport, source = source, name = playername, message = reason, uuid = xPlayer.getUUID()}
        TriggerClientEvent('admin:updateReportCount', -1, #reports) 
    end
end)

RegisterServerEvent('admin:DeleteReport')
AddEventHandler('admin:DeleteReport', function(playerid)
    local report = reports[playerid]
    if report then
        reports[playerid] = nil
        TriggerClientEvent('admin:updateReportCount', -1, #reports) 
    end
end)

RegisterServerEvent('admin:takingReport')
AddEventHandler('admin:takingReport', function(playerid)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    local report = reports[playerid]
    if report and ESX.GetPlayerFromId(reports[playerid].source) then
        ESX.GetPlayerFromId(reports[playerid].source).showNotification(GetPlayerName(_source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " s'occupe de votre ticket !")
        local name = GetPlayerName(_source)
        if not name then
            name = "nil"
        end
        TriggerEvent('esx:sendLog', "staff", name .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " s'occupe du ticket de " .. GetPlayerName(report.source) .. " ( "  .. report.source .. ' - ' .. report.uuid .. " )")
    elseif report and not ESX.GetPlayerFromId(reports[playerid].source) then
        xPlayer.showNotification("Ce Joueur s'est déconnecté, ticket fermé")
        reports[playerid] = nil
    end
    end
end)

RegisterServerEvent('admin:give')
AddEventHandler('admin:give', function(type, item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " s'est give " .. amount .." " .. type .. " " .. item)
        if type == 'money' then
            if item == 'cash' then
                xPlayer.addMoney(amount)
            elseif item == 'black_money' then
                xPlayer.addAccountMoney(item, amount)
            end
        elseif type == 'item' then
            xPlayer.addInventoryItem(item, amount)
        elseif type == 'weapon' then
            xPlayer.addWeapon(item, amount)
        end
    end
end)

RegisterServerEvent('admin:kick')
AddEventHandler('admin:kick', function(target, reason)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if target then
        local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        TriggerEvent('esx:sendLog', "kick", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a kick " ..  GetPlayerName(target) .. " ( "  .. target .. ' - ' .. xTarget.getUUID() .. " ) pour " .. reason)
        DropPlayer(target, reason)
    end
    end
end)

RegisterServerEvent('admin:freeze')
AddEventHandler('admin:freeze', function(target, toggle)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    if target then
        TriggerClientEvent('admin:FreezePlayer', target, toggle)
    end
    end
end)

ESX.RegisterServerCallback('admin:getReports', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    cb(reports)
    end
end)


RegisterNetEvent("zizou:fivem:setbucket")
AddEventHandler("zizou:fivem:setbucket", function(bucket)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= "user" then
        if bucket == "99999" then
            SetPlayerRoutingBucket(xPlayer.source, 99999)
        elseif bucket == "basic" then
            SetPlayerRoutingBucket(xPlayer.source, 0)
        else
            SetPlayerRoutingBucket(xPlayer.source, 0)
        end
    end
end)

RegisterServerEvent("admin:deleteAllPeds")
AddEventHandler("admin:deleteAllPeds", function()
    local _source = source
    TriggerClientEvent("admin:deleteAllPeds", -1) 
end)

RegisterServerEvent("admin:deleteAllVehicles")
AddEventHandler("admin:deleteAllVehicles", function()
    local _source = source
    TriggerClientEvent("admin:deleteAllVehicles", -1) 
end)

RegisterServerEvent("admin:deleteAllProps")
AddEventHandler("admin:deleteAllProps", function()
    local _source = source
    TriggerClientEvent("admin:deleteAllProps", -1) 
end)

RegisterServerEvent("admin:deleteAllEntities")
AddEventHandler("admin:deleteAllEntities", function()
    local _source = source
    TriggerClientEvent("admin:deleteAllEntities", -1) 
end)

