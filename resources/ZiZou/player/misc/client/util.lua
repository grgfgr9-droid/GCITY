local mp_pointing = false
local keyPressed = false
local bmx = false
local GUI = {}
GUI.Time = 0
InService = false
AntiSpamJobs = false

PassJoin = false

RegisterNetEvent("esx:passjoin")
AddEventHandler("esx:passjoin", function()
	PassJoin = true
  ESX.PlayerData.PassJoin = true
  ESX.PlayerLoaded = true
end)

function pocketBMX()
    if not bmx then
    ESX.Game.SpawnVehicle("bmx", ESX.PlayerData.cache.coords, ESX.PlayerData.cache.heading, function(vehicle)
        local playerPed = ESX.PlayerData.cache.playerped
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        bmx = true
        ESX.ShowNotification("BMX Sorti.")
    end, "bmx")
    else
        local playerPed = ESX.PlayerData.cache.playerped
        local coords = GetEntityCoords(playerPed)
        local vehicle = GetClosestVehicle(coords, 2.0, 0, 71)
 if vehicle then
  local carModel = GetEntityModel(vehicle)
  if carModel == 1131912276 then
    bmx = false 
    ESX.Game.DeleteVehicle(vehicle)
    ESX.ShowNotification("BMX Rangé.")
  else
    ESX.ShowNotification("Aucun bmx à proximité.")
  end
end
    end
end

RegisterCommand("syncweapon", function()
  TriggerEvent("esx:restoreLoadout")
end)

Citizen.CreateThread(function()
    RequestAnimDict("amb@world_human_hang_out_street@female_arms_crossed@base")
    RequestAnimDict("random@mugging3")
end)

RegisterCommand("+jobmenu", function()
    if not ESX.PlayerData.IsDead then
     if ESX.PlayerData.job.name == "police" then
       OpenPoliceActionsMenu()
      elseif ESX.PlayerData.job.name == "sheriff" then
        OpenSheriffActionsMenu()
     elseif ESX.PlayerData.job.name == "ambulance" then
       OpenAmbulanceMenu()
     elseif ESX.PlayerData.job.name == "kintaki" then
       OpenKFCMenu()
     elseif CheckIsMechanic(ESX.PlayerData.job.name) then
        OpenMechanicsMenu()
     elseif ESX.PlayerData.job.name == "gouv" and InService then
        OpenGouvMenu()

    end
  end
   end, false)
   
   RegisterKeyMapping("+jobmenu", "Menu metier", "keyboard", "f6")


RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)

if CheckIsMechanic(playerData.job.name) then
    StartMechanics()
elseif CheckIsPolice(playerData.job.name) then
    StartPolice()
elseif CheckisSheriff(playerData.job.name) then
    StartSheriff()
elseif playerData.job.name == "tabac" then
    StartTabacJob()
elseif playerData.job.name == "vigneron" then
    StartVigneronJob()
elseif playerData.job.name == "joal" then
    StartJoalJob()
elseif playerData.job.name == "gouv" then
    StartGouvJob()
end

    if playerData.job2.name ~= "unemployed2" then
        StartGangSystem()
    end

end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    if CheckIsMechanic(job.name) then
        StartMechanics()
    elseif CheckIsPolice(job.name) then
        StartPolice()
    elseif CheckisSheriff(job.name) then
        StartSheriff()
    elseif job.name == "tabac" then
        StartTabacJob()
    elseif job.name == "unicorn" then
        StartUnicornJob()
    elseif job.name == "vigneron" then
        StartVigneronJob()
    elseif job.name == "joal" then
        StartJoalJob()
    elseif job.name == "gouv" then
        StartGouvJob()
      end
end)

RegisterNetEvent("esx:setJob2")
AddEventHandler("esx:setJob2", function(job2)
    if job2.name ~= "unemployed2" then
        StartGangSystem()
    end
end)

RegisterNetEvent("esx:UpdateService")
AddEventHandler("esx:UpdateService", function(value)

CloseMenu()
InService = value
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
  local result = nil

  -- Vérifier si showDialog est bien exportée par ZiZouDialog
  if exports.ZiZouDialog and exports.ZiZouDialog.showDialog then
      -- Utiliser la fonction showDialog exportée
      exports.ZiZouDialog:showDialog(entryTitle, textEntry, inputText, nil, 
          function(submittedInput)
              result = submittedInput -- Récupérer le texte soumis
          end, 
          function()
              result = nil -- Annulation
          end, 
          false
      )

      -- Attendre jusqu'à ce que l'utilisateur soumette ou annule
      while result == nil do
        SetNuiFocus(false, false)
          Citizen.Wait(100)
      end
  else

      result = nil
  end

  return result
end


function StartBodySearch(playerid)
  FouillerMenu = {}
  PlayerFouille = playerid
  FouillerMenu = {
    Base = { Title = "Fouiller", HeaderColor = {51, 51, 51} },
    Data = { currentMenu = "menu fouille" },
  
    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
        if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "sheriff" then
        if btn.action == "black_money" then
          TriggerServerEvent("handcuff:confiscatePlayerItem", PlayerFouille, "item_account", "black_money", btn.amountmoney)
        elseif btn.action == "weapon" then
          TriggerServerEvent("handcuff:confiscatePlayerItem", PlayerFouille, "item_weapon", btn.weaponname, 1)
        elseif btn.action == "item" then
          TriggerServerEvent("handcuff:confiscatePlayerItem", PlayerFouille, "item_standard", btn.itemname, btn.itemamount)
        end
        end
    end
    },
  
  }
  
  FouillerMenu.Menu = {}
  FouillerMenu.Menu["menu fouille"] = {}
  FouillerMenu.Menu["menu fouille"].b = {}
  
  ESX.TriggerServerCallback("esx:getOtherPlayerData", function(data)
    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == "black_money" and data.accounts[i].money > 0 then
        table.insert(FouillerMenu.Menu["menu fouille"].b, {name = "Argent sale: "..data.accounts[i].money.."$", amountmoney = data.accounts[i].money, action = "black_money", ask = "→", askX = true})
      end
    end
  
    for i=1, #data.loadout, 1 do
      table.insert(FouillerMenu.Menu["menu fouille"].b, {name = data.loadout[i].label, weaponname = data.loadout[i].name, action = "weapon", ask = "→", askX = true})
    end
  
    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(FouillerMenu.Menu["menu fouille"].b, {name = data.inventory[i].count.."x "..data.inventory[i].label, itemname = data.inventory[i].name, itemamount = data.inventory[i].count, action = "item", ask = "→", askX = true})
      end
    end
  
    CreateMenu(FouillerMenu)
  
  end, PlayerFouille)
  
  end