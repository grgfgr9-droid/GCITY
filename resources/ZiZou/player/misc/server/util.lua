RegisterNetEvent('txaLogger:internalChatMessage')
AddEventHandler('txaLogger:internalChatMessage', function(target, title, message)
    if string.find(title, "(Broadcast)") then
    TriggerClientEvent('esx:announce', target, "~b~Annonce", message, 5)
    end
end)

ESX.RegisterServerCallback('esx:GetRankExpiration', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer and xPlayer.getExpiration() then
        cb(math.floor((xPlayer.getExpiration() - os.time()) / 60 / 60 / 24))
    else
        cb(false)
    end
end)

function CheckPlayersCoordsBetweenEachOther(player1, player2, distance)
	local playeroneped = GetPlayerPed(player1)
	local playertwoped = GetPlayerPed(player2)

	local playeronecoords = GetEntityCoords(playeroneped)
	local playertwocoords = GetEntityCoords(playertwoped)

	if #(playeronecoords - playertwocoords) < tonumber(distance) then
		return true
	end

	return false
end