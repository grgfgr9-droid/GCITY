local PlayersHarvesting = {}
local PlayersTransforming = {}
local PlayersSelling = {}

TriggerEvent('society:registerSociety', 'joal', 'joal', 'society_joal', 'society_joal', 'society_joal', {type = 'private'})


local function Harvest(source, drug)

	SetTimeout(9000, function()

		if PlayersHarvesting[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			if not xPlayer.canCarryItem(drug, 1) then 
				PlayersHarvesting[source] = false 
				TriggerClientEvent('esx:showNotification', source, 'Votre inventaire est plein')
				return
			end

			xPlayer.addInventoryItem(drug, 1)
			Harvest(source, drug)

		end
	end)
end

RegisterServerEvent('joal:startHarvest')
AddEventHandler('joal:startHarvest', function()

	local _source = source

	PlayersHarvesting[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Récolte en cours...')

	Harvest(_source, 'joal')

end)

RegisterServerEvent('joal:stopHarvest')
AddEventHandler('joal:stopHarvest', function()

	local _source = source

	PlayersHarvesting[_source] = false

end)


local function Sell(source, drug)

	SetTimeout(7500, function()

		if PlayersSelling[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem(drug).count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source,'Pas assez d\'items sur vous')
			else
				xPlayer.removeInventoryItem(drug, 1)
				local societyAccount = nil
				TriggerEvent('addonaccount:getSharedAccount', 'society_joal', function(account)
					societyAccount = account
				  end)
				  if societyAccount ~= nil then
					societyAccount.addMoney(500)
					xPlayer.addMoney(500)
					TriggerClientEvent('esx:showNotification', source, 'Vendu un item')
				end				
				Sell(source, drug)
			end

		end
	end)
end

RegisterServerEvent('joal:startSell')
AddEventHandler('joal:startSell', function()

	local _source = source

	PlayersSelling[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Vente en cours...')

	Sell(_source, 'joal')

end)

RegisterServerEvent('joal:stopSell')
AddEventHandler('joal:stopSell', function()

	local _source = source

	PlayersSelling[_source] = false

end)