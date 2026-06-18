local AlreadyStartGouv = false

local Zones = {
    GouvActions = {
        Pos   = vector3(-544.48, -199.28, 46.55),
          Type  = 1,
          Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu." 
    },
    Armory = {
        Pos   = vector3(-572.38, -202.62, 41.7),
          Type  = 1,
          Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu." 
    },
    VehicleSpawner = {
        Pos   = vector3(-513.12, -262.75, 34.43),
          Type  = 1,
          Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu." 
    },
    VehicleDeleter = {
        Pos   = vector3(-523.73, -267.35, 34.3),
          Type  = 1,
          Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu." 
    },
    HelicopterSpawner = {
        Pos   = vector3(-549.85, -242.95, 35.82),
          Type  = 1,
          Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu." 
    },
    HelicopterDeleter = {
        Pos   = vector3(-542.35, -251.64, 36.58),
          Type  = 1,
          Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu." 
    }
}

function OpenGouvMenu()
    GouvMenu = {
        Base = { Title = "Gouvernement", HeaderColor = {255, 255,255}},
        Data = { currentMenu = "gouvernement"},

        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
              if btn.action == "personne" then
                OpenMenu("interaction sur personne")
              end
            end
        },
        Menu = {
            ["gouvernement"] = {
                b = {
                    {name = "Intéractions sur personne", action = "personne", ask = "→", askX = true},
                    {name = "Intéractions sur véhicule", action = "vehicle", ask = "→", askX = true}
                }
            },
            ["interaction sur personne"] = {
              b = {
                {name = "Fouiller", action = "fouiller", ask = "→", askX = true},
                {name = "Menotter/démenotter", action = "togglecuff", ask = "→", askX = true},
                {name = "Escorter", action = "putemdr", ask = "→", askX = true},
                {name = "Mettre dans un véhicule", action = "mettreveh", ask = "→", askX = true},
                {name = "Sortir du véhicule", action = "mettreveh", ask = "→", askX = true}
              }
            }
        }
    }

    CreateMenu(GouvMenu)
end

function OpenGouvActionsMenu()
    GouvActionsMenu = {
        Base = { Title = "Gouvernement", HeaderColor = {255, 255, 255}},
        Data = { currentMenu = "gouvernement"},

        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                if btn.action == 'announce' then
                  local msg = KeyboardInput('GOUV_ANNOUNCE', "Message de l'annonce", "", 50)
                  if msg and msg ~= "" then
                      TriggerServerEvent('gouv:announce', msg)
                  else
                      -- Si le message est vide, tu peux aussi afficher un avertissement à l'utilisateur, par exemple :
                      ESX.ShowNotification("Veuillez entrer un message avant d'envoyer l'annonce.")
                  end                  
                elseif btn.action == 'service' then
                    OpenMenu("service")
                elseif btn.action == "bossmenu" then
                    CloseMenu()
                    OpenBossMenu("gouv", 1)
                elseif btn.action == 'serviceon' then
                    TriggerServerEvent('player:serviceOn')
                elseif btn.action == 'serviceoff' then
                    TriggerServerEvent('player:serviceOff')
                end
            end
        },

        Menu = {
            ["gouvernement"] = {
                b = {
                    {name = "Menu Service", action = "service", ask = "→", askX = true}
                }
            },
            ["service"] = {
                b = {
                  {name = "Se mettre en service", action = "serviceon", ask = "→", askX = true},
                  {name = "Ne plus être en service", action = "serviceoff", ask = "→", askX = true},
                }
              },
        }
    }

    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == "boss" then
        table.insert(GouvActionsMenu.Menu["gouvernement"].b, {name = "Menu Gouverneur", action = "bossmenu", ask = "→", askX = true})
    end

    if ESX.PlayerData.job ~= nil then
        if ESX.PlayerData.job.grade_name == "boss" or ESX.PlayerData.job.grade_name == "prime" then
        table.insert(GouvActionsMenu.Menu["gouvernement"].b, {name = "Faire une annonce", action = "announce", ask = "→", askX = true})
        end
    end

    CreateMenu(GouvActionsMenu)
end

RegisterNetEvent('gouv:announce')
AddEventHandler('gouv:announce', function(message)
    SetAudioFlag("LoadMPData", 1)
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
    ESX.Scaleform.ShowFreemodeMessage("~y~Gouvernement", message, 3)
end)

function StartGouvJob()
    if AlreadyStartGouv then
      return
    end
    AlreadyStartGouv = true
    Citizen.CreateThread(function()
    while ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "gouv" do
      Citizen.Wait(5)
  
      local pedCoords = ESX.PlayerData.cache.coords
      local isInMarkerGouv = false
      local letSleepGouv = true
  
      for k,v in pairs(Zones) do
        if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 15) and v.Type ~= -1 then
          letSleepGouv = false
          DrawMarker(1, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
        end
        if (GetDistanceBetweenCoords(pedCoords, v.Pos, true) < 2) then
            isInMarkerGouv = true
            AlreadyMarkerGouv = true
            if DataActionGouv == nil then
              if v.Text then
              ESX.ShowHelpNotification(v.Text)
              end
            end
    
            if (IsControlJustReleased(1, 38)) and DataActionGouv == nil then
              if k == "GouvActions" then
                DataActionGouv = k
                OpenGouvActionsMenu()
              elseif k == "Armory" then
                OpenCoffreMenu(1)
              elseif k == "VehicleSpawner" then
                if not IsPedInAnyVehicle(playerPed, false) then
                OpenVehicleSpawnerMenuGouv()  
                else 
                  CloseMenu()
              end
              elseif k == "VehicleDeleter" then
                local playerPed = ESX.PlayerData.cache.playerped
                local coords = GetEntityCoords(playerPed)
                if IsPedInAnyVehicle(playerPed,  false) then
                  local vehicle, distance = ESX.Game.GetClosestVehicle({
                    x = coords.x,
                    y = coords.y,
                    z = coords.z
                  })
    
                  if distance ~= -1 and distance <= 1.0 then
                    ESX.Game.DeleteVehicle(vehicle)
                  end
                end
              end
              end
        end
      end


    if not isInMarkerGouv and AlreadyMarkerGouv then
      AlreadyMarkerGouv = false
      if DataActionGouv ~= nil and DataActionGouv == "GouvActions" then
        DataActionGouv = nil
        CloseMenu()
      end
    end

    if letSleepGouv then
      Citizen.Wait(2500)
    end
    end
    AlreadyStartGouv = false
    end)
end

function OpenVehicleSpawnerMenuGouv()
	local playerCoords = ESX.PlayerData.cache.coords
	local playerPed = ESX.PlayerData.cache.playerped

	GouvVehicleMenu = {
		Base = { Title = "Garage", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "garage gouv" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == "spawnveh" then

        ESX.Game.SpawnVehicle(btn.model, {
          x = Zones.VehicleSpawner.Pos.x,
          y = Zones.VehicleSpawner.Pos.y,
          z = Zones.VehicleSpawner.Pos.z
        }, 261.10, function(vehicle)
          local plate = 'GOUV'..math.random(100, 900)
					plate = string.gsub(plate, " ", "")
					SetVehicleNumberPlateText(vehicle, plate)
					local playerPed = ESX.PlayerData.cache.playerped
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					TriggerServerEvent("vehiclelock:preterkey", plate)
					ESX.ShowNotification('Votre véhicule a été sorti.')
					CloseMenu()

        end, "job")
			elseif btn.action == "delveh" then
				local playerPed = ESX.PlayerData.cache.playerped
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local hash = GetEntityModel(vehicle)  
				local truck = Vehicles
				local found = false
	
				for i=1, #truck, 1 do
				if hash == GetHashKey(truck[i]) then
				ESX.Game.DeleteVehicle(vehicle)
				TriggerEvent('esx:showNotification', 'Le véhicule à bien été rangé.')
				found = true
				CloseMenu()
				end
				end 
	
			   if not found then
			   TriggerEvent('esx:showNotification', 'Vous ne pouvez pas ranger ce véhicule.')
			   end
			end
		end
	  },
	
	  Menu = {
		["garage gouv"] = {
			b = {

			}
		}
	 }
	}

	if not IsPedInAnyVehicle(playerPed, false) then
		table.insert(GouvVehicleMenu.Menu["garage gouv"].b, {name = 'Moto', model = 'policeb', action = "spawnveh"})
                table.insert(GouvVehicleMenu.Menu["garage gouv"].b, {name = 'Voiture de patrouille', model = 'police3', action = "spawnveh"})
                table.insert(GouvVehicleMenu.Menu["garage gouv"].b, {name = 'VIR', model = 'ghispo2', action = "spawnveh"})
                table.insert(GouvVehicleMenu.Menu["garage gouv"].b, {name = 'Insurgent', model = 'insurgent2', action = "spawnveh"})
                table.insert(GouvVehicleMenu.Menu["garage gouv"].b, {name = 'riot', model = 'riot', action = "spawnveh"})
	  end
	
	CreateMenu(GouvVehicleMenu)

end

