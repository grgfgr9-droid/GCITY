local ItemsData = {
	["bread"] = {price = 5, type = "item"},
	["water"] = {price = 5, type = "item"},
	["phone"] = {price = 1500, type = "item"},



	["parapluie"] = {price = 500, type = "item"},
    ["marteaux"] = {price = 500, type = "item"},
    ["piedbiche"] = {price = 700, type = "item"},
    ["rateau"] = {price = 500, type = "item"},
    ["lampebureau"] = {price = 600, type = "item"},
    ["grainefleur"] = {price = 1500, type = "item"},
    ["potfleur"] = {price = 400, type = "item"},
    ["crochetage"] = {price = 700, type = "item"},
    ["caisseoutil"] = {price = 1500, type = "item"},
    ["fil"] = {price = 400, type = "item"},
    ["boulon"] = {price = 1500, type = "item"},

	["WEAPON_SNSPISTOL"] = {price = 300000, type = "legalweashop"},
	["WEAPON_VINTAGEPISTOL"] = {price = 400000, type = "legalweashop"},
	["WEAPON_PISTOL50"] = {price = 600000, type = "legalweashop"},
	["WEAPON_BAT"] = {price = 20000, type = "legalweashop"},
	--["WEAPON_SMG"] = {price = 1000000, type = "legalweashop"},
	["WEAPON_COMBATPDW"] = {price = 2500000, type = "legalweashop", vip = true},
	------
	["WEAPON_SWITCHBLADE"] = {price = 100000, type = "illegalweashop"},
	["WEAPON_MACHETE"] = {price = 20000, type = "illegalweashop"},
	["WEAPON_APPISTOL"] = {price = 1200000, type = "illegalweashop"},
	["WEAPON_MINISMG"] = {price = 1800000, type = "illegalweashop"},
	["WEAPON_COMPACTRIFLE"] = {price = 4000000, type = "illegalweashop"},
	["WEAPON_ASSAULTRIFLE"] = {price = 5500000, type = "illegalweashop"},
	["WEAPON_SAWNOFFSHOTGUN"] = {price = 2500000, type = "illegalweashop"},
	["WEAPON_GUSENBERG"] = {price = 4500000, type = "illegalweashop"},
	["WEAPON_MG"] = {price = 6000000, type = "illegalweashop"},
	["WEAPON_ASSAULTRIFLE_MK2"] = {price = 4000000, type = "illegalweashop", vip = true},
	["WEAPON_CARBINERIFLE_MK2"] = {price = 3000000, type = "illegalweashop", vip = true},
	-------
	["clip"] = {price = 1000, type = "item"},
	["silencieux"] = {price = 5000, type = "item"},
	["yusuf"] = {price = 7500, type = "item"},
	["grip"] = {price = 7500, type = "item"},
	["flashlight"] = {price = 10000, type = "item"}
}


ESX.RegisterServerCallback('shops:checkMoney', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= 1000 then
		xPlayer.removeMoney(1000)
     	TriggerClientEvent('esx:showNotification', _source, 'vous avez payé ' .. '$' .. 1000)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('shops:buyItem')
AddEventHandler('shops:buyItem', function(item, type, amount)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
	local itemdata = ItemsData[item]
	local price = itemdata.price
	if type == "item" and itemdata.type == "item" then
	price = itemdata.price * amount
    if xPlayer.getMoney() >= price then
        if not xPlayer.canCarryItem(item, amount) then 
            TriggerClientEvent('esx:showNotification', _source, 'Votre inventaire est plein')
            return
        end
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem(item, amount)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez payé ' .. price .. '$') 
    else
    TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez d\'argent pour acheter cet article') 
	end
    elseif type == "weapon" then
		if xPlayer.hasWeapon(item) then TriggerClientEvent('esx:showNotification', _source, 'Vous possédez déjà cette arme !') return end
		if itemdata.vip and xPlayer.getRank() == 'default' then TriggerClientEvent('esx:showNotification', _source, 'Vous devez avoir le grade VIP ou Diamond pour acheter ceci') return end
		if itemdata.type == "legalweashop" then
		    if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
			xPlayer.addWeapon(item, 42)
			TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheté 1x ' .. ESX.GetWeaponLabel(item))
		    else
			TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent')
		    end
		elseif itemdata.type == "illegalweashop" then
		local account = xPlayer.getAccount('black_money')
		if account.money >= price then
			xPlayer.removeAccountMoney('black_money', price)
			xPlayer.addWeapon(item, 42)
			TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheté 1x ' .. ESX.GetWeaponLabel(item))
		else
			TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent')
		end
		end
	end
end)

ESX.RegisterServerCallback('shops:CheckWeaponLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = xPlayer.getLicense('weapon')

	if license then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('shops:BuyWeaponLicense')
AddEventHandler('shops:BuyWeaponLicense', function ()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 50000 then
		xPlayer.removeMoney(50000)

		xPlayer.addLicense('weapon')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent')
	end
end)


RegisterServerEvent('shops:saveOutfit')
AddEventHandler('shops:saveOutfit', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)
	local store = GetDataStore('property', xPlayer.identifier)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
end)

RegisterServerEvent('shops:deleteOutfit')
AddEventHandler('shops:deleteOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)
	local store = GetDataStore('property', xPlayer.identifier)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		label = label
		
		table.remove(dressing, label)

		store.set('dressing', dressing)
end)

ESX.RegisterServerCallback('shops:checkPropertyDataStore', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local foundStore = false
	local store = GetDataStore('property', xPlayer.identifier)
	foundStore = store ~= nil

	cb(foundStore)
end)

ESX.RegisterServerCallback('shops:getPlayerDressing', function(source, cb)
  local xPlayer  = ESX.GetPlayerFromId(source)
  local store = GetDataStore('property', xPlayer.identifier)
  if not store then return end
    local count    = store.count('dressing')
    local labels   = {}
    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      table.insert(labels, entry.label)
    end

    cb(labels)
end)

ESX.RegisterServerCallback('shops:getPlayerOutfit', function(source, cb, num)
  local xPlayer  = ESX.GetPlayerFromId(source)
  local store = GetDataStore('property', xPlayer.identifier)
  local outfit = store.get('dressing', num)
  cb(outfit.skin)
end)
