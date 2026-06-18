ESX.RegisterCommand('setcoords', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = "se téléporter aux coordonnées", validate = true, arguments = {
	{name = 'x', help = "axe X", type = 'number'},
	{name = 'y', help = "axe Y", type = 'number'},
	{name = 'z', help = "axe Z", type = 'number'}
}})

ESX.RegisterCommand('setjob', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
    if ESX.DoesJobExist(args.job, args.grade) then
        args.playerId.setJob(args.job, args.grade)
        
        -- Envoi d'un log Discord
        discordLog("setjob", "" .. (xPlayer and xPlayer.getName() or "Console") .. " a défini "
            .. "" .. args.playerId.getName() .. "** (UUID: " .. args.playerId.getUUID() .. ") en tant que "
            .. args.job .. " avec le grade " .. args.grade .. "")
    else
        showError("Le job, le grade ou les deux sont invalides")
    end
end, true, {help = "axe Z", validate = true, arguments = {
    {name = 'playerId', help = "ID joueur", type = 'player'},
    {name = 'job', help = "Nom du job", type = 'string'},
    {name = 'grade', help = "Grade du job", type = 'number'}
}})


ESX.RegisterCommand('setjob2', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob2(args.job, args.grade)
	else
		showError("le job, le grade ou les deux sont invalides")
	end
end, true, {help = "axe Z", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'job', help = "nom du job", type = 'string'},
	{name = 'grade', help = "grade du job", type = 'number'}
}})

ESX.RegisterCommand('coords', "owner", function(xPlayer, args, showError)
	print("".. xPlayer.getName().. ": ^5".. xPlayer.getCoords(true))
end, false)


ESX.RegisterCommand('wipe', {"owner", "responsable", "superadmin", "admin", "purple", "modo"}, function(xPlayer, args, showError)
    if args.playerId then
        TriggerClientEvent('zizouwipe:openClientMenu', xPlayer.source, args.playerId.source)
    else
        xPlayer.showNotification("~r~ID du joueur invalide !")
    end
end, false, {
    help = 'Wipe a player.',
    validate = true,
    arguments = {
        {name = 'playerId', help = 'The player ID', type = 'player'}
    }
})















ESX.RegisterCommand('addvehicle', {"owner"}, function(xPlayer, args, showError)
    if args.uuid and args.vehicle and args.plate then
        if args.plate == "random" then 
            plate = Genplaqueserver()
        else 
            plate = args.plate
        end
        
        MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE uuid=@uuid',
            {
                ['@uuid'] = args.uuid
            },
            function(result)
                if result[1] then 
                    local uuid = result[1].uuid
                    if uuid then
                        ESX.AssignVehicleCOMMAND(xPlayer.source, uuid, args.vehicle, plate)

                        -- 🔹 Rafraîchir la table owned_vehicles
                        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {}, function(vehicles)
                            print("[DEBUG] Table owned_vehicles mise à jour, nombre de véhicules : " .. #vehicles)
                        end)
                    end
                else
                    showError("UUID introuvable.")
                end
            end
        )
    end
end, true, {help = '', validate = true, arguments = {
    {name = 'uuid', help = 'UUID du joueur', type = 'string'},
    {name = 'vehicle', help = 'Nom du véhicule', type = 'string'},
    {name = 'plate', help = 'Plaque du véhicule', type = 'string'},
}}, true)


ESX.RegisterCommand('delete', {"owner"}, function(xPlayer, args, showError)
    if args.uuid then
        local identifier = ESX.getIdentifierFromUUID(args.uuid)
        if identifier then
            ESX.WipePlayer(identifier, args.uuid)
            print("Le joueur avec UUID " .. args.uuid .. " a été supprimé.")  -- Affiche un message de succès
        else
            print("UUID invalide : Aucun joueur trouvé avec cet UUID.")  -- Affiche un message d'erreur si l'UUID est invalide
            showError("UUID invalide : Aucun joueur trouvé avec cet UUID.")  -- Affiche également l'erreur à l'utilisateur
        end
    else
        showError("Vous devez fournir un UUID valide.")  -- Si aucun UUID n'est fourni, affiche un message d'erreur
    end
end, true, {
    help = 'Supprime un joueur en fonction de son UUID',
    validate = true,
    arguments = {
        {name = 'uuid', help = 'UUID du joueur à supprimer', type = 'string'},
    }
})



ESX.RegisterCommand('addstorevip', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	if args.uuid and args.rank and args.time then
		local identifier = ESX.getIdentifierFromUUID(args.uuid)
		if identifier then
		ESX.SetRank(identifier, args.rank, args.time)
		TriggerEvent('esx:sendLog', "store", ' Un joueur [' .. args.uuid .. '] vient de recevoir le grade ' .. args.rank)
		end
	end
end, true, {help = '', validate = true, arguments = {
	{name = 'uuid', help = 'UUID du joueur', type = 'string'},
	{name = 'rank', help = 'grade', type = 'string'},
	{name = 'time', help = 'expiration', type = 'number'}
}}, true)

RegisterCommand("addstorepoints", function(source, args, rawCommand)
    if source > 0 then
        print("You are not console.")
    else
        if args[1] and args[2] then
            local identifier = ESX.getIdentifierFromUUID(args[1])
			if identifier then 
			ESX.AddStorePoints(identifier, tonumber(args[2]))
			TriggerEvent('esx:sendLog', "store", ' Un joueur [' .. args[1] .. '] vient de recevoir ' .. args[2] .. " StorePoints")
			end
            CancelEvent()
        else
            RconPrint("Usage: addstorepoints [uuid] [number]\n")
            CancelEvent()
        end
        CancelEvent()
    end
end, true)

ESX.RegisterCommand('heal', {'owner','admin', 'responsable','superadmin', 'modo', 'purple'}, function(xPlayer, args, showError)
	args.playerId.setEat(100)
	args.playerId.setDrink(100)
	TriggerClientEvent("esx:SyncMyPlayer", args.playerId.source, args.playerId.getStatus(), args.playerId.getTime(), true)
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

ESX.RegisterCommand('revive', {'owner','admin', 'responsable','superadmin', 'modo', 'purple'}, function(xPlayer, args, showError)
	args.playerId.setDead(false)
	TriggerClientEvent('ambulance:revive', args.playerId.source)
	args.playerId.triggerEvent('esx:updateDeath', false)
	args.playerId.setEat(100)
	args.playerId.setDrink(100)
	TriggerClientEvent("esx:SyncMyPlayer", args.playerId.source, args.playerId.getStatus(), args.playerId.getTime())
end, true, {help = 'Revive a player.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

ESX.RegisterCommand('updatehudmessage', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	TriggerClientEvent('esx:UpdateHUDMessage', -1, args.info)
end, true, {help = "faire appaitre un véhicule", validate = false, arguments = {
	{name = 'info', help = "nom ou hash du véhicule", type = 'any'}
}})

ESX.RegisterCommand('car', {'owner', 'admin','responsable', 'purple'}, function(xPlayer, args, showError)
    xPlayer.triggerEvent('esx:spawnVehicle', args.car)
    
    -- Envoi d'un log Discord
    discordLog("spawnvehicle", "(" .. (xPlayer and xPlayer.getName() or "Console") .. " - " .. xPlayer.getUUID() .. ") a spawn le véhicule : " .. args.car)
end, false, {help = "faire appaitre un véhicule", validate = false, arguments = {
    {name = 'car', help = "nom ou hash du véhicule", type = 'any'}
}})

ESX.RegisterCommand({'cardel', 'dv'}, {'owner', 'admin','responsable', 'purple'}, function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
end, false, {help = "supprimer le véhicule à proximité", validate = false, arguments = {
	{name = 'radius', help = "optionnel, supprime les véhicules dans un rayon spécifié", type = 'any'}
}})

ESX.RegisterCommand('setaccountmoney', 'owner', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)
	else
		showError("nom de compte invalide")
	end
end, true, {help = "définir la somme d\'argent pour un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'account', help = "nom de compte valide", type = 'string'},
	{name = 'amount', help = "quantité d\'argent à définir", type = 'number'}
}})

ESX.RegisterCommand('giveaccountmoney', 'owner', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)
	else
		showError("nom de compte invalide")
	end
end, true, {help = "donner de l\'argent sur un compte", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'account', help = "nom de compte valide", type = 'string'},
	{name = 'amount', help = "quantité à ajouter", type = 'number'}
}})

ESX.RegisterCommand('giveitem', {'owner'}, function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)

	discordLog("giveitem", "" .. (xPlayer and xPlayer.getName() or "Console") .. 
		" a donné l'objet '" .. args.item .. 
		"' x" .. args.count .. 
		" à " .. args.playerId.getName() .. 
		" (UUID: " .. args.playerId.getUUID() .. ")")
end, true, {
	help = "Donner un objet à un joueur",
	validate = true,
	arguments = {
		{name = 'playerId', help = "ID joueur", type = 'player'},
		{name = 'item', help = "Nom de l'objet", type = 'item'},
		{name = 'count', help = "Quantité de l'objet", type = 'number'}
	}
})

RegisterCommand("setmaxplayers", function(source, args)
	if source == 0 then 
    if #args ~= 1 then
        print("Utilisation : /setmaxplayers [nombre de joueurs]")
        return
    end

    local newMaxPlayers = tonumber(args[1])

    if newMaxPlayers == nil then
        print("Veuillez entrer un nombre valide.")
        return
    end

    if newMaxPlayers < GetConvarInt("sv_minclients", 1) then
        print("Le nombre maximal de joueurs ne peut pas être inférieur au nombre minimal de joueurs.")
		ExecuteCommand('heartbeat')
		ExecuteCommand('heartbeat')
		ExecuteCommand('heartbeat')
		ExecuteCommand('heartbeat')
		ExecuteCommand('heartbeat')
		ExecuteCommand('heartbeat')
		ExecuteCommand('heartbeat')
		ExecuteCommand('heartbeat')
		ExecuteCommand('heartbeat')

        return
    end

    local newConvarValue = newMaxPlayers
    SetConvar("sv_maxclients", newConvarValue)
    print("Nombre maximal de joueurs défini sur " .. newMaxPlayers)
end 
end, true)


ESX.RegisterCommand('giveitemall', 'owner', function(xPlayer, args, showError)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xSelectedPlayer = ESX.GetPlayerFromId(xPlayers[i])
	    xSelectedPlayer.addInventoryItem(args.item, args.count)
	end
end, true, {help = "donner un objet à un joueur", validate = true, arguments = {
	{name = 'item', help = "nom de l\'objet", type = 'item'},
	{name = 'count', help = "quantité de l\'objet", type = 'number'}
}})

ESX.RegisterCommand('givelicense', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	args.playerId.addLicense(args.license)
end, true, {help = "donner un objet à un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'license', help = "nom de l\'objet", type = 'string'}
}})

ESX.RegisterCommand('screen', {'owner','admin', 'superadmin', 'modo', 'responsable', 'purple'}, function(xPlayer, args, showError)
	TriggerClientEvent(ACConfig.Name.. ":clientScreen",args.playerId.source,02)
end, true, {help = "donner un objet à un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'}
}})

ESX.RegisterCommand('giveweapon', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
    if args.playerId.hasWeapon(args.weapon) then
        showError("le joueur a déjà cette arme")
    else
        args.playerId.addWeapon(args.weapon, args.ammo)
        
        -- Envoi d'un log Discord
        discordLog("giveweapon", "" .. (xPlayer and xPlayer.getName() or "Console") .. " a donné l'arme "
            .. args.weapon .. " avec " .. args.ammo .. " munitions à " .. args.playerId.getName() .. " (UUID: " .. args.playerId.getUUID() .. ")")
    end
end, true, {help = "donner une arme à un joueur", validate = true, arguments = {
    {name = 'playerId', help = "id joueur", type = 'player'},
    {name = 'weapon', help = "nom de l'arme", type = 'weapon'},
    {name = 'ammo', help = "quantité de munitions", type = 'number'}
}})


ESX.RegisterCommand('givepermweapon', 'owner', function(xPlayer, args, showError)
    if args.playerId.hasPermWeapon(args.weapon) then
        showError("le joueur a déjà cette arme")
    else
        args.playerId.addPermWeapon(args.weapon, args.ammo)
        
        -- Envoi d'un log Discord
        discordLog("givepermweapon", "" .. (xPlayer and xPlayer.getName() or "Console") .. " a donné l'arme "
            .. args.weapon .. " avec " .. args.ammo .. " munitions à " .. args.playerId.getName() .. " (UUID: " .. args.playerId.getUUID() .. ")")
    end
end, true, {help = "donner une arme à un joueur", validate = true, arguments = {
    {name = 'playerId', help = "id joueur", type = 'player'},
    {name = 'weapon', help = "nom de l'arme", type = 'weapon'},
    {name = 'ammo', help = "quantité de munitions", type = 'number'}
}})


ESX.RegisterCommand('giveweaponcomponent', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	if args.playerId.hasWeapon(args.weaponName) then
		local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

		if component then
			if xPlayer.hasWeaponComponent(args.weaponName, args.componentName) then
				showError("le joueur a déjà cet accessoire")
			else
				xPlayer.addWeaponComponent(args.weaponName, args.componentName)
			end
		else
			showError("accessoire invalide")
		end
	else
		showError("le joueur n\'a pas cette arme")
	end
end, true, {help = "nom de l\'accessoire", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'weaponName', help = "nom de l\'arme", type = 'weapon'},
	{name = 'componentName', help = "nom de l\'accessoire", type = 'string'}
}})

ESX.RegisterCommand('givepermweaponcomponent', 'owner', function(xPlayer, args, showError)
	if args.playerId.hasPermWeapon(args.weaponName) then
		local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

		if component then
			if xPlayer.hasPermWeaponComponent(args.weaponName, args.componentName) then
				showError("le joueur a déjà cet accessoire")
			else
				xPlayer.addPermWeaponComponent(args.weaponName, args.componentName)
			end
		else
			showError("accessoire invalide")
		end
	else
		showError("le joueur n\'a pas cette arme")
	end
end, true, {help = "nom de l\'accessoire", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'weaponName', help = "nom de l\'arme", type = 'weapon'},
	{name = 'componentName', help = "nom de l\'accessoire", type = 'string'}
}})

ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = "vider le chat"})

ESX.RegisterCommand({'clearall', 'clsall'}, {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, false, {help = "vider le chat pour tous"})

ESX.RegisterCommand('clearinventory', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	for k,v in ipairs(args.playerId.inventory) do
		if v.count > 0 then
			args.playerId.setInventoryItem(v.name, 0)
		end
	end
end, true, {help = "vider l\'inventaire d\'un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'}
}})

ESX.RegisterCommand('clearloadout', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	for k,v in ipairs(args.playerId.loadout) do
		args.playerId.removeWeapon(v.name)
	end
end, true, {help = "vider le loadout d\'un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'}
}})

ESX.RegisterCommand('setgroup', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
    local targetPlayer = args.playerId
    local group = args.group
    local xPlayerGroup = xPlayer and xPlayer.getGroup()

    -- Si c'est la console
    if not xPlayer then
        if targetPlayer then
            targetPlayer.setGroup(group)
            TriggerClientEvent('esx:showNotification', targetPlayer.source, "Votre groupe a été changé en: " .. group)

            discordLog("setgroup", "La console a défini " .. targetPlayer.getName() .. " (UUID: " .. targetPlayer.getUUID() .. ") en tant que " .. group)
            TriggerClientEvent('esx:setGroup', targetPlayer.source, group)

            print("La console a défini " .. targetPlayer.getName() .. " en tant que " .. group)
        else
            print("❌ Joueur introuvable.")
        end
        return
    end

    -- Groupes que admin et purple peuvent set
    local adminAndPurpleAllowedGroups = {
        ["user"] = true,
        ["modo"] = true,
        ["superadmin"] = true,
        ["responsable"] = true
    }

    if targetPlayer then
        if xPlayerGroup == "owner"
        or ((xPlayerGroup == "admin" or xPlayerGroup == "purple") and adminAndPurpleAllowedGroups[group]) then
            targetPlayer.setGroup(group)
            TriggerClientEvent('esx:showNotification', targetPlayer.source, "Votre groupe a été changé en: " .. group)
            TriggerClientEvent('esx:setGroup', targetPlayer.source, group)
            xPlayer.showNotification("✅ Vous avez défini " .. targetPlayer.getName() .. " en tant que " .. group)
            discordLog("setgroup", xPlayer.getName() .. " (UUID: " .. xPlayer.getUUID() .. ") a défini " .. targetPlayer.getName() .. " (UUID: " .. targetPlayer.getUUID() .. ") en tant que " .. group)
        else
            xPlayer.showNotification("❌ Vous n'avez pas la permission de définir ce groupe.")
        end
    else
        xPlayer.showNotification("❌ Joueur introuvable.")
    end
end, true, { -- Arguments
    help = "Définir un groupe à un joueur",
    arguments = {
        {name = 'playerId', help = 'ID du joueur', type = 'player'},
        {name = 'group', help = 'Nouveau groupe', type = 'string'}
    }
})



ESX.RegisterCommand('save', {'owner', 'admin', 'purple'}, function(xPlayer, args, showError)
	ESX.SavePlayer(args.playerId)
end, true, {help = "sauvegarder un joueur dans la base de données", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'}
}})

ESX.RegisterCommand('saveall', 'owner', function(xPlayer, args, showError)
	ESX.SavePlayers()
end, true, {help = "sauvegarder tous les joueurs dans la base de données"})


--[[RegisterCommand('twt', function(source, args, rawCommand)
    local xPlayerSource = ESX.GetPlayerFromId(source)
            local src = source
            local msg = rawCommand:sub(5)
            local args = msg
			if AntiSpamNotif["twt"] and not AntiSpamNotif["twt"][source] then 
			TriggerClientEvent('esx:showAdvancedNotification', -1, "Twitter", GetPlayerName(source), msg, "CHAR_MULTIPLAYER", 8)
			AntiSpamNotif["twt"][source] = true
			SetTimeout(30000, function()
				AntiSpamNotif["twt"][source] = false
			end)
			end
end, false)

RegisterCommand('ano', function(source, args, rawCommand)
    local xPlayerSource = ESX.GetPlayerFromId(source)
            local src = source
            local msg = rawCommand:sub(5)
            local args = msg
			if AntiSpamNotif["ano"] and not AntiSpamNotif["ano"][source] then 
				TriggerClientEvent('esx:showAdvancedNotification', -1, "Anonyme [" .. source .. "]", ZiZouConfig.ServerName .. ".onion", msg, "CHAR_MULTIPLAYER", 8)
				AntiSpamNotif["ano"][source] = true
				SetTimeout(30000, function()
					AntiSpamNotif["ano"][source] = false
				end)
				end
end, false)]]

RegisterCommand("reboot", function(source)
	if source == 0 then
	ESX.SavePlayers(function()
	end)
    end
end)

RegisterCommand('changeuuid', function(source, args)
    if source == 0 then
        if args[1] and args[2] then
            print('Vérification en cours...')
            MySQL.Async.fetchAll(
                'SELECT * FROM users WHERE uuid = @uuid',
                {
                    ['@uuid'] = args[1]
                },
                function(result)
                    if result[1] then 
                        print('UUID trouvé, mise à jour en cours...')
                        ESX.ChangeUUID(result[1].identifier, args[1], args[2])
                    else
                        print('UUID introuvable')
                    end
                end
            )
        else
            print('Arguments manquants : /changeuuid <ancien_uuid> <nouveau_uuid>')
        end
    end
end, true)



RegisterCommand('leavegang', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer then 
	xPlayer.setJob2('unemployed2', 0)
	end
end)

RegisterCommand('leavejob', function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then 
	
	xPlayer.setJob('unemployed', 0)
	end
end)


ESX.RegisterCommand('surveillance', {"owner", "responsable", "superadmin", "admin", "purple", "modo"}, function(xPlayer, args, showError)
    if args.uuid and args.reason then
        MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE uuid = @uuid',
            {
                ['@uuid'] = args.uuid  -- On passe directement l'UUID sans découper
            },
            function(result)
                if result[1] then 
                    local identifier = result[1].identifier  -- Pas de découpe ici, on utilise l'identifiant complet

                    if identifier then
                        ESX.SurveillancePlayer(identifier, args.reason, xPlayer)  -- Passe l'identifiant complet à la fonction
                    end
                end    
            end
        ) 
    end
end, true, {
    help = '',
    validate = true,
    arguments = {
        {name = 'uuid', help = 'UUID du joueur', type = 'string'},
        {name = 'reason', help = 'Raison de la surveillance', type = 'string'},
    }
}, true)


ESX.RegisterCommand('desurveillance', {"owner", "admin", "purple", "responsable"}, function(xPlayer, args, showError)
    if args.uuid then
        MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE uuid = @uuid',
            {
                ['@uuid'] = args.uuid  -- Utilise l'UUID fourni
            },
            function(result)
                if result[1] then 
                    local identifier = result[1].identifier  -- On récupère l'identifiant du joueur

                    -- Appelle la fonction pour retirer la surveillance
                    ESX.DesurveillancePlayer(identifier, xPlayer)
                else
                    -- Si l'UUID n'est pas trouvé dans la base de données
                    if showError then
                        showError("Cette UUID n'est pas enregistrée dans notre base de données.")
                    else
                        print("Cette UUID n'est pas enregistrée dans notre base de données.")
                    end
                end    
            end
        )
    else
        -- Si l'UUID n'est pas fourni dans la commande
        if showError then
            showError("UUID manquant dans les arguments.")
        else
            print("UUID manquant dans les arguments.")
        end
    end
end, true, {
    help = 'Retirer la surveillance d\'un joueur.',
    validate = true,
    arguments = {
        {name = 'uuid', help = 'UUID du joueur', type = 'string'},
    }
}, true)
