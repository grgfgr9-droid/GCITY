RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount, type)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('esx:showNotification', _source, "Montant invalide.", "error")
	else
		if type == "player" then
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', amount)
		TriggerClientEvent('esx:showNotification', _source, "Dépot effectué.", "success")
		elseif type == "society" then
			TriggerEvent('addonaccount:getSharedAccount', 'society_' .. xPlayer.job.name, function(account)
				if account then
					xPlayer.removeMoney(amount)
					account.addMoney(amount)
				end
			end)
		end
	end
end)

RegisterServerEvent('bank:refreshSocietyMoney')
AddEventHandler('bank:refreshSocietyMoney', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerEvent('addonaccount:getSharedAccount', 'society_' .. xPlayer.job.name, function(account)
		if account then

			TriggerClientEvent("bank:refreshSocietyMoney", _source, account.money)
		else
			TriggerClientEvent("bank:refreshSocietyMoney", _source, 0)
		end
	end)
end)

ESX.RegisterServerCallback('bank:getSocietyMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('addonaccount:getSharedAccount', 'society_' .. xPlayer.job.name, function(account)
		if account then
			cb(account.money)
		else
			cb(0)
		end
	end)
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount, type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if type == "society" then
		TriggerEvent('addonaccount:getSharedAccount', 'society_' .. xPlayer.job.name, function(account)
			if account then
				base = account.money
			else
				return
			end
		end)
	end
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('esx:showNotification', _source, "Montant invalide.", "error")
	else
	if type == "player" then
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', _source, "Retrait effectué.", "success")
	elseif type == "society" then
		TriggerEvent('addonaccount:getSharedAccount', 'society_' .. xPlayer.job.name, function(account)
			if account then
				xPlayer.addMoney(amount)
				account.removeMoney(amount)
			end
		end)
	end
	end
end)