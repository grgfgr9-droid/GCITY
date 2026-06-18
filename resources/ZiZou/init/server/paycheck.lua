local AFKPlayers = {}
local AFKZone = vector3(-1809.89, 5511.23, 11.24)

ESX.StartPayCheck = function()
	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local salary  = 100

			if xPlayer.getRank() == 'vip' then
				salary = math.floor(salary * 1.5)
				xPlayer.showNotification('Votre salaire a été multiplié grâce à votre grade ' .. string.lower(xPlayer.getRank()))
			elseif xPlayer.getRank() == 'diamond' then
				salary = math.floor(salary * 2)
				xPlayer.showNotification('Votre salaire a été multiplié grâce à votre grade ' .. string.lower(xPlayer.getRank()))	
			end

			if salary > 0 then
				xPlayer.addAccountMoney('bank', salary)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "banque", "paiement reçu", "Vous avez reçu une aide de l'état de : ~g~$" .. salary, 'CHAR_BANK_MAZE', 9)
			end

		end

		SetTimeout(Config.PaycheckInterval, payCheck)
	end

	SetTimeout(Config.PaycheckInterval, payCheck)
end

ESX.StartAFKCheck = function()
	function afkCheck()
		for k, v in pairs(AFKPlayers) do
			local xPlayer = ESX.GetPlayerFromId(k)
			if xPlayer then
				if xPlayer.afk.enable then
					local PlayerPed = GetPlayerPed(xPlayer.source)
                    local playerCoords = GetEntityCoords(PlayerPed)
					if DoesEntityExist(PlayerPed) and #(playerCoords - AFKZone) > 10 then
						SetEntityCoords(PlayerPed, AFKZone.x, AFKZone.y, AFKZone.z)
					end
			        AFKPlayers[k] = v + 1
				    xPlayer.setAFK(xPlayer.afk.enable, AFKPlayers[k])
				else
					ESX.RemoveAFKPlayer(xPlayer.source)
				end
		    else
				AFKPlayers[k] = nil
		    end
		end
		SetTimeout(60 * 1000, afkCheck)
	end

	SetTimeout(60 * 1000, afkCheck)
end

ESX.AddAFKPlayer = function(source)
	if not AFKPlayers[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer then
            AFKPlayers[source] = 0
			xPlayer.setAFK(true, 0)
		end
	end
end

RegisterServerEvent("esx:ToggleAFK")
AddEventHandler("esx:ToggleAFK", function()
	if not AFKPlayers[source] then
		ESX.AddAFKPlayer(source)
	else
		ESX.RemoveAFKPlayer(source)
	end
end)

ESX.RemoveAFKPlayer = function(source)
	if AFKPlayers[source] then
		AFKPlayers[source] = nil
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer then
			xPlayer.setAFK(false, 0)
		end
	end
end

ESX.StartAFKReward = function()
    function afkReward()
        for k, v in pairs(AFKPlayers) do
            if v >= 10 then
                local xPlayer = ESX.GetPlayerFromId(k)
                if xPlayer then
                    local reward = 5000
                    local afkTime = v * 10 -- Convertit en minutes réelles

                    -- Bonus selon le grade du joueur
                    if xPlayer.getRank() == 'vip' then
                        reward = 10000
                        xPlayer.showNotification('Votre reward AFK a été multiplié grâce à votre grade ' .. string.lower(xPlayer.getRank()))
                    elseif xPlayer.getRank() == 'diamond' then
                        reward = 15000
                        xPlayer.showNotification('Votre reward AFK a été multiplié grâce à votre grade ' .. string.lower(xPlayer.getRank()))
                    end

                    -- Attribution de l'argent
                    xPlayer.addMoney(reward)
                    xPlayer.showNotification('Votre reward AFK s\'élève à ~g~' .. reward .. '$~s~')
                    
                    -- Attribution des caisses
                    if afkTime >= 150 and not xPlayer.hasReceivedBronze then -- 2h30 (150 min)
                        xPlayer.addInventoryItem('blue_case', 1)
                        xPlayer.showNotification('Vous avez reçu une Caisse Bronze pour votre temps AFK !')
                        xPlayer.hasReceivedBronze = true
                    end

                    if afkTime >= 300 and not xPlayer.hasReceivedGold then -- 5h (300 min)
                        xPlayer.addInventoryItem('blue_case', 1)
                        xPlayer.showNotification('Vous avez reçu une Caisse Gold pour votre temps AFK !')
                        xPlayer.hasReceivedGold = true
                    end
                end
            end
        end
        
        SetTimeout(10 * 60 * 1000, afkReward) -- Répète toutes les 10 minutes
    end

    SetTimeout(10 * 60 * 1000, afkReward)
end