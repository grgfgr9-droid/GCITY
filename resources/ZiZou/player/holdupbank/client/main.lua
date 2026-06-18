local holdingup = false
local bank = ""
local secondsRemaining = 0
local blipRobbery = nil

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('holdupbank:currentlyrobbing')
AddEventHandler('holdupbank:currentlyrobbing', function(robb)
	holdingup = true
	bank = robb
	secondsRemaining = 5 * 60
end)

RegisterNetEvent('holdupbank:killblip')
AddEventHandler('holdupbank:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('holdupbank:setblip')
AddEventHandler('holdupbank:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('holdupbank:toofarlocal')
AddEventHandler('holdupbank:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification("le braquage vas être annulé, vous ne gagnerez rien !")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('holdupbank:robberycomplete') 
AddEventHandler('holdupbank:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification("~r~Braquage terminé. ~w~Vous avez volé : ~r~" .. Banks[bank].reward .. '$')
	bank = ""
	secondsRemaining = 0
	incircle = false
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if holdingup then
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			else 
				Wait(1000)
			end
		end
	end
end)


incircle = false

Citizen.CreateThread(function()
	while not ESX.PlayerData.PassJoin do
		Wait(5)
	end
	while true do
		local pos = ESX.PlayerData.cache.coords
		local letSleep = true

		for k,v in pairs(Banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 5.0)then
				letSleep = false
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 3.0)then
						if (incircle == false) then
							DisplayHelpText("Appuyer sur ~INPUT_CONTEXT~ pour braquer ~g~" .. v.nameofbank)
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							TriggerServerEvent('holdupbank:rob', k)

						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 3.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
			letSleep = false
			drawTxt(0.66, 1.44, 1.0,1.0,0.4, "braquage : ~r~" .. secondsRemaining .. "~w~ secondes restantes", 255, 255, 255, 255)

			local pos2 = Banks[bank].position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 15.0)then
				TriggerServerEvent('holdupbank:toofar', bank)
			end
		end

		if letSleep then
			Citizen.Wait(2500)
		end

		Citizen.Wait(5)
	end
end)
