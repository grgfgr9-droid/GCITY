local Bills = {}
local actualbillid = 0

RegisterServerEvent('billing:sendBill')
AddEventHandler('billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	local _source = source
	local target = playerId
	amount = ESX.Math.Round(amount)
	if playerId ~= -1 then 
		if xPlayer and xTarget then
		if xPlayer ~= xTarget then 
			if not CheckPlayersCoordsBetweenEachOther(source, playerId, 10) then DropPlayer(source, "Pas Bien de Trigger mec") return end
			if amount > 0 and xTarget then
				TriggerEvent('addonaccount:getSharedAccount', "society_" .. sharedAccountName, function(account)
					local targettype = ''
					if account then
						targettype = 'society'
						sharedAccountName = "society_" .. sharedAccountName
					else
						targettype = 'player'
					end
					TriggerEvent('esx:sendLog', "billing", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a envoyé une facture ' .. "de " .. amount .. "$" .. " à " .. GetPlayerName(playerId) .. " ( "  .. playerId .. ' - ' .. xTarget.getUUID() .. " )")
					actualbillid = actualbillid + 1
					Bills[actualbillid] = {id = actualbillid, target = target, label = label, amount = tonumber(amount), account = sharedAccountName, sender = _source, target_type = targettype}
					TriggerClientEvent("billing:receiveBill", target, actualbillid, label, tonumber(amount), sharedAccountName, _source)
				end)
			end
		end
	end
	end
end)

function SendBillToPlayer(source, target, sharedAccountName, label, amount, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
	amount = ESX.Math.Round(amount)
	if xPlayer and xTarget then
		local SocietyAccount = GetSharedAccount(sharedAccountName)
		actualbillid = actualbillid + 1
		Bills[actualbillid] = {id = actualbillid, target = target, label = label, amount = tonumber(amount), account = sharedAccountName, sender = source, target_type = "society", callback = cb}
		TriggerClientEvent("billing:receiveBill", target, actualbillid, label, tonumber(amount), sharedAccountName, source)
	end
end

RegisterServerEvent('billing:payBill')
AddEventHandler('billing:payBill', function(billId)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bill = Bills[billId]
	if bill then
		local amount = bill.amount
		local xTarget = ESX.GetPlayerFromId(bill.sender)
			if bill.target_type == 'player' then
				if xTarget then
					if xPlayer.getMoney() >= amount then
						Bills[billId] = nil
						xPlayer.removeMoney(amount)
						xTarget.addMoney(amount)
						ESX.SavePlayer(xPlayer)
						ESX.SavePlayer(xTarget)


						xPlayer.showNotification("vous avez ~g~payé~s~ une facture de ~r~$" .. ESX.Math.GroupDigits(amount) .. "~s~")
						xTarget.showNotification("vous avez ~g~reçu~s~ une paiement de ~g~$" .. ESX.Math.GroupDigits(amount) .. "~s~")

					elseif xPlayer.getAccount('bank').money >= amount then
						Bills[billId] = nil
						xPlayer.removeAccountMoney('bank', amount)
						xTarget.addAccountMoney('bank', amount)
						ESX.SavePlayer(xPlayer)
						ESX.SavePlayer(xTarget)

						xPlayer.showNotification("vous avez ~g~payé~s~ une facture de ~r~$" .. ESX.Math.GroupDigits(amount) .. "~s~")
						xTarget.showNotification("vous avez ~g~reçu~s~ une paiement de ~g~$" .. ESX.Math.GroupDigits(amount) .. "~s~")

					else
						xTarget.showNotification("le joueur ~r~n\'a pas~s~ assez d\'argent pour payer la facture !")
						xPlayer.showNotification("vous n\'avez pas assez d\'argent pour payer cette facture")
					end
				end
			elseif bill.target_type == 'society' then
				local account = GetSharedAccount(bill.account)
				if account then
					if xPlayer.getMoney() >= amount then
						Bills[billId] = nil
						xPlayer.removeMoney(amount)
						account.addMoney(amount)
						ESX.SavePlayer(xPlayer)

						xPlayer.showNotification("vous avez ~g~payé~s~ une facture de ~r~$" .. ESX.Math.GroupDigits(amount) .. "~s~")
						if xTarget then
							xTarget.showNotification("vous avez ~g~reçu~s~ une paiement de ~g~$" .. ESX.Math.GroupDigits(amount) .. "~s~")
						end
					if bill.callback then
						bill.callback()
					end
					elseif xPlayer.getAccount('bank').money >= amount then
						Bills[billId] = nil
						xPlayer.removeAccountMoney('bank', amount)
						account.addMoney(amount)
						ESX.SavePlayer(xPlayer)
						xPlayer.showNotification("vous avez ~g~payé~s~ une facture de ~r~$" .. ESX.Math.GroupDigits(amount) .. "~s~")

						if xTarget then
							xTarget.showNotification("vous avez ~g~reçu~s~ une paiement de ~g~$" .. ESX.Math.GroupDigits(amount) .. "~s~")
						end
					if bill.callback then
						bill.callback()
					end
					else
						if xTarget then
							xTarget.showNotification("le joueur ~r~n\'a pas~s~ assez d\'argent pour payer la facture !")
						end

						xPlayer.showNotification("vous n\'avez pas assez d\'argent pour payer cette facture")
					end
				end
			end
	end
end)

RegisterServerEvent('billing:expireBill')
AddEventHandler('billing:expireBill', function(billId)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bill = Bills[billId]
	if bill then
		Bills[billId] = nil
		local xTarget = ESX.GetPlayerFromId(bill.sender)
		if xTarget then
			xTarget.showNotification("~y~La facture a expiré !")
		end
	end
end)

RegisterServerEvent('billing:refuseBill')
AddEventHandler('billing:refuseBill', function(billId)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bill = Bills[billId]
	if bill then
		Bills[billId] = nil
		local xTarget = ESX.GetPlayerFromId(bill.sender)
		if xTarget then
			xTarget.showNotification("~r~La personne a refusé la facture !")
		end
	end
end)
