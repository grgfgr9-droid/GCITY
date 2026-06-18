PlayersRegistredThisSession = {}

RegisterServerEvent('creator:setIdentity')
AddEventHandler('creator:setIdentity', function(data)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.setFirstName(data.FirstName)
	xPlayer.setLastName(data.LastName)
	xPlayer.setDOB(data.DOB)
	xPlayer.setSex(data.Sex)
	xPlayer.setHeight(data.Height)
	PlayersRegistredThisSession[xPlayer.identifier] = true
end)

RegisterServerEvent('creator:putMeInBukket')
AddEventHandler('creator:putMeInBukket', function(enable)
	if enable then
		SetPlayerRoutingBucket(source, source)
	else 
		SetPlayerRoutingBucket(source, 0)
	end
end)