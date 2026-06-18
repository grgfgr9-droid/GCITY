ESX.Triggers = {}

ESX.Trace = function(msg)
	if ZiZouConfig.DevMode then
		print(('[framework] [^2TRACE^7] %s^7'):format(msg))
	end
end

ESX.SetTimeout = function(msec, cb)
	local id = ESX.TimeoutCount + 1

	SetTimeout(msec, function()
		if ESX.CancelledTimeouts[id] then
			ESX.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	ESX.TimeoutCount = id

	return id
end
ESX.ChangeUUID = function(identifier, oldUUID, newUUID)
    MySQL.Async.execute(
        'UPDATE users SET uuid = @newUUID WHERE identifier = @identifier AND uuid = @oldUUID',
        {
            ['@identifier'] = identifier,
            ['@oldUUID'] = oldUUID,
            ['@newUUID'] = newUUID
        },
        function(rowsChanged)
            if rowsChanged > 0 then
                print('UUID mis à jour avec succès !')
                
                -- Mise à jour de l'UUID dans owned_vehicles
                MySQL.Async.execute(
                    'UPDATE owned_vehicles SET owner = @newUUID WHERE owner = @oldUUID',
                    {
                        ['@oldUUID'] = oldUUID,
                        ['@newUUID'] = newUUID
                    },
                    function(vehiclesUpdated)
                        print(vehiclesUpdated .. ' véhicules mis à jour avec le nouvel UUID.')
                    end
                )

                -- Récupération du joueur en jeu
                local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
                if xPlayer then
                   
                    DropPlayer(xPlayer.source, "Votre UUID a été mis à jour, veuillez vous reconnecter.")
                    print('Joueur déconnecté pour mise à jour de l\'UUID.')
                end
            else
                print('Erreur lors de la mise à jour de l\'UUID.')
            end
        end
    )
end



ESX.Trigger = function(source, eventName)
	if not ESX.Triggers[source] then
		ESX.Triggers[source] = 1
	else 
		ESX.Triggers[source] = ESX.Triggers[source] + 1
	end

	if ESX.Triggers[source] < 30 then
		return true
	elseif ESX.Triggers[source] >= 30 then
		DropPlayer(source, "ZiZouAC: Trop de requetes envoyées au serveur !")
		return false
	end
end

ESX.RegisterCommand = function(name, group, cb, allowConsole, suggestion)
	if type(name) == 'table' then
		for k,v in ipairs(name) do
			ESX.RegisterCommand(v, group, cb, allowConsole, suggestion)
		end

		return
	end

	if ESX.RegisteredCommands[name] then
		print(('[framework] [^3WARNING^7] An command "%s" is already registered, overriding command'):format(name))

		if ESX.RegisteredCommands[name].suggestion then
			TriggerClientEvent('chat:removeSuggestion', -1, ('/%s'):format(name))
		end
	end

	if suggestion then
		if not suggestion.arguments then suggestion.arguments = {} end
		if not suggestion.help then suggestion.help = '' end

		TriggerClientEvent('chat:addSuggestion', -1, ('/%s'):format(name), suggestion.help, suggestion.arguments)
	end

	ESX.RegisteredCommands[name] = {group = group, cb = cb, allowConsole = allowConsole, suggestion = suggestion}

	RegisterCommand(name, function(playerId, args, rawCommand)
		local command = ESX.RegisteredCommands[name]

		if not command.allowConsole and playerId == 0 then
			print(('[framework] [^3WARNING^7] %s'):format("cette commande ne peut pas être utilisée dans la console"))
		else
			local xPlayer, error = ESX.GetPlayerFromId(playerId), nil

			if command.suggestion then
				if command.suggestion.validate then
					if #args ~= #command.suggestion.arguments then
						error = "argument count mismatch (passed " .. #args .. ", wanted " .. #command.suggestion.arguments .. ")"
					end
				end

				if not error and command.suggestion.arguments then
					local newArgs = {}

					for k,v in ipairs(command.suggestion.arguments) do
						if v.type then
							if v.type == 'number' then
								local newArg = tonumber(args[k])

								if newArg then
									newArgs[v.name] = newArg
								else
									error = "argument #" .. k .. " type mismatch (passed string, wanted number)"
								end
							elseif v.type == 'player' or v.type == 'playerId' then
							if v.type == 'player' and not tonumber(args[k]) and args[k] ~= "me" and args[k] ~= "all" then
								local targetPlayer = args[k]

								if targetPlayer then
									local xTargetPlayer = ESX.GetPlayerFromUUID(targetPlayer)

									if xTargetPlayer then
										newArgs[v.name] = xTargetPlayer
									else
										error = "il n\'ya aucun joueur avec cet UUID en jeu"
									end
								else
									error = "argument #" .. k .. " type mismatch (passed string, wanted number)"
								end
							else
								local targetPlayer = tonumber(args[k])

								if args[k] == 'me' then targetPlayer = playerId end

								if targetPlayer then
									local xTargetPlayer = ESX.GetPlayerFromId(targetPlayer)

									if xTargetPlayer then
										if v.type == 'player' then
											newArgs[v.name] = xTargetPlayer
										else
											newArgs[v.name] = targetPlayer
										end
									else
										error = "il n\'ya aucun joueur avec cet ID en jeu"
									end
								else
									error = "argument #" .. k .. " type mismatch (passed string, wanted number)"
								end
							end
							elseif v.type == 'string' then
								newArgs[v.name] = args[k]
							elseif v.type == 'item' then
								if ESX.Items[args[k]] then
									newArgs[v.name] = args[k]
								else
									error = "nom de l\'objet invalide"
								end
							elseif v.type == 'weapon' then
								if ESX.GetWeapon(args[k]) then
									newArgs[v.name] = string.upper(args[k])
								else
									error = "arme invalide"
								end
							elseif v.type == 'any' then
								newArgs[v.name] = args[k]
							end
						end

						if error then break end
					end

					args = newArgs
				end
			end

			if error then
				if playerId == 0 then
					print(('[framework] [^3WARNING^7] %s^7'):format(error))
				else
				end
			else
				cb(xPlayer or false, args, function(msg)
					if playerId == 0 then
						print(('[framework] [^3WARNING^7] %s^7'):format(msg))
					else
					end
				end)
			end
		end
	end, true)

	if type(group) == 'table' then
		for k,v in ipairs(group) do
			ExecuteCommand(('add_ace group.%s command.%s allow'):format(v, name))
		end
	else
		ExecuteCommand(('add_ace group.%s command.%s allow'):format(group, name))
	end
end

ESX.ClearTimeout = function(id)
	ESX.CancelledTimeouts[id] = true
end

ESX.RegisterServerCallback = function(name, cb)
	ESX.ServerCallbacks[name] = cb
end

ESX.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if ESX.ServerCallbacks[name] then
		ESX.ServerCallbacks[name](source, cb, ...)
	else
		print(('[framework] [^3WARNING^7] Server callback "%s" does not exist. Make sure that the server sided file really is loading, an error in that file might cause it to not load.'):format(name))
	end
end

ESX.getIdentifierFromUUID = function(uuid)
	local user = ESX.RegistredPlayers[uuid]
	local identifier = nil
	if user and user.identifier then
		identifier = user.identifier
	end
    return identifier
end

ESX.SavePlayer = function(xPlayer, cb)
	local asyncTasks = {}
	table.insert(asyncTasks, function(cb2)
		MySQL.Async.execute('UPDATE users SET accounts = @accounts, job = @job, job_grade = @job_grade, job2 = @job2, job2_grade = @job2_grade, `group` = @group, loadout = @loadout, permloadout = @permloadout, position = @position, identity = @identity, licenses = @licenses, inventory = @inventory, rank = @rank, rank_expiration = @rank_expiration, storepoints = @storepoints, time = @time, isDead = @isDead, status = @status, skin = @skin, jail = @jail WHERE identifier = @identifier', {
			['@accounts'] = json.encode(xPlayer.getAccounts(true)),
			['@job'] = xPlayer.job.name,
			['@job_grade'] = xPlayer.job.grade,
			['@job2'] = xPlayer.job2.name,
			['@job2_grade'] = xPlayer.job2.grade,
			['@group'] = xPlayer.getGroup(),
			['@loadout'] = json.encode(xPlayer.getLoadout()),
			['@permloadout'] = json.encode(xPlayer.getPermLoadout()),
			['@position'] = json.encode(xPlayer.getCoords()),
			['@identity'] = json.encode(xPlayer.identity),
			['@licenses'] = json.encode(xPlayer.getLicenses()),
			['@inventory'] = json.encode(xPlayer.getInventory(true)),
			['@rank'] = xPlayer.getRank(),
			['@rank_expiration'] = xPlayer.getExpiration(),
			['@storepoints'] = xPlayer.getStorePoints(),
			['@isDead'] = xPlayer.IsDead,
			['@time'] = xPlayer.getTime(),
			['@status'] = json.encode(xPlayer.getStatus()),
			['@skin'] = json.encode(xPlayer.getSkin()),
			['@jail'] = json.encode(xPlayer.jail),
			['@identifier'] = xPlayer.getIdentifier()
		}, function(rowsChanged)
			cb2()
			xPlayer.showNotification("Votre personnage a bien été synchronisé !")
		end)
	end)

	Async.parallel(asyncTasks, function(results)
		if cb then
			cb()
		end
	end)
end

ESX.SyncPlayer = function(xPlayer, cb, doAddTime, doCheckStatus)
	local asyncTasks = {}
	table.insert(asyncTasks, function(cb2)
		if xPlayer.jail.time == 0 and not xPlayer.afk.enable and xPlayer.PassJoin then
		    local PlayerPed = GetPlayerPed(xPlayer.source)
			local PlayerCoords = GetEntityCoords(PlayerPed)
			if doAddTime then
			xPlayer.setTime(xPlayer.getTime() + 2)
			end
			if doCheckStatus then
			local newEat = xPlayer.getStatus().eat - 1
			local newDrink = xPlayer.getStatus().drink - 1
			if newEat < 0 then
				xPlayer.setEat(0)
			else
				xPlayer.setEat(newEat)
			end
			if newDrink < 0 then
				xPlayer.setDrink(0)
			else
				xPlayer.setDrink(newDrink)
			end
		end
		if DoesEntityExist(PlayerPed) then
			if #(PlayerCoords - vector3(-75.11, -819.02, 326.18)) > 30 then
			    xPlayer.updateCoords({x = ESX.Math.Round(PlayerCoords.x, 1), y = ESX.Math.Round(PlayerCoords.y, 1), z = ESX.Math.Round(PlayerCoords.z, 1), heading = ESX.Math.Round(GetEntityHeading(PlayerPed), 1)})
		    elseif #(PlayerCoords - vector3(-75.11, -819.02, 326.18)) <= 30 then
				xPlayer.showNotification("Si êtes bloqué ici, il suffit de quitter et revenir")
			end
		end
	    end
			TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
		cb2()
	end)

	Async.parallel(asyncTasks, function(results)
		if cb then
			cb()
		end
	end)
end

ESX.SavePlayers = function(cb)
	local xPlayers, asyncTasks = ESX.GetPlayers(), {}

	for i=1, #xPlayers, 1 do
		table.insert(asyncTasks, function(cb2)
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			ESX.SavePlayer(xPlayer, cb2)
		end)
	end

	Async.parallelLimit(asyncTasks, 8, function(results)
		if cb then
			cb()
		end
	end)
end

ESX.SyncPlayers = function(cb)
	local xPlayers, asyncTasks = ESX.GetPlayers(), {}

	for i=1, #xPlayers, 1 do
		table.insert(asyncTasks, function(cb2)
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			ESX.SyncPlayer(xPlayer, cb2, true, true)
		end)
	end

	Async.parallelLimit(asyncTasks, 8, function(results)
		if cb then
			cb()
		end
	end)
end

ESX.StartDBSync = function()
	function saveData()
		ESX.SavePlayers()
		SetTimeout(10 * 60 * 1000, saveData)
	end

	SetTimeout(10 * 60 * 1000, saveData)
end

ESX.StartPlayersSync = function()
	function syncData()
		ESX.SyncPlayers()
		SetTimeout(2 * 60 * 1000, syncData)
	end

	SetTimeout(2 * 60 * 1000, syncData)
end

ESX.StartResetTriggers = function()
	function resetTrigg()
		ESX.Triggers = {}
		SetTimeout(5 * 1000, resetTrigg)
	end

	SetTimeout(5 * 1000, resetTrigg)
end

ESX.StartResetTriggers()

ESX.GetPlayers = function()
	local sources = {}

	for k,v in pairs(ESX.Players) do
		table.insert(sources, k)
	end

	return sources
end

ESX.GetPlayerFromId = function(source)
	return ESX.Players[tonumber(source)]
end

ESX.GetPlayerFromIdentifier = function(identifier)
	for k,v in pairs(ESX.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

ESX.GetPlayerFromUUID = function(uuid)
	for k,v in pairs(ESX.Players) do
		if v.uuid == uuid then
			return v
		end
	end
end

ESX.genPhoneNumber = function()
    local numBase0 = math.random(100,999)
    local numBase1 = math.random(0,9999)
    local num = string.format("%03d-%04d", numBase0, numBase1)

	return num
end

ESX.SetRank = function(identifier, rank, time)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	local expiration = 0
	if time == 1 then
	timeShift = 7 * 24 * 60 * 60  -- 1 week
	expiration = os.time() + timeShift
	elseif time == 2 then
	local timeShift = 30 * 24 * 60 * 60  -- 1 month
	expiration = os.time() + timeShift
    elseif time == 3 then
	expiration = os.time() + (99 * 12 * 30 * 24 * 60 * 60) -- Lifetime
	end

	if xPlayer then
		xPlayer.setRank(rank, expiration)
	else
		MySQL.Async.execute('UPDATE users SET rank = @rank, rank_expiration = @rank_expiration WHERE identifier = @identifier',
                         {['@rank'] = rank,
                         ['@identifier'] = identifier,
						 ['@rank_expiration'] = expiration
                        }, function(AR)
    end)
	end
end

ESX.AddStorePoints = function(identifier, storepoints)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

	if xPlayer then
		xPlayer.addStorePoints(storepoints)
	else
		MySQL.Async.execute('UPDATE users SET storepoints = storepoints + @points WHERE identifier = @identifier',
                         {['@points'] = storepoints,
                         ['@identifier'] = identifier
                        }, function(AR)
    end)
	end
end

ESX.AssignVehicle = function(source, uuid, model, plate)
    local vehiclehash = GetHashKey(model)
    if vehiclehash and uuid then
    local vehicleprops = {model = vehiclehash, plate = plate}
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = uuid,
		['@plate']   = plate,
		['@vehicle'] = json.encode(vehicleprops)
	}, function (rowsChanged)
		TriggerClientEvent('esx:announce', source, '~y~Boutique', 'Véhicule acheté : ~b~' .. string.upper(model) .. '~w~ de plaque ~b~' .. plate .. '~w~ Merci pour votre achat !', 2)
	end)
    end
end

ESX.AssignVehicleCOMMAND = function(source, uuid, model, plate)
    local vehiclehash = GetHashKey(model)
    if vehiclehash and uuid then
        local vehicleprops = {model = vehiclehash, plate = plate}
        
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
            ['@owner']   = uuid,
            ['@plate']   = plate,
            ['@vehicle'] = json.encode(vehicleprops)
        }, function (rowsChanged)
            -- Vérifier si le véhicule est déjà dans le garage
            if not GetGarageVehicle(plate) then
                InsertGarageVehicle({ owner = uuid, plate = plate, vehicle = vehicleprops, type = "car", state = true })
            end
            
            -- Envoyer l'annonce au joueur s'il est en ligne
            if source and source ~= 0 and ESX.GetPlayerFromId(source) then
                TriggerClientEvent('esx:announce', source, '~y~Boutique', 'Véhicule acheté : ~b~' .. string.upper(model) .. '~w~ de plaque ~b~' .. plate .. '~w~ Merci pour votre achat !', 2)
            end
        end)
    end
end


ESX.WipePlayer = function(identifier, uuid)
    print("UUID : " .. uuid .. "/ Identifier : " .. identifier)
    
    -- Tentative de récupération du joueur via son identifiant
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    
    if xPlayer then

        ExecuteCommand('setgroup '..uuid..' user')

        Wait(1000)  

      
        DropPlayer(xPlayer.source, "Votre personnage vient d'être delete...")

        -- Suppression du joueur dans la table users en fonction de son UUID
        MySQL.Async.execute(
            'DELETE FROM users WHERE uuid=@uuid',  -- Requête pour supprimer en fonction de l'UUID
            { ['@uuid'] = uuid },  -- On passe l'UUID comme paramètre
            function(affectedRows)
                -- Vérifier si des lignes ont été affectées (i.e., si la suppression a bien eu lieu)
                if affectedRows > 0 then
                    print('Le joueur avec UUID ' .. uuid .. ' a été supprimé de la table users.')
                else
                    -- Si aucune ligne n'est affectée, afficher un message d'erreur
                    print('Aucun joueur trouvé avec UUID ' .. uuid .. ' dans la table users.')
                end
            end
        )

        -- Suppression du joueur dans la table owned_vehicles en fonction de son UUID (dans la colonne 'owner')
        MySQL.Async.execute(
            'DELETE FROM owned_vehicles WHERE owner=@uuid',  -- Requête pour supprimer le véhicule en fonction de l'UUID du propriétaire
            { ['@uuid'] = uuid },  -- On passe l'UUID comme paramètre
            function(affectedRows)
                -- Vérifier si des lignes ont été affectées (i.e., si la suppression a bien eu lieu)
                if affectedRows > 0 then
                    print('Le véhicule du joueur avec UUID ' .. uuid .. ' a été supprimé de la table owned_vehicles.')
                else
                    -- Si aucun véhicule n'a été trouvé pour cet UUID, afficher un message d'erreur
                    print('Aucun véhicule trouvé pour l\'UUID ' .. uuid .. ' dans la table owned_vehicles.')
                end
            end
        )
        
    else
        -- Si aucun joueur n'est trouvé avec l'identifiant fourni, afficher un message d'erreur
        print('Aucun joueur trouvé avec l\'identifiant ' .. identifier .. ' à effacer.')
    end
end




ESX.RegisterUsableItem = function(item, cb)
	ESX.UsableItemsCallbacks[item] = cb
end

ESX.UseItem = function(source, item)
	ESX.UsableItemsCallbacks[item](source, item)
end

ESX.GetItemLabel = function(item)
	if ESX.Items[item] then
		return ESX.Items[item].label
	end
end

ESX.DoesJobExist = function(job, grade)
	grade = tostring(grade)
	if job and grade then
		if ESX.Jobs[job] and ESX.Jobs[job].grades[grade] then
			return true
		end
	end

	return false
end
AddEventHandler('esx:playerLoaded', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local uuid = xPlayer.getUUID and xPlayer.getUUID() or "Inconnu"
    discordLog('joins', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. uuid .. " )".. ' a rejoint le serveur.')

    local id = nil
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            id = string.sub(v, string.len("license:") + 1)
            break
        end
    end

    if not id then
        print("Erreur: Impossible de récupérer l'ID license du joueur " .. GetPlayerName(source))
        return
    end

    local name = GetPlayerName(source) 
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = id}, function(players)
        if players[1] then
            local surveillanceReason = players[1].surveillance or "Aucune"

            -- Mise à jour de la surveillance si nécessaire
            if surveillanceReason ~= "Aucune" then 
                MySQL.Async.execute('UPDATE users SET surveillance = @surveillance WHERE identifier = @identifier',
                    {['@surveillance'] = "Aucune", ['@identifier'] = id})
            end

            -- Envoi de la notification si le joueur était sous surveillance
            if surveillanceReason ~= "Aucune" then
                local allplayers = ESX.GetPlayers()
                for i = 1, #allplayers, 1 do
                    local thePlayer = ESX.GetPlayerFromId(allplayers[i])
                    if thePlayer and thePlayer.getGroup and thePlayer.getGroup() ~= 'user' then
                        if players[1].uuid then 
                            TriggerClientEvent('surveillance:announce', allplayers[i], '~r~Surveillance', 
                                string.format('%s ( %d - %s ) a été mis sous surveillance pour la raison : %s s\'est reconnecté ', 
                                    GetPlayerName(source), source, players[1].uuid, surveillanceReason), 10)
                        else 
                            TriggerClientEvent('surveillance:announce', allplayers[i], '~r~Surveillance', 
                                string.format('%s ( %d ) a été mis sous surveillance pour la raison : %s s\'est reconnecté ', 
                                    GetPlayerName(source), source, surveillanceReason), 10)
                        end
                    end
                end
            end
        end
    end)
end)


ESX.SurveillancePlayer = function(identifier, reason, console)
    -- Affiche l'UUID fourni
    print('UUID fourni : ' .. identifier)

    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer then 
        if console == false then 
            print('Le joueur est déjà connecté !')
        else 
            console.showNotification('Le joueur est déjà connecté !')
        end 
    else 
        MySQL.Async.execute('UPDATE users SET `surveillance` = @surveillance WHERE identifier = @identifier', {
            ['@surveillance'] = reason,
            ['@identifier'] = identifier,  -- Utilise directement l'UUID complet ici
        }, function(AR)
            if AR > 0 then 
                if console == false then
                    print('Le joueur a bien été mis sous surveillance !')
                else 
                    console.showNotification('Le joueur a bien été mis sous surveillance !')
                end
            else 
                if console == false then 
                    print('Cette UUID n\'est pas enregistrée dans notre base de données.')
                else 
                    console.showNotification('Cette UUID n\'est pas enregistrée dans notre base de données.')
                end
            end
        end)
    end
end

ESX.DesurveillancePlayer = function(identifier, xPlayer)

	MySQL.Async.execute('UPDATE users SET `surveillance` = NULL WHERE identifier = @identifier', { ['@identifier'] = identifier, }, 
		function(AR)
		 if AR > 0 then
			print('La surveillance a bien été retirée pour le joueur ' .. identifier)
		else        
			print('Aucune surveillance à retirer pour ce joueur.')
		end
	end)
end

