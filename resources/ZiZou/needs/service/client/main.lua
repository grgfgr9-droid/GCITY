RegisterNetEvent('service:notifyAllInService')
AddEventHandler('service:notifyAllInService', function(notification, target)
	target = GetPlayerFromServerId(target)
	if target == PlayerId() then return end

	local targetPed = GetPlayerPed(target)
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(targetPed)

	ESX.ShowAdvancedNotification(notification.title, notification.subject, notification.msg, mugshotStr, notification.iconType)
	UnregisterPedheadshot(mugshot)
end)

RegisterNetEvent('player:InService')
AddEventHandler('player:InService', function()
	CloseMenu()
	ESX.ShowNotification('Vous êtes en service !')
end)

RegisterNetEvent('player:NotService')
AddEventHandler('player:NotService', function()
	CloseMenu()
	ESX.ShowNotification('Vous n\'êtes plus en service !')
end)