local CountPlayers = 0

Citizen.CreateThread(function()
	local id = GetPlayerServerId(PlayerId())
	AddTextEntry('PM_PANE_LEAVE', ZiZouConfig.DefaultColorCode .. 'Retourner sur la liste des serveurs.')
	AddTextEntry("PM_PANE_QUIT", "Fermer ~r~FiveM")
	AddTextEntry("PM_SCR_MAP", "Map " .. ZiZouConfig.DefaultColorCode ..ZiZouConfig.ServerName.."~w~")
	AddTextEntry("PM_SCR_GAM", ZiZouConfig.DefaultColorCode .. "Aéroport~w~")
	AddTextEntry("PM_SCR_INF", ZiZouConfig.DefaultColorCode .. "Logs~w~")
	AddTextEntry("PM_SCR_STA", ZiZouConfig.DefaultColorCode .. "Statistiques~w~")
	AddTextEntry("PM_SCR_SET", ZiZouConfig.DefaultColorCode .. "Paramètres~w~")
	AddTextEntry("PM_SCR_GAL", ZiZouConfig.DefaultColorCode .. "Gallerie~w~")
	AddTextEntry("PM_SCR_RPL", ZiZouConfig.DefaultColorCode .. "Rockstar~w~")
	AddTextEntry('PM_PANE_KEYS', ZiZouConfig.DefaultColorCode .. "Configurer vos Touches")
	AddTextEntry('PM_PANE_CFX', ZiZouConfig.DefaultColorCode .. ZiZouConfig.ServerName)
end)	

Citizen.CreateThread(function()
	while not ESX.PlayerData.PassJoin do
		Wait(100)
	end
	while true do
	SetDiscordAppId(ZiZouConfig.RichPresenceID)
	SetDiscordRichPresenceAsset("logo")
	SetDiscordRichPresenceAssetText(ZiZouConfig.DiscordURL)
	local id = GetPlayerServerId(PlayerId())
	local uuid = ESX.PlayerData.uuid
	SetRichPresence(uuid.." | "..CountPlayers.."/128")
    SetDiscordRichPresenceAction(0, "🎤 DISCORD", "https://" .. ZiZouConfig.DiscordURL)
	SetDiscordRichPresenceAction(1, "🎮 JOUER", "https://" .. ZiZouConfig.DiscordURL)
   -- SetDiscordRichPresenceAction(1, "🎮 JOUER", "fivem://connect/"..ZiZouConfig.ConnectURL)
	AddTextEntry("FE_THDR_GTAO", uuid .. " | " .. CountPlayers .. "/128" .. " - "..ZiZouConfig.DefaultColorCode..ZiZouConfig.ServerName.."~w~ | "..ZiZouConfig.DiscordURL)
	Citizen.Wait(10000)
	end
end)


RegisterNetEvent("esx:UpdatePlayersCount")
AddEventHandler("esx:UpdatePlayersCount", function(count)
CountPlayers = count
end)