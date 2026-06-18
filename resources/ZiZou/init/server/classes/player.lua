function CreateExtendedPlayer(playerId, identifier, ip, group, accounts, inventory, weight, maxWeight, job, job2, loadout, name, coords, uuid, rank, storepoints, expiration, isdead, identity, licenses, time, status, permloadout, skin, jail)
	local self = {}

	self.accounts = accounts
	self.ip = ip
	self.coords = coords
	self.group = group
	self.identifier = identifier
	self.inventory = inventory
	self.job = job
	self.job2 = job2
	self.loadout = loadout
	self.name = name
	self.playerId = playerId
	self.source = playerId
	self.variables = {}
	self.weight = weight
	self.maxWeight = maxWeight
	self.uuid = uuid
	self.rank = rank
	self.storepoints = storepoints
	self.expiration = expiration
	self.IsDead = isdead
	self.identity = identity
	self.time = time
	self.status = status
	self.permloadout = permloadout
	self.skin = skin
	self.licenses = licenses
	self.jail = jail
	self.afk = {enable = false, time = 0}
	self.PassJoin = false

	ExecuteCommand(('add_principal identifier.license:%s group.%s'):format(self.identifier, self.group))

	self.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	self.getIP = function()
		return self.ip
	end

	self.setDead = function(dead)
		self.IsDead = dead
		ESX.Trace(self.IsDead)
		self.triggerEvent('esx:updateDeath', self.IsDead)
	end

	self.setPassJoin = function(value)
		self.PassJoin = value
	end

	self.setCoords = function(coords)
		self.updateCoords(coords)
		self.triggerEvent('esx:teleport', coords)
	end

	self.setJailTime = function(time)
		self.jail.time = time
		self.triggerEvent('esx:updateJail', self.jail)
	end

	self.setJailStation = function(station)
		self.jail.station = station
		self.triggerEvent('esx:updateJail', self.jail)
	end

	self.updateCoords = function(coords)
		self.coords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1), heading = ESX.Math.Round(coords.heading or 0.0, 1)}
	end

	self.setAFK = function(isafk, time)
		self.afk.enable = isafk
		self.afk.time   = time
	end

	self.getCoords = function(vector)
		if vector then
			return vector3(self.coords.x, self.coords.y, self.coords.z)
		else
			return self.coords
		end
	end

	self.getFirstName = function()
		return self.identity.firstname
	end

	self.getLastName = function()
		return self.identity.lastname
	end

	self.getDOB = function()
		return self.identity.dob
	end

	self.getSex = function()
		return self.identity.sex
	end

	self.getHeight = function()
		return self.identity.height
	end

	self.setFirstName = function(firstname)
		self.identity.firstname = firstname
		self.triggerEvent('esx:updateIdentity', self.identity)
	end

	self.setLastName = function(lastname)
		self.identity.lastname = lastname
		self.triggerEvent('esx:updateIdentity', self.identity)
	end

	self.setDOB = function(dob)
		self.identity.dob = dob
		self.triggerEvent('esx:updateIdentity', self.identity)
	end

	self.setSex = function(sex)
		self.identity.sex = sex
		self.triggerEvent('esx:updateIdentity', self.identity)
	end

	self.setHeight = function(height)
		self.identity.height = height
		self.triggerEvent('esx:updateIdentity', self.identity)
	end

	self.setSkin = function(skin)
		self.skin = skin
		self.triggerEvent('esx:updateSkin', self.skin)
	end

	self.getSkin = function()
		return self.skin
	end

	self.kick = function(reason)
		DropPlayer(self.source, reason)
	end

	self.setMoney = function(money)
		money = ESX.Math.Round(money)
		self.setAccountMoney('money', money)
	end

	self.getMoney = function()
		return self.getAccount('money').money
	end

	self.addMoney = function(money)
		money = ESX.Math.Round(money)
		self.addAccountMoney('money', money)
	end

	self.removeMoney = function(money)
		money = ESX.Math.Round(money)
		self.removeAccountMoney('money', money)
	end

	self.getLicenses = function()
		return self.licenses
	end

	self.getLicense = function(key)
		return self.licenses[key]
	end

	self.hasLicense = function(key)
		if self.licenses[key] then
			return true
		end
		return false
	end

	self.addLicense = function(key)
		local thelicense = Config.Licenses[key]
		if thelicense then
		self.licenses[key] = thelicense
		self.triggerEvent('esx:updateLicenses', self.licenses)
		end
	end

	self.removeLicense = function(key)
		self.licenses[key] = nil
		self.triggerEvent('esx:updateLicenses', self.licenses)
	end

	self.getIdentifier = function()
		return self.identifier
	end

	self.getUUID = function()
		return self.uuid
	end

	self.setEat = function(eat)
		self.status.eat = tonumber(eat)
	end

	self.setDrink = function(drink)
		self.status.drink = tonumber(drink)
	end

	self.getStatus = function()
		return self.status
	end

	self.getTime = function()
		return self.time
	end

	self.setTime = function(value)
		self.time = value
	end

	self.getRank = function()
		return self.rank
	end

	self.getExpiration = function()
		return self.expiration
	end

	self.setRank = function(newrank, rankexpiration)
		self.rank = newrank
		self.expiration = rankexpiration
		if newrank == 'default' then
			TriggerClientEvent('esx:announce', self.source, '~y~Boutique', 'Votre Grade a expiré, Rendez vous la boutique pour renouveler votre grade', 2)
		else
			TriggerClientEvent('esx:announce', self.source, '~y~Boutique', 'Votre Grade : ~b~' .. string.upper(self.rank) .. '~w~ Merci pour votre achat !', 2)
		end
		self.triggerEvent('esx:setRank', self.rank, self.expiration)
	end

	self.getStorePoints = function()
		return self.storepoints
	end

	self.getPlayerID = function()
		return self.playerId
	end

	self.addStorePoints = function(newstorepoints)
		self.storepoints = math.floor(self.storepoints + newstorepoints)
		self.triggerEvent('esx:announce', '~y~Boutique', 'Vous avez reçu ~b~' .. string.upper(newstorepoints) .. " " .. ZiZouConfig.StorePointsName .. '~w~, Merci pour votre achat !', 5)
		self.triggerEvent('esx:setStorePoints', self.storepoints)
	end

	self.addvehicle = function(model)
		--TriggerClientEvent('esx:SpawnVehicle', playerId, identifier, model)
	end

	self.setGroup = function(newGroup)
		ExecuteCommand(('remove_principal identifier.license:%s group.%s'):format(self.identifier, self.group))
		self.group = newGroup
		ExecuteCommand(('add_principal identifier.license:%s group.%s'):format(self.identifier, self.group))
	end

	self.getGroup = function()
		return self.group
	end

	self.set = function(k, v)
		self.variables[k] = v
	end

	self.get = function(k)
		return self.variables[k]
	end

	self.getAccounts = function(minimal)
		if minimal then
			local minimalAccounts = {}

			for k,v in ipairs(self.accounts) do
				minimalAccounts[v.name] = v.money
			end

			return minimalAccounts
		else
			return self.accounts
		end
	end

	self.getAccount = function(account)
		for k,v in ipairs(self.accounts) do
			if v.name == account then
				return v
			end
		end
	end

	self.getInventory = function(minimal)
		if minimal then
			local minimalInventory = {}

			for k,v in ipairs(self.inventory) do
				if v.count > 0 then
					minimalInventory[v.name] = v.count
				end
			end

			return minimalInventory
		else
			return self.inventory
		end
	end

	self.getJob = function()
		return self.job
	end

	self.getJob2 = function()
		return self.job2
	end

	self.getLoadout = function()
		return self.loadout
	end

	self.getPermLoadout = function()
		return self.permloadout
	end

	self.getName = function()
		return self.name
	end

	self.setName = function(newName)
		self.name = newName
	end

	self.setAccountMoney = function(accountName, money)
		if money >= 0 then
			local account = self.getAccount(accountName)

			if account then
				local prevMoney = account.money
				local newMoney = ESX.Math.Round(money)
				account.money = newMoney

				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.addAccountMoney = function(accountName, money)
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				local newMoney = account.money + ESX.Math.Round(money)
				account.money = newMoney

				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.removeAccountMoney = function(accountName, money)
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				local newMoney = account.money - ESX.Math.Round(money)
				account.money = newMoney

				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.removeStorePoints = function(storepoints)
		if self.storepoints >= storepoints then
				local newStorePoints = self.storepoints - ESX.Math.Round(storepoints)
				self.storepoints = newStorePoints
		end
	end

	self.getInventoryItem = function(name)
		for k,v in ipairs(self.inventory) do
			if v.name == name then
				return v
			end
		end

		return
	end

	self.hasInventoryItem = function(name)
		for k,v in ipairs(self.inventory) do
			if v.name == name and v.count > 0 then
				return true
			end
		end

		return false
	end

	self.addInventoryItem = function(name, count)
		local item = self.getInventoryItem(name)

		if item then
			count = ESX.Math.Round(count)
			item.count = item.count + count
			self.weight = self.weight + (item.weight * count)

			TriggerEvent('esx:onAddInventoryItem', self.source, item.name, item.count)
			self.triggerEvent('esx:addInventoryItem', item.name, item.count)
		end
	end

	self.removeInventoryItem = function(name, count)
		local item = self.getInventoryItem(name)

		if item then
			count = ESX.Math.Round(count)
			local newCount = item.count - count

			if newCount >= 0 then
				item.count = newCount
				self.weight = self.weight - (item.weight * count)

				TriggerEvent('esx:onRemoveInventoryItem', self.source, item.name, item.count)
				self.triggerEvent('esx:removeInventoryItem', item.name, item.count)
			end
		end
	end

	self.setInventoryItem = function(name, count)
		local item = self.getInventoryItem(name)

		if item and count >= 0 then
			count = ESX.Math.Round(count)

			if count > item.count then
				self.addInventoryItem(item.name, count - item.count)
			else
				self.removeInventoryItem(item.name, item.count - count)
			end
		end
	end


	self.getWeight = function()
		return self.weight
	end

	self.getMaxWeight = function()
		return self.maxWeight
	end

	self.canCarryItem = function(name, count)
		local currentWeight, itemWeight = self.weight, ESX.Items[name].weight
		local newWeight = currentWeight + (itemWeight * count)

		return newWeight <= self.maxWeight
	end

	self.canSwapItem = function(firstItem, firstItemCount, testItem, testItemCount)
		local firstItemObject = self.getInventoryItem(firstItem)
		local testItemObject = self.getInventoryItem(testItem)

		if firstItemObject.count >= firstItemCount then
			local weightWithoutFirstItem = ESX.Math.Round(self.weight - (firstItemObject.weight * firstItemCount))
			local weightWithTestItem = ESX.Math.Round(weightWithoutFirstItem + (testItemObject.weight * testItemCount))

			return weightWithTestItem <= self.maxWeight
		end

		return false
	end

	self.setMaxWeight = function(newWeight)
		self.maxWeight = newWeight
		self.triggerEvent('esx:setMaxWeight', self.maxWeight)
	end

	self.setJob = function(job, grade)
		grade = tostring(grade)
		local lastJob = json.decode(json.encode(self.job))

		if ESX.DoesJobExist(job, grade) then
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

			self.job.id    = jobObject.id
			self.job.name  = jobObject.name
			self.job.label = jobObject.label

			self.job.grade        = tonumber(grade)
			self.job.grade_name   = gradeObject.name
			self.job.grade_label  = gradeObject.label
			self.job.grade_salary = gradeObject.salary

			if gradeObject.skin_male then
				self.job.skin_male = json.decode(gradeObject.skin_male)
			else
				self.job.skin_male = {}
			end

			if gradeObject.skin_female then
				self.job.skin_female = json.decode(gradeObject.skin_female)
			else
				self.job.skin_female = {}
			end

			TriggerEvent('esx:setJob', self.source, self.job, lastJob)
			self.triggerEvent('esx:setJob', self.job)
		else
			print(('[framework] [^3WARNING^7] Ignoring invalid .setJob() usage for "%s"'):format(self.identifier))
		end
	end

	self.setJob2 = function(job, grade)
		grade = tostring(grade)
		local lastJob = json.decode(json.encode(self.job2))

		if ESX.DoesJobExist(job, grade) then
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

			self.job2.id    = jobObject.id
			self.job2.name  = jobObject.name
			self.job2.label = jobObject.label

			self.job2.grade        = tonumber(grade)
			self.job2.grade_name   = gradeObject.name
			self.job2.grade_label  = gradeObject.label
			self.job2.grade_salary = gradeObject.salary

			if gradeObject.skin_male then
				self.job2.skin_male = json.decode(gradeObject.skin_male)
			else
				self.job2.skin_male = {}
			end

			if gradeObject.skin_female then
				self.job2.skin_female = json.decode(gradeObject.skin_female)
			else
				self.job2.skin_female = {}
			end

			TriggerEvent('esx:setJob2', self.source, self.job2, lastJob)
			self.triggerEvent('esx:setJob2', self.job2)
		else
			print(('[framework] [^3WARNING^7] Ignoring invalid .setJob2() usage for "%s"'):format(self.identifier))
		end
	end

	self.addWeapon = function(weaponName, ammo)
		weaponName = string.upper(weaponName)
		if not self.hasWeapon(weaponName) then
			
			local weaponLabel = ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME"

			table.insert(self.loadout, {
				name = weaponName,
				ammo = ammo,
				label = weaponLabel,
				components = {},
				tintIndex = 0
			})
			
			self.triggerEvent('esx:addWeapon', weaponName, ammo, self.loadout)
			TriggerEvent('esx:checkPlayerWeapons', self.source)
		end
	end

	self.addWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if not self.hasWeaponComponent(weaponName, weaponComponent) then
					table.insert(self.loadout[loadoutNum].components, weaponComponent)
					self.triggerEvent('esx:addWeaponComponent', weaponName, weaponComponent)
				end
			end
		end
	end

	self.addWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			weapon.ammo = weapon.ammo + ammoCount
			self.triggerEvent('esx:setWeaponAmmo', weaponName, weapon.ammo)
		end
	end

	self.updateWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			weapon.ammo = ammoCount
			self.triggerEvent('esx:setWeaponAmmo', weaponName, weapon.ammo)
		end
	end

	self.setWeaponTint = function(weaponName, weaponTintIndex)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local weaponNum, weaponObject = ESX.GetWeapon(weaponName)

			if weaponObject.tints and weaponObject.tints[weaponTintIndex] then
				self.loadout[loadoutNum].tintIndex = weaponTintIndex
				self.triggerEvent('esx:setWeaponTint', weaponName, weaponTintIndex)
				self.triggerEvent('esx:addInventoryItem', weaponObject.tints[weaponTintIndex], false, true)
			end
		end
	end

	self.getWeaponTint = function(weaponName)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			return weapon.tintIndex
		end

		return 0
	end

	self.removeWeapon = function(weaponName)
		local weaponLabel
		weaponName = string.upper(weaponName)
		for k,v in ipairs(self.loadout) do
			if string.upper(v.name) == weaponName then
				self.triggerEvent('esx:removeWeapon', weaponName, self.loadout)
				weaponLabel = v.label

				for k2,v2 in ipairs(v.components) do
					self.removeWeaponComponent(weaponName, v2)
				end

				table.remove(self.loadout, k)
				break
			end
		end
		TriggerEvent('esx:checkPlayerWeapons', self.source)
	end

	self.removeWeapons = function(list) 
		for k, v in ipairs(list) do 
			self.removeWeapon(v)
		end
	end

	self.removeWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if self.hasWeaponComponent(weaponName, weaponComponent) then
					for k,v in ipairs(self.loadout[loadoutNum].components) do
						if v == weaponComponent then
							table.remove(self.loadout[loadoutNum].components, k)
							break
						end
					end

					self.triggerEvent('esx:removeWeaponComponent', weaponName, weaponComponent)
					self.triggerEvent('esx:removeInventoryItem', component.label, false, true)
				end
			end
		end
	end

	self.removeWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			weapon.ammo = weapon.ammo - ammoCount
			self.triggerEvent('esx:setWeaponAmmo', weaponName, weapon.ammo)
		end
	end

	self.hasWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			for k,v in ipairs(weapon.components) do
				if v == weaponComponent then
					return true
				end
			end

			return false
		else
			return false
		end
	end

	self.hasWeapon = function(weaponName)
		for k,v in ipairs(self.loadout) do
			if string.upper(v.name) == string.upper(weaponName) then
				return true
			end
		end

		return false
	end

	self.getWeapon = function(weaponName)
		for k,v in ipairs(self.loadout) do
			if string.upper(v.name) == string.upper(weaponName) then
				return k, v
			end
		end

		return
	end

	-- Perma Loadout

	self.addPermWeapon = function(weaponName, ammo)
		weaponName = string.lower(weaponName)
		if not self.hasPermWeapon(weaponName) then
			local weaponLabel = ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME"

			if not self.hasPermWeapon(weaponName) then

			table.insert(self.permloadout, {
				name = weaponName,
				ammo = ammo,
				label = weaponLabel,
				components = {},
				tintIndex = 0
			})

			self.triggerEvent('esx:addPermWeapon', weaponName, ammo, self.permloadout)
		end
		end
	end

	self.addPermWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getPermWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if not self.hasWeaponComponent(weaponName, weaponComponent) then
					table.insert(self.permloadout[loadoutNum].components, weaponComponent)
					self.triggerEvent('esx:addPermWeaponComponent', weaponName, weaponComponent)
				end
			end
		end
	end

	self.addPermWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getPermWeapon(weaponName)

		if weapon then
			weapon.ammo = weapon.ammo + ammoCount
			self.triggerEvent('esx:setPermWeaponAmmo', weaponName, weapon.ammo)
		end
	end

	self.updatePermWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getPermWeapon(weaponName)

		if weapon then
			if ammoCount < weapon.ammo then
				weapon.ammo = ammoCount
			end
		end
	end

	self.setPermWeaponTint = function(weaponName, weaponTintIndex)
		local loadoutNum, weapon = self.getPermWeapon(weaponName)

		if weapon then
			local weaponNum, weaponObject = ESX.GetWeapon(weaponName)

			if weaponObject.tints and weaponObject.tints[weaponTintIndex] then
				self.permloadout[loadoutNum].tintIndex = weaponTintIndex
				self.triggerEvent('esx:setPermWeaponTint', weaponName, weaponTintIndex)
			end
		end
	end

	self.getPermWeaponTint = function(weaponName)
		local loadoutNum, weapon = self.getPermWeapon(weaponName)

		if weapon then
			return weapon.tintIndex
		end

		return 0
	end

	self.removePermWeapon = function(weaponName)
		local weaponLabel
		weaponName = string.lower(weaponName)
		for k,v in ipairs(self.permloadout) do
			if string.lower(v.name) == string.lower(weaponName) then
				weaponLabel = v.label

				for k2,v2 in ipairs(v.components) do
					self.removeWeaponComponent(weaponName, v2)
				end

				table.remove(self.permloadout, k)
				self.triggerEvent('esx:removePermWeapon', weaponName, self.permloadout)
				break
			end
		end


	end

	self.removePermWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getPermWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if self.hasWeaponComponent(weaponName, weaponComponent) then
					for k,v in ipairs(self.permloadout[loadoutNum].components) do
						if v == weaponComponent then
							table.remove(self.permloadout[loadoutNum].components, k)
							break
						end
					end

					self.triggerEvent('esx:removePermWeaponComponent', weaponName, weaponComponent)
				end
			end
		end
	end

	self.removePermWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getPermWeapon(weaponName)

		if weapon then
			weapon.ammo = weapon.ammo - ammoCount
			self.triggerEvent('esx:setPermWeaponAmmo', weaponName, weapon.ammo)
		end
	end

	self.hasPermWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getPermWeapon(weaponName)

		if weapon then
			for k,v in ipairs(weapon.components) do
				if v == weaponComponent then
					return true
				end
			end

			return false
		else
			return false
		end
	end

	self.hasPermWeapon = function(weaponName)
		for k,v in ipairs(self.permloadout) do
			if string.lower(v.name) == string.lower(weaponName) then
				return true
			end
		end

		return false
	end

	self.getPermWeapon = function(weaponName)
		for k,v in ipairs(self.permloadout) do
			if string.lower(v.name) == string.lower(weaponName) then
				return k, v
			end
		end

		return
	end

	self.showNotification = function(msg, type)
		self.triggerEvent('esx:showNotification', msg, type)
	end

	self.showHelpNotification = function(msg, thisFrame, beep, duration)
		self.triggerEvent('esx:showHelpNotification', msg, thisFrame, beep, duration)
	end

	return self
end
