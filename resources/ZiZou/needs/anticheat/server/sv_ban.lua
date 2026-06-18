local presentCard = {}
presentCard.card = {
    ['verif'] = {
        ["type"] = "AdaptiveCard",
        ["minHeight"] = "100px",
        ["body"] = {
            {
                type = "Container",
                items = {
                    {
                        type = "Image",
                        url = ZiZouConfig.LogoURL,
                        size = "medium",
                        horizontalAlignment = "center",
                        style = "person"
                    },
                    {
                        type = "TextBlock",
                        horizontalAlignment = "center",
                        text = 'Vérification de vos informations ...'
                    }
                }
            }
        },
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["version"] = "1.2"
    },
    ['connect'] = function(playerName)
        return {
            ["type"] = "AdaptiveCard",
            ["minHeight"] = "100px",
            ["body"] = {
                {
                    type = "Container",
                    items = {
                        {
                            type = "Image",
                            url = ZiZouConfig.LogoURL,
                            size = "medium",
                            horizontalAlignment = "center",
                            style = "person"
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = ('Bienvenue %s, sur %s'):format(playerName, ZiZouConfig.ServerName .."*"),
                            size = "large",
                            weight = 'Bolder',
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = ("Merci de nous avoir choisis pour commencer votre aventure.\n Voici quelques liens utiles pour améliorer votre expérience sur %s."):format(ZiZouConfig.ServerName),
                            size = "medium",
                        },
                        {
                            type = "ActionSet",
                            horizontalAlignment = "center",
                            actions = {
                                {
                                    type = "Action.OpenUrl",
                                    title = "Wiki " .. ZiZouConfig.ServerName,
                                    url = ZiZouConfig.DiscordURL
                                },
                                {
                                    type = "Action.OpenUrl",
                                    title = "Accéder au Discord",
                                    url = ZiZouConfig.DiscordURL
                                },
                                {
                                    type = "Action.OpenUrl",
                                    title = "Accéder au Tebex",
                                    url = ZiZouConfig.TebexURL
                                }
                            }
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = "Vous pouvez maintenant acceder au serveur en cliquant sur le bouton 'Se Connecter' ci-dessous.",
                            size = "small",
                        },
                        {
                            type = "ActionSet",
                            horizontalAlignment = "center",
                            actions = {
                                {
                                    type = "Action.Submit",
                                    title = "Se connecter",
                                    data = { action = "connect" }
                                },
                            }
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = ("%s n'est pas affilié ou approuvé par Take-Two, Rockstar North interactive et toute autre détenteur de droits d'auteur"):format(ZiZouConfig.ServerName),
                            size = "small"
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = "Toutes marques de commerce utilisées sont les propriétaires respectifs et ne sont pas affiliées ou approuvées par Take-Two, Rockstar North interactive",
                            size = "small"
                        }
                    }
                }
            },
            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
            ["version"] = "1.2"
        }
    end,
    ['ban'] = {}
}

AnticheatBanList = {}

AddEventHandler('playerConnecting', function(playerName, setKickReason, c)
    local identifier, discord, playerip = "nn/aa", "nn/aa", "nn/aa"
    local found, uuid = false, ""

    for _, v in ipairs(GetPlayerIdentifiers(source)) do
        if v:find("license:") then
            identifier = v
        elseif v:find("discord:") then
            discord = v
        elseif v:find("steam:") then
            playerip = v
        end
    end

    if #AnticheatBanList < 1 then
        Citizen.Wait(3000) 
    end

    for _, v in pairs(AnticheatBanList) do
        if tostring(v.identifier) == tostring(identifier) or tostring(v.discord) == tostring(discord) then
            found, uuid = true, v.uuid
            break
        end
    end
    if found then
        setKickReason('\n\n🚫 Vous avez été banni par ZiZouAC.\n📌 ID Ban : ' .. uuid .. '\n⏳ Temps Restant : Permanent')
        CancelEvent()
    else
        c.done()
    end
end)























































function RequestPlayerBan(source, reason)
    local identifier, discord, uuid = "n/a", "n/a", "n/a"
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then 
        uuid = xPlayer.getUUID() 
    end

    for _, v in ipairs(GetPlayerIdentifiers(source)) do
        if v:find("license:") then identifier = v end
        if v:find("discord:") then discord = v end
    end

    -- Vérification que reason n'est pas nil
    if not reason or reason == "" then
        reason = "Raison inconnue"
    end

    -- Appliquer le ban et kick du joueur
    AnticheatBan(identifier, discord, GetPlayerName(source), uuid)
    DropPlayer(source, "Vous avez été banni par " .. ACConfig.Name .. " pour : " .. reason)
end



RegisterCommand("refreshbanlist", function(source)
    if source == 0 then loadAnticheatBanList() end
end)

RegisterCommand("acunban", function(source, args)
    if source ~= 0 then return end
    local uuid = args[1]
    if not uuid then print("Erreur: UUID requis. Usage: /acunban [UUID]") return end

    MySQL.Async.execute("DELETE FROM anticheat_bans WHERE uuid = @uuid", {['@uuid'] = uuid}, function(rowsChanged)
        if rowsChanged > 0 then
            print("Succès: Joueur débanni (UUID: " .. uuid .. ")")
            loadAnticheatBanList()
        else
            print("Erreur: Aucun joueur avec cet UUID.")
        end
    end)
end, false)

RegisterCommand("reloadbanlist", function(source)
    if source == 0 then
        loadAnticheatBanList()
        print("Liste des bans rechargée !")
    end
end, false)

function AnticheatBan(identifier, discord, playername, uuid)
    local timeat = os.time()
    table.insert(AnticheatBanList, {identifier = identifier, discord = discord, uuid = uuid})
    
    MySQL.Async.execute('INSERT INTO anticheat_bans (identifier, discord, playername, uuid, timeat) VALUES (@identifier, @discord, @playername, @uuid, @timeat)', {
        ['@identifier'] = identifier,
        ['@discord'] = discord,
        ['@playername'] = playername,
        ['@uuid'] = uuid,
        ['@timeat'] = timeat
    }, function(rowsChanged)
        if rowsChanged then
            print("Joueur " .. playername .. " banni avec succès.")
        else
            print("Erreur lors de l'insertion dans la base de données.")
        end
    end)
end

function loadAnticheatBanList()
    MySQL.Async.fetchAll('SELECT * FROM anticheat_bans', {}, function(data)
        AnticheatBanList = {}
        for _, d in ipairs(data) do
            table.insert(AnticheatBanList, {identifier = d.identifier, discord = d.discord, uuid = d.uuid})
        end
        print('Anticheat Banlist chargée.')
    end)
end
