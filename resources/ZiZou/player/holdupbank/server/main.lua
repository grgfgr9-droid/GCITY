local rob = false
local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('holdupbank:toofar')
AddEventHandler('holdupbank:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], "~r~Braquage annulé à: ~y~" .. Banks[robb].nameofbank)
			TriggerClientEvent('holdupbank:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('holdupbank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, "~s~~h~Le braquage à été annulé: ~g~" .. Banks[robb].nameofbank)
	end
end)

RegisterServerEvent('holdupbank:rob')
AddEventHandler('holdupbank:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Banks[robb] then

		local bank = Banks[robb]

		if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then

			TriggerClientEvent('esx:showNotification', source, "cet endroit a déjà été braqué. Veuillez attendre: " .. (1800 - (os.time() - bank.lastrobbed)) .. " secondes.")
			return
		end


		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
				cops = cops + 1
			end
		end


		if rob == false then

			if(cops >= BankHoldupConfig.NumberOfCopsRequired)then
				if (robb == "PrincipalBank" and cops < 6) then TriggerClientEvent('esx:showNotification', source, "Pour braquer il faut minimum autant de policiers : " .. 6) return end
				rob = true
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
							TriggerClientEvent('esx:showNotification', xPlayers[i], "~s~~h~~r~Un braquage est en cours à: ~g~" .. bank.nameofbank)
							TriggerClientEvent('holdupbank:setblip', xPlayers[i], Banks[robb].position)
					end
				end

				TriggerClientEvent('esx:showNotification', source, "Vous avez commencé à braquer " .. bank.nameofbank .. ", ne vous éloignez pas!")
				TriggerClientEvent('esx:showNotification', source, "l\'alarme à été déclenché")
				TriggerClientEvent('esx:showNotification', source, "Tenez la position pendant 5 minutes et l\'argent est à vous!")
				TriggerClientEvent('holdupbank:currentlyrobbing', source, robb)
				Banks[robb].lastrobbed = os.time()
				robbers[source] = robb
				local savedSource = source
				SetTimeout(5 * 60 * 1000, function()

					if(robbers[savedSource])then

						rob = false
						TriggerClientEvent('holdupbank:robberycomplete', savedSource, job)
						if(xPlayer)then

							xPlayer.addAccountMoney('black_money', bank.reward)
							local xPlayers = ESX.GetPlayers()
							for i=1, #xPlayers, 1 do
								local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
								if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
										TriggerClientEvent('esx:showNotification', xPlayers[i], "~s~~h~Braquage terminé à: ~g~" .. bank.nameofbank)
										TriggerClientEvent('holdupbank:killblip', xPlayers[i])
								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('esx:showNotification', source, "Pour braquer il faut minimum autant de policiers : " .. BankHoldupConfig.NumberOfCopsRequired)
			end
		else
			TriggerClientEvent('esx:showNotification', source, "~r~Un braquage est déjà en cours.")
		end
	end
end)
