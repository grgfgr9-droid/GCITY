local PlayersHarvesting = {}
local PlayersTransforming = {}
local PlayersSelling = {}

TriggerEvent('society:registerSociety', 'vigneron', 'vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', {type = 'private'})


local function Harvest(source, drug)

	SetTimeout(5000, function()

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

RegisterServerEvent('vigneron:startHarvest')
AddEventHandler('vigneron:startHarvest', function()

	local _source = source

	PlayersHarvesting[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Récolte en cours...')

	Harvest(_source, 'vigne')

end)

RegisterServerEvent('vigneron:stopHarvest')
AddEventHandler('vigneron:stopHarvest', function()

	local _source = source

	PlayersHarvesting[_source] = false

end)

local function Transform(source, drug)

	SetTimeout(7000, function()

		if PlayersTransforming[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem(drug).count
			if not xPlayer.canCarryItem(drug .. '_pooch', 1) then 
				TriggerClientEvent('esx:showNotification', source, 'Votre inventaire est plein')
				return
			end
			if Quantity < 2 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de vigne sur vous')
			else
				xPlayer.removeInventoryItem(drug, 2)
				xPlayer.addInventoryItem(drug .. '_pooch', 1)
			
				Transform(source, drug)
			end

		end
	end)
end

RegisterServerEvent('vigneron:startTransform')
AddEventHandler('vigneron:startTransform', function()

	local _source = source

	PlayersTransforming[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Transformation en cours...')

	Transform(_source, 'vigne')

end)

RegisterServerEvent('vigneron:stopTransform')
AddEventHandler('vigneron:stopTransform', function()

	local _source = source

	PlayersTransforming[_source] = false

end)

local function Sell(source, drug)

	SetTimeout(5000, function()

		if PlayersSelling[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem(drug .. '_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source,'Pas assez d\'items sur vous')
			else
				xPlayer.removeInventoryItem(drug .. '_pooch', 1)
				local societyAccount = nil
				TriggerEvent('addonaccount:getSharedAccount', 'society_vigneron', function(account)
					societyAccount = account
				  end)
				  if societyAccount ~= nil then
					societyAccount.addMoney(250)
					xPlayer.addMoney(250)
					TriggerClientEvent('esx:showNotification', source, 'Vendu un item')
				end				
				Sell(source, drug)
			end

		end
	end)
end

RegisterServerEvent('vigneron:startSell')
AddEventHandler('vigneron:startSell', function()

	local _source = source

	PlayersSelling[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Vente en cours...')

	Sell(_source, 'vigne')

end)

RegisterServerEvent('vigneron:stopSell')
AddEventHandler('vigneron:stopSell', function()

	local _source = source

	PlayersSelling[_source] = false

end)