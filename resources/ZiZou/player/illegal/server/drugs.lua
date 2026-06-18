local PlayersHarvesting = {}
local PlayersTransforming = {}
local PlayersSelling = {}

local function Harvest(source, drug)

	SetTimeout(5000, function()

		if PlayersHarvesting[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			if CheckDrugsCoords(source, drug, "harvest") then

			    if not xPlayer.canCarryItem(drug, 1) then 
				    PlayersHarvesting[source] = false 
				    TriggerClientEvent('esx:showNotification', source, 'Votre inventaire est plein')
				    return
			    end

			    xPlayer.addInventoryItem(drug, 1)
			    Harvest(source, drug)
		    else
				PlayersHarvesting[source] = false
		    end

		end
	end)
end

RegisterServerEvent('drugs:startHarvest')
AddEventHandler('drugs:startHarvest', function(drug)

	local _source = source

	if CheckDrugsCoords(source, drug, "harvest") then

	PlayersHarvesting[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Récolte en cours...')

	Harvest(_source, drug)
	else
		SendAntiCheatLog(_source, "Unauthorized Drugs Farm attempt", true)
	end

end)

RegisterServerEvent('drugs:stopHarvest')
AddEventHandler('drugs:stopHarvest', function()

	local _source = source

	PlayersHarvesting[_source] = false

end)

local function Transform(source, drug)

	SetTimeout(7000, function()

		if PlayersTransforming[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			if CheckDrugsCoords(source, drug, "transform") then

			    local Quantity = xPlayer.getInventoryItem(drug).count
			    if not xPlayer.canCarryItem(drug .. '_pooch', 1) then 
				    TriggerClientEvent('esx:showNotification', source, 'Votre inventaire est plein')
				    return
			    end
			    if Quantity < 3 then
				    TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de drogue sur vous')
			    else
				    xPlayer.removeInventoryItem(drug, 3)
				    xPlayer.addInventoryItem(drug .. '_pooch', 1)
			
				    Transform(source, drug)
			    end

			else
				PlayersTransforming[source] = false
		    end

		end
	end)
end

RegisterServerEvent('drugs:startTransform')
AddEventHandler('drugs:startTransform', function(drug)

	local _source = source

	if CheckDrugsCoords(source, drug, "transform") then

	PlayersTransforming[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Transformation en cours...')

	Transform(_source, drug)

	else
		SendAntiCheatLog(_source, "Unauthorized Drugs Farm attempt", true)
	end
end)

RegisterServerEvent('drugs:stopTransform')
AddEventHandler('drugs:stopTransform', function()

	local _source = source

	PlayersTransforming[_source] = false

end)

local function Sell(source, drug)
	SetTimeout(4000, function()
		if PlayersSelling[source] == true then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			
			if CheckDrugsCoords(source, drug, "sell") then
				-- Blanchiment de l'argent sale
				if drug == "moneywash" then
					local blackAccount = xPlayer.getAccount('black_money')
					local blackMoney = blackAccount.money

					-- Vérifie si l'argent sale est suffisant pour blanchir 9000
					local amountToWash = math.min(blackMoney, 9000)  -- Blanchir soit 9000$ soit l'argent qu'il a
					if amountToWash > 0 then
						xPlayer.removeAccountMoney('black_money', amountToWash)  -- Retirer l'argent sale
						xPlayer.addMoney(amountToWash)  -- Ajouter l'argent propre
						TriggerClientEvent('esx:showNotification', source, 'Vous avez blanchi ~r~' .. amountToWash .. '$~s~')

						-- Relance la fonction de vente après un délai
						Sell(source, drug)
					else
						PlayersSelling[source] = false
						TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent ~r~sale~s~ pour blanchir')
					end
				else
					-- Vendre les drogues
					if drug ~= "moneywash" then
						local poochQuantity = xPlayer.getInventoryItem(drug .. '_pooch').count

						if poochQuantity == 0 then
							TriggerClientEvent('esx:showNotification', source, 'Pas assez d\'items sur vous')
						else
							xPlayer.removeInventoryItem(drug .. '_pooch', 1)
							local modifier = 1

							if xPlayer.getRank() == "vip" then
								modifier = 1.5
								TriggerClientEvent('esx:showNotification', source, 'Vous avez un bonus grâce à votre grade ' .. xPlayer.getRank())
							elseif xPlayer.getRank() == "diamond" then
								modifier = 2
								TriggerClientEvent('esx:showNotification', source, 'Vous avez un bonus grâce à votre grade ' .. xPlayer.getRank())
							end

							if drug == 'coke' then
								xPlayer.addAccountMoney('black_money', modifier * 1400)
							elseif drug == 'meth' then
								xPlayer.addAccountMoney('black_money', modifier * 1200)
							elseif drug == 'opium' then
								xPlayer.addAccountMoney('black_money', modifier * 1000)
							elseif drug == 'weed' then
								xPlayer.addAccountMoney('black_money', modifier * 800)
							end
							
							TriggerClientEvent('esx:showNotification', source, 'Vendu un item')
							Sell(source, drug)
						end
					end
				end
			end
		end
	end)
end



function CheckDrugsCoords(source, drug, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local coords = DrugsZones[drug][zone]
	coords = vector3(coords.x, coords.y, coords.z)
	local playerped = GetPlayerPed(source)
	local playercoords = GetEntityCoords(playerped)

	if xPlayer then
		if #(playercoords - coords) < 10 then
			return true
		else
			PlayersHarvesting[source] = false
			PlayersSelling[source] = false
			PlayersTransforming[source] = false
		end
	else
		DropPlayer(source, "Désynchronisation ou stop resource")
	end

	return false
	
end

RegisterServerEvent('drugs:startSell')
AddEventHandler('drugs:startSell', function(drug)

	local _source = source

	if CheckDrugsCoords(source, drug, "sell") then

	PlayersSelling[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Vente en cours...')

	Sell(_source, drug)
	else
		SendAntiCheatLog(_source, "Unauthorized Drugs Farm attempt", true)
	end
end)

RegisterServerEvent('drugs:stopSell')
AddEventHandler('drugs:stopSell', function()

	local _source = source

	PlayersSelling[_source] = false

end)