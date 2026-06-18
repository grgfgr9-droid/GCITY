
RegisterServerEvent('admin:delVeh')
AddEventHandler('admin:delVeh', function(NetID)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() ~= 'user' then
		local entity = NetworkGetEntityFromNetworkId(NetID)
		DeleteEntity(entity)
	end
end)
