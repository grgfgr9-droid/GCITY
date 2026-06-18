local PlayersHarvesting = {}
local PlayersTransforming = {}
local PlayersSelling = {}

TriggerEvent('society:registerSociety', 'tabac', 'tabac', 'society_tabac', 'society_tabac', 'society_tabac', {type = 'private'})


local function Harvest(source, drug)

	SetTimeout(7500, function()

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

RegisterServerEvent('tabac:startHarvest')
AddEventHandler('tabac:startHarvest', function()

	local _source = source

	PlayersHarvesting[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Récolte en cours...')

	Harvest(_source, 'tabac')

end)

RegisterServerEvent('tabac:stopHarvest')
AddEventHandler('tabac:stopHarvest', function()

	local _source = source

	PlayersHarvesting[_source] = false

end)

local function Transform(source, drug)

	SetTimeout(10000, function()

		if PlayersTransforming[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem(drug).count
			if not xPlayer.canCarryItem(drug .. '_pooch', 1) then 
				TriggerClientEvent('esx:showNotification', source, 'Votre inventaire est plein')
				return
			end
			if Quantity < 1 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de tabac sur vous')
			else
				xPlayer.removeInventoryItem(drug, 1)
				xPlayer.addInventoryItem(drug .. '_pooch', 1)
			
				Transform(source, drug)
			end

		end
	end)
end

RegisterServerEvent('tabac:startTransform')
AddEventHandler('tabac:startTransform', function()

	local _source = source

	PlayersTransforming[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Transformation en cours...')

	Transform(_source, 'tabac')

end)

RegisterServerEvent('tabac:stopTransform')
AddEventHandler('tabac:stopTransform', function()

	local _source = source

	PlayersTransforming[_source] = false

end)

local function Sell(source, drug)

	SetTimeout(7500, function()

		if PlayersSelling[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem(drug .. '_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source,'Pas assez d\'items sur vous')
			else
				xPlayer.removeInventoryItem(drug .. '_pooch', 1)
				local societyAccount = nil
				TriggerEvent('addonaccount:getSharedAccount', 'society_tabac', function(account)
					societyAccount = account
				  end)
				  if societyAccount ~= nil then
					societyAccount.addMoney(300)
					xPlayer.addMoney(300)
					TriggerClientEvent('esx:showNotification', source, 'Vendu un item')
				end				
				Sell(source, drug)
			end

		end
	end)
end

RegisterServerEvent('tabac:startSell')
AddEventHandler('tabac:startSell', function()

	local _source = source

	PlayersSelling[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Vente en cours...')

	Sell(_source, 'tabac')

end)

RegisterServerEvent('tabac:stopSell')
AddEventHandler('tabac:stopSell', function()

	local _source = source

	PlayersSelling[_source] = false

end)