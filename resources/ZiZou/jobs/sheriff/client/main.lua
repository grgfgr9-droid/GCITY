local isnearSheriff = false
local nearSheriff = nil
local isSheriff = false
local AleardyStartedSheriff = false
local AleardyStartednearSheriff = false
local SheriffMenuOpen = ""
local playerInService = false
local SheriffFines = {
	{name = "Vol de voiture", price = 10000},
	{name = "Conduite sans permis", price = 5000},
	{name = "Délit de fuite", price = 20000},
	{name = "Excès de vitesse", price = 5000},
	{name = "Vente de drogue", price = 25000},
	{name = "Possession de drogue", price = 25000},
	{name = "Tir sur civil", price = 50000},
	{name = "Tir sur agent", price = 80000},
	{name = "Outrage à agent", price = 5000},
	{name = "Braquage", price = 50000}
}
local renfortBlips = {}
local JailOption = {"10 minutes", "15 minutes", "20 minutes", "30 minutes", "Sortir"}

local SheriffVehicles = {
    [GetHashKey('policeb')] = true,
    [GetHashKey('police3')] = true,
    [GetHashKey('ghispo2')] = true, 
    [GetHashKey('insurgent2')] = true,
    [GetHashKey('riot')] = true,
    [GetHashKey('polmav')] = true,
    [GetHashKey('buzzard2')] = true
}

local BlipsData = {
    ["south"] = {
        sprite = 60,
        scale = 0.5,
        color = 52,
        display = 4,
        asShortRange = true
    }
}

function StartSheriff()
    while not ESX.PlayerData.PassJoin do
        Wait(5)
    end
    if AleardyStartedSheriff then 
        return
    end
    isSheriff = true
    AleardyStartedSheriff = true
    Citizen.CreateThread(function()
        while isSheriff do
            if SheriffStations[ESX.PlayerData.job.name] then
				for key, value in pairs(SheriffStations[ESX.PlayerData.job.name].zones) do 
					if #(ESX.PlayerData.cache.coords - value) < 10 then
						isnearSheriff = true
						nearSheriff = SheriffStations[ESX.PlayerData.job.name]
						Found = true
					end
				end
            else
                isSheriff = false
                isnearSheriff = false
                nearSheriff = nil
                break
            end
            if isnearSheriff and not AleardyStartednearSheriff then
                StartnearSheriff()
            end
            Wait(2500)
        end
        isSheriff = false
        isnearSheriff = false
        nearSheriff = nil
        AleardyStartedSheriff = false
    end)
end

function StartnearSheriff()
    if AleardyStartednearSheriff then
        return
    end
    AleardyStartednearSheriff = true
    Citizen.CreateThread(function()
        while isnearSheriff do
            if SheriffStations[ESX.PlayerData.job.name] then
				for key, value in pairs(SheriffStations[ESX.PlayerData.job.name].zones) do 
                    local draw = true
                    if key == "boss" and ESX.PlayerData.job.grade_name ~= "boss" then
                        draw = false
                    end
                    if draw then
						DrawMarker(ZiZouConfig.Marker.Markers.Marker.type, value, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ZiZouConfig.Marker.Markers.Marker.x, ZiZouConfig.Marker.Markers.Marker.y, ZiZouConfig.Marker.Markers.Marker.z, ZiZouConfig.Marker.Markers.Marker.r, ZiZouConfig.Marker.Markers.Marker.g, ZiZouConfig.Marker.Markers.Marker.b, ZiZouConfig.Marker.Markers.Marker.a, ZiZouConfig.Marker.Markers.Marker.rotate, false, 2, false, nil, nil, false)

                 --   DrawMarker(1, value, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 50, 50, 204, 200, false, true, 2, false, false, false, false)
                    end
                if #(ESX.PlayerData.cache.coords - value) < 2 and SheriffMenuOpen == "" and draw then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acceder au menu.")
                    if IsControlJustReleased(1, 38) then  
                        local success = false
						if key == "boss" and ESX.PlayerData.job.grade_name == "boss" then      
                            success = true
                            OpenBossMenu('sheriff', 1)
						elseif key == "cloakrooms" then
                            success = true
							OpenCloakroomMenuSheriff()
                        elseif key == "armory" then
                            success = true
                            OpenArmoryMenuSheriff()
                        elseif key == "cars" or key == "helicopters" then
                            OpenVehicleSpawnerSheriff(key)
						end
                        if success then
                            SheriffMenuOpen = key              
                        end
                    end
                elseif #(ESX.PlayerData.cache.coords - value) >= 2 and SheriffMenuOpen == key then
                    SheriffMenuOpen = ""
                    CloseMenu()
                end
			    end
            end
            Wait(5)
        end
        AleardyStartednearSheriff = false
    end)
end

function OpenVehicleSpawnerSheriff(type)
	SheriffVehicleMenu = {
		Base = { Title = "Garage", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "garage sheriff" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == "garage" then
				SheriffVehicleMenu.Menu["garage"].b = {}
				if type == 'cars' then
				table.insert(SheriffVehicleMenu.Menu["garage"].b, {name = 'Moto', model = 'policeb', action = "spawnveh"})
                table.insert(SheriffVehicleMenu.Menu["garage"].b, {name = 'Voiture de patrouille', model = 'police3', action = "spawnveh"})
				if ESX.PlayerData.job.grade_name ~= "recruit" then
                table.insert(SheriffVehicleMenu.Menu["garage"].b, {name = 'VIR', model = 'ghispo2', action = "spawnveh"})
				end
				if ESX.PlayerData.job.grade_name ~= "recruit" and ESX.PlayerData.job.grade_name ~= "officer" and ESX.PlayerData.job.grade_name ~= "sergeant" then
                table.insert(SheriffVehicleMenu.Menu["garage"].b, {name = 'Insurgent', model = 'insurgent2', action = "spawnveh"})
                table.insert(SheriffVehicleMenu.Menu["garage"].b, {name = 'riot', model = 'riot', action = "spawnveh"})
				end
				elseif ESX.PlayerData.job.grade_name ~= "recruit" and ESX.PlayerData.job.grade_name ~= "officer" then
				table.insert(SheriffVehicleMenu.Menu["garage"].b, {name = 'Buzzard', model = 'buzzard2', action = "spawnveh"})
				end
				OpenMenu('garage')
			elseif btn.action == "spawnveh" then
				ESX.Game.SpawnVehicle(btn.model, ESX.PlayerData.cache.coords, ESX.PlayerData.cache.heading, function(vehicle)
					local plate = 'BCSO'..math.random(100, 900)
					plate = string.gsub(plate, " ", "")
					SetVehicleNumberPlateText(vehicle, plate)
					TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, vehicle, -1)
					TriggerServerEvent("vehiclelock:preterkey", plate)
					ESX.ShowNotification('Votre véhicule a été sorti.')
					CloseMenu()
				end, "job")
			elseif btn.action == "delveh" then	
				if SheriffVehicles[GetEntityModel(ESX.PlayerData.cache.vehicle)] then
				    ESX.Game.DeleteVehicle(ESX.PlayerData.cache.vehicle)
				    ESX.ShowNotification('Le véhicule à bien été rangé.')
				    CloseMenu()
                else
                    ESX.ShowNotification('Vous ne pouvez pas ranger ce véhicule.')
				end 
			end
		end,
        onExited = function()
            SheriffMenuOpen = ""
        end
	  },
	
	  Menu = {
		["garage sheriff"] = { b = {} },
		["garage"] = { b = {} }
	 }
	}
	if ESX.PlayerData.cache.invehicle then
		table.insert(SheriffVehicleMenu.Menu["garage sheriff"].b, {name = 'Ranger le véhicule', action = 'delveh'})
	  else
		table.insert(SheriffVehicleMenu.Menu["garage sheriff"].b, {name = 'Sortir un véhicule', action = 'garage'})
	  end
	CreateMenu(SheriffVehicleMenu)
end

function OpenCloakroomMenuSheriff()
	SheriffCloakroomMenu = {
		Base = { Title = "Vestiaire", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "vestiaire" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == 'wear' then
				cleanPlayer(ESX.PlayerData.cache.playerped)
				if btn.value == 'citizen_wear' then
					TriggerServerEvent("player:serviceOff")
					TriggerEvent('caruiskinchanger:loadSkin', ESX.PlayerData.skin)
				else
					TriggerServerEvent("player:serviceOn")
					if btn.value ~= "boss_wear" then
			        setUniformSheriff(btn.value, ESX.PlayerData.cache.playerped)
					end
				end
			end
		end,
        onExited = function()
            SheriffMenuOpen = ""
        end
	  },
	
	  Menu = {
		["vestiaire"] = {
			b = {
				{ name = 'Tenue civil', action = "wear", value = 'citizen_wear' },
				{ name = 'Gilet pare-balles', action = "wear", value = 'bullet_wear' }
			}
		}
	 }
	}

	if ESX.PlayerData.job.grade_name == 'recruit' then
		table.insert(SheriffCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = 'recruit_wear'})
	elseif ESX.PlayerData.job.grade_name == 'officer' then
		table.insert(SheriffCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = 'officer_wear'})
	elseif ESX.PlayerData.job.grade_name == 'sergeant' then
		table.insert(SheriffCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = 'sergeant_wear'})
	elseif ESX.PlayerData.job.grade_name == 'lieutenant' then
		table.insert(SheriffCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = 'lieutenant_wear'})
	elseif ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(SheriffCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = "boss_wear"})
	end
	
	CreateMenu(SheriffCloakroomMenu)
end

function setUniformSheriff(job, playerPed)
	TriggerEvent('caruiskinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if SheriffUniforms[job].male ~= nil then
				TriggerEvent('caruiskinchanger:loadClothes', skin, SheriffUniforms[job].male)
			else
				ESX.ShowNotification('Il n\'y a pas d\'uniforme à votre taille...')
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			if SheriffUniforms[job].female ~= nil then
				TriggerEvent('caruiskinchanger:loadClothes', skin, SheriffUniforms[job].female)
			else
				ESX.ShowNotification('Il n\'y a pas d\'uniforme à votre taille...')
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function OpenArmoryMenuSheriff(station)
	SheriffArmoryMenu = {
		Base = { Title = "Armurerie", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "armurerie" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == 'coffre' then
				CloseMenu()
				Wait(100)
		        TriggerEvent('coffre:OpenMenu', 1)
			elseif btn.action == 'buy_weapons' then
				CloseMenu()
				Wait(100)
				OpenBuyWeaponsMenuu()
			end
		end
	  },
	
	  Menu = {
		["armurerie"] = {
			b = {
				{ name = 'Gérer ses armes', action = 'buy_weapons' },
				{ name = 'Coffre', action = 'coffre' }
			}
		}
	 }
	}
	
	CreateMenu(SheriffArmoryMenu)
end

function OpenBuyWeaponsMenuu()
	local elements = {}
	local playerPed = ESX.PlayerData.cache.playerped

	BuyWeaponsMenu = {
		Base = { Title = "Armes", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "achat armes" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.hasWeapon then ESX.ShowNotification('Vous possédez déjà cette arme !') return end
			ESX.TriggerServerCallback('sheriffjob:buyWeapon', function(bought)
				if bought then
					CloseMenu()
					Wait(100)
					OpenBuyWeaponsMenuu()
				else
					ESX.ShowNotification('Vous ne pouvez pas acheter cette arme')
				end
			end, btn.weaponname, 1)
		end
	  },
	
	  Menu = {
		["achat armes"] = {
			b = {
				
			}
		}
	 }
	}
	for k,v in ipairs(SheriffWeapons[ESX.PlayerData.job.grade_name]) do
		local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		local label = {}

		local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

		if hasWeapon then
			label = weapon.label .. ' ~r~' .. 'Acquis'
		else
			label = weapon.label
		end

		table.insert(BuyWeaponsMenu.Menu["achat armes"].b, {
			name = label,
			weaponLabel = weapon.label,
			weaponname = weapon.name,
			components = components,
			prix = v.price,
			hasWeapon = hasWeapon
		})
	end
	
	CreateMenu(BuyWeaponsMenu)
end

function OpenSheriffActionsMenu()
	SheriffMenu = {
		Base = { Title = "Sheriff", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "sheriff" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		if btn.action == "cit_interaction" then
			OpenMenu("sheriff citoyen")
			
			return
		elseif btn.action == "car_interaction" then
			local playerPed = ESX.PlayerData.cache.playerped
			local vehicle = ESX.Game.GetVehicleInDirection()
			if DoesEntityExist(vehicle) then
			  OpenMenu("sheriff vehicule")
			end
			return
		end
	
		if btn.action == "info_veh" then
			--
			return
		elseif btn.action == "openvehicle" then
			local playerPed = ESX.PlayerData.cache.playerped
			local coords = GetEntityCoords(playerPed)
			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
				local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.Wait(10000)
				ClearPedTasksImmediately(playerPed)
	
				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ESX.ShowNotification('Véhicule deverouiller.')
			end
			return
		elseif btn.action == "delvehicle" then
			local vehicle = ESX.Game.GetVehicleInDirection()
			if DoesEntityExist(vehicle) then
			  ESX.Game.DeleteVehicle(vehicle)
			end
			return
		elseif btn.action == "askrenforts" then
			OpenMenu("renforts")
			return
		  elseif btn.action == "renforts" then
			TriggerServerEvent("sheriffjob:askForHelp", btn.thetype)
			return
		  elseif btn.action == "vehicleinfos" then
			local vehicle = ESX.Game.GetVehicleInDirection()
			if DoesEntityExist(vehicle) then
				TriggerServerEvent("sheriffjob:RequestVehicleInfos", GetVehicleNumberPlateText(vehicle))
			end
			return

--[[		elseif btn.action == "camera_interact" then
			OpenMenu("camera interact")
		elseif btn.action == "camera1" then
			TriggerEvent('cctv:camera', 25) 
		elseif btn.action == "camera2" then
			TriggerEvent('cctv:camera', 26) 
		elseif btn.action == "camera3" then
			TriggerEvent('cctv:camera', 27)
		elseif btn.action == "camera4" then
			TriggerEvent('cctv:camera', 1) 
		elseif btn.action == "camera5" then
			TriggerEvent('cctv:camera', 2)
		elseif btn.action == "camera6" then
			TriggerEvent('cctv:camera', 3) 
		elseif btn.action == "camera7" then
			TriggerEvent('cctv:camera', 4) 
		elseif btn.action == "camera8" then
			TriggerEvent('cctv:camera', 5) 
		elseif btn.action == "camera9" then
			TriggerEvent('cctv:camera', 6) ]]
		end
	
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 1.0 then
	
		  if btn.action == "carteiden" then
			CloseMenu()
			Wait(10)
			OpenIdentityCardMenu(closestPlayer)
	
		  elseif btn.action == "search" then
			if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "random@mugging3", "handsup_standing_base", 3) or IsEntityDead(GetPlayerPed(closestPlayer)) then
			CloseMenu()
			StartBodySearch(GetPlayerServerId(closestPlayer))
			else
			ESX.ShowNotification("Impossible de fouiller une personne qui n'a pas les mains levées.")
			end
	
		  elseif btn.action == "handcuff" then
			local target, distance = ESX.Game.GetClosestPlayer()
			playerheading = ESX.PlayerData.cache.heading
			playerlocation = GetEntityForwardVector(ESX.PlayerData.cache.playerped)
			playerCoords = ESX.PlayerData.cache.coords
			local target_id = GetPlayerServerId(target)
			TriggerServerEvent('handcuff:on', target_id)
	
		  elseif btn.action == "unhandcuff" then
			local target, distance = ESX.Game.GetClosestPlayer()
			playerheading = ESX.PlayerData.cache.heading
			playerlocation = GetEntityForwardVector(ESX.PlayerData.cache.playerped)
			playerCoords = ESX.PlayerData.cache.coords
			local target_id = GetPlayerServerId(target)
			TriggerServerEvent('handcuff:off', target_id)
	
		  elseif btn.action == "drag" then
			TriggerServerEvent('handcuff:drag', GetPlayerServerId(closestPlayer))
	
		  elseif btn.action == "in_vehicle" then
			TriggerServerEvent('handcuff:ZiZouVehicle', GetPlayerServerId(closestPlayer))
	
		  elseif btn.action == "out_vehicle" then
			TriggerServerEvent('handcuff:OutVehicle', GetPlayerServerId(closestPlayer))
	
		  elseif btn.action == "facture" then
			SheriffMenu.Menu["amendes"].b = {{name = "Amende Personalisée", action = "customfinecitizen", ask = "→", askX = true}}
			for k, v in ipairs(SheriffFines) do
				table.insert(SheriffMenu.Menu["amendes"].b, {name = v.name, action = "finecitizen", fineprice = v.price, ask = "→", askX = true})
			end
			OpenMenu("amendes")
	
		  elseif btn.action == "finecitizen" then
			TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'sheriff', 'Amende: '..btn.name..'', btn.fineprice, true)
			ESX.ShowNotification("Amende envoyé avec succès.")
			CloseMenu()
		  elseif btn.action == "customfinecitizen" then
			local name = KeyboardInput("sheriff_FINENAME", "Raison de l'amende", "", 9)
					if name and name ~= "" then
						local amount = KeyboardInput("sheriff_FINEPRICE", "Somme de l'amende", "", 6)
						if amount and tonumber(amount) then
							TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'sheriff', 'Amende: '..name..'', tonumber(amount), true)
							ESX.ShowNotification("Amende envoyée avec succès.")
						else
							ESX.ShowNotification("Veuillez entrer une somme valide pour l'amende.")
						end
					else
						ESX.ShowNotification("Veuillez entrer une raison pour l'amende.")
					end
					CloseMenu()

		  elseif btn.action == "openmen" then
			OpenMenu("sheriff menotte")
		  elseif btn.action == "menuprison" then
			OpenMenu("prisons")
		  elseif btn.action == "prison" then
		if btn.station ~= "out" then
			local amount = KeyboardInput("sheriff_DURATIONJAIL", "Temps en prison (minutes)", "", 2)
			if tonumber(amount) and tonumber(amount) <= 20  then
				TriggerServerEvent("sheriffjob:jailPlayer", GetPlayerServerId(closestPlayer), btn.station, tonumber(amount))
			end
		else
			TriggerServerEvent("sheriffjob:jailPlayer", GetPlayerServerId(closestPlayer), "out", 0)
		end
		  end
		else
			ESX.ShowNotification("Personne à proximité.")
		end
	
		end
	  },
	
	  Menu = {
		["sheriff"] = {
			b = {
			  {name = "Citoyen", action = "cit_interaction", ask = "→", askX = true},
			  {name = "Vehicule", action = "car_interaction", ask = "→", askX = true},
			  {name = "Demande de renforts", action = "askrenforts", ask = "→", askX = true},
			--  {name = "Caméra de la ville", action = "camera_interact", ask = "→", askX = true},
			  {name = "Poser/Ranger Radar (Bientôt)", action = "radar", ask = "→", askX = true},
			}
		  },
		["sheriff citoyen"] = {
		  b = {
			{name = "Carte d'identité", action = "carteiden", ask = "→", askX = true},
			{name = "Menu menottes", action = "openmen", ask = "→", askX = true},
			{name = "Mettre une amende", action = "facture", ask = "→", askX = true},
			{name = "Mettre en prison", action = "menuprison", ask = "→", askX = true}
		  }
		},
--[[		["camera interact"] = {
			b = {
			  {name = "Caméra 1 (Ballas)", action = "camera1", ask = "→", askX = true},
			  {name = "Caméra 2 (Families)", action = "camera2", ask = "→", askX = true},
			  {name = "Caméra 3 (Vagos)", action = "camera3", ask = "→", askX = true},
			  {name = "Caméra 4 (Superette Unicorn)", action = "camera4", ask = "→", askX = true},
			  {name = "Caméra 5 (Superette Ballas)", action = "camera5", ask = "→", askX = true},
			  {name = "Caméra 6 (Superette BurgerShot)", action = "camera7", ask = "→", askX = true},
			  {name = "Caméra 7 (Superette Taxi)", action = "camera8", ask = "→", askX = true},
			  {name = "Caméra 8 (Superette Vinewood)", action = "camera9", ask = "→", askX = true}
			}
		  },]]
		["amendes"] = {
			b = {	
		  }
		},
		["sheriff menotte"] = {
			b = {
			  {name = "Fouiller", action = "search", ask = "→", askX = true},
			  {name = "Menotter", action = "handcuff", ask = "→", askX = true},
			  {name = "Demenotter", action = "unhandcuff", ask = "→", askX = true},
			  {name = "Escorter", action = "drag", ask = "→", askX = true},
			  {name = "Mettre dans véhicule", action = "in_vehicle", ask = "→", askX = true},
			  {name = "Sortir du véhicule", action = "out_vehicle", ask = "→", askX = true}
			}
		},
		["sheriff vehicule"] = {
		 b = {
		  {name = "Ouvrir le véhicule", action = "openvehicle", ask = "→", askX = true},
		  {name = "Informations sur le véhicule", action = "vehicleinfos", ask = "→", askX = true},
		  {name = "Mettre le véhicule en fourrière", action = "delvehicle", ask = "→", askX = true}
		 }
		},
		["renforts"] = {
			b = {
			 {name = "Légère", action = "renforts", thetype = "lite", ask = "→", askX = true},
			 {name = "Moyenne", action = "renforts", thetype = "normal", ask = "→", askX = true},
			 {name = "Forte", action = "renforts", thetype = "high", ask = "→", askX = true}
			}
		},
		["prisons"] = {
			b = {
			 {name = "Station 1", action = "prison", station = "sheriffstation1", ask = "→", askX = true},
			 {name = "Station 2", action = "prison", station = "sheriffstation2", ask = "→", askX = true},
			 {name = "Station 3", action = "prison", station = "sheriffstation3", ask = "→", askX = true},
			 {name = "Fédérale", action = "prison", station = "federal", ask = "→", askX = true},
			 {name = "Sortir de prison", action = "prison", station = "out", ask = "→", askX = true}
			}
		}
	 }
	}
	
	CreateMenu(SheriffMenu)
	end

	RegisterNetEvent("sheriffjob:receiveHelpBlip")
	AddEventHandler("sheriffjob:receiveHelpBlip", function(blipid, coords, name, _thetype)
		if not renfortBlips[blipid] then
			local color = 3
			if _thetype == "normal" then
				color = 33
			elseif _thetype == "high" then
				color = 1
			end
		local blip = AddBlipForCoord(coords.x, coords.y, 1000.0)
		SetBlipSprite(blip , 161)
		SetBlipScale(blip , 2.0)
		SetBlipColour(blip, color)
		PulseBlip(blip)
		local blip2 = AddBlipForCoord(coords.x, coords.y, 1000.0)
		SetBlipSprite(blip2 , 685)
		SetBlipScale(blip2 , 1.0)
		SetBlipColour(blip2, color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(name)
		EndTextCommandSetBlipName(blip2)
		renfortBlips[blipid] = {blip, blip2}
		end
	end)

	RegisterNetEvent("sheriffjob:removeHelpBlip")
	AddEventHandler("sheriffjob:removeHelpBlip", function(blipid)
		if renfortBlips[blipid] then
			for k, v in pairs(renfortBlips[blipid]) do
				RemoveBlip(v)
			end
		renfortBlips[blipid] = nil
		end
	end)

	function OpenIdentityCardMenu(player)
		ESX.TriggerServerCallback('sheriffjob:getOtherPlayerData', function(data)
		
				local elements    = {}
				local nameLabel   = ('Nom: %s'):format(data.name)
				local jobLabel    = nil
				local sexLabel    = nil
				local dobLabel    = nil
				local heightLabel = nil
			
				if data.grade ~= nil and  data.grade ~= '' then
					jobLabel = ('Métier: %s'):format(data.job .. ' - ' .. data.grade)
				else
					jobLabel = ('Métier: %s'):format(data.job)
				end
					nameLabel = ('Nom: %s'):format(data.firstname .. ' ' .. data.lastname)
			
					if data.sex ~= nil then
						if string.lower(data.sex) == 'm' then
							sexLabel = "Sexe: Homme"
						else
							sexLabel = "Sexe: Femme"
						end
					else
						sexLabel = "Sexe: Inconnu"
					end
			
					if data.dob ~= nil then
						dobLabel = ('DOB: %s'):format(data.dob)
					else
						dobLabel = "DOB: Inconnu"
					end
			
					if data.height ~= nil then
						heightLabel = ('Taille: %s'):format(data.height)
					else
						heightLabel = 'Taille: Inconnu'
					end
		
		
				CitizenIDMenu = {
					Base = { Title = "Identité", HeaderColor = {169, 187, 232} },
					Data = { currentMenu = "identite" },
				
					Events = {
					onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
					end
				  },
				
				  Menu = {
					["identite"] = {
						b = {
							{name = nameLabel, value = nil},
							{name = jobLabel,  value = nil},
							{name = sexLabel, value = nil},
							{name = dobLabel, value = nil},
							{name = heightLabel, value = nil}
						}
					}
				 }
				}
				
				CreateMenu(CitizenIDMenu)
			
			end, GetPlayerServerId(player))
		end
		
