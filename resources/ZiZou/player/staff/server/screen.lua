function SendDiscordLog(webhook, message)
    local discordMessage = {
        ["username"] = "Screenshot Logs",
        ["content"] = message
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(discordMessage), { ['Content-Type'] = 'application/json' })
end

function getLicense(xPlayer)
    if not xPlayer then return "inconnu" end
    
    local identifier = xPlayer.identifier
    if not identifier then
        for _, id in ipairs(GetPlayerIdentifiers(xPlayer.source)) do
            if string.sub(id, 1, 8) == "license:" then
                return id
            end
        end
        return "inconnu"
    end
    
    return identifier
end

function IsStaff(xPlayer)
    if not xPlayer then return false end

    local playerGroup

    local status, result = pcall(function()
        if xPlayer.getGroup then
            return xPlayer.getGroup()
        elseif xPlayer.group then
            return xPlayer.group
        elseif xPlayer.getLevel then
            return xPlayer.getLevel()
        else

            local identifier = xPlayer.identifier
            if not identifier then
                identifier = xPlayer.getIdentifier()
            end     
            return "user" 
        end
    end)

    if not status then
        return false
    end
    
    playerGroup = result

    local allowedGroups = {
        ['admin'] = true,
        ['superadmin'] = true,
        ['mod'] = true,
    }
    
    return allowedGroups[playerGroup] or false
end

function LogAdminAction(action, adminId, targetId, details)
    local adminName = GetPlayerName(adminId) or "Inconnu"
    local targetName = GetPlayerName(targetId) or "Inconnu"
end

RegisterCommand("screenig", function(source, args, rawCommand)
    if source == 0 then

        return
    end

    local adminId = source  
    local playerName = GetPlayerName(adminId) or "Inconnu"
    if #args < 1 then
        TriggerClientEvent('esx:showNotification', adminId, "~r~Utilisation: /screenig [ID]")
        return
    end

    local targetId = tonumber(args[1])
    if not targetId then
        TriggerClientEvent('esx:showNotification', adminId, "~r~ID joueur invalide.")
        return
    end
    
     local targetName = GetPlayerName(targetId)
    if not targetName then

        TriggerClientEvent('esx:showNotification', adminId, "~r~Joueur avec ID " .. targetId .. " non connecté.")
        return
    end
    
if not targetId or not tonumber(targetId) then

        TriggerClientEvent('esx:showNotification', adminId, "~r~ID joueur invalide.")
        return
    end

    if not targetName then

        TriggerClientEvent('esx:showNotification', adminId, "~r~Joueur avec ID " .. targetId .. " introuvable.")
        return
    end
TriggerClientEvent('ZiiroxScreen:screenshot', targetId, adminId, ZiZouConfig.Webhook.ScreenShot.IG)


    LogAdminAction("screenshot", adminId, targetId, "Capture d'écran du joueur")
end, false)

RegisterNetEvent("ZiiroxScreen::uploadscreen")
AddEventHandler("ZiiroxScreen::uploadscreen", function(screenshot, adminId)
    local targetId = source 

    if not adminId or adminId == "" or adminId == 0 then

        return
    end

    if not screenshot then
       
        return
    end

    adminId = tonumber(adminId)
    if not adminId then

        return
    end

    if not GetPlayerName(targetId) then

        return
    end
    
    if not GetPlayerName(adminId) then
        return
    end

    local xTarget = ESX.GetPlayerFromId(targetId)
    local xAdmin = ESX.GetPlayerFromId(adminId)

    if not xTarget then
    end
    
    if not xAdmin then
    end
    
    local targetName = GetPlayerName(targetId) or "Inconnu"
    local adminName = GetPlayerName(adminId) or "Inconnu"
    
    local screenshotType = screenshot == "local" and "local" or "discord"


    TriggerClientEvent('ZiiroxScreen:uploadscreen:send', adminId, screenshot)
        
end)
