local OwnedProperties, Blips, CurrentActionData = {}, {}, {}
local CurrentProperty, CurrentPropertyOwner, LastProperty, LastPart, CurrentAction, CurrentActionMsg
local firstSpawn, hasChest, hasAlreadyEnteredMarker, inProperty = true, false, false, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('property:getProperties', function(properties)
		PropertyConfig.Properties = properties
		CreateBlips()
	end)

	ESX.TriggerServerCallback('property:getOwnedProperties', function(result)
		for k,v in ipairs(result) do
			SetPropertyOwned(v.name, true, v.rented)
		end
	end)
end)

-- only used when script is restarting mid-session
RegisterNetEvent('property:sendProperties')
AddEventHandler('property:sendProperties', function(properties)
	PropertyConfig.Properties = properties
	CreateBlips()

	ESX.TriggerServerCallback('property:getOwnedProperties', function(result)
		for k,v in ipairs(result) do
			SetPropertyOwned(v.name, true, v.rented)
		end
	end)
end)

function DrawSub(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end

function CreateBlips()
	for i=1, #PropertyConfig.Properties, 1 do
		local property = PropertyConfig.Properties[i]

		if property.entering then
			Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

			SetBlipSprite (Blips[property.name], 374)
			SetBlipDisplay(Blips[property.name], 4)
			SetBlipScale  (Blips[property.name], 0.5)
			SetBlipAsShortRange(Blips[property.name], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName("propriété libre")
			EndTextCommandSetBlipName(Blips[property.name])
		end
	end
end

function PropertyIsOwned(property)
	return OwnedProperties[property.name] ~= nil
end

function GetProperties()
	return PropertyConfig.Properties
end

function GetProperty(name)
	for i=1, #PropertyConfig.Properties, 1 do
		if PropertyConfig.Properties[i].name == name then
			return PropertyConfig.Properties[i]
		end
	end
end

function EnterProperty(name, owner)
	local property       = GetProperty(name)
	CurrentProperty      = property
	CurrentPropertyOwner = owner
	inProperty = true

	for i=1, #PropertyConfig.Properties, 1 do
		if PropertyConfig.Properties[i].name ~= name then
			PropertyConfig.Properties[i].disabled = true
		end
	end

	TriggerServerEvent('property:saveLastProperty', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		for i=1, #property.ipls, 1 do
			RequestIpl(property.ipls[i])

			while not IsIplActive(property.ipls[i]) do
				Citizen.Wait(0)
			end
		end

		SetEntityCoords(ESX.PlayerData.cache.playerped, property.inside.x, property.inside.y, property.inside.z)
		DoScreenFadeIn(800)
		DrawSub(property.label, 5000)
	end)

end

RegisterCommand('debugappart', function()
	TriggerEvent('instance:leave')
end)

function ExitProperty(name)
	local property  = GetProperty(name)
	local outside   = nil
	CurrentProperty = nil
	inProperty = false
	outside = property.outside

	TriggerServerEvent('property:deleteLastProperty')

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		SetEntityCoords(ESX.PlayerData.cache.playerped, outside.x, outside.y, outside.z)

		for i=1, #property.ipls, 1 do
			RemoveIpl(property.ipls[i])
		end

		for i=1, #PropertyConfig.Properties, 1 do
			PropertyConfig.Properties[i].disabled = false
		end

		DoScreenFadeIn(800)
	end)
end

function SetPropertyOwned(name, owned, rented)
	local property     = GetProperty(name)
	local entering     = nil
	local enteringName = nil

	if property then

	entering     = property.entering
	enteringName = property.name

	if owned then
		OwnedProperties[name] = rented
		RemoveBlip(Blips[enteringName])

		Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
		SetBlipSprite(Blips[enteringName], 40)
		SetBlipAsShortRange(Blips[enteringName], true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("propriété")
		EndTextCommandSetBlipName(Blips[enteringName])
	else
		OwnedProperties[name] = nil
		local found = false

		if not found then
			RemoveBlip(Blips[enteringName])

			Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
			SetBlipSprite(Blips[enteringName], 374)
			SetBlipAsShortRange(Blips[enteringName], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName("propriété libre")
			EndTextCommandSetBlipName(Blips[property.name])
		end
	end
    end
end

function OpenAppartMenu(property)
	PropertyMenu = { 
		  Base = { Title = "Property", HeaderColor = {130, 109, 68} },
		  Data = { currentMenu = "property" },
	Events = { 
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result) 
			if btn.action == 'enter' then
				TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier}) 
				inProperty = true
			elseif btn.action == 'visit' then
				TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
				inProperty = true
			end       
		end    
	},      
	Menu = {
		["property"] = {
		    b = {}   
		}    
	}  
}   
    if PropertyIsOwned(property) then
		table.insert(PropertyMenu.Menu["property"].b, {name = 'Entrer', action = 'enter'})
	else 
		table.insert(PropertyMenu.Menu["property"].b, {name = 'Visiter', action = 'visit'})
	end
CreateMenu(PropertyMenu)   
end

function OpenRoomMenu(property, owner)

	RoomMenu = { 
		Base = { Title = "Property", HeaderColor = {130, 109, 68} },
		Data = { currentMenu = "property" },
    Events = { 
	  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result) 
		  if btn.action == 'invite' then
			RoomMenu.Menu["players"].b = {}
			local playersInArea = ESX.Game.GetPlayersInArea(entering, 10.0)
			for i=1, #playersInArea, 1 do
				if playersInArea[i] ~= PlayerId() then
					table.insert(RoomMenu.Menu["players"].b, {name = GetPlayerName(playersInArea[i]), action = 'inviter', player = playersInArea[i]})
				end
			end

			OpenMenu('players')
		  elseif btn.action == 'inviter' then
			TriggerEvent('instance:invite', 'property', GetPlayerServerId(btn.player), {property = property.name, owner = owner})
			ESX.ShowNotification('Vous avez invité ~r~' .. GetPlayerName(btn.player) .. "~s~")
		  elseif btn.action == 'dressing' then
			OpenMenu("garde robe")
		  elseif btn.action == 'coffre' then
			OpenMenu("tiroir")
			--ESX.ShowNotification("Les Coffres sont désactivés temporairement !")
		  elseif btn.action == 'tenues' then
			ESX.TriggerServerCallback('property:getPlayerDressing', function(dressing)
				RoomMenu.Menu["vetements"].b = {}

				for i=1, #dressing, 1 do
					table.insert(RoomMenu.Menu["vetements"].b, {
						name = dressing[i],
						action = 'habiller',
						tenueid = i
					})
				end
				OpenMenu('vetements')
			end)
		  elseif btn.action == 'habiller' then
			TriggerEvent('getSkin', function(skin)
			ESX.TriggerServerCallback('property:getPlayerOutfit', function(clothes)
				TriggerEvent('loadClothes', skin, clothes)
				TriggerEvent('skin:setLastSkin', skin)

				TriggerEvent('getSkin', function(skin)
					TriggerServerEvent('skin:save', skin)
				end)
			end, btn.tenueid)
	    	end)
		   elseif btn.action == 'deletetenues' then
			ESX.TriggerServerCallback('property:getPlayerDressing', function(dressing)
				RoomMenu.Menu["vetements"].b = {}

				for i=1, #dressing, 1 do
					table.insert(RoomMenu.Menu["vetements"].b, {
						name = dressing[i],
						action = 'delete',
						tenueid = i
					})
				end
				OpenMenu('vetements')
			end)
		elseif btn.action == 'delete' then
			TriggerServerEvent('property:removeOutfit', btn.tenueid)
			ESX.ShowNotification('Tenue Supprimée !')
		elseif btn.action == 'prendreobjectmenu' then
			ESX.TriggerServerCallback('property:getPropertyInventory', function(inventory)

			RoomMenu.Menu["inventory"].b = {}

		if inventory.blackMoney > 0 then
			table.insert(RoomMenu.Menu["inventory"].b, {
				name = "argent sale: <span style=\"color:red;\">" .. ESX.Math.GroupDigits(inventory.blackMoney) .. "</span>",
				type = 'item_account',
				value = 'black_money',
				action = 'retirer'
			})
		end

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(RoomMenu.Menu["inventory"].b, {
					name = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name,
					action = 'retirer'
				})
			end
		end

		for i=1, #inventory.weapons, 1 do
			local weapon = inventory.weapons[i]

			table.insert(RoomMenu.Menu["inventory"].b, {
				name = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']',
				type  = 'item_weapon',
				value = weapon.name,
				index = i,
				action = 'retirer'
			})
		end
		OpenMenu("inventory")
	end, owner)
		elseif btn.action == 'deposerobjectmenu' then
			ESX.TriggerServerCallback('property:getPlayerInventory', function(inventory)

				RoomMenu.Menu["inventory"].b = {}
	
			if inventory.blackMoney > 0 then
				table.insert(RoomMenu.Menu["inventory"].b, {
					name = "argent sale: <span style=\"color:red;\">" .. ESX.Math.GroupDigits(inventory.blackMoney) .. "</span>",
					type = 'item_account',
					value = 'black_money',
					action = 'deposer'
				})
			end
	
			for i=1, #inventory.items, 1 do
				local item = inventory.items[i]
	
				if item.count > 0 then
					table.insert(RoomMenu.Menu["inventory"].b, {
						name = item.label .. ' x' .. item.count,
						type = 'item_standard',
						value = item.name,
						action = 'deposer'
					})
				end
			end
	
			for i=1, #inventory.weapons, 1 do
				local weapon = inventory.weapons[i]
	
				table.insert(RoomMenu.Menu["inventory"].b, {
					name = ESX.GetWeaponLabel(weapon.name) or "UNKNOW WEAPON" .. ' [' .. weapon.ammo or 0 .. ']',
					type  = 'item_weapon',
					value = weapon.name,
					index = i,
					action = 'deposer'
				})
			end
			OpenMenu("inventory")
		end, owner)
	elseif btn.action == 'deposer' then
		if btn.type == 'item_weapon' then
			CloseMenu()
			TriggerServerEvent('property:putItem', owner, btn.type, btn.value, 0)
			CreateMenu(RoomMenu)
		else
			local amount = KeyboardInput("PROPERTY_DEPOSIT", "Combien deposer ?", "", 150)
			if tonumber(amount) then
				CloseMenu()
				TriggerServerEvent('property:putItem', owner, btn.type, btn.value, tonumber(amount))
				CreateMenu(RoomMenu)
			end		
		end
	elseif btn.action == 'retirer' then
		if btn.type == 'item_weapon' then
			CloseMenu()
			TriggerServerEvent('property:getItem', owner, btn.type, btn.value, 0)
			CreateMenu(RoomMenu)
		else
			local amount = KeyboardInput("PROPERTY_DEPOSIT", "Combien prendre ?", "", 150)
			if tonumber(amount) then
				CloseMenu()
				TriggerServerEvent('property:getItem', owner, btn.type, btn.value, tonumber(amount))
				CreateMenu(RoomMenu)
			end		
		end
		  end       
	  end    
  },      
  Menu = {
	  ["property"] = {
		  b = {
			{name = 'Inviter un joueur', action = 'invite'},
			{name = 'Garde Robe', action = 'dressing'},
			{name = 'Tiroir', action = 'coffre'}
		  }   
	  },
	  ["players"] = {
		b = {
		  
		}   
	  },
	  ["garde robe"] = {
		b = {
			{name = 'Tenues', action = 'tenues'},
			{name = 'Supprimer des tenues', action = 'deletetenues'}
		}   
	  },
	  ["vetements"] = {
		b = {
			
		}   
	  },
	  ["tiroir"] = {
		b = {
			{name = 'Prendre un objet', action = 'prendreobjectmenu'},
			{name = 'Déposer un objet', action = 'deposerobjectmenu'}
		}   
	  },
	  ["inventory"] = {
		b = {
			
		}   
	  },

  }  
}   
CreateMenu(RoomMenu)   
end

AddEventHandler('instance:loaded', function()
	TriggerEvent('instance:registerType', 'property', function(instance)
		EnterProperty(instance.data.property, instance.data.owner)
	end, function(instance)
		ExitProperty(instance.data.property)
	end)
end)

AddEventHandler('esx:onPlayerSpawn', function()
	if firstSpawn then
		Citizen.CreateThread(function()
			while not ESX.IsPlayerLoaded() do
				Citizen.Wait(0)
			end

			ESX.TriggerServerCallback('property:getLastProperty', function(propertyName)
				if propertyName then
					if propertyName ~= '' then
						local property = GetProperty(propertyName)

						for i=1, #property.ipls, 1 do
							RequestIpl(property.ipls[i])

							while not IsIplActive(property.ipls[i]) do
								Citizen.Wait(0)
							end
						end

						TriggerEvent('instance:create', 'property', {property = propertyName, owner = ESX.GetPlayerData().identifier})
					end
				end
			end)
		end)

		firstSpawn = false
	end
end)

AddEventHandler('property:getProperties', function(cb)
	cb(GetProperties())
end)

AddEventHandler('property:getProperty', function(name, cb)
	cb(GetProperty(name))
end)

RegisterNetEvent('property:setPropertyOwned')
AddEventHandler('property:setPropertyOwned', function(name, owned, rented)
	SetPropertyOwned(name, owned, rented)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'property' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
	if instance.type == 'property' then
		local property = GetProperty(instance.data.property)
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned  = false

		if PropertyIsOwned(property) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			hasChest = true
		else
			hasChest = false
		end
	end
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(instance, player)
	if player == instance.host then
		TriggerEvent('instance:leave')
	end
end)

AddEventHandler('property:hasEnteredMarker', function(name, part)
	local property = GetProperty(name)

	if part == 'entering' then
		CurrentAction     = 'property_menu'
		CurrentActionMsg  = "appuyez sur ~INPUT_CONTEXT~ pour accéder au menu"
		CurrentActionData = {property = property}
	elseif part == 'exit' then
		CurrentAction     = 'room_exit'
		CurrentActionMsg  = "appuyez sur ~INPUT_CONTEXT~ pour accéder sortir"
		CurrentActionData = {propertyName = name}
	elseif part == 'roomMenu' then
		CurrentAction     = 'room_menu'
		CurrentActionMsg  = "appuyez sur ~INPUT_CONTEXT~ pour accéder au menu"
		CurrentActionData = {property = property, owner = CurrentPropertyOwner}
	end
end)

AddEventHandler('property:hasExitedMarker', function(name, part)
	
	CloseMenu()
	CurrentAction = nil
end)

-- Enter / Exit marker events & Draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		local isInMarker, letSleep = false, true
		local currentProperty, currentPart

		for i=1, #PropertyConfig.Properties, 1 do
			local property = PropertyConfig.Properties[i]

			-- Entering
			if property.entering and not property.disabled then
				local distance = GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, property.entering.x, property.entering.y, property.entering.z, true)

				if distance < PropertyConfig.DrawDistance then
					DrawMarker(PropertyConfig.MarkerType, property.entering.x, property.entering.y, property.entering.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PropertyConfig.MarkerSize.x, PropertyConfig.MarkerSize.y, PropertyConfig.MarkerSize.z, PropertyConfig.MarkerColor.r, PropertyConfig.MarkerColor.g, PropertyConfig.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < ((PropertyConfig.MarkerSize.x + PropertyConfig.MarkerSize.y) / 2) then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'entering'
				end
			end

			-- Exit
			if property.exit and not property.disabled and inProperty then
				local distance = GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, property.exit.x, property.exit.y, property.exit.z, true)

				if distance < PropertyConfig.DrawDistance then
					DrawMarker(PropertyConfig.MarkerType, property.exit.x, property.exit.y, property.exit.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PropertyConfig.MarkerSize.x, PropertyConfig.MarkerSize.y, PropertyConfig.MarkerSize.z, PropertyConfig.MarkerColor.r, PropertyConfig.MarkerColor.g, PropertyConfig.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < ((PropertyConfig.MarkerSize.x + PropertyConfig.MarkerSize.y) / 2) then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'exit'
				end
			end

			-- Room menu
			if property.roomMenu and hasChest and not property.disabled then
				local distance = GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, true)

				if distance < PropertyConfig.DrawDistance then
					DrawMarker(PropertyConfig.MarkerType, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PropertyConfig.MarkerSize.x, PropertyConfig.MarkerSize.y, PropertyConfig.MarkerSize.z, PropertyConfig.RoomMenuMarkerColor.r, PropertyConfig.RoomMenuMarkerColor.g, PropertyConfig.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < PropertyConfig.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'roomMenu'
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker or (isInMarker and (LastProperty ~= currentProperty or LastPart ~= currentPart) ) then
			hasAlreadyEnteredMarker = true
			LastProperty            = currentProperty
			LastPart                = currentPart

			TriggerEvent('property:hasEnteredMarker', currentProperty, currentPart)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('property:hasExitedMarker', LastProperty, LastPart)
		end

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'property_menu' then
					OpenAppartMenu(CurrentActionData.property)
				elseif CurrentAction == 'room_menu' then
					OpenRoomMenu(CurrentActionData.property, CurrentActionData.owner)
				elseif CurrentAction == 'room_exit' then
					TriggerEvent('instance:leave')
					inProperty = false
				end

				CurrentAction = nil
			end
		end
		if letSleep then
			Citizen.Wait(2500)
		end
	end
end)
