local MarkersData = {
	size = {4.0, 4.0, 1.5},
	color = {168, 50, 50, 100},
	DrawDistance = 10.0,
	Messages = {
		["harvest"] = "Appyuez sur ~INPUT_CONTEXT~ pour récolter : ",
		["transform"] = "Appyuez sur ~INPUT_CONTEXT~ pour traîter : ",
		["sell"] = "Appyuez sur ~INPUT_CONTEXT~ pour vendre : "
	}
}

local IsUsingDrugSystem = false

local AntiSpamDrugs = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local sleep = true
		local InZone = false
    for a,b in pairs(DrugsZones) do
		for k,v in pairs(b) do
            -- Retirer la condition 'a == "moneywash" and ESX.PlayerData.job2.name == "moneywasher"'
            if(GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, v.x, v.y, v.z, true) < MarkersData.DrawDistance) then
                sleep = false
				DrawMarker(ZiZouConfig.Marker.Markers.MarkerDrugs.type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 0.5, ZiZouConfig.Marker.Markers.MarkerDrugs.r, ZiZouConfig.Marker.Markers.MarkerDrugs.g, ZiZouConfig.Marker.Markers.MarkerDrugs.b, ZiZouConfig.Marker.Markers.MarkerDrugs.a, ZiZouConfig.Marker.Markers.MarkerDrugs.rotate, false, 2, false, nil, nil, false)
            end
            -- Retirer la condition qui restreint l'accès aux "moneywashers"
            if(GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, v.x, v.y, v.z, true) < 4.0) then
				InZone = true
				if not IsUsingDrugSystem then
                    -- Afficher la notification pour tout le monde
 					ESX.ShowHelpNotification(MarkersData.Messages[k] .. a)
                    if IsControlJustReleased(0, 38) then
                        DrugControlManager(k, a)
						IsUsingDrugSystem = true
                    end
			    end
            end
		end
    end
	if not InZone and IsUsingDrugSystem then
		IsUsingDrugSystem = false
		TriggerServerEvent("drugs:stopHarvest")
		TriggerServerEvent("drugs:stopTransform")
		TriggerServerEvent("drugs:stopSell")
	end
		if sleep then
		Citizen.Wait(1000)
		end
	end
end)


function DrugControlManager(zone, drug)
	if zone == "harvest" then
	TriggerServerEvent("drugs:startHarvest", drug)
	elseif zone == "transform" then
	TriggerServerEvent("drugs:startTransform", drug)
	elseif zone == "sell" then
	TriggerServerEvent("drugs:startSell", drug)
	end
end

RegisterNetEvent('esx:playerLoaded', function()

    Citizen.Wait(5000)
    TriggerEvent('chat:addMessage', {
        color = { 255, 204, 0},
        multiline = true,
        args = {"Informations", 'Gagnez des récompenses gratuitement en restant AFK via la commande /AFK en safezone ⚠️'}
    })
    TriggerEvent('chat:addMessage', {
        color = { 0, 240, 255, 255},
        multiline = true,
        args = {ZiZouConfig.ServerName, "Visitez notre boutique en appuyant sur la touche F1 ! Merci de votre soutien et bon jeu sur ".. ZiZouConfig.ServerName .." ❤️"}
    })
end)
