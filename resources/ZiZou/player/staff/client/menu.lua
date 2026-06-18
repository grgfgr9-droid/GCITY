RegisterNetEvent("admin:requestSpectate")
RegisterNetEvent("admin:FreezePlayer")
RegisterNetEvent("admin:GoToPlayerCli")
RegisterNetEvent("admin:GoToPlayerCli2")
RegisterNetEvent("admin:SetPlayer")
RegisterNetEvent("admin:delVeh")

local DebugColor = 0
InServiceAdmin = false
staffsCount = 0
boolHud = false

local ininstancejailfdp = false
local invisibleMode = false

local gamerTags = {}
local gamerTagsColor = {}

local IDActive = false
local BARINFO = false
local noclipse = false
local DelGunVeh = false
local gunstafffdp = true

local BanOption = {"1 jours", "2 jours", "3 jours", "1 semaine", "Permanent"}
local JailOption = {"10 minutes", "30 minutes", "1 heure", "1 jour", "1 semaine", "Unjail"}
local annonceOption = {"Petite", "Grande", "UI", "50 METRES"}

local eventoptionzizouledevelopeurdezizouleak = {"Marker Rouge"}



local annoncejobOption = {"Légal", "Illégal"}
local FreezeOption = {"Freeze le joueur", "Defreeze le joueur"}
local MoneyGiveOption = {"Liquide", "Argent sale"}
local ItemGiveOption = {"Item", "Arme"}
local TeleportOption = {"Ma position", "Bring back", "Parking Central"}
local SearchOption = {"UUID", "ID"}
local SearchOption2 = {"Joueur", "Staff"}
local SelectedPlayer = {}
local SelectedReport = {}

local NoClip = {
    Camera = nil,
    Speed = 1.0
}

OnlinePlayers = {}

local AntiSpamReport = false

function ToggleMenu(type) 
	if InServiceAdmin then
        if type == 'staff' and ESX.PlayerData.group and ESX.PlayerData.group ~= "user" then
			openAdminMenu()
        elseif type == 'report' and ESX.PlayerData.group and ESX.PlayerData.group ~= "user" then
			openAdminReportMenu()
        end
	  else
		openAdminServiceMenu(type)
	  end
end

RegisterCommand("+noclip", function()
	if ESX.PlayerData.group and ESX.PlayerData.group ~= "user" then
		admin_no_clip()
	end
end, false)

RegisterCommand("+adminmenu", function()
	if ESX.PlayerData.group and ESX.PlayerData.group ~= "user" then
	ToggleMenu('staff')
	end
end, false)

RegisterKeyMapping("+adminmenu", "Menu Staff", "keyboard", "f10")
RegisterKeyMapping("+noclip", "Activer / désactiver Noclip", "keyboard", "f2")


RegisterNetEvent("admin:receivemessage")
AddEventHandler("admin:receivemessage", function(msg)
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	local head = RegisterPedheadshot(ESX.PlayerData.cache.playerped)
	while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
		Wait(1)
	end
	headshot = GetPedheadshotTxdString(head)
	ESX.ShowAdvancedNotification('Message du Staff', '~r~Informations', '~r~Raison ~w~: ' ..msg, headshot, 3)
end)



function TenueStaffLeSang()
    local model = GetEntityModel(PlayerPedId())
    local group = ESX.GetPlayerData().group
    local sex = "male"
    if model == `mp_f_freemode_01` then
        sex = "female"
    end

    local clothesSkin = {}

    if sex == "male" then
        if ZiZouConfig.MenuStaff.TenueStaff.male[group] then
            clothesSkin = ZiZouConfig.MenuStaff.TenueStaff.male[group]
        end
    elseif sex == "female" then
        if ZiZouConfig.MenuStaff.TenueStaff.female[group] then
            clothesSkin = ZiZouConfig.MenuStaff.TenueStaff.female[group]
        end
    end

    TriggerEvent('caruiskinchanger:getSkin', function(skin)
        TriggerEvent('caruiskinchanger:loadClothes', skin, clothesSkin)
    end)
end

function openAdminServiceMenu(menu)
	AdminService = {
    Base = { Title = "staff", HeaderColor = {255, 0, 0} },
    Data = { currentMenu = "menu staff" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "service" then
        TriggerServerEvent("admin:Service", true)
		InServiceAdmin = true
		staffsCount = staffsCount + 1
		CloseMenu()
		ShowNames()
		delGunStaffActive = true
		TriggerEvent('nui:serviceon')
		 GiveWeaponToPed(PlayerPedId(), "weapon_snspistol_mk2", 255, false, true)
		 GiveWeaponComponentToPed(PlayerPedId(), "weapon_snspistol_mk2", "COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE")
		 GiveWeaponComponentToPed(PlayerPedId(), "weapon_snspistol_mk2", "COMPONENT_AT_PI_SUPP_02")
		 GiveWeaponComponentToPed(PlayerPedId(), "weapon_snspistol_mk2", "COMPONENT_SNSPISTOL_MK2_CLIP_02")
		 GiveWeaponComponentToPed(PlayerPedId(), "weapon_snspistol_mk2", "COMPONENT_AT_PI_RAIL_02")
		 GiveWeaponComponentToPed(PlayerPedId(), "weapon_snspistol_mk2", "COMPONENT_AT_PI_FLSH_03")
		 SetPedInfiniteAmmo(PlayerPedId(), true, "weapon_snspistol_mk2")
		 boolStaffGun()

	Citizen.CreateThread(function()
			while InServiceAdmin do
				Citizen.Wait(5000)
				OnlinePlayers = GetOnlinePlayers()
			end
		end)
		TenueStaffLeSang()
		if menu == 'staff' then
		openAdminMenu()
		elseif menu == 'report' then
		openAdminReportMenu()
		end
      end
    end
  },

Menu = {
    ["menu staff"] = {
      b = {
        {name = "Mode Staff", action = "service", checkbox = InServiceAdmin},
      }
    },
}

}

CreateMenu(AdminService)
end



function SetPlayerInvisible(state)
    local playerPed = PlayerPedId()

    if state then
        SetEntityVisible(playerPed, false, false) 
    else
        SetEntityVisible(playerPed, true, true) 
    end

    TriggerServerEvent("admin:SetPlayerInvisible", state) 
end


RegisterNetEvent("admin:ApplyInvisibleMode")
AddEventHandler("admin:ApplyInvisibleMode", function(state)
end)


function openAdminMenu()
AdminMenu = {}

AdminMenu = {
    Base = { Title = "Staff", HeaderColor = {255, 0, 0} },
    Data = { currentMenu = "menu staff" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)

		if btn.action == "playerslist" then
			AdminMenu.Menu["liste joueurs"].b = {
				{name = "Rechercher un joueur", action = "searchplayer", idplayer = 0, slidemax = SearchOption},
				{name = "Trier par", action = "searchplayer2", idplayer = 0, slidemax = SearchOption2}
			}
			ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
				for k,v in pairs(playerlist) do

					if v.invisible == false then
					if v.name then
						table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.name, idplayer = v.id, action = "actionplayer"})
					elseif v.name == nil then
						table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.addoncolor .. "["..v.id .. " | " .. v.uuid .."] ".."Unknown".."", idplayer = v.id, action = "actionplayer"})
					end
				end
			end
				OpenMenu("liste joueurs")
			end)
		  elseif btn.action == "stafflist" then
			AdminMenu.Menu["liste joueurs"].b = {{name = "Rechercher un joueur", action = "searchplayer", idplayer = 0, slidemax = SearchOption}}
			ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
				for k,v in pairs(playerlist) do
					if v.group ~= "user" then
						if v.name then
							table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.name, idplayer = v.id, action = "actionplayer"})
						elseif v.name == nil then
							table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.addoncolor .. "["..v.id .. " | " .. v.uuid .."] ".."Unknown".."", idplayer = v.id, action = "actionplayer"})
						end
					end
				end
				OpenMenu("liste joueurs")
			end)
	  elseif btn.action == "staffaction" then
		CloseMenu()
		OpenAdminPersonalMenu()

	elseif btn.action == "surveillancebyzizoulekhobendejolesangdelaveinequitue" then
		local uuidInput = KeyboardInput('ZiZou_RECHERCHE_SYS', "Entrez l'uuid du joueur à mettre en surveillance", '', 20)
	
		if uuidInput then
			raisonInput = KeyboardInput('ZiZou_RECHERCHE_SYS', "Entrez la raison de la surveillance", '', 20)
			
			if raisonInput and raisonInput ~= "" then
				ExecuteCommand("surveillance " .. uuidInput .. " " .. raisonInput)
			else
				print("Erreur : la raison de la surveillance est requise.")
			end
		else
			print("Erreur : L'UUID doit être composé de 3 lettres suivies de 3 chiffres.")
		end

	

	elseif btn.action == "searchplayer" then


		if btn.slidenum == 1 then
			local msg = KeyboardInput("ADMIN_FILTER", "UUID du joueur", "", 8)
			if not msg or msg == "" then return end
			msg = string.lower(msg) 
		
			AdminMenu.Menu["liste joueurs"].b = {}
			ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
				for _, v in pairs(playerlist) do
					local uuidLower = string.lower(v.uuid) 
					if tonumber(msg) and tonumber(v.id) == tonumber(msg) then
						
						table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.name, idplayer = v.id, action = "actionplayer"})
					elseif string.find(uuidLower, msg, 1, true) then
						
						table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.name, idplayer = v.id, action = "actionplayer"})
					end
				end
				OpenMenu("liste joueurs")
			end)
		


		   elseif btn.slidenum == 2 then
			local msg = KeyboardInput("ADMIN_FILTER", "ID du joueur", "", 8)
			if not msg then return end
			if tonumber(msg) then
			  AdminMenu.Menu["liste joueurs"].b = {}
			 ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
			  for k,v in pairs(playerlist) do
			   if tonumber(v.id) == tonumber(msg) then
				table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.name, idplayer = v.id, action = "actionplayer"})
			end
			  end
			  OpenMenu("liste joueurs")
			 end)
			else 
			AdminMenu.Menu["liste joueurs"].b = {}
			 ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
			  for k,v in pairs(playerlist) do
			   if v.uuid == msg then
				table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.name, idplayer = v.id, action = "actionplayer"})
			end
			  end
			  OpenMenu("liste joueurs")
			 end)
			end
		   end
		   
		elseif btn.action == "searchplayer2" then
			AdminMenu.Menu["liste joueurs"].b = {}
			ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
				for _, v in pairs(playerlist) do
					if btn.slidenum == 1 and v.group == "user" then
						table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.name, idplayer = v.id, action = "actionplayer"})
					elseif btn.slidenum == 2 and v.group ~= "user" then
						table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.name, idplayer = v.id, action = "actionplayer"})
					end
				end
				OpenMenu("liste joueurs")
			end)

	  elseif btn.action == "actionplayer" then
		SelectedPlayer = btn.idplayer
		AdminMenu.Menu["joueur"].b[1] = {name = btn.name, action = "null"}
		OpenMenu("joueur")

	  elseif btn.action == "message" then
		local msg = KeyboardInput("ADMIN_MSG", "Votre message ?", "", 100)
        if msg ~= nil then
        TriggerServerEvent("admin:SendMessageToPlayer", tonumber(SelectedPlayer), msg)
		end

	elseif btn.action == "revive" then
		if SelectedPlayer then
			ExecuteCommand("revive " .. tonumber(SelectedPlayer))
		else
			ESX.ShowNotification("~r~Aucun joueur sélectionné !")
		end
	
	  elseif btn.action == "playertome" then
        TriggerServerEvent("admin:TeleportPlayerToMe", tonumber(SelectedPlayer), ESX.PlayerData.cache.coords)

	elseif btn.action == "gotoplayer" then
		if not noclipse then 
			admin_no_clip() 
		end
		TriggerServerEvent("admin:GoToPlayer", tonumber(SelectedPlayer))
	
	

	  elseif btn.action == "freeze" then
		if btn.slidenum == 1 then
		 TriggerServerEvent("admin:freeze", tonumber(SelectedPlayer), true)
		elseif btn.slidenum == 2 then
		 TriggerServerEvent("admin:freeze", tonumber(SelectedPlayer), false)
		end

	  elseif btn.action == "ban" then
		local msg = KeyboardInput("ADMIN_BAN", "Raison du ban ?", "", 100)
        if msg ~= nil then
		  if btn.slidenum == 1 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 1)
		  elseif btn.slidenum == 2 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 2)
		  elseif btn.slidenum == 3 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 3)
		  elseif btn.slidenum == 4 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 7)
		  elseif btn.slidenum == 5 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 0)
		  end
		end

	  elseif btn.action == "kick" then
		local msg = KeyboardInput("ADMIN_KICK", "Raison du kick ?", "", 100)
        if msg ~= nil then
		TriggerServerEvent("admin:kick", tonumber(SelectedPlayer), msg)
		end

	elseif btn.action == "supprveh" then
		local msg = KeyboardInput("ADMIN_KICK", "Etes-vous sûr de cette action ?", "", 100)
		
		
		if msg ~= nil and msg:lower() == "oui" then  
			RemoveAllVehicles()
			
			ESX.ShowNotification("Tous les véhicules ont été supprimés avec succès.")
		else
			
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "supprpropss" then
		local msg = KeyboardInput("ADMIN_KICK", "Etes-vous sûr de cette action ?", "", 100)
		
		
		if msg ~= nil and msg:lower() == "oui" then  
			RemoveAllProps()
			
			ESX.ShowNotification("Tous les props ont été supprimés avec succès.")
		else
			
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "deleteAllPeds" then
		TriggerServerEvent("admin:deleteAllPeds")

	elseif btn.action == "deleteAllProps" then
		TriggerServerEvent("admin:deleteAllProps")

	elseif btn.action == "deleteAllEntities" then
		TriggerServerEvent("admin:deleteAllEntities")

	elseif btn.action == "deleteAllVehicles" then
		TriggerServerEvent("admin:deleteAllVehicles")


	elseif btn.action == "supprpedsss" then
		local msg = KeyboardInput("ADMIN_KICK", "Etes-vous sûr de cette action ?", "", 100)
		
		
		if msg ~= nil and msg:lower() == "oui" then  
			RemoveAllPeds()
			
			ESX.ShowNotification("Tous les peds ont été supprimés avec succès.")
		else
			
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "changerheure" then
		
		local hour = KeyboardInput("ZiZou", "Entrez l'heure (0-23)", "", 2)
		local minutes = KeyboardInput("ZiZou", "Entrez les minutes (0-59)", "", 2)
	
		if hour and minutes then
			ExecuteCommand("time " .. hour .. " " .. minutes)
			ESX.ShowNotification("L'heure a été changée avec succès à " .. hour .. ":" .. minutes)
		else
			ESX.ShowNotification("Entrée invalide. Veuillez entrer une heure et des minutes valides.")
		end

	elseif btn.action == "changermeteo" then
	
		local weather = KeyboardInput("ZiZou", "Entrez la météo souhaitée (e.g. CLEAR, RAIN)", "", 10)

		if weather then
			
			ExecuteCommand("weather " .. weather)
			ESX.ShowNotification("La météo a été changée à " .. weather)
		else
			
			ESX.ShowNotification("Entrée invalide. Veuillez entrer une météo valide.")
		end
	
	--	
	elseif btn.action == "freezeletempszinc" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)
	
		if confirm and confirm:lower() == "oui" then
		
			ExecuteCommand("freezetime")
			ESX.ShowNotification("Le temps a été gelé avec succès.")
		else
		
			ESX.ShowNotification("Action annulée.")
		end
--
	elseif btn.action == "freezemeteozinc" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)

		if confirm and confirm:lower() == "oui" then

			ExecuteCommand("freezeweather")
			ESX.ShowNotification("La météo a été gelé avec succès.")
		else
			ESX.ShowNotification("Action annulée.")
		end
	
	elseif btn.action == "solielzinc" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)

		if confirm and confirm:lower() == "oui" then

			ExecuteCommand("weather extrasunny")
			
		else
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "sixheure" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)

		if confirm and confirm:lower() == "oui" then

			ExecuteCommand("time 6 00")
			
		else
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "douzeheure" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)

		if confirm and confirm:lower() == "oui" then

			ExecuteCommand("time 12 00")
			
		else
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "dixhuigtheure" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)

		if confirm and confirm:lower() == "oui" then

			ExecuteCommand("time 18 00")
			
		else
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "minuitzinc" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)

		if confirm and confirm:lower() == "oui" then

			ExecuteCommand("time 00 00")
			
		else
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "redeamscript" then
	
		local scriptName = KeyboardInput("ZiZou", "Entrez le nom du script", "", 20)
	
		
		if scriptName then
			
			ExecuteCommand("restart " .. scriptName)
			ESX.ShowNotification("~g~Le script ~b~" .. scriptName .. "~s~ a été redémarré avec succès.")
		else
	
			ESX.ShowNotification("~r~Veuillez entrer un nom de script valide.")
		end

	elseif btn.action == "stopscript" then
	
		local scriptName = KeyboardInput("ZiZou", "Entrez le nom du script", "", 20)
	
		
		if scriptName then
			
			ExecuteCommand("stop " .. scriptName)
			ESX.ShowNotification("~g~Le script ~b~" .. scriptName .. "~s~ a été stop avec succès.")
		else
	
			ESX.ShowNotification("~r~Veuillez entrer un nom de script valide.")
		end

		

	elseif btn.action == "startscript" then
	
		local scriptName = KeyboardInput("ZiZou", "Entrez le nom du script", "", 20)
	
		
		if scriptName then
			
			ExecuteCommand("start " .. scriptName)
			ESX.ShowNotification("~g~Le script ~b~" .. scriptName .. "~s~ a été stop avec succès.")
		else
	
			ESX.ShowNotification("~r~Veuillez entrer un nom de script valide.")
		end

	elseif btn.action == "refrshscript" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)

		if confirm and confirm:lower() == "oui" then

			ExecuteCommand("refresh")
			
		else
			ESX.ShowNotification("Action annulée.")
		end

	elseif btn.action == "viderleserveurzizoi" then
	
		local confirm = KeyboardInput("ZiZou", "Etes-vous sûr ? (Oui/Non)", "", 3)

		if confirm and confirm:lower() == "oui" then

			RemoveAllVehicles()
            RemoveAllProps()
            RemoveAllPeds()
			ESX.ShowNotification("Serveur vidé avec succès")
			
		else
			ESX.ShowNotification("Action annulée.")
		end
	

	elseif btn.action == "pointgpsmap" then
		TriggerServerEvent("zizoustaff:SetGPS", tonumber(SelectedPlayer))
	

	
	  

	elseif btn.action == "announce" then
		local msg = KeyboardInput("ADMIN_ANNONCE", "Entrez le message de l'annonce", "", 100)
	
		if msg ~= nil and msg ~= "" then
			local author = GetPlayerName(PlayerId())
	
			if btn.slidenum == 1 then
				local audience = KeyboardInput("ADMIN_ANNONCE_AUDIENCE", "Envoyer à tout le monde sauf 'user'? (Oui/Non)", "", 3)
	
				if audience ~= nil and audience:lower() == "oui" then
					-- Send to all except 'user'
					TriggerServerEvent('zizou:sendAnnonce', "PetiteAnnonce", msg, author, true)
				else
					-- Send to everyone
					TriggerServerEvent('zizou:sendAnnonce', "PetiteAnnonce", msg, author, false)
				end
	
			elseif btn.slidenum == 2 then
				local audience = KeyboardInput("ADMIN_ANNONCE_AUDIENCE", "Envoyer à tout le monde sauf 'user'? (Oui/Non)", "", 3)
				if audience ~= nil and audience:lower() == "oui" then
				TriggerServerEvent('esx:adminannounce', '~b~Annonce', msg, 5, true)
				else
					TriggerServerEvent('esx:adminannounce', '~b~Annonce', msg, 5, false)
				end
			elseif btn.slidenum == 3 then
				ExecuteCommand("annonceui " .. msg)
			elseif btn.slidenum == 4 then
				ExecuteCommand("annonceui50METRES " .. msg)
			end
		else
			ESX.ShowNotification("Veuillez entrer un message pour l'annonce.")
		end
	
		

	elseif btn.action == "eventlekhobenjehodezizoulamoulabyzizouledeveloppeurindefinssablelesangdelaveinedubiceps" then
		local msg = KeyboardInput("ADMIN_KICK", "Etes-vous sûr de cette action ?", "", 100)
		
		
		if msg ~= nil and msg:lower() == "oui" then  
ExecuteCommand("vehiculeEvent")
		else
			
			ESX.ShowNotification("Action annulée.")
		end


	elseif btn.action == "announcejob" then
		local jobName = KeyboardInput("ADMIN_ANNONCE", "Entrez le job de l'annonce", "", 100)

		if jobName ~= nil and jobName ~= "" then

			if btn.slidenum == 1 then
				TriggerServerEvent('esx:adminannounce', '~g~Légal', 'Le job "' .. jobName .. '" est disponible à la reprise !', 5)
			elseif btn.slidenum == 2 then
				TriggerServerEvent('esx:adminannounce', '~r~Illégal', 'La faction "' .. jobName .. '" est disponible à la reprise !', 5)
			end
		else
			ESX.ShowNotification("Veuillez entrer un job pour l'annonce.")
		end
		

	

	
		
		

	  elseif btn.action == "service" then
		TriggerServerEvent("admin:Service", false)
		IDActive = false
		InServiceAdmin = false
		staffsCount = math.max(0, staffsCount - 1)
		boolHud = false
		RemoveWeaponFromPed(PlayerPedId(), "weapon_snspistol_mk2")
                        delGunStaffActive = false
                        SetPedInfiniteAmmo(PlayerPedId(), false, "weapon_snspistol_mk2") 
		CloseMenu()
		TriggerEvent('caruiskinchanger:loadSkin', ESX.PlayerData.skin)
		TriggerEvent('nui:serviceoff')
		openAdminServiceMenu("staff")
	  elseif btn.action == "givemenu" then
		OpenMenu("give")
	elseif btn.action == "setjob" then
		local job = KeyboardInput("ADMIN_SETJOB", "Le métier", "", 100)
        if job ~= nil then
			local grade = KeyboardInput("ADMIN_SETJOB_GRADE", "Le grade", "", 1)
            if tonumber(grade) ~= nil then
				
		TriggerServerEvent("admin:setJob", tonumber(SelectedPlayer), job, grade, 1)
			end
		end

				
	elseif btn.action == "tpposssss" then
			if btn.slidenum == 1 then
				TriggerServerEvent("staff:Teleport1", "bring", tonumber(SelectedPlayer))
			
			elseif btn.slidenum == 2 then 
				TriggerServerEvent("staff:Teleport1", "bringback", tonumber(SelectedPlayer))
				
			elseif btn.slidenum == 3 then 
				TriggerServerEvent("staff:Teleport1", "tppc", tonumber(SelectedPlayer))
				
			end

		elseif btn.action == "prendrescreen" then
			if btn.slidenum == 1 then
				ExecuteCommand("screen " .. tonumber(SelectedPlayer))
			
			elseif btn.slidenum == 2 then 
				ExecuteCommand("screenig " .. tonumber(SelectedPlayer))

			end

		elseif btn.action == "healactionpd" then
			ExecuteCommand("heal "..tonumber(SelectedPlayer).."")
	
			
	elseif btn.action == "setjob2" then
		local job = KeyboardInput("ADMIN_SETJOB2", "Le gang", "", 100)
        if job ~= nil then
			local grade = KeyboardInput("ADMIN_SETJOB2_GRADE", "Le grade", "", 1)
            if tonumber(grade) ~= nil then
				
		TriggerServerEvent("admin:setJob", tonumber(SelectedPlayer), job, grade, 2)
			end
		end
	  elseif btn.action == "givemoney" then
		local amount = KeyboardInput("ESX_GIVE", "Somme à se give", "", 8)
        if tonumber(amount) ~= nil then
			if btn.slidenum == 1 then
			TriggerServerEvent('admin:give', 'money', 'cash', tonumber(amount))	
			CloseMenu()
			elseif btn.slidenum == 2 then 
			TriggerServerEvent('admin:give', 'money', 'black_money', tonumber(amount))
			CloseMenu()
			end
		end
	elseif btn.action == "giveitem" then
		if btn.slidenum == 1 then
			local item = KeyboardInput("ESX_GIVE", "Item à se Give", "", 30)
        if item ~= nil then
			local amount = KeyboardInput("ESX_GIVE", "Nombre d'items", "", 3)
        if tonumber(amount) ~= nil then
			TriggerServerEvent('admin:give', 'item', item, tonumber(amount))
			CloseMenu()	
		end
		end
			elseif btn.slidenum == 2 then 
				local weapon = KeyboardInput("ESX_GIVE", "Arme à se Give", "", 30)
				if weapon ~= nil then
					local amount = KeyboardInput("ESX_GIVE", "Munitions", "", 3)
				if tonumber(amount) ~= nil then
					TriggerServerEvent('admin:give', 'weapon', weapon, tonumber(amount))	
					CloseMenu()
				end
				end
			end
		elseif btn.action == "reports" then
			CloseMenu()
			openAdminReportMenu()



			
		elseif btn.action == "register" then
			TriggerServerEvent("admin:MakePlayerRegister", tonumber(SelectedPlayer))
		elseif btn.action == "jail" then
			local time = 10
			  if btn.slidenum == 1 then
				time = 10
			  elseif btn.slidenum == 2 then
				time = 30
			  elseif btn.slidenum == 3 then
				time = 60
			  elseif btn.slidenum == 4 then
				time = 24 * 60
			  elseif btn.slidenum == 5 then
				time = 7 * 24 * 60
			  elseif btn.slidenum == 6 then
				time = 0
			  end
			  if btn.slidenum == 6 then
			  TriggerServerEvent('admin:JailPlayer', tonumber(SelectedPlayer), time, "")
			  else
				local reason = KeyboardInput("ADMIN_JAIL", "Raison du jail ?", "", 100)
				if reason ~= nil then
					TriggerServerEvent('admin:JailPlayer', tonumber(SelectedPlayer), time, reason)
				end
			  end
		elseif btn.action == "unjail" then
			TriggerServerEvent('admin:Unjail', tonumber(SelectedPlayer))
		elseif btn.action == "wipe" then
			if ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
			local reason = KeyboardInput("ADMIN_WIPE", "Raison du wipe ?", "", 100)
			if reason ~= nil then
			    TriggerServerEvent("admin:WipeArme", tonumber(SelectedPlayer), reason)
			end
		else
			ESX.ShowNotification("Vous avez pas la permission")
		end

	elseif btn.action == "wipearmess" then
		if btn.slidenum == 1 then
			if ESX.PlayerData.group == "responsable" or ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
				CloseMenu()
				ExecuteCommand("wipe " .. tonumber(SelectedPlayer))
			else
				ESX.ShowNotification("Vous avez pas la permission")
			end  
		elseif btn.slidenum == 2 then 
			if ESX.PlayerData.group == "owner" then
				local reason = KeyboardInput("ADMIN_WIPE", "Raison du wipe ?", "", 100)
				
				-- Vérifie si 'reason' n'est ni vide ni nil
				if reason ~= nil and reason ~= "" then
					TriggerServerEvent("admin:WipeArme", tonumber(SelectedPlayer), reason)
				else
					-- Optionnel: message ou log si aucune raison n'est donnée
					ESX.ShowNotification("Veuillez fournir une raison pour le wipe.")
				end
			else
				ESX.ShowNotification("Vous n'avez pas la permission.")
			end  
		end
		
	




	end
	end  
  },

  Menu = {
    ["menu staff"] = {
      b = {
		{name = "Mode Staff", action = "service", checkbox = InServiceAdmin},
		{name = "Voir la liste des joueurs en ligne", action = "playerslist", ask = "→", askX = true},
		{name = "Voir la liste des staffs en ligne", action = "stafflist", ask = "→", askX = true},
		{name = "Listes des reports", action = "reports", ask = "→", askX = true},
		{name = "Options Personnel", action = "staffaction", ask = "→", askX = true},
		{name = "Mettre un joueur sous Surveillance", action = "surveillancebyzizoulekhobendejolesangdelaveinequitue", ask = "→", askX = true},
      }
	},
	["liste joueurs"] = {
		b = {}
	},
	["give"] = {
		b = {
			{name = "Give Argent", action = "givemoney", slidemax = MoneyGiveOption},
		    {name = "Give Item", action = "giveitem", slidemax = ItemGiveOption},
		}
	},
	["joueur"] = {
      b = {
		{name = "NULL", action = "null"},
		{name = "Me téléporter au joueur", action = "gotoplayer", ask = "→", askX = true},
		{name = "Téléporter", action = "tpposssss", slidemax = {"Ma position", "Bring back", "Parking Central"}},
		{name = "Soigner", action = "healactionpd", ask = "→", askX = true},
		{name = "Réanimer", action = "revive", ask = "→", askX = true},
		{name = "Prendre en Screen", action = "prendrescreen", slidemax = {"Logs Discord", "En Jeu"}},
		{name = "Point GPS sur la map", action = "pointgpsmap", ask = "→", askX = true},
	--	{name = "Informations", action = "infoplayers", slidemax = {"Métier", "Groupe illégal", "Permission", "License", "UUID", "Rank"}},
		{name = "Envoyer un message privé", action = "message", ask = "→", askX = true},
		{name = "Wipe", action = "wipearmess", slidemax = {"Normal", "~r~ALL"}},
		

      }
	},
	["actions anticheat"] = {
		b = {
			{name = "Supprimer tous les Véhicules", action = "deleteAllVehicles"},
			{name = "Supprimer tous les Props", action = "deleteAllProps"},
			{name = "Supprimer tous les Peds", action = "deleteAllPeds"},
			{name = "Supprimer tous les Entités", action = "deleteAllEntities"},
		}

	},
	["gestion serveur"] = {
		b = {
			{name = "Changer Le Temps", action = "changerheure"},
			{name = "Changer La Météo", action = "changermeteo"},
			{name = "Freeze Le Temps", action = "freezeletempszinc"},
			{name = "Freeze La Météo", action = "freezemeteozinc"},
			{name = "Soleil", action = "solielzinc"},
			{name = "6H00", action = "sixheure"},
			{name = "12H00", action = "douzeheure"},
			{name = "18H00", action = "dixhuigtheure"},
			{name = "00H00", action = "minuitzinc"},
			{name = "Redémarrer Un Script", action = "redeamscript"},
			{name = "Stopper Un Script", action = "stopscript"},
			{name = "Start Un Script", action = "startscript"},
			{name = "Refresh Ressources", action = "refrshscript"},
			{name = "Vider Le Serveur", action = "viderleserveurzizoi"},
		}
	},
  }

  }

if ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
    table.insert(AdminMenu.Menu["joueur"].b, {name = "Register", action = "register", ask = "→", askX = true})
    table.insert(AdminMenu.Menu["joueur"].b, {name = "Mettre un métier", action = "setjob", ask = "→", askX = true})
    table.insert(AdminMenu.Menu["joueur"].b, {name = "Mettre une organisation", action = "setjob2", ask = "→", askX = true})
end

table.insert(AdminMenu.Menu["joueur"].b, {name = "Freeze", action = "freeze", slidemax = FreezeOption})

if ESX.PlayerData.group == "owner" then 
table.insert(AdminMenu.Menu["menu staff"].b, {name = "Actions Anticheat", action = "ZiZouacactions", ask = "→", askX = true})
end

if ESX.PlayerData.group == "owner" then 
	table.insert(AdminMenu.Menu["menu staff"].b, {name = "Gestion Serveur", action = "gestionserv", ask = "→", askX = true})
	end

if ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
    table.insert(AdminMenu.Menu["menu staff"].b, {name = "Faire une annonce", action = "announce", slidemax = annonceOption})
end

if ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
    table.insert(AdminMenu.Menu["menu staff"].b, {name = "Annonce Légal/Illégal", action = "announcejob", slidemax = annoncejobOption})
end


if ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
    table.insert(AdminMenu.Menu["menu staff"].b, {name = "Gérer Evenement", action = "eventlekhobenjehodezizoulamoulabyzizouledeveloppeurindefinssablelesangdelaveinedubiceps", slidemax = eventoptionzizouledevelopeurdezizouleak})
end


if ESX.PlayerData.group == "owner" then
    table.insert(AdminMenu.Menu["menu staff"].b, {name = "Options Give", action = "givemenu", ask = "→", askX = true})
	table.insert(AdminMenu.Menu["joueur"].b, {name = "Bannir", action = "ban", slidemax = BanOption})
end


table.insert(AdminMenu.Menu["joueur"].b, {name = "Jail", action = "jail", slidemax = JailOption})
table.insert(AdminMenu.Menu["joueur"].b, {name = "Kick", action = "kick", ask = "→", askX = true})
--table.insert(AdminMenu.Menu["joueur"].b, {name = "Bannir", action = "ban", slidemax = BanOption})



CreateMenu(AdminMenu)
end

function OpenAdminPersonalMenu()
AdminPersonalMenu = {}

AdminPersonalMenu = {
    Base = { Title = "Staff", HeaderColor = {255, 0, 0} },
    Data = { currentMenu = "actions staff " },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
	  if btn.action == "noclip" then
		admin_no_clip()

	  elseif btn.action == "idname" then
		ShowNames()

	elseif btn.action == "infobar" then
	--	boolHudInfos()

	  elseif btn.action == "gotoplayer" then
		local msg = KeyboardInput("ADMIN_TP", "ID du joueur", "", 5)
        if tonumber(msg) ~= nil then
        if noclipse == false then
        admin_no_clip()
        end
        TriggerServerEvent("admin:GoToPlayer", tonumber(msg))
        end



		
		

	  elseif btn.action == "playertome" then
		local msg = KeyboardInput("ADMIN_TP", "ID du joueur", "", 5)
		if tonumber(msg) ~= nil then
		 TriggerServerEvent("admin:TeleportPlayerToMe", tonumber(msg), ESX.PlayerData.cache.coords)
		end

	  elseif btn.action == "reviveme" then
		ExecuteCommand("revive me")

	elseif btn.action == "invisiblemode" then
		invisibleMode = not invisibleMode
		TriggerServerEvent("admin:SetInvisibleMode", invisibleMode)
	
	elseif btn.action == "gotoinstancejail" then
		ininstancejailfdp = not ininstancejailfdp
    
		-- Appelle l'événement pour gérer l'entrée/sortie de l'instance
		TriggerEvent("esx:setbucketnwar")

	elseif btn.action == "revive" then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestDistance ~= -1 and closestDistance <= 3.0 then
			local targetId = GetPlayerServerId(closestPlayer)
			ExecuteCommand("revive " .. targetId)
		else
			ESX.ShowNotification("~r~Aucun joueur à proximité !")
		end
	

	  elseif btn.action == "repairveh" then
		admin_vehicle_repair()

	  elseif btn.action == "delveh" then
		local vehicle = GetClosestVehicle(ESX.PlayerData.cache.coords, 2.0, 0, 71)
		if vehicle then
			ESX.Game.DeleteVehicle(vehicle)
		end

	elseif btn.action == "demenotee" then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then 
			TriggerServerEvent('handcuff:off', GetPlayerServerId(closestPlayer))
		else
			ESX.ShowNotification('Aucun joueur à proximité')
		end

	  elseif btn.action == "spawnveh" then
		ESX.Game.SpawnVehicle(btn.model, ESX.PlayerData.cache.coords, 0, function(vehicle)
			TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped,  vehicle, -1)
			local plate = "ADM "..math.random(100, 900)
			SetVehicleNumberPlateText(vehicle, plate)
			CloseMenu()
		end, "staff")
	elseif btn.action == "staffgun" then
		TriggerEvent("ESX:staffgun")
		gunstafffdp = not gunstafffdp
														elseif btn.action == "tpmmm" then
													ExecuteCommand('tpm')
													elseif btn.action == "pedsmenu" then
														OpenMenu('menu peds')
													elseif btn.action == "resetskinfdp" then
														ResetPed()


			elseif btn.action == "setped" then
				ParticleMaker("scr_rcbarry2", "scr_clown_appears", 0.5) 
				Citizen.Wait(100)

				SpawnPed(btn.ped)

											elseif btn.action == "menuveh" then
												OpenMenu("spawn vehicule ")
											elseif btn.action == "gunveh" then
												TriggerEvent("esx:delGunVeh")
												DelGunVeh = not DelGunVeh
											end
											end
  },

  Menu = {
    ["actions staff "] = {
        b = {
            {name = "Se revive", action = "reviveme", ask = "→", askX = true},
            {name = "Spawn un véhicule", action = "menuveh", ask = "→", askX = true},
            {name = "Réparer le véhicule", action = "repairveh", ask = "→", askX = true},
            {name = "Supprimer véhicule à proximité", action = "delveh", ask = "→", askX = true},
			{name = "Démenotter un joueur à proximité", action = "demenotee", ask = "→", askX = true},
            {name = "Mettre/Enlever le noclip", action = "noclip", checkbox = noclipse},
            {name = "Afficher/Cacher les ID", action = "idname", checkbox = IDActive},
			{name = "Afficher la barre d'information", action = "infobar", checkbox = BARINFO},
			{name = "Entrer/Sortir en instance de jail", action = "gotoinstancejail", checkbox = ininstancejailfdp},
            {name = "Pistolet Joueur", action = "staffgun", checkbox = gunstafffdp},
            {name = "Pistolet véhicules", action = "gunveh", checkbox = DelGunVeh},
			{name = "TP Marker", action = "tpmmm", ask = "→", askX = true},
        }
    },
	["menu peds"] = {
		b = {
			{name = "Mon personnage", action = "resetskinfdp", ask = "→", askX = true},
			{name = "            ---------------------------------------------------", action = "", ask = "", askX = true},
			{name = "Tonton", ped = "a_m_y_downtown_01", action = "setped", ask = "→", askX = true},
			{name = "Toad 1", ped = "Toad", action = "setped", ask = "→", askX = true},
			{name = "Minion 2", ped = "MinionBlue", action = "setped", ask = "→", askX = true},
			{name = "Toad 3", ped = "SSG Kid Goku", action = "setped", ask = "→", askX = true},
		}
	},
    ["spawn vehicule "] = {
        b = {
            {name = "Sentinel", action = "spawnveh", model = "sentinel"},
            {name = "BF400", action = "spawnveh", model = "bf400"}
        }
    },
}


  }

  if ESX.PlayerData.group == "owner" then
	table.insert(AdminPersonalMenu.Menu["menu peds"].b, { name = "Tom Escobar", ped = "Child", action = "setped", ask = "→", askX = true})
	table.insert(AdminPersonalMenu.Menu["menu peds"].b, { name = "Rangers", ped = "rangers", action = "setped", ask = "→", askX = true})
	table.insert(AdminPersonalMenu.Menu["menu peds"].b, { name = "FILLE", ped = "BabyLiviaG_MILLERSTORE", action = "setped", ask = "→", askX = true})
	end

  if ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
  table.insert(AdminPersonalMenu.Menu["actions staff "].b, { name = "Mode Invisible", checkbox = invisibleMode, action = "invisiblemode"})
  end

  if ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "admin" then
	table.insert(AdminPersonalMenu.Menu["actions staff "].b, {name = "Peds", action = "pedsmenu", ask = "→", askX = true})
  end

CreateMenu(AdminPersonalMenu)
end

function openAdminReportMenu()
AdminMenuReport = {}

AdminMenuReport = {
	Base = { Title = "reports", HeaderColor = {255, 0, 0} },
	Data = { currentMenu = "reports" },
	
	Events = {
	  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		if btn.action == "actionreport" then
		SelectedReport = btn
		AdminMenuReport.Menu["reportsaction"].b = {
		{name = "Report numéro "..btn.numreport.."", action = "null"},
		{name = "ID/UUID/Nom: "..btn.source.." | "..btn.uuid.." | "..btn.nameplayer.."", action = "null"},
		{name = "Message: "..btn.message, action = "null"},
		{name = "--------------------", action = "null"},
		{name = "Me téléporter au joueur", action = "gotoplayer", ask = "→", askX = true},
		{name = "Téléporter le joueur à moi", action = "playertome", ask = "→", askX = true},
		{name = "Réanimer le joueur", action = "revive", ask = "→", askX = true},
		{name = "Fermer le ticket", action = "closereport", ask = "→", askX = true}
		}
		TriggerServerEvent("admin:takingReport", btn.source)
		OpenMenu("reportsaction")
		elseif btn.action == "gotoplayer" then
	     if noclipse == false then
		   admin_no_clip()
		 end
		 TriggerServerEvent("admin:GoToPlayer", tonumber(SelectedReport.source))
		elseif btn.action == "playertome" then
		  if noclipse == false then
			admin_no_clip()
		  end
		  TriggerServerEvent("admin:TeleportPlayerToMe", SelectedReport.source, ESX.PlayerData.cache.coords)
		elseif btn.action == "revive" then
		  TriggerServerEvent("ambulance:revive", tonumber(SelectedReport.source), true)
		elseif btn.action == "closereport" then
		  TriggerServerEvent("admin:DeleteReport", SelectedReport.source)
		  CloseMenu()
	    end
	end
	},
	
	Menu = {
	["reports"] = {
	  b = {}
	},
	["reportsaction"] = {
	  b = {}
	},
  }	
}

ESX.TriggerServerCallback("admin:getReports", function(reports)
	for k,v in pairs(reports) do
		table.insert(AdminMenuReport.Menu["reports"].b, {name = "~r~["..v.source.."] "..v.name..": "..v.message.."~s~", message = v.message, source = v.source, uuid = v.uuid, nameplayer = v.name, numreport = v.num, action = "actionreport"})
	end
	CreateMenu(AdminMenuReport)
end)
end

RegisterNetEvent("admin:toggleNoclip")
AddEventHandler("admin:toggleNoclip", function()
	if ESX.PlayerData.group ~= "user" then
	admin_no_clip()
	end
end)

function ResetPed()
    ESX.TriggerServerCallback('skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0

        TriggerEvent('caruiskinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('skin:getPlayerSkin', function(skin)
                TriggerEvent('caruiskinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
				TriggerEvent('esx:restorePermLoadout')
                Citizen.Wait(200)
                ESX.ShowNotification("~b~Votre personnage a été réinitialisé ...") 
            end)

        end)
       TriggerEvent('esx:restoreLoadout')
	   TriggerEvent('esx:restorePermLoadout')

    end)
end


AddEventHandler("admin:delVeh", function(NetID)
for vehicle in EnumerateVehicles() do
  if DoesEntityExist(vehicle) then
   if NetworkGetNetworkIdFromEntity(vehicle) == NetID then
	NetworkRequestControlOfEntity(vehicle)
  	local timeout = 1000
  	while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
      Citizen.Wait(100)
      timeout = timeout - 100
  	end
  	SetEntityAsMissionEntity(vehicle, true, true)
  	local timeout = 2000
  	while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
      Citizen.Wait(100)
      timeout = timeout - 100
  	end
	DeleteEntity(vehicle)
   end
  end
end
end)

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(5)
	  if frozen then
		FreezeEntityPosition(ESX.PlayerData.cache.playerped, frozen)
		if ESX.PlayerData.cache.invehicle then
		FreezeEntityPosition(ESX.PlayerData.cache.vehicle, frozen)
		end 
	  else
	  Citizen.Wait(1000)
	end
  end
end)


function GetOnlinePlayers()
    local clientPlayers = false;
    ESX.TriggerServerCallback('esx:retrievePlayers', function(players)
        clientPlayers = players
    end)

    while not clientPlayers do
        Citizen.Wait(5)
    end
    return clientPlayers
end

function RetrievePlayerDataByID(source)
    local player = {}
    for i, v in pairs(OnlinePlayers) do
        if (v.source == source) then
            player = v;
        end
    end
    return player;
end

function ShowNames()
    IDActive = not IDActive 
    if IDActive then
        Citizen.CreateThread(function()
            while IDActive do
                for _, v in pairs(GetActivePlayers()) do
                    local PlayerID = GetPlayerServerId(v)
                    local player = RetrievePlayerDataByID(PlayerID)

                    if player and player.uuid then
                        local otherPed = GetPlayerPed(v)
                        if #(ESX.PlayerData.cache.coords - GetEntityCoords(otherPed, false)) < 100.0 then
                            gamerTags[v] = CreateFakeMpGamerTag(otherPed, "" .. player.uuid .. " - " .. GetPlayerName(v), false, false, "", 0)
                            SetMpGamerTagName(gamerTags[v], "" .. player.uuid .. " - " .. GetPlayerName(v))   
                            SetMpGamerTagVisibility(gamerTags[v], 2, true) 

                            if player.invisible then
                                SetMpGamerTagColour(gamerTags[v], 0) 
                            elseif player.color then
                                SetMpGamerTagColour(gamerTags[v], 0, player.color)
                            else
                                SetMpGamerTagColour(gamerTags[v], 0, 225) 
                            end

                            SetMpGamerTagAlpha(gamerTags[v], 4, 255) 
                            SetMpGamerTagAlpha(gamerTags[v], 2, 255) 
                        else
                      
                            RemoveMpGamerTag(gamerTags[v])
                            gamerTags[v] = nil
                        end
                    end
                end
                Wait(500)
            end
            for _, v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
                gamerTags[v] = nil
            end
        end)
    end
end



local noclip = false
local noclip_speed = 1.5 

function admin_no_clip()
	noclipse = true
    noclip = not noclip
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false) 
    local entity = vehicle ~= 0 and vehicle or playerPed 

    if noclip then
        SetEntityInvincible(entity, true)
        SetEntityVisible(entity, false, false)
        SetEntityCollision(entity, false, false)
        FreezeEntityPosition(entity, true) 

        Citizen.CreateThread(function()
            while noclip do
                Citizen.Wait(1)

                local coords = GetEntityCoords(entity, false)
                local camDirection = getCamDirection()
				local camRot = GetGameplayCamRot(2) 
                local moveVector = vector3(0, 0, 0)

                -- Déplacements
                if IsControlPressed(0, 32) then 
                    moveVector = moveVector + (noclip_speed * camDirection)
                end
                if IsControlPressed(0, 269) then 
                    moveVector = moveVector - (noclip_speed * camDirection)
                end
                if IsControlPressed(0, 34) then 
                    moveVector = moveVector - vector3(camDirection.y, -camDirection.x, 0) * noclip_speed
                end
                if IsControlPressed(0, 9) then 
                    moveVector = moveVector + vector3(camDirection.y, -camDirection.x, 0) * noclip_speed
                end

                SetEntityCoordsNoOffset(entity, coords.x + moveVector.x, coords.y + moveVector.y, coords.z + moveVector.z, true, true, true)
				SetEntityHeading(entity, camRot.z)

                if IsControlJustPressed(1, 15) then 
                    noclip_speed = math.min(noclip_speed + 0.5, 10.0)
                end
                if IsControlJustPressed(1, 14) then 
                    noclip_speed = math.max(noclip_speed - 0.5, 0.1)
                end
            end
        end)
    else
        Citizen.SetTimeout(50, function()
            SetEntityInvincible(entity, false)
            SetEntityCollision(entity, true, true)
            SetEntityVisible(entity, true, false)
            FreezeEntityPosition(entity, false) 
        end)
    end
end

function getCamDirection()
    local rot = GetGameplayCamRot(2)
    local heading = math.rad(rot.z)
    local pitch = math.rad(rot.x)

    local x = -math.sin(heading) * math.cos(pitch)
    local y = math.cos(heading) * math.cos(pitch)
    local z = math.sin(pitch)

    return vector3(x, y, z)
end

function isNoclip()
    return noclip
end



function admin_vehicle_repair()
SetVehicleFixed(ESX.PlayerData.cache.vehicle)
SetVehicleDirtLevel(ESX.PlayerData.cache.vehicle, 0.0)
end


AddEventHandler("admin:GoToPlayerCli", function(src)
TriggerServerEvent("admin:GoPlayer", src, ESX.PlayerData.cache.coords)
end)

AddEventHandler("admin:GoToPlayerCli2", function(coords)
SetEntityCoords(ESX.PlayerData.cache.playerped, coords.x, coords.y, coords.z)
end)

AddEventHandler("admin:requestSpectate", function(playerId)
	spectatePlayer(GetPlayerPed(playerId), playerId, GetPlayerName(playerId))
end)

AddEventHandler("admin:FreezePlayer", function(toggle)
	frozen = toggle
	FreezeEntityPosition(ESX.PlayerData.cache.playerped, frozen)
	if ESX.PlayerData.cache.invehicle then
		FreezeEntityPosition(ESX.PlayerData.cache.vehicle, frozen)
	end 
end)

RegisterCommand("report", function(source, args, rawCommand)
	if #args < 1 then
		ESX.ShowNotification("~r~Utilisation de la commande invalide.~s~", "error")
		return
	end

	local MessageFinal = ""

	for k,v in pairs(args) do
	 MessageFinal = MessageFinal..v.." "
	end

	if not AntiSpamReport then
     TriggerServerEvent("admin:sendReport", MessageFinal, GetPlayerName(PlayerId()))
	 ESX.ShowNotification("Votre report à bien été envoyé ! 🔍", "success")
     AntiSpamReport = true
     Citizen.SetTimeout(1000, function()
      AntiSpamReport = false
     end)
    else
      ESX.ShowNotification("Vous devez attendre un peu avant de refaire un report.", "info")
    end
end)

RegisterNetEvent('admin:teleport')
AddEventHandler('admin:teleport', function(x, y, z)
	SetEntityCoords(ESX.PlayerData.cache.playerped, x, y, z)
end)

RegisterNetEvent('admin:receiveReportNotification')
AddEventHandler('admin:receiveReportNotification', function()
	if ESX.PlayerData.group ~= "user" and InServiceAdmin then
		ESX.ShowNotification('Un Nouveau report vous attend !', "info")
	end
end)





function RemoveAllVehicles()
    local vehicles = GetAllVehicles()
    for _, vehicle in ipairs(vehicles) do
        if DoesEntityExist(vehicle) then
            if not IsAnyPlayerInVehicle(vehicle) then
                DeleteEntity(vehicle)
            end
        end
    end
end

function IsAnyPlayerInVehicle(vehicle)
    for playerId = 0, 255 do 
        if NetworkIsPlayerActive(playerId) then
            local ped = GetPlayerPed(playerId)
            if GetVehiclePedIsIn(ped, false) == vehicle then
                return true 
            end
        end
    end
    return false
end

function RemoveAllProps()
    local props = GetAllObjects()
    for _, prop in ipairs(props) do
        if DoesEntityExist(prop) then
            DeleteEntity(prop)
        end
    end
end

function RemoveAllPeds()
    local peds = GetAllPeds()
    for _, ped in ipairs(peds) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
end

function GetAllVehicles()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end
    return vehicles
end

function GetAllObjects()
    local objects = {}
    for object in EnumerateObjects() do
        table.insert(objects, object)
    end
    return objects
end

RegisterNetEvent('zizoustaff:ReceiveGPS')
AddEventHandler('zizoustaff:ReceiveGPS', function(coords)
    SetNewWaypoint(coords.x, coords.y)
end)

function GetAllPeds()
    local peds = {}
    for ped in EnumeratePeds() do
        table.insert(peds, ped)
    end
    return peds
end
function EnumerateVehicles()
    return coroutine.wrap(function()
        local handle, vehicle = FindFirstVehicle()
        local success
        repeat
            coroutine.yield(vehicle)
            success, vehicle = FindNextVehicle(handle)
        until not success
        EndFindVehicle(handle)
    end)
end

function EnumerateObjects()
    return coroutine.wrap(function()
        local handle, object = FindFirstObject()
        local success
        repeat
            coroutine.yield(object)
            success, object = FindNextObject(handle)
        until not success
        EndFindObject(handle)
    end)
end

function EnumeratePeds()
    return coroutine.wrap(function()
        local handle, ped = FindFirstPed()
        local success
        repeat
            coroutine.yield(ped)
            success, ped = FindNextPed(handle)
        until not success
        EndFindPed(handle)
    end)
end

local savedCoords = nil 

RegisterNetEvent("staff:Teleport1")
AddEventHandler("staff:Teleport1", function(type, x, y, z)
    local playerPed = PlayerPedId()
    
    if type == "goto" or type == "tppc" then
        SetEntityCoordsNoOffset(playerPed, x, y, z, 0.0, 0.0, 0.0, true)

    elseif type == "bring" then
        if not savedCoords then
            savedCoords = GetEntityCoords(playerPed) 
        end
        DoScreenFadeOut(1000)
        Wait(1000)
        SetEntityCoordsNoOffset(playerPed, x, y, z, 0.0, 0.0, 0.0, true)
        DoScreenFadeIn(1000)

    elseif type == "bringback" then
        if savedCoords then
            DoScreenFadeOut(1000)
            Wait(1000)
            SetEntityCoordsNoOffset(playerPed, savedCoords.x, savedCoords.y, savedCoords.z, 0.0, 0.0, 0.0, true)
            DoScreenFadeIn(1000)
            savedCoords = nil 
        else
            ESX.ShowNotification("Aucune position sauvegardée pour retourner en arrière.")
        end
    end
end)


RegisterCommand("tp", function(source, args, rawCommand)
	if ESX.PlayerData.group ~= "user" then
    local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])

    if x and y and z then
        TeleportPlayer(vector3(x, y, z))
       ESX.ShowNotification("Tp good mon frr")
    else
       ESX.ShowNotification("Utilisation : /tp x y z")
    end
else
	ESX.ShowNotification("Vous n'avez pas la permission")
end
end, false)

function TeleportPlayer(coords)
    local player = GetPlayerPed(-1)

    if IsPedInAnyVehicle(player, false) then
        TaskLeaveVehicle(player, GetVehiclePedIsIn(player, false), 0)
    end

    SetEntityCoordsNoOffset(player, coords.x, coords.y, coords.z, true, true, true)
end




















AddEventHandler("esx:setbucketnwar", function()
    if ininstancejailfdp then
        -- Si on est en instance de jail, on téléporte à la position de la prison
        TriggerServerEvent("zizou:fivem:setbucket", "99999")
        SetEntityCoords(PlayerPedId(), vector3(-2178.37, 5190.43, 15.99)) -- Position en jail
    else
        -- Si on n'est pas en instance de jail, on téléporte à la position du parking central
        TriggerServerEvent("zizou:fivem:setbucket", "basic")
        SetEntityCoords(PlayerPedId(), vector3(215.22, -906.83, 30.69)) -- Position du parking central
    end
end)


RegisterCommand('tpm', function(source, args, rawCommand)
    if ESX.PlayerData.group ~= "user" then
        local waypointHandle = GetFirstBlipInfoId(8)

        if DoesBlipExist(waypointHandle) then
            local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            local groundZ = nil
            local attempts = 0
            local z = waypointCoords.z + 500.0

            while not groundZ and attempts < 10 do
                Citizen.Wait(10)
                local found, newZ = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, z, false)
                if found then
                    groundZ = newZ
                else
                    z = z - 50.0
                end
                attempts = attempts + 1
            end

            if not groundZ then
                groundZ = waypointCoords.z + 1.0
            end

            local heading = GetEntityHeading(playerPed)

            if vehicle ~= 0 then
                SetEntityCoords(vehicle, waypointCoords.x, waypointCoords.y, groundZ, false, false, false, true)
                SetEntityHeading(vehicle, heading)
            else
                SetEntityCoords(playerPed, waypointCoords.x, waypointCoords.y, groundZ, false, false, false, true)
                SetEntityHeading(playerPed, heading)
            end

            TriggerEvent('esx:showNotification', "Téléportation effectuée.")
        else
            TriggerEvent('esx:showNotification', "Aucun waypoint n'est défini.")
        end
    else
        TriggerEvent('esx:showNotification', "Vous n'avez pas les permissions !")
    end
end, false)


function SpawnPed(pedname)
    local j1 = PlayerId()
    local p1 = GetHashKey(pedname)
    RequestModel(p1)
    ESX.ShowNotification("Chargement...")
    while not HasModelLoaded(p1) do
        Wait(0)
    end
        SetPlayerModel(j1, p1)
        SetModelAsNoLongerNeeded(p1)
        Citizen.Wait(500)
		TriggerEvent('esx:restoreLoadout')
		TriggerEvent('esx:restorePermLoadout')
end
   
--[[nction VerifierServerEtAction(InServiceAdmin)

	if InServiceAdmin then 
		ESX.ShowNotification("Vous ne pouvez pas acheter de tenue pendant votre service.")
		return true
	end
	return false

end


RegisterCommand("testService", function(source, args, rawCommand)

local isInService = args[1] == "on"

	InServiceAdmin = isInService

	if isInService then
		ESX.ShowNotification("SERVICE ON")
	else
		ESX.ShowNotification("SERVICE OFF")
	end

	if VerifierServerEtAction(InServiceAdmin) then
		ESX.ShowNotification("Test Reussi : action bloqué")
	else
		ESX.ShowNotification("Test réussi : action autorisée car vous n'êtes pas en service.")
	end

end, false)]]

RegisterNetEvent("zizou:getCoordsAndSendLocalAnnonce")
AddEventHandler("zizou:getCoordsAndSendLocalAnnonce", function(message)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    -- Envoie l'annonce à tous les clients avec position du joueur source
    TriggerServerEvent("zizou:broadcastLocalAnnonce", message, coords)
end)

RegisterNetEvent("zizou:displayLocalAnnonce")
AddEventHandler("zizou:displayLocalAnnonce", function(message, sourceCoords)
    local myCoords = GetEntityCoords(PlayerPedId())
    local distance = #(myCoords - vector3(sourceCoords.x, sourceCoords.y, sourceCoords.z))

    if distance <= 50.0 then
        -- Affiche l'annonce (à adapter selon ton UI)
        TriggerEvent("ZiZouANNONCESEND", "", message)
    end
end)



RegisterNetEvent("admin:deleteAllPeds")
AddEventHandler("admin:deleteAllPeds", function()
    for ped in EnumeratePeds() do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
end)

RegisterNetEvent("admin:deleteAllVehicles")
AddEventHandler("admin:deleteAllVehicles", function()
    for vehicle in EnumerateVehicles() do
        if DoesEntityExist(vehicle) then
            DeleteEntity(vehicle)
        end
    end
end)

RegisterNetEvent("admin:deleteAllProps")
AddEventHandler("admin:deleteAllProps", function()
    for object in EnumerateObjects() do
        if DoesEntityExist(object) then
            DeleteEntity(object)
        end
    end
end)

RegisterNetEvent("admin:deleteAllEntities")
AddEventHandler("admin:deleteAllEntities", function()
    for ped in EnumeratePeds() do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    for vehicle in EnumerateVehicles() do
        if DoesEntityExist(vehicle) then
            DeleteEntity(vehicle)
        end
    end
    for object in EnumerateObjects() do
        if DoesEntityExist(object) then
            DeleteEntity(object)
        end
    end
end)
