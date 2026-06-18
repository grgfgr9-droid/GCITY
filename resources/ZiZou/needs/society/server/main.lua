local Jobs = ESX.Jobs
local RegisteredSocieties = {}


function GetSociety(name)
	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

AddEventHandler('society:registerSociety', function(name, label, account, datastore, inventory, data)
	local found = false

	local society = {
		name = name,
		label = label,
		account = account,
		datastore = datastore,
		inventory = inventory,
		data = data
	}

	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			found, RegisteredSocieties[i] = true, society
			break
		end
	end

	if not found then
		table.insert(RegisteredSocieties, society)
	end
end)

AddEventHandler('society:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('society:getSociety', function(name, cb)
	cb(GetSociety(name))
end)

RegisterServerEvent('society:withdrawMoney')
AddEventHandler('society:withdrawMoney', function(societyName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(societyName)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name == society.name then
		TriggerEvent('addonaccount:getSharedAccount', society.account, function(account)
			if amount > 0 and account.money >= amount then
				account.removeMoney(amount)
				xPlayer.addMoney(amount)
				xPlayer.showNotification('Vous avez retiré ' .. ESX.Math.GroupDigits(amount) .. ' $')
			else
				xPlayer.showNotification('Montant invalide')
			end
		end)
	else
		print(('society: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('society:depositMoney')
AddEventHandler('society:depositMoney', function(societyName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(societyName)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name == society.name then
		if amount > 0 and xPlayer.getAccount('bank').money >= amount then
			TriggerEvent('addonaccount:getSharedAccount', society.account, function(account)
				xPlayer.removeAccountMoney('bank', amount)
				account.addMoney(amount)
				xPlayer.showNotification('Vous avez déposé ' .. ESX.Math.GroupDigits(amount) .. ' $')
			end)
		elseif amount > 0 and xPlayer.getMoney() >= amount then
			TriggerEvent('addonaccount:getSharedAccount', society.account, function(account)
				xPlayer.removeMoney(amount)
				account.addMoney(amount)
				xPlayer.showNotification('Vous avez déposé ' .. ESX.Math.GroupDigits(amount) .. ' $')
			end)
		else
			xPlayer.showNotification('Montant invalide')
		end
	else
		print(('society: %s attempted to call depositMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('society:washMoney')
AddEventHandler('society:washMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local theSociety = GetSociety(society)
	local account = xPlayer.getAccount('black_money')
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name == society then
		if amount and amount > 0 and account.money >= amount then
			local account = GetSharedAccount(theSociety.account)
			if account then
			xPlayer.removeAccountMoney('black_money', amount)
			account.addMoney(amount)
			xPlayer.showNotification('Vous avez blanchi ' .. ESX.Math.GroupDigits(amount) .. " $")
			end
		else
			xPlayer.showNotification('Montant invalide')
		end
	else
		print(('society: %s attempted to call washMoney!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('society:getSocietyMoney', function(source, cb, societyName)
	local society = GetSociety(societyName)

	if society then
		TriggerEvent('addonaccount:getSharedAccount', society.account, function(account)
			if account then
			    cb(account.money)
			else
				cb(0)
			end
		end)
	else
		cb(0)
	end
end)

ESX.RegisterServerCallback('society:getEmployees', function(source, cb, society, type)
	if type == 1 then
		MySQL.Async.fetchAll('SELECT * FROM users WHERE job = @job ORDER BY job_grade DESC', {
			['@job'] = society
		}, function (results)
			local employees = {}

			for i=1, #results, 1 do
				local identity = json.decode(results[i].identity)
				table.insert(employees, {
					name       = identity.firstname .. ' ' .. identity.lastname,
					identifier = results[i].identifier,
					job = {
						name        = results[i].job,
						label       = Jobs[results[i].job].label,
						grade       = results[i].job_grade,
						grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
						grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label
					}
				})
			end

			cb(employees)
		end)
	elseif type == 2 then
		MySQL.Async.fetchAll('SELECT * FROM users WHERE job2 = @job2 ORDER BY job2_grade DESC', {
			['@job2'] = society
		}, function (results)
			local employees = {}

			for i=1, #results, 1 do
				local identity = json.decode(results[i].identity)
				table.insert(employees, {
					name       = identity.firstname .. ' ' .. identity.lastname,
					identifier = results[i].identifier,
					job = {
						name        = results[i].job2,
						label       = Jobs[results[i].job2].label,
						grade       = results[i].job2_grade,
						grade_name  = Jobs[results[i].job2].grades[tostring(results[i].job2_grade)].name,
						grade_label = Jobs[results[i].job2].grades[tostring(results[i].job2_grade)].label
					}
				})
			end

			cb(employees)
		end)
	end
end)

ESX.RegisterServerCallback('society:setJob', function(source, cb, target, job, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'
	local xTarget = nil
	if tonumber(target) then
	xTarget = ESX.GetPlayerFromId(target)
	end
	identifier = nil

	local fuckingword = 'recruter'

	if job == "unemployed" then
		fuckingword = 'virer'
	end

	if job ~= 'unemployed' and xPlayer.job.name ~= job then TriggerClientEvent('esx:showNotification', source, "Pas de bypass avec moi :D.") return end

	if isBoss then
	if xTarget then
	identifier = xTarget.identifier
		if xTarget.job.name ~= 'unemployed' and type == 'hire' then
		TriggerClientEvent('esx:showNotification', source, "Vous ne pouvez pas recruter un joueur qui est déjà dans une autre entreprise.")
		cb()
		return	
		end

		if xTarget.job.name ~= xPlayer.job.name and type == 'fire' then
			TriggerClientEvent('esx:showNotification', source, "Vous ne pouvez pas virer un joueur qui est dans une autre entreprise.")
			cb()
			return	
		end
		xTarget.setJob(job, grade)
		ESX.SavePlayer(xTarget)
		TriggerClientEvent('esx:showNotification', target, "Vous venez de vous faire " .. fuckingword .. " " .. xPlayer.identity.firstname .. ' ' .. xPlayer.identity.lastname)
		TriggerClientEvent('esx:showNotification', source, "Vous venez de " .. fuckingword .. " " .. xTarget.identity.firstname .. ' ' .. xTarget.identity.lastname)
	else
		identifier = target
		local player = ESX.GetPlayerFromIdentifier(identifier)
		if player then
			player.setJob(job, grade)
			ESX.SavePlayer(player)
			TriggerClientEvent('esx:showNotification', player.source, "Vous venez de vous faire " .. fuckingword .. " " .. xPlayer.identity.firstname .. ' ' .. xPlayer.identity.lastname)
			TriggerClientEvent('esx:showNotification', source, "Vous venez de " .. fuckingword .. " " .. player.identity.firstname .. ' ' .. player.identity.lastname)
		else 
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	end
else
	print(('society: %s attempted to setJob'):format(xPlayer.identifier))
	cb()
end
end)


ESX.RegisterServerCallback('society:promote', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'
	local xTarget = ESX.GetPlayerFromId(target)
	local identifier = xTarget.identifier
	local fuckingword = "promouvoir"

	if  xPlayer.job.name == xTarget.job.name then

	if isBoss then

		if xTarget then
			local currentgrade = xTarget.job.grade
		    local newgrade = currentgrade + 1
			xTarget.setJob(xTarget.job.name, newgrade)
			ESX.SavePlayer(xTarget)
			TriggerClientEvent('esx:showNotification', target, "Vous venez de vous faire " .. fuckingword .. " " .. xPlayer.identity.firstname .. ' ' .. xPlayer.identity.lastname)
			TriggerClientEvent('esx:showNotification', source, "Vous venez de " .. fuckingword .. " " .. xTarget.identity.firstname .. ' ' .. xTarget.identity.lastname)
			cb()
		end
	else
		print(('society: %s attempted to promote'):format(xPlayer.identifier))
		cb()
	end
    else
		TriggerClientEvent('esx:showNotification', source, "Essaye pas de glitch.")
		cb()
    end
end)

ESX.RegisterServerCallback('society:demote', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'
	local xTarget = ESX.GetPlayerFromId(target)
	local identifier = xTarget.identifier
	local fuckingword = "destituer"

	if xPlayer.job.name == xTarget.job.name then
	if isBoss then
		if xTarget then
			local currentgrade = xTarget.job.grade
		    local newgrade = currentgrade - 1
			xTarget.setJob(xTarget.job.name, newgrade)
			ESX.SavePlayer(xTarget)
			TriggerClientEvent('esx:showNotification', target, "Vous venez de vous faire " .. fuckingword .. " " .. xPlayer.identity.firstname .. ' ' .. xPlayer.identity.lastname)
			TriggerClientEvent('esx:showNotification', source, "Vous venez de " .. fuckingword .. " " .. xTarget.identity.firstname .. ' ' .. xTarget.identity.lastname)
			cb()
		end
	else
		print(('society: %s attempted to demote'):format(xPlayer.identifier))
		cb()
	end
else
	TriggerClientEvent('esx:showNotification', source, "Essaye pas de glitch.")
	cb()
end
end)


ESX.RegisterServerCallback('society:setJob2', function(source, cb, target, job, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job2.grade_name == 'boss'
	local xTarget = nil
	if tonumber(target) then
	xTarget = ESX.GetPlayerFromId(target)
	end
	identifier = nil

	local fuckingword = 'recruter'

	if job == "unemployed2" then
		fuckingword = 'virer'
	end
	

	if job ~= 'unemployed2' and xPlayer.job2.name ~= job then TriggerClientEvent('esx:showNotification', source, "Pas de bypass avec moi :D.") return end

	if isBoss then
	if xTarget then
	identifier = xTarget.identifier
		if xTarget.job2.name ~= 'unemployed2' and type == 'hire' then
		TriggerClientEvent('esx:showNotification', source, "Vous ne pouvez pas recruter un joueur qui est déjà dans une organisation.")
		cb()
		return	
		end

		if xTarget.job2.name ~= xPlayer.job2.name and type == 'fire' then
			TriggerClientEvent('esx:showNotification', source, "Vous ne pouvez pas virer un joueur qui est dans une autre organisation.")
			cb()
			return	
		end
		xTarget.setJob2(job, grade)
		ESX.SavePlayer(xTarget)
		TriggerClientEvent('esx:showNotification', target, "Vous venez de vous faire " .. fuckingword .. " " .. xPlayer.identity.firstname .. ' ' .. xPlayer.identity.lastname)
		TriggerClientEvent('esx:showNotification', source, "Vous venez de " .. fuckingword .. " " .. xTarget.identity.firstname .. ' ' .. xTarget.identity.lastname)
	else
		identifier = target
		local player = ESX.GetPlayerFromIdentifier(identifier)
		if player then
			player.setJob2(job, grade)
			ESX.SavePlayer(player)
			TriggerClientEvent('esx:showNotification', player.source, "Vous venez de vous faire " .. fuckingword .. " " .. xPlayer.identity.firstname .. ' ' .. xPlayer.identity.lastname)
			TriggerClientEvent('esx:showNotification', source, "Vous venez de " .. fuckingword .. " " .. player.identity.firstname .. ' ' .. player.identity.lastname)
		else 
			MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
				['@job2']        = job,
				['@job2_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	end
else
	print(('society: %s attempted to setJob2'):format(xPlayer.identifier))
	cb()
end

end)


ESX.RegisterServerCallback('society:promote2', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job2.grade_name == 'boss'
	local xTarget = ESX.GetPlayerFromId(target)
	local identifier = xTarget.identifier
	local fuckingword = "promouvoir"
	if  xPlayer.job2.name == xTarget.job2.name then

	if isBoss then
		if xTarget then
			local currentgrade = xTarget.job2.grade
		    local newgrade = currentgrade + 1
			xTarget.setJob2(xTarget.job2.name, newgrade)
			ESX.SavePlayer(xTarget)
			TriggerClientEvent('esx:showNotification', target, "Vous venez de vous faire " .. fuckingword .. " " .. xPlayer.identity.firstname .. ' ' .. xPlayer.identity.lastname)
			TriggerClientEvent('esx:showNotification', source, "Vous venez de " .. fuckingword .. " " .. xTarget.identity.firstname .. ' ' .. xTarget.identity.lastname)
			cb()
		end
	else
		print(('society: %s attempted to promote'):format(xPlayer.identifier))
		cb()
	end
    else
		TriggerClientEvent('esx:showNotification', source, "Essaye pas de glitch.")
		cb()
    end
end)

ESX.RegisterServerCallback('society:demote2', function(source, cb, target, job)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job2.grade_name == 'boss'
	local xTarget = ESX.GetPlayerFromId(target)
	local identifier = xTarget.identifier
	local fuckingword = "destituer"
	if  xPlayer.job2.name == xTarget.job2.name then


	if isBoss then
		if xTarget then
			local currentgrade = xTarget.job2.grade
		    local newgrade = currentgrade - 1
			xTarget.setJob2(xTarget.job2.name, newgrade)
			ESX.SavePlayer(xTarget)
			TriggerClientEvent('esx:showNotification', target, "Vous venez de vous faire " .. fuckingword .. " " .. xPlayer.identity.firstname .. ' ' .. xPlayer.identity.lastname)
			TriggerClientEvent('esx:showNotification', source, "Vous venez de " .. fuckingword .. " " .. xTarget.identity.firstname .. ' ' .. xTarget.identity.lastname)
			cb()
		end
	else
		print(('society: %s attempted to demote'):format(xPlayer.identifier))
		cb()
	end
else
	TriggerClientEvent('esx:showNotification', source, "Essaye pas de glitch.")
	cb()
end
end)

RegisterServerEvent('society:leavejob')
AddEventHandler('society:leavejob', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
	xPlayer.setJob('unemployed', '0')
	end
end)

RegisterServerEvent('society:leavegang')
AddEventHandler('society:leavegang', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
	xPlayer.setJob2('unemployed2', '0')
	end
end)





RegisterCommand('kickall', function(source, args, rawCommand)
    if source == 0 then
        local reason = table.concat(args, " ")
        if reason == "" then
            reason = ""
        end 
        local players = GetPlayers()
        local count = 0
        
        for _, playerId in ipairs(players) do
            local playerIdNum = tonumber(playerId)
            if playerIdNum then

                DropPlayer(playerIdNum, reason)
                count = count + 1
            end
        end   
	else
        TriggerClientEvent('esx:showNotification', source, "Cette commande est réservée à la console serveur.")
    end
end, true)

RegisterCommand('consolebanall', function(source, args, rawCommand)
    if source == 0 then
        local duree = tonumber(args[1])
        local reason = table.concat(args, " ", 2)
        
        if duree and reason then
            local playerCount = 0
            -- Récupérer tous les joueurs
            local players = ESX.GetPlayers()
            
            print("^3Début du bannissement de tous les joueurs...")
            
            for _, playerId in ipairs(players) do
                local xTarget = ESX.GetPlayerFromId(playerId)
                if xTarget then
                    -- Log de l'action
                    TriggerEvent('esx:sendLog', "staff", "CONSOLE a banni " .. GetPlayerName(playerId) .. " ( " .. playerId .. ' - ' .. xTarget.getUUID() .. " ) pour " .. reason .. "")
                    
                    -- Appel à la fonction de bannissement
                    cmdban(0, playerId, duree, reason)
                    playerCount = playerCount + 1
                end
            end
            
            print("^2Ban massif terminé: " .. playerCount .. " joueurs bannis pour: " .. reason)
        else
            print("^1Usage: consolebanall [durée] [raison]")
            print("^1Exemple: consolebanall 30 Maintenance serveur")
        end
    else
        -- Si quelqu'un tente d'utiliser la commande en jeu
        TriggerClientEvent('esx:showNotification', source, "Cette commande est réservée à la console serveur.")
        print("^1Tentative d'utilisation de la commande consolebanall par " .. GetPlayerName(source) .. " (" .. source .. ")")
    end
end, true)