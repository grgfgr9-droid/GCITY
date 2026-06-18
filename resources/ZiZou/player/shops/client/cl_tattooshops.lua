local currentTattoos, cam, CurrentActionData = {}, -1, {}
local HasAlreadyEnteredMarker, CurrentAction, CurrentActionMsg

TattooConfig              = {}

TattooConfig.DrawDistance = 10.0
TattooConfig.Size         = {x = 1.5, y = 1.5, z = 1.5}
TattooConfig.Color        = {r = 102, g = 102, b = 204}
TattooConfig.Type         = 1

TattooConfig.Zones = {
	vector3(1322.6, -1651.9, 51.2),
	vector3(-1153.6, -1425.6, 3.9),
	vector3(322.1, 180.4, 102.5),
	vector3(-3170.0, 1075.0, 19.8),
	vector3(1864.6, 3747.7, 32.0),
	vector3(-293.7, 6200.0, 30.4)
}

AddEventHandler('caruiskinchanger:modelLoaded', function()
	ESX.TriggerServerCallback('tattooshop:requestPlayerTattoos', function(tattooList)
		if tattooList then
			for k,v in pairs(tattooList) do
				ApplyPedOverlay(ESX.PlayerData.cache.playerped, GetHashKey(v.collection), GetHashKey(TattooConfig.TattooList[v.collection][v.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
end)

function OpenTattoShopMenu()
	local CurrentCat = nil
	TattooMenu = { 
		  Base = { Title = "Tattoo", HeaderColor = {130, 109, 68} },
		  Data = { currentMenu = "tattoocatlist" },
	Events = { 
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result) 
			if btn.action == 'opencat' then
				TattooMenu.Menu["tattoolist"].b = {{name = 'Revenir aux catégories', action = "goback"}}
				CurrentCat = btn.value
				
				for k,v in pairs(TattooConfig.TattooList[btn.value]) do
					table.insert(TattooMenu.Menu["tattoolist"].b, {
						name = "tattouage " .. k .. " - " .. "<span style=\"color:green;\">$" .. ESX.Math.GroupDigits(v.price) .. "</span>",
						value = k,
						prix = v.price,
						action = "buyitem"
					})
				end
				OpenMenu("tattoolist")	
			elseif btn.action == 'goback' then
			CloseMenu()
			OpenTattoShopMenu()	
			elseif btn.action == 'buyitem' then
				CloseMenu()
				ESX.TriggerServerCallback('tattooshop:purchaseTattoo', function(success)
					if success then
						table.insert(currentTattoos, {collection = CurrentCat, texture = btn.value})
					end
				end, currentTattoos, btn.prix, {collection = CurrentCat, texture = btn.value})
				CreateMenu(TattooMenu)
			end
		end,
		onButtonSelected = function(currentaMenu, k, j, btn, self)
			if btn.prix then
				if CurrentCat ~= nil then
				cleanPlayer()
				drawTattoo(btn.value, CurrentCat)
				end
			else
				cleanPlayer()
			end 
		end,
		onExited = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide)
			OpenTattoShopMenu()
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(cam, false)
			cleanPlayer()
			setPedSkin()
		end
	},      
	Menu = {
		["tattoocatlist"] = {
		    b = {}   
		},
		["tattoolist"] = {
		    b = {}   
		}      
	}  
}   

for k,v in pairs(TattooConfig.TattooCategories) do
	table.insert(TattooMenu.Menu["tattoocatlist"].b, {name = v.name, value = v.value, action = 'opencat'})
end

if DoesCamExist(cam) then
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(cam, false)
end

CreateMenu(TattooMenu)   
end

Citizen.CreateThread(function()
	for k,v in pairs(TattooConfig.Zones) do
		local blip = AddBlipForCoord(v)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 1)
		SetBlipScale  (blip, 0.5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Salon de tattouages")
		EndTextCommandSetBlipName(blip)
	end
end)

-- Draw Marker / Control Listener
Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5)
   
     local isInMarker = false
     local letSleep = true
   
     for k,v in pairs(TattooConfig.Zones) do
       if (GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, v.x, v.y, v.z, true) < 10) then
         letSleep = false
         DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 30, 30, 30, 200, false, true, 2, false, false, false, false)
       end
   
       if (GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, v.x, v.y, v.z, true) < 1.5) then
         HasAlreadyEnteredMarker = true
         isInMarker = true
         ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le magasin.")
         if (IsControlJustPressed(1, 38)) then
			OpenTattoShopMenu()
         end
       end
     end
   
     if not isInMarker and HasAlreadyEnteredMarker then
       HasAlreadyEnteredMarker = false
       CloseMenu()
     end
   
     if letSleep then
       Citizen.Wait(5000)
     end
    end
end)

function setPedSkin()
	ESX.TriggerServerCallback('skin:getPlayerSkin', function(skin)
		TriggerEvent('caruiskinchanger:loadSkin', skin)
	end)

	Citizen.Wait(1000)

	for k,v in pairs(currentTattoos) do
		ApplyPedOverlay(ESX.PlayerData.cache.playerped, GetHashKey(v.collection), GetHashKey(TattooConfig.TattooList[v.collection][v.texture].nameHash))
	end
end

function drawTattoo(current, collection)
	SetEntityHeading(ESX.PlayerData.cache.playerped, 297.7296)
	ClearPedDecorations(ESX.PlayerData.cache.playerped)

	for k,v in pairs(currentTattoos) do
		ApplyPedOverlay(ESX.PlayerData.cache.playerped, GetHashKey(v.collection), GetHashKey(TattooConfig.TattooList[v.collection][v.texture].nameHash))
	end

	TriggerEvent('caruiskinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('caruiskinchanger:loadSkin', {
				sex      = 0,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 15,
				torso_2  = 0,
				pants_1  = 14,
				pants_2  = 0
			})
		else
			TriggerEvent('caruiskinchanger:loadSkin', {
				sex      = 1,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 15,
				torso_2  = 1,
				pants_1  = 14,
				pants_2  = 0
			})
		end
	end)

	ApplyPedOverlay(ESX.PlayerData.cache.playerped, GetHashKey(collection), GetHashKey(TattooConfig.TattooList[collection][current].nameHash))

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, ESX.PlayerData.cache.coords)
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		SetCamCoord(cam, ESX.PlayerData.cache.coords)
	end

	local x,y,z = table.unpack(ESX.PlayerData.cache.coords)

	SetCamCoord(cam, x + TattooConfig.TattooList[collection][current].addedX, y + TattooConfig.TattooList[collection][current].addedY, z + TattooConfig.TattooList[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, TattooConfig.TattooList[collection][current].rotZ)
end

function cleanPlayer()
	ClearPedDecorations(ESX.PlayerData.cache.playerped)

	for k,v in pairs(currentTattoos) do
		ApplyPedOverlay(ESX.PlayerData.cache.playerped, GetHashKey(v.collection), GetHashKey(TattooConfig.TattooList[v.collection][v.texture].nameHash))
	end
end
