Text               = {}
BanList            = {}
BanListLoad        = false
BanListHistory     = {}
BanListHistoryLoad = false

SQLBanConfig                   = {}

--GENERAL
SQLBanConfig.Lang              = 'fr'    --Set lang (fr-en)
SQLBanConfig.Permission        = "owner" --Permission need to use FiveM-BanSql commands (mod-admin-superadmin)
SQLBanConfig.ForceSteam        = false    --Set to false if you not use steam auth
SQLBanConfig.MultiServerSync   = false   --This will check if a ban is add in the sql all 30 second, use it only if you have more then 1 server (true-false)

--WEBHOOK
SQLBanConfig.EnableDiscordLink = true --Turn this true if you want link the log to a discord (true-false)
SQLBanConfig.webhookban        = "https://discord.com/api/webhooks/1353103161870782525/qPceTL39I80adS9eMw9YPrPNSungSHWUK3wtedS_mWaFk5Omeb_V9E7ryf1-tg4oWOeL"
SQLBanConfig.webhookunban      = "https://discord.com/api/webhooks/1353103304514863134/3fBCuNroLxqzDIgi9ns_j2jlhBzptZLjA2LiMURgDQJm6_enMugtyGpOQzqoEGzlEK4P"


--LANGUAGE
SQLBanConfig.TextFr = {
	start         = "La BanList et l'historique a ete charger avec succes",
	starterror    = "ERREUR : La BanList ou l'historique n'a pas ete charger nouvelle tentative.",
	banlistloaded = "La BanList a ete charger avec succes.",
	historyloaded = "La BanListHistory a ete charger avec succes.",
	loaderror     = "ERREUR : La BanList n a pas été charger.",
	cmdban        = "/sqlban (ID) (Durée en jours) (Raison)",
	cmdbanoff     = "/sqlbanoffline (Permid) (Durée en jours) (Raison)",
	cmdhistory    = "/sqlbanhistory (Steam name) ou /sqlbanhistory 1,2,2,4......",
	noreason      = "Raison Inconnue",
	during        = " pendant : ",
	noresult      = "Il n'y a pas autant de résultats !",
	isban         = " a été ban",
	isunban       = " a été déban",
	invalidsteam  =  "Vous devriez ouvrir steam",
	invalidid     = "ID du joueur incorrect",
	invalidname   = "Le nom n'est pas valide",
	invalidtime   = "Duree du ban incorrecte",
	alreadyban    = " étais déja bannie pour : ",
	yourban       = "Vous avez été banni de GtaCity",
	yourpermban   = "Vous avez été banni de GtaCity",
	youban        = "Vous avez banni : ",
	forr          = " jours. Pour : ",
	permban       = " de facon permanente pour : ",
	timeleft      = ". Il reste : ",
	toomanyresult = "Trop de résultats, veillez être plus précis.",
	day           = " Jours ",
	hour          = " Heures ",
	minute        = " Minutes ",
	by            = "par",
	ban           = "Bannir un joueurs qui est en ligne",
	banoff        = "Bannir un joueurs qui est hors ligne",
	bansearch     = "Trouver l'id permanent d'un joueur qui est hors ligne",
	dayhelp       = "Nombre de jours",
	reason        = "Raison du ban",
	permid        = "Trouver l'id permanent avec la commande (sqlsearch)",
	history       = "Affiche tout les bans d'un joueur",
	reload        = "Recharge la BanList et la BanListHistory",
	unban         = "Retirez un ban de la liste",
	steamname     = "(Nom Steam)",
}


SQLBanConfig.TextEn = {
	start         = "BanList and BanListHistory loaded successfully.",
	starterror    = "ERROR: BanList and BanListHistory failed to load, please retry.",
	banlistloaded = "BanList loaded successfully.",
	historyloaded = "BanListHistory loaded successfully.",
	loaderror     = "ERROR: The BanList failed to load.",
	cmdban        = "/sqlban (ID) (Duration in days) (Ban reason)",
	cmdbanoff     = "/sqlbanoffline (Permid) (Duration in days) (Steam name)",
	cmdhistory    = "/sqlbanhistory (Steam name) or /sqlbanhistory 1,2,2,4......",
	forcontinu    = " days. To continue, execute /sqlreason [reason]",
	noreason      = "No reason provided.",
	during        = " during: ",
	noresult      = "No results found.",
	isban         = " was banned",
	isunban       = " was unbanned",
	invalidsteam  = "Steam is required to join this server.",
	invalidid     = "Player ID not found",
	invalidname   = "The specified name is not valid",
	invalidtime   = "Invalid ban duration",
	alreadyban    = " was already banned for : ",
	yourban       = "You have been banned for: ",
	yourpermban   = "You have been permanently banned for: ",
	youban        = "You are banned from this server for: ",
	forr          = " days. For: ",
	permban       = " permanently for: ",
	timeleft      = ". Time remaining: ",
	toomanyresult = "Too many results, be more specific to shorten the results.",
	day           = " days ",
	hour          = " hours ",
	minute        = " minutes ",
	by            = "by",
	ban           = "Ban a player",
	banoff        = "Ban an offline player",
	dayhelp       = "Duration (days) of ban",
	reason        = "Reason for ban",
	history       = "Shows all previous bans for a certain player",
	reload        = "Refreshes the ban list and history.",
	unban         = "Unban a player.",
	steamname     = "Steam name"
}


if SQLBanConfig.Lang == "fr" then Text = SQLBanConfig.TextFr elseif SQLBanConfig.Lang == "en" then Text = SQLBanConfig.TextEn else print("FIveM-BanSql : Invalid SQLBanConfig.Lang") end

CreateThread(function()
	while true do
		Wait(30000)
        if BanListLoad == false then
			loadBanList()
			if BanList ~= {} then
				print(Text.banlistloaded)
				BanListLoad = true
			else
				print(Text.starterror)
			end
		end
		if BanListHistoryLoad == false then
			loadBanListHistory()
            if BanListHistory ~= {} then
				print(Text.historyloaded)
				BanListHistoryLoad = true
			else
				print(Text.starterror)
			end
		end
	end
end)

CreateThread(function()
    while SQLBanConfig.MultiServerSync do
        Wait(30000)
        MySQL.Async.fetchAll(
            'SELECT * FROM banlist',
            {},
            function (data)
                if #data ~= #BanList then
                    BanList = {}

                    for i = 1, #data, 1 do
                        table.insert(BanList, {
                            license          = data[i].license,
                            identifier       = data[i].identifier,
                            liveid           = data[i].liveid,
                            xblid            = data[i].xblid,
                            discord          = data[i].discord,
                            playerip         = data[i].playerip,
                            targetplayername = data[i].targetplayername,
                            sourceplayername = data[i].sourceplayername,
                            reason           = data[i].reason,
                            timeat           = data[i].timeat,
                            expiration       = data[i].expiration,
                            permanent        = data[i].permanent,
                            uuid             = data[i].uuid
                        })
                    end
                    loadBanListHistory()
                    TriggerClientEvent('BanSql:Respond', -1)
                end
            end
        )
    end
end)



RegisterCommand("ban", function(source, args, rawCommand)
    if source == 0 then -- Vérifie si la commande est exécutée depuis la console
        if #args < 3 then
            print("^1[Erreur]^0 Syntaxe incorrecte. Utilisation : /ban uuid durée raison")
            return
        end

        local target = args[1] -- UUID du joueur à bannir
        local duree = tonumber(args[2]) -- Convertit en nombre (jours)
        local reason = table.concat(args, " ", 3) -- Tout après le 2ème argument = raison

        if not target or not duree then
            print("^1[Erreur]^0 UUID ou durée invalide.")
            return
        end

        if duree == 0 then
            duree = "permanent" -- On met "permanent" si la durée est 0
        end

        -- Exécuter la fonction de bannissement
        cmdban(source, target, duree, reason)

        print("^2[BanSystem]^0 Joueur avec UUID " .. target .. " banni pour " ..
            (duree == "permanent" and "Permanent" or (duree .. " jours")) ..
            " | Raison : " .. reason)
    end
end, true)


RegisterCommand("unban", function(source, args, raw)
    if source == 0 then
        cmdunban(source, args)
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and (xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "owner" or xPlayer.getGroup() == "purple") then
        cmdunban(source, args)
    else
        TriggerClientEvent('esx:showNotification', source, "Tu n'as pas la permission d'utiliser cette commande.")
    end
end, false)



RegisterCommand("search", function(source, args, raw)
	if source == 0 then
		cmdsearch(source, args)
	end
end, true)

RegisterCommand("banoffline", function(source, args, raw)
	if source == 0 then
		cmdbanoffline(source, args)
	end
end, true)

RegisterCommand("banhistory", function(source, args, raw)
	if source == 0 then
		cmdbanhistory(source, args)
	end
end, true)


TriggerEvent('es:addGroupCommand', 'sqlban', SQLBanConfig.Permission, function (source, args, user)
	cmdban(source, args)
end, function(source, args, user)
end, {help = Text.ban, params = {{name = "id"}, {name = "day", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

TriggerEvent('es:addGroupCommand', 'sqlunban', SQLBanConfig.Permission, function (source, args, user)
	cmdunban(source, args)
end, function(source, args, user)
end, {help = Text.unban, params = {{name = "name", help = Text.steamname}}})

TriggerEvent('es:addGroupCommand', 'sqlsearch', SQLBanConfig.Permission, function (source, args, user)
	cmdsearch(source, args)
end, function(source, args, user)
end, {help = Text.bansearch, params = {{name = "name", help = Text.steamname}}})

TriggerEvent('es:addGroupCommand', 'sqlbanoffline', SQLBanConfig.Permission, function (source, args, user)
	cmdbanoffline(source, args)
end, function(source, args, user)
end, {help = Text.banoff, params = {{name = "permid", help = Text.permid}, {name = "day", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

TriggerEvent('es:addGroupCommand', 'sqlbanhistory', SQLBanConfig.Permission, function (source, args, user)
	cmdbanhistory(source, args)
end, function(source, args, user)
end, {help = Text.history, params = {{name = "name", help = Text.steamname}, }})

TriggerEvent('es:addGroupCommand', 'sqlbanreload', SQLBanConfig.Permission, function (source)
  BanListLoad        = false
  BanListHistoryLoad = false
  Wait(5000)
  if BanListLoad == true then
	TriggerEvent('bansql:sendMessage', source, Text.banlistloaded)
	if BanListHistoryLoad == true then
		TriggerEvent('bansql:sendMessage', source, Text.historyloaded)
	end
  else
	TriggerEvent('bansql:sendMessage', source, Text.loaderror)
  end
end, function(source, args, user)
end, {help = Text.reload})


--How to use from server side : TriggerEvent("BanSql:ICheat", "Auto-Cheat Custom Reason",TargetId)
RegisterServerEvent('BanSql:ICheat')
AddEventHandler('BanSql:ICheat', function(reason,servertarget)
	local license,identifier,liveid,xblid,discord,target
	local duree     = 0
	local reason    = reason

	if not reason then reason = "Auto Anti-Cheat" end

	if tostring(source) == "" then
		target = tonumber(servertarget)
	else
		target = source
	end

	if target and target > 0 then
		local ping = GetPlayerPing(target)
	
		if ping and ping > 0 then
			if duree and duree < 365 then
				local sourceplayername = "Anti-Cheat-System"
				local targetplayername = GetPlayerName(target)
					for k,v in ipairs(GetPlayerIdentifiers(target))do
						if string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
						elseif string.sub(v, 1, string.len("live:")) == "live:" then
							liveid = v
						elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
							xblid  = v
						elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
							discord = v
						end
					end
			
				if duree > 0 then
					ban(target,license,identifier,liveid,xblid,discord,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
					DropPlayer(target, Text.yourban .. reason)
				else
					ban(target,license,identifier,liveid,xblid,discord,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
					DropPlayer(target, Text.yourpermban .. reason)
				end
			
			else
				print("BanSql Error : Auto-Cheat-Ban time invalid.")
			end	
		else
			print("BanSql Error : Auto-Cheat-Ban target are not online.")
		end
	else
		print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
	end
end)

RegisterServerEvent('BanSql:CheckMe')
AddEventHandler('BanSql:CheckMe', function()
	doublecheck(source)
end)

RegisterServerEvent('BanSql:ban')
AddEventHandler('BanSql:ban', function(target, reason, duree)
	local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
	if xPlayer.getGroup() ~= "user" then
	TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a ban " ..  GetPlayerName(target) .. " ( "  .. target .. ' - ' .. xTarget.getUUID() .. " ) pour " .. reason)
	cmdban(source, target, duree, reason)
	end
end)




AddEventHandler('bansql:sendMessage', function(source, message)
	if source ~= 0 then
	else
		print('SqlBan: ' .. message)
	end
end)


AddEventHandler('playerConnecting', function (playerName,setKickReason)
	local license,steamID,liveid,xblid,discord  = "n/a","n/a","n/a","n/a","n/a"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		end
	end


	if (Banlist == {}) then
		Citizen.Wait(1000)
	end

    if steamID == "n/a" and SQLBanConfig.ForceSteam then
		setKickReason(Text.invalidsteam)
		CancelEvent()
    end

	for i = 1, #BanList, 1 do
		if 
			  tostring(BanList[i].license) == tostring(license) 
			or tostring(BanList[i].identifier) == tostring(steamID) 
			or tostring(BanList[i].liveid) == tostring(liveid) 
			or tostring(BanList[i].xblid) == tostring(xblid) 
			or tostring(BanList[i].discord) == tostring(discord) 
		then

			if (tonumber(BanList[i].permanent)) == 1 then

			


				setKickReason('\n\n' .. Text.yourpermban ..
				'\nRaison du Ban: ' .. tostring(BanList[i].reason) ..
				'\nAuteur du Ban : ' .. tostring(BanList[i].sourceplayername) ..
				'\nVotre UUID : ' .. tostring(BanList[i].uuid) ..
				'\nTemps Restant : Permanent')
			
			
				CancelEvent()
				break

			elseif (tonumber(BanList[i].expiration)) > os.time() then

				local tempsrestant     = (((tonumber(BanList[i].expiration)) - os.time())/60)
				if tempsrestant >= 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = (day - math.floor(day)) * 24
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)

					setKickReason('\n\n' .. Text.yourban ..
					'\nRaison du Ban: ' .. tostring(BanList[i].reason) ..
					'\nAuteur du Ban : ' .. tostring(BanList[i].sourceplayername) ..
					'\nVotre UUID : ' .. tostring(BanList[i].uuid) ..
					'\nTemps Restant : ' .. txtday .. Text.day ..txthrs .. Text.hour ..txtminutes .. Text.minute)

					CancelEvent()


						break
				elseif tempsrestant >= 60 and tempsrestant < 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = tempsrestant / 60
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)


					setKickReason('\n\n' .. Text.yourban ..
					'\nRaison du Ban: ' .. tostring(BanList[i].reason) ..
					'\nAuteur du Ban : ' .. tostring(BanList[i].sourceplayername) ..
					'\nVotre UUID : ' .. tostring(BanList[i].uuid) ..
					'\nTemps Restant : ' .. txtday .. Text.day ..txthrs .. Text.hour ..txtminutes .. Text.minute)

						CancelEvent()
						break
				elseif tempsrestant < 60 then
					local txtday     = 0
					local txthrs     = 0
					local txtminutes = math.ceil(tempsrestant)


					setKickReason('\n\n' .. Text.yourban ..
					'\nRaison du Ban: ' .. tostring(BanList[i].reason) ..
					'\nAuteur du Ban : ' .. tostring(BanList[i].sourceplayername) ..
					'\nVotre UUID : ' .. tostring(BanList[i].uuid) ..
					'\nTemps Restant : ' .. txtday .. Text.day ..txthrs .. Text.hour ..txtminutes .. Text.minute)

						CancelEvent()
						break
				end

			elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then

				deletebanned(license)
				break
			end
		end
	end
end)





AddEventHandler('esx:playerLoaded', function(source)
    CreateThread(function()
        Wait(5000)
        local license, steamID, liveid, xblid, discord, uuid
        local playername = GetPlayerName(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        -- Récupération des identifiants
        for k, v in ipairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamID = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            end
        end

        -- Récupération de l'UUID via ESX
        uuid = xPlayer and xPlayer.getUUID() or "N/A"

        -- Vérification dans la base de données
        MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
            ['@license'] = license
        }, function(data)
            local found = false
            for i = 1, #data, 1 do
                if data[i].license == license then
                    found = true
                end
            end

            if not found then
                MySQL.Async.execute('INSERT INTO baninfo (license, identifier, liveid, xblid, discord, playername, uuid) VALUES (@license, @identifier, @liveid, @xblid, @discord, @playername, @uuid)', {
                    ['@license'] = license,
                    ['@identifier'] = steamID,
                    ['@liveid'] = liveid,
                    ['@xblid'] = xblid,
                    ['@discord'] = discord,
                    ['@playername'] = playername,
                    ['@uuid'] = uuid
                })
            else
                MySQL.Async.execute('UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playername` = @playername, `uuid` = @uuid WHERE `license` = @license', {
                    ['@license'] = license,
                    ['@identifier'] = steamID,
                    ['@liveid'] = liveid,
                    ['@xblid'] = xblid,
                    ['@discord'] = discord,
                    ['@playername'] = playername,
                    ['@uuid'] = uuid
                })
            end
        end)

        if SQLBanConfig.MultiServerSync then
            doublecheck(source)
        end
    end)
end)
