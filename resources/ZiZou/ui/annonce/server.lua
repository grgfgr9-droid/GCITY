RegisterCommand("annonceui", function(source, args)
    local player = ESX.GetPlayerFromId(source)

    if source ~= 0 then
        if not player then return end
        local playerGroup = player.getGroup()
        if playerGroup ~= "owner" and playerGroup ~= "admin" and playerGroup ~= "purple" then
            player.showNotification("~r~Vous n'avez pas la permission d'exécuter cette commande")
            return
        end
    end

    local message = table.concat(args, " ")
    if message == "" then
        if source == 0 then
            print("Veuillez fournir un message pour l'annonce")
        else
            player.showNotification("~r~Veuillez fournir un message pour l'annonce")
        end
        return
    end

    TriggerClientEvent("ZiZouANNONCESEND", -1, "", message)

    -- TriggerEvent("Logs", "Joueur (ID Unique): " .. player.getIdentifier() .. " a fait l'annonce: " .. message, Shared.Logs)
end, false)


RegisterCommand("annonceui50METRES", function(source, args)
    local player = ESX.GetPlayerFromId(source)

    if source ~= 0 then
        if not player then return end
        local playerGroup = player.getGroup()
        if playerGroup ~= "owner" and playerGroup ~= "admin" and playerGroup ~= "purple" then
            player.showNotification("~r~Vous n'avez pas la permission d'exécuter cette commande")
            return
        end
    end

    local message = table.concat(args, " ")
    if message == "" then
        if source == 0 then
            print("Veuillez fournir un message pour l'annonce")
        else
            player.showNotification("~r~Veuillez fournir un message pour l'annonce")
        end
        return
    end

    TriggerClientEvent("zizou:getCoordsAndSendLocalAnnonce", source, message)
end, false)

RegisterServerEvent("zizou:broadcastLocalAnnonce")
AddEventHandler("zizou:broadcastLocalAnnonce", function(message, coords)
    -- Envoie à tous les clients, chacun filtrera selon distance
    TriggerClientEvent("zizou:displayLocalAnnonce", -1, message, coords)
end)

