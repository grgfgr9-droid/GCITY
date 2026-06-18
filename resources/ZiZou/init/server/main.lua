playerLoadouts = {}

ESX.PlayersAdd = math.random(0, 0)

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function genUUID()
	local generatedUUID = string.lower(GetRandomLetter(3) .. GetRandomNumber(3))
	if not ESX.RegistredPlayers[generatedUUID] then
		return generatedUUID
	else
		return genUUID()
	end
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

Citizen.CreateThread(function()
	SetMapName('Los Santos')
	SetGameType('Roleplay')
end)

RegisterNetEvent('esx:onPlayerJoined')
AddEventHandler('esx:onPlayerJoined', function()
	if not ESX.Players[source] then
		TriggerClientEvent("esx:receiveProtectedEvents", source, ProtectedEvents)
		onPlayerJoined(source)
	end
end)

RegisterServerEvent("esx:passjoin")
AddEventHandler("esx:passjoin", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		xPlayer.setPassJoin(true)
	end
end)

function onPlayerJoined(playerId)
    local identifier, discordID

    -- Récupération des identifiants
    for _, id in ipairs(GetPlayerIdentifiers(playerId)) do
        if id:match("^discord:") then
            discordID = id:gsub("discord:", "")
        elseif id:match("^license:") then
            identifier = id:gsub("license:", "")
        end

        -- Arrêter la boucle si les deux identifiants sont trouvés
        if identifier and discordID then break end
    end

    if identifier then
        if ESX.GetPlayerFromIdentifier(identifier) then
            DropPlayer(playerId, ('There was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
        else
            MySQL.Async.fetchScalar('SELECT uuid FROM users WHERE identifier = @identifier', {
                ['@identifier'] = identifier
            }, function(result)
                if result then
                    loadKCPlayer(identifier, playerId, result)
                else
                    local accounts = {}
                    for account, money in pairs(Config.StartingAccountMoney) do
                        accounts[account] = money
                    end

                    local UUID = genUUID()

                    MySQL.Async.execute(
                        'INSERT INTO users (accounts, identifier, uuid, discord_id) VALUES (@accounts, @identifier, @uuid, @discord_id) ' ..
                        'ON DUPLICATE KEY UPDATE discord_id = VALUES(discord_id)',
                        {
                            ['@accounts'] = json.encode(accounts),
                            ['@identifier'] = identifier,
                            ['@uuid'] = UUID,
                            ['@discord_id'] = discordID
                        },
                        function(rowsChanged)
                            loadKCPlayer(identifier, playerId, UUID)
                        end
                    )
                end
            end)
        end
    else
        DropPlayer(playerId, 'There was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
    end
end






function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function loadKCPlayer(identifier, playerId, UUID)
	local _source = playerId
	local tasks = {}

	local userData = {
		accounts = {},
		inventory = {},
		group = 'user',
		job = {},
		job2 = {},
		loadout = {},
		permloadout = {},
		playerName = GetPlayerName(playerId),
		weight = 0,
		status = {
			eat = 50,
			drink = 50
		},
		uuid = UUID,
		rank = 'default',
		storepoints = 0,
		expiration = 0,
		isdead = false,
		identity = {
			firstname = nil,
			lastname = nil,
			dob = nil,
			sex = nil,
			height = 0
		},
		licenses = {},
		time = 0,
		skin = {}
	}

	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			ESX.RegistredPlayers[result[1].uuid] = result[1]
			local job, grade, jobObject, gradeObject = result[1].job, tostring(result[1].job_grade)
			local job2, grade2, job2Object, grade2Object = result[1].job2, tostring(result[1].job2_grade)
			local foundAccounts, foundItems = {}, {}

			-- Accounts
			if result[1].accounts and result[1].accounts ~= '' then
				local accounts = json.decode(result[1].accounts)

				for account,money in pairs(accounts) do
					foundAccounts[account] = money
				end
			end

			for account,label in pairs(Config.Accounts) do
				table.insert(userData.accounts, {
					name = account,
					money = foundAccounts[account] or Config.StartingAccountMoney[account] or 0,
					label = label
				})
			end
			-- Job
			if ESX.DoesJobExist(job, grade) then
				jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			else
				print(('[framework] [^3WARNING^7] Ignoring invalid job for %s [job: %s, grade: %s]'):format(identifier, job, grade))
				job, grade = 'unemployed', '0'
				jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			end
			-- Job2
			if ESX.DoesJobExist(job2, grade2) then
				job2Object, grade2Object = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]
			else
				print(('[framework] [^3WARNING^7] Ignoring invalid job for %s [job: %s, grade: %s]'):format(identifier, job2, grade2))
				job2, grade2 = 'unemployed2', '0'
				job2Object, grade2Object = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]
			end

			userData.job.id = jobObject.id
			userData.job.name = jobObject.name
			userData.job.label = jobObject.label

			userData.job.grade = tonumber(grade)
			userData.job.grade_name = gradeObject.name
			userData.job.grade_label = gradeObject.label
			userData.job.grade_salary = gradeObject.salary

			userData.job.skin_male = {}
			userData.job.skin_female = {}

			if gradeObject.skin_male then userData.job.skin_male = json.decode(gradeObject.skin_male) end
			if gradeObject.skin_female then userData.job.skin_female = json.decode(gradeObject.skin_female) end

			userData.job2.id = job2Object.id
			userData.job2.name = job2Object.name
			userData.job2.label = job2Object.label

			userData.job2.grade = tonumber(grade2)
			userData.job2.grade_name = grade2Object.name
			userData.job2.grade_label = grade2Object.label
			userData.job2.grade_salary = grade2Object.salary

			userData.job2.skin_male = {}
			userData.job2.skin_female = {}

			if grade2Object.skin_male then userData.job2.skin_male = json.decode(grade2Object.skin_male) end
			if grade2Object.skin_female then userData.job.skin_female = json.decode(grade2Object.skin_female) end

			-- Inventory
			if result[1].inventory and result[1].inventory ~= '' then
				local inventory = json.decode(result[1].inventory)

				for name,count in pairs(inventory) do
					local item = ESX.Items[name]

					if item then
						foundItems[name] = count
					else
						print(('[framework] [^3WARNING^7] Ignoring invalid item "%s" for "%s"'):format(name, identifier))
					end
				end
			end

			for name,item in pairs(ESX.Items) do
				local count = foundItems[name] or 0
				if count > 0 then userData.weight = userData.weight + (item.weight * count) end

				table.insert(userData.inventory, {
					name = name,
					count = count,
					label = item.label,
					weight = item.weight,
					usable = ESX.UsableItemsCallbacks[name] ~= nil,
					rare = item.rare,
					canRemove = item.canRemove
				})
			end

			table.sort(userData.inventory, function(a, b)
				return a.label < b.label
			end)

			-- Group
			if result[1].group then
				userData.group = result[1].group
			else
				userData.group = 'user'
			end

			--Status
			if result[1].status ~= nil then
				userData.status = json.decode(result[1].status)
			else
				userData.status = {eat = 50, drink = 50}
			end

			-- Rank
			if result[1].rank then
				userData.rank = result[1].rank
			else
				userData.rank = 'default'
			end

			-- Identity
			if result[1].identity then
				userData.identity = json.decode(result[1].identity)
			else
				userData.identity = userData.identity
			end

			-- Skin
			if result[1].skin then
				userData.skin = json.decode(result[1].skin)
			else
				userData.skin = {sex = 0}
			end

			-- Jail
			if result[1].jail then
				userData.jail = json.decode(result[1].jail)
			else
				userData.jail = {station = nil, time = 0}
			end

			-- isDead
			if result[1].isDead == 1 then
				userData.isdead = true
			else
				userData.isdead = false
			end

			userData.ip = GetPlayerEndpoint(_source)

			-- Time
			if result[1].time then
				userData.time = result[1].time
			else
				userData.time = 0
			end

			-- Rank
			if result[1].rank_expiration then
				userData.expiration = result[1].rank_expiration
				if userData.expiration > 0 and os.time() >= userData.expiration then
					userData.rank = 'default'
					userData.expiration = 0
				end
			else
				userData.expiration = 0
			end

			-- StorePoints
			if result[1].storepoints then
				userData.storepoints = result[1].storepoints
			else
				userData.storepoints = 0
			end

			-- Licenses
			if result[1].licenses then
				userData.licenses = json.decode(result[1].licenses)
			else
				userData.licenses = {}
			end

			-- Loadout

			if result[1].loadout and result[1].loadout ~= '' then
					local loadout = json.decode(result[1].loadout) or {}
	
					for k, weapon in pairs(loadout) do
						local name = string.upper(weapon.name)
						local label = ESX.GetWeaponLabel(name)
	
						if label then
							if not weapon.components then weapon.components = {} end
							if not weapon.tintIndex then weapon.tintIndex = 0 end
	
							table.insert(userData.loadout, {
								name = name,
								ammo = weapon.ammo,
								label = label,
								components = weapon.components,
								tintIndex = weapon.tintIndex
							})
						end
					end
			else
				userData.loadout = {}
			end

			--[[table.sort(userData.loadout, function(a, b)
				return ESX.GetWeaponLabel(a.name) < ESX.GetWeaponLabel(b.name)
			end)]]

			-- Perma Loadout

			if result[1].permloadout and result[1].permloadout ~= '' then
				local formattedPermLoadout = json.decode(result[1].permloadout) or {}

				for i = 1, #formattedPermLoadout, 1 do
					if formattedPermLoadout[i].components == nil then
						formattedPermLoadout[i].components = {}
					end
				end

				userData.permloadout = formattedPermLoadout
			else
				userData.permloadout = {}
			end

			--[[table.sort(userData.permloadout, function(a, b)
				return ESX.GetWeaponLabel(a.name) < ESX.GetWeaponLabel(b.name)
			end)]]

			if userData.rank and userData.rank == 'diamond' then
				userData.maxWeight = 200
			else
				userData.maxWeight = 150
			end


			-- Position
			if result[1].position and result[1].position ~= '' then
				userData.coords = json.decode(result[1].position)
			else
				print('[framework] [^3WARNING^7] Column "position" in "users" table is missing required default value. Using backup coords, fix your database.')
				userData.coords = {x = -255.9, y = -296.76, z = 20.63, heading = 207.9}
			end
			cb()
		end)
	end)

	Async.parallel(tasks, function(results)
		local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.ip, userData.group, userData.accounts, userData.inventory, userData.weight, userData.maxWeight, userData.job, userData.job2, userData.loadout, userData.playerName, userData.coords, userData.uuid, userData.rank, userData.storepoints, userData.expiration, userData.isdead, userData.identity, userData.licenses, userData.time, userData.status, userData.permloadout, userData.skin, userData.jail)
		ESX.Players[playerId] = xPlayer
		TriggerEvent('esx:playerLoaded', playerId, xPlayer)
		if ZiZouConfig.DevMode then
			ESX.PlayersAdd = 0
		end
		TriggerClientEvent('esx:UpdatePlayersCount', -1, #ESX.GetPlayers() + ESX.PlayersAdd)
		TriggerEvent('esx:UpdatePlayersCount', #ESX.GetPlayers() + ESX.PlayersAdd)
		TriggerEvent('esx:checkPlayerWeapons', playerId)
		for k, v in pairs(VehicleShops) do
			if IsSomeoneInService(k) then
				TriggerClientEvent("vehicleshop:ToggleAutoShop", -1, k, true)
			else
				TriggerClientEvent("vehicleshop:ToggleAutoShop", -1, k, false)
			end
		end
		SendAntiCheatLog(playerId, "join")
		AnticheatPlayerJoined(playerId)
		xPlayer.triggerEvent('esx:playerLoaded', {
			accounts = xPlayer.getAccounts(),
			coords = xPlayer.getCoords(),
			identifier = xPlayer.getIdentifier(),
			inventory = xPlayer.getInventory(),
			group = xPlayer.getGroup(),
			job = xPlayer.getJob(),
			job2 = xPlayer.getJob2(),
			loadout = xPlayer.getLoadout(),
			permloadout = xPlayer.getPermLoadout(),
			maxWeight = xPlayer.getMaxWeight(),
			money = xPlayer.getMoney(),
			uuid = xPlayer.getUUID(),
			rank = xPlayer.getRank(),
			storepoints = xPlayer.getStorePoints(),
			expiration = xPlayer.getExpiration(),
			IsDead = xPlayer.IsDead,
			identity = xPlayer.identity,
			licenses = xPlayer.getLicenses(),
			time = xPlayer.getTime(),
			status = xPlayer.getStatus(),
			skin = xPlayer.getSkin(),
			jail = xPlayer.jail
		})

		print(('[framework] [^2INFO^7] A player with name "%s^7" has connected to the server with assigned player id %s'):format(xPlayer.getName(), xPlayer.getUUID()))
	end)
end

AddEventHandler('chatMessage', function(playerId, author, message)
	if message:sub(1, 1) == '/' and playerId > 0 then
		CancelEvent()
		local commandName = message:sub(1):gmatch("%w+")()
	end
end)

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId, reason)
		removeService(playerId, xPlayer.job.name)
		if xPlayer.IsDead then
			if reason == 'Disconnected.' or reason == 'Exiting' then
				SendAntiCheatLog(playerId, "left server while dead")
			else
				SendAntiCheatLog(playerId, "left server while dead (crash)")
			end
		else 
			if reason == 'Disconnected.' or reason == 'Exiting' then
				SendAntiCheatLog(playerId, "left server")
			else
				SendAntiCheatLog(playerId, "left server (crash)")
			end
		end

		ESX.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
		end)
	end
	if ZiZouConfig.DevMode then
		ESX.PlayersAdd = 0
	end
	if #ESX.GetPlayers() > 0 then
	    TriggerClientEvent('esx:UpdatePlayersCount', -1, #ESX.GetPlayers() + ESX.PlayersAdd)
	    TriggerEvent('esx:UpdatePlayersCount', #ESX.GetPlayers() + ESX.PlayersAdd)
	else
	    TriggerEvent('esx:UpdatePlayersCount', 0)
	end
end)

RegisterServerEvent('esx:syncPlayer')
AddEventHandler('esx:syncPlayer', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		ESX.SyncPlayer(xPlayer, function()
			ESX.SavePlayer(xPlayer)
		end, false, false)
	end
end)

RegisterServerEvent('esx:updateWeaponsAmmo')
AddEventHandler('esx:updateWeaponsAmmo', function(weapons)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and weapons then
		for k, v in pairs(weapons) do
			xPlayer.updateWeaponAmmo(k, v)
		end
	end
end)

RegisterServerEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
	local playerId = source
	local sourceXPlayer = ESX.GetPlayerFromId(playerId)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == 'item_standard' then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)

				sourceXPlayer.showNotification("vous avez donné ~y~" .. itemCount .. "x~s~ ~b~" .. sourceItem.label .. "~s~ à ~y~" .. targetXPlayer.name .. "~s~")
				targetXPlayer.showNotification("vous avez reçu ~y~" .. itemCount .. "x~s~ ~b~" .. sourceItem.label .. "~s~ de ~y~" .. sourceXPlayer.name .. "~s~")
			else
				sourceXPlayer.showNotification("action impossible, depassement de la limite d\'inventaire pour ~y~" .. targetXPlayer.name .. "~s~")
			end
		else
			sourceXPlayer.showNotification("action impossible, ~r~quantité invalide")
		end
	elseif type == 'item_account' then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney   (itemName, itemCount)
			discordLog("money", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. sourceXPlayer.getUUID() .. " )".. ' a donné ' .. itemCount .. "$ " .. "de " .. itemName .. " à " .. GetPlayerName(target) .. " ( "  .. target .. ' - ' .. targetXPlayer.getUUID() .. " )")
			sourceXPlayer.showNotification("vous avez donné ~g~$" .. ESX.Math.GroupDigits(itemCount) .. "~s~ (" .. Config.Accounts[itemName] .. ") à ~y~" .. targetXPlayer.name .. "~s~")
			targetXPlayer.showNotification("vous avez reçu ~g~$" .. ESX.Math.GroupDigits(itemCount) .. "~s~ (" .. Config.Accounts[itemName] .. ") par ~y~" .. sourceXPlayer.name .. "~s~")
		else
			sourceXPlayer.showNotification("action impossible, ~r~quantité invalide")
		end
	elseif type == 'item_weapon' then
		if sourceXPlayer.hasWeapon(itemName) then
			local weaponLabel = ESX.GetWeaponLabel(itemName)

			if not targetXPlayer.hasWeapon(itemName) then
				local _, weapon = sourceXPlayer.getWeapon(itemName)
				local _, weaponObject = ESX.GetWeapon(itemName)
				itemCount = weapon.ammo

				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)

				discordLog("weapons", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. sourceXPlayer.getUUID() .. " )".. ' a donné une ' .. itemName .. " à " .. GetPlayerName(target) .. " ( "  .. target .. ' - ' .. targetXPlayer.getUUID() .. " )")

				if weaponObject.ammo and itemCount > 0 then
					local ammoLabel = weaponObject.ammo.label
					sourceXPlayer.showNotification("vous avez donné ~y~1x~s~ ~b~" .. weaponLabel .. "~s~ avec ~o~" .. itemCount .. "x " .. ammoLabel .. "~s~ à ~y~" .. targetXPlayer.name .. "~s~")
					targetXPlayer.showNotification("vous avez reçu ~y~1x~s~ ~b~" .. weaponLabel .. "~s~ avec ~o~" .. itemCount .. "x " .. ammoLabel .. "~s~ par ~y~" .. sourceXPlayer.name .. "~s~")
				else
					sourceXPlayer.showNotification("vous avez donné ~y~1x~s~ ~b~" .. weaponLabel .. "~s~ à ~y~" .. targetXPlayer.name .. "~s~")
					targetXPlayer.showNotification("vous avez reçu ~y~1x~s~ ~b~" .. weaponLabel .. "~s~ par ~y~" .. sourceXPlayer.name .. "~s~")
				end
			else
				sourceXPlayer.showNotification("~y~" .. targetXPlayer.name .. "~s~ a déjà ~y~" .. weaponLabel .. "~s~")
				targetXPlayer.showNotification("~b~" .. sourceXPlayer.name .. "~s~ a tenté de vous donner ~y~" .. weaponLabel .. "~s~, mais vous en aviez déjà un exemplaire")
			end 
		end
	end
end)

RegisterServerEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if type == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification("action impossible, ~r~quantité invalide")
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				xPlayer.showNotification("action impossible, ~r~quantité invalide")
			else
				xPlayer.removeInventoryItem(itemName, itemCount)
				xPlayer.showNotification("vous avez jeté ~y~" .. itemCount .. "x~s~ ~b~x" .. Item.label .. "~s~")
			end
		end
	elseif type == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification("action impossible, ~r~montant invalide")
		else
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				xPlayer.showNotification("action impossible, ~r~montant invalide")
			else
				xPlayer.removeAccountMoney(itemName, itemCount)
				xPlayer.showNotification("vous avez jeté ~g~$" .. ESX.Math.GroupDigits(itemCount) .. "~s~ ~b~" .. string.lower(account.label) .. "~s~")
			end
		end
	elseif type == 'item_weapon' then
		if xPlayer.hasWeapon(itemName) then
			local _, weapon = xPlayer.getWeapon(itemName)
			local _, weaponObject = ESX.GetWeapon(itemName)
			xPlayer.removeWeapon(itemName)

			if weaponObject.ammo and weapon.ammo > 0 then
				local ammoLabel = weaponObject.ammo.label
				xPlayer.showNotification("vous avez jeté ~y~1x~s~ ~b~" .. weapon.label .. "~s~ avec ~o~" .. weapon.ammo .. "x " .. ammoLabel .. "~s~")
			else
				xPlayer.showNotification("vous avez jeté ~y~1x~s~ ~b~" .. weapon.label)
			end

		end
	end
end)

RegisterServerEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local count = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		ESX.UseItem(source, itemName)
	else
		xPlayer.showNotification("action impossible")
	end
end)

local PoliceWeapons = {		
'WEAPON_PISTOL',
'WEAPON_NIGHTSTICK',
'WEAPON_STUNGUN',
'WEAPON_FLASHLIGHT',
'WEAPON_PUMPSHOTGUN',
'WEAPON_ADVANCEDRIFLE',
'WEAPON_SNIPERRIFLE'
}

local SheriffWeapons = {		
	'WEAPON_PISTOL',
	'WEAPON_NIGHTSTICK',
	'WEAPON_STUNGUN',
	'WEAPON_FLASHLIGHT',
	'WEAPON_PUMPSHOTGUN',
	'WEAPON_ADVANCEDRIFLE',
	'WEAPON_SNIPERRIFLE'
}

RegisterNetEvent('esx:checkPlayerWeapons')
AddEventHandler('esx:checkPlayerWeapons', function(playersource)
	local xPlayer = ESX.GetPlayerFromId(playersource)

		if xPlayer.getRank() ~= 'vip' and xPlayer.getRank() ~= 'diamond' then
		if xPlayer.hasWeapon('WEAPON_COMBATPDW') then
		   xPlayer.removeWeapon('WEAPON_COMBATPDW')
		end
		if xPlayer.hasWeapon('WEAPON_ASSAULTRIFLE_MK2') then
			xPlayer.removeWeapon('WEAPON_ASSAULTRIFLE_MK2')
		end
        if xPlayer.hasWeapon('WEAPON_CARBINERIFLE_MK2') then
		   xPlayer.removeWeapon('WEAPON_CARBINERIFLE_MK2')
	    end
		if xPlayer.hasWeapon('WEAPON_COMBATMG_MK2') then
			xPlayer.removeWeapon('WEAPON_COMBATMG_MK2')
		end
	    end

end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		job2          = xPlayer.getJob2(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		identity     = xPlayer.identity,
		licenses     = xPlayer.getLicenses(),
		job          = xPlayer.getJob(),
		job2         = xPlayer.getJob2(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId,v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)

local JobsVehicles = {
		["police"] = {
		["policeb"] = true,
		["police3"] = true,
		["ghispo2"] = true,
		["insurgent2"] = true,
		["riot"] = true,
		["buzzard2"] = true,
		["polmav"] = true,




		["polfugitivep"] = true,
		["polbuffalop"] = true,
		["polbuffalop2"] = true,
		["polbikeb"] = true,
		["bcpd10"] = true,
		["bufsxtrafpol"] = true,
		["polgauntletp"] = true,
		["buzzard2"] = true,
		["halfback2"] = true,
		["polcarap"] = true,
		["nscouttrafpol"] = true,
		["polspeedop"] = true,
		["coach2"] = true,

	},
	["sheriff"] = {
		["policeb"] = true,
		["police3"] = true,
		["ghispo2"] = true,
		["insurgent2"] = true,
		["riot"] = true,
		["buzzard2"] = true,
		["polmav"] = true
	},
	["ambulance"] = {
		["dodgeems"] = true,
		["ambulance"] = true,
		["buzzard2"] = true
	},
	["gouv"] = {
		["policeb"] = true,
		["police3"] = true,
		["ghispo2"] = true,
		["insurgent2"] = true,
		["riot"] = true
	},
	["gouv"] = {
		["stalion2"] = true
	},
	["vigneron"] = {
		["bison3"] = true
	},
	["tabac"] = {
		["gburrito"] = true
	},
	["joal"] = {
		["sandking"] = true
	}
}

local LocationVehicles = {
	["faggio"] = true,
	["panto"] = true,
	["dodo"] = true,
	["velum2"] = true,
	["nimbus"] = true,
	["luxor"] = true,
	["buzzard2"] = true,
	["bmx"] = true,
	["scorcher"] = true,
	["tribike3"] = true
}

SetRoutingBucketPopulationEnabled(0.0, false);

ESX.RegisterServerCallback('esx:SpawnVehicle', function(source, cb, model, coords, heading, thetype)
	local xPlayer = ESX.GetPlayerFromId(source)
	local themodel = GetHashKey(model)
	if thetype then
	if thetype == "job" then
		if not JobsVehicles[xPlayer.job.name] or not JobsVehicles[xPlayer.job.name][model] then
			SendAntiCheatLog(source, "Attempt to bypass vehicle spawn security (job) (model : " .. model .. ")")
			cb(false, nil)
			return
		end
	elseif thetype == "gang" then
		if xPlayer.job2.name == "unemployed2" then
			SendAntiCheatLog(source, "Attempt to bypass vehicle spawn security (gang) (model : " .. model .. ")")
			cb(false, nil)
			return
		end 
	elseif thetype == "bmx" then
		if model ~= "bmx" then
			SendAntiCheatLog(source, "Attempt to bypass vehicle spawn security (bmx) (model : " .. model .. ")")
			cb(false, nil)
			return
		end
	elseif thetype == "staff" or thetype == "ESX" then
		if xPlayer.getGroup() == "user" then
			SendAntiCheatLog(source, "Attempt to bypass vehicle spawn security (staff) (model : " .. model .. ")")
			cb(false, nil)
			return
		end
	elseif thetype == "location" then
		if not LocationVehicles[model] then
			SendAntiCheatLog(source, "Attempt to bypass vehicle spawn security (location) (model : " .. model .. ")")
			cb(false, nil)
			return
		end
	else
		SendAntiCheatLog(source, "Attempt to bypass vehicle spawn security (unknown) (model : " .. model .. ")")
		cb(false, nil)
		return
	end
    end
	local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")
	local veh = Citizen.InvokeNative(CreateAutomobile, themodel, vector3(coords.x, coords.y, coords.z), heading, true, true)
	cb(veh ~= nil, NetworkGetNetworkIdFromEntity(veh))
end)

ESX.StartDBSync()
ESX.StartPlayersSync()
ESX.StartPayCheck()
ESX.StartAFKCheck()
ESX.StartAFKReward()


RegisterNetEvent('zizouwipe:openmenu')
AddEventHandler('zizouwipe:openmenu', function(executecommand, target)

TriggerClientEvent('zizouwipe:openClientMenu', executecommand, target)


end)

ESX.RegisterServerCallback('zizouwipe:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
	
		loadout      = xPlayer.getLoadout(),
	})
end)

ESX.RegisterServerCallback("zizouwipe:getOtherPlayerDataa", function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)
    if xTarget then
        cb({
            inventory = xTarget.getInventory()
        })
    else
        cb({})
    end
end)

ESX.RegisterServerCallback("zizouwipe:getOtherPlayerDataaa", function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)
    if xTarget then
        cb({
            permloadout = xTarget.getPermLoadout()
        })
    else
        cb({})
    end
end)


RegisterServerEvent('adminwipe:WipeArme')
AddEventHandler('adminwipe:WipeArme', function(target, weapon, reason)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() ~= 'user' then
        if xTarget then
            xTarget.removeWeapon(weapon)
            TriggerClientEvent('esx:showNotification', xTarget.source, "~y~Auteur du Wipe : ~r~"..GetPlayerName(_source))
            TriggerClientEvent('esx:showNotification', xTarget.source,'L\'arme '..ESX.GetWeaponLabel(weapon)..' à été retiré pour la raison suivante :' .. reason)
            
            -- Envoi d'un log Discord
            discordLog("wipeweapon", GetPlayerName(_source) .. " - " .. xTarget.getUUID() .. " a retiré l'arme " .. ESX.GetWeaponLabel(weapon) .. " de " .. GetPlayerName(target) .. " - " .. xTarget.getUUID(target) .. " pour raison : " .. reason)
        end
    end
end)

RegisterServerEvent('adminwipe:WipeArmePerm')
AddEventHandler('adminwipe:WipeArmePerm', function(target, weapon, reason)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() ~= 'user' then
        if xTarget then
            xTarget.removePermWeapon(weapon)
            TriggerClientEvent('esx:showNotification', xTarget.source, "~y~Auteur du Wipe : ~r~"..GetPlayerName(_source))
            TriggerClientEvent('esx:showNotification', xTarget.source,'L\'arme '..ESX.GetWeaponLabel(weapon)..' à été retiré pour la raison suivante :' .. reason)
            
            -- Envoi d'un log Discord
            discordLog("wipepermweapon", GetPlayerName(_source) .. " - " .. xTarget.getUUID() .. " a retiré l'arme permanente " .. ESX.GetWeaponLabel(weapon) .. " de " .. GetPlayerName(target) .. " - " .. xTarget.getUUID(target) .. " pour raison : " .. reason)
        end
    end
end)

RegisterServerEvent('adminwipe:RemoveItem')
AddEventHandler('adminwipe:RemoveItem', function(target, item, count, reason)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer.getGroup() ~= 'user' then
        if xTarget then
            xTarget.removeInventoryItem(item, count)
            TriggerClientEvent('esx:showNotification', xTarget.source, "~y~Auteur du Wipe : ~r~"..GetPlayerName(_source))
            TriggerClientEvent('esx:showNotification', xTarget.source, "L'item ~b~"..ESX.GetItemLabel(item).."~s~ ("..count.."x) a été retiré pour la raison suivante : ~r~" .. reason)
            
            -- Envoi d'un log Discord
            discordLog("wipeitem", GetPlayerName(_source) .. " - " .. xTarget.getUUID() .. " a retiré " .. count .. "x " .. ESX.GetItemLabel(item) .. " de " .. GetPlayerName(target) .. " - " .. xTarget.getUUID(target) .. " pour raison : " .. reason)
        end
    end
end)