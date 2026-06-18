
RegisterServerEvent('skin:save')
AddEventHandler('skin:save', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.setSkin(skin)
	ESX.SavePlayer(xPlayer)
end)

ESX.RegisterServerCallback('skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
		local jobSkin = {
			skin_male   = xPlayer.job.skin_male,
			skin_female = xPlayer.job.skin_female
		}
		cb(xPlayer.getSkin(), jobSkin)
end)
