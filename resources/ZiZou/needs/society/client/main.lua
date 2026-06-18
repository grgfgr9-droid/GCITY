RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job2 = job
end)

function OpenBossMenu(society, type)	
	if type == 1 and ESX.PlayerData.job.grade_name == "boss" and ESX.PlayerData.job.name == society then 
	
	BossMenu = {
		Base = { Title = "Menu patrons", HeaderColor = {252, 186, 3} },
		Data = { currentMenu = "menu patrons" },
	
		Events = {
		  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		  if btn.action == "withdraw" then
			local amount = KeyboardInput("SOCIETY_WITHDRAW", "Combien retirer ?", "", 6)
			if tonumber(amount) ~= nil then
			TriggerServerEvent("society:withdrawMoney", society, tonumber(amount))
			CloseMenu()
			end
			
		  elseif btn.action == "deposit" then
			local amount = KeyboardInput("SOCIETY_DEPOSIT", "Combien déposer ?", "", 6)
			if tonumber(amount) ~= nil then
			TriggerServerEvent("society:depositMoney", society, tonumber(amount))
			CloseMenu()
			end
	
		  elseif btn.action == "wash" then
			local amount = KeyboardInput("SOCIETY_WASH", "Combien blanchir ?", "", 6)
			if tonumber(amount) ~= nil then
			TriggerServerEvent("society:washMoney", society, tonumber(amount))
			CloseMenu()
			end
	
		  elseif btn.action == "leavejob" then
			local confirm = KeyboardInput("SOCIETY_CONFIRMQUIT", "Confirmer ? Ecrivez oui pour confirmer.", "", 6)
			if confirm ~= nil and confirm == "oui" then
			TriggerServerEvent("society:leavejob")
			CloseMenu()
			end
	
		  elseif btn.action == "recrutmenu" then
			OpenMenu("recrutement")
	
		  elseif btn.action == "annoncerecrut" then
			TriggerServerEvent("society:Advert")
	
		  elseif btn.action == "recruit" then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
			  ESX.TriggerServerCallback('society:setJob', function()
				OpenBossMenu(society, type)
			end, GetPlayerServerId(closestPlayer), society, 0, 'hire')
			end
	
		  elseif btn.action == "fire" then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				ESX.TriggerServerCallback('society:setJob', function()
					OpenBossMenu(society, type)
				end, GetPlayerServerId(closestPlayer), 'unemployed', 0, 'fire')
			end
	
		  elseif btn.action == "promote" then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				ESX.TriggerServerCallback('society:promote', function()
					OpenBossMenu(society, type)
				end, GetPlayerServerId(closestPlayer), society)
			end
	
		  elseif btn.action == "demote" then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				ESX.TriggerServerCallback('society:demote', function()
					OpenBossMenu(society, type)
				end, GetPlayerServerId(closestPlayer), society)
			end
	
		  elseif btn.action == "virermenu" then
			BossMenu.Menu["virer employe"].b = {}
			ESX.TriggerServerCallback("society:getEmployees", function(employes)
				
				for i = 1, #employes, 1 do
				  table.insert(BossMenu.Menu["virer employe"].b, {name = employes[i].name.." | Grade: "..employes[i].job.grade_label, identifier = employes[i].identifier, grade = employes[i].job.grade_name, action = "vireremployemenu", ask = "→", askX = true})
				end
				OpenMenu("virer employe")
			end, ESX.PlayerData.job.name, 1)
	
		  elseif btn.action == "vireremployemenu" then
			
			ESX.TriggerServerCallback('society:setJob', function()
				OpenBossMenu(society, type)
			end, btn.identifier, 'unemployed', 0, 'fire')
			  CloseMenu()
		  end
	
		end
	  },
	
	  Menu = {
		["menu patrons"] = {
		  b = {}
		},
		["recrutement"] = {
		  b = {
			{name = "Recruter joueur", action = "recruit", ask = "→", askX = true},
			{name = "Virer joueur", action = "fire", ask = "→", askX = true},
			{name = "Promouvoir joueur", action = "promote", ask = "→", askX = true},
			{name = "Destituer joueur", action = "demote", ask = "→", askX = true},
		  }
		},
		["virer employe"] = {
		  b = {}
		},
		["activite"] = {
		  b = {}
		},
	  }
	}

	table.insert(BossMenu.Menu["menu patrons"].b, {name = "Compte Entreprise : ~g~" .. societymoney .. "$", action = "null", ask = "→", askX = true})	
	table.insert(BossMenu.Menu["menu patrons"].b, {name = "Retirer de l'argent", action = "withdraw", ask = "→", askX = true})
	table.insert(BossMenu.Menu["menu patrons"].b, {name = "Deposer de l'argent", action = "deposit", ask = "→", askX = true})

	if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "sheriff" then
	table.insert(BossMenu.Menu["menu patrons"].b, {name = "Blanchir de l'argent", action = "wash", ask = "→", askX = true})
	end
	table.insert(BossMenu.Menu["menu patrons"].b, {name = "Menu de recrutement", action = "recrutmenu", ask = "→", askX = true})
	table.insert(BossMenu.Menu["menu patrons"].b, {name = "Virer un employé", action = "virermenu", ask = "→", askX = true})
	table.insert(BossMenu.Menu["menu patrons"].b, {name = "~r~Quitter mon entreprise~s~", action = "leavejob", ask = "→", askX = true})
	
	CreateMenu(BossMenu)
	
	elseif type == 2 and ESX.PlayerData.job2.name == society and ESX.PlayerData.job2.grade_name == 'boss' then
	
	BossMenu = {
		Base = { Title = "Menu patrons", HeaderColor = {252, 186, 3} },
		Data = { currentMenu = "menu patrons" },
	
		Events = {
		  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		  if btn.action == "leavegang" then
			local confirm = KeyboardInput("SOCIETY_CONFIRMQUIT", "Confirmer ? Ecrivez oui pour confirmer.", "", 3)
			if confirm ~= nil and confirm == "oui" then
			TriggerServerEvent("society:leavegang")
			CloseMenu()
			end
	
		  elseif btn.action == "recrutmenu" then
			OpenMenu("recrutement")
	
		elseif btn.action == "recruit" then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
			  ESX.TriggerServerCallback('society:setJob2', function()
				OpenBossMenu(society, type)
			end, GetPlayerServerId(closestPlayer), society, 1, 'hire')
			end
	
		  elseif btn.action == "fire" then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				ESX.TriggerServerCallback('society:setJob2', function()
					OpenBossMenu(society, type)
				end, GetPlayerServerId(closestPlayer), 'unemployed2', 0, 'fire')
			end
	
		elseif btn.action == "promote" then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				ESX.TriggerServerCallback('society:promote2', function()
					OpenBossMenu(society, type)
				end, GetPlayerServerId(closestPlayer), society)
			end
	
		  elseif btn.action == "demote" then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				ESX.TriggerServerCallback('society:demote2', function()
					OpenBossMenu(society, type)
				end, GetPlayerServerId(closestPlayer), society)
			end
	
		  elseif btn.action == "virermenu" then
			BossMenu.Menu["virer membre"].b = {}
			ESX.TriggerServerCallback("society:getEmployees", function(employes)
				
				for i = 1, #employes, 1 do
				  table.insert(BossMenu.Menu["virer membre"].b, {name = employes[i].name.." | Grade: "..employes[i].job.grade_label, identifier = employes[i].identifier, grade = employes[i].job.grade_name, action = "virermembremenu", ask = "→", askX = true})
				end
				OpenMenu("virer membre")
			end, ESX.PlayerData.job2.name, 2)
	
		  elseif btn.action == "virermembremenu" then
			ESX.TriggerServerCallback('society:setJob2', function()
					OpenBossMenu(society, type)
				end, btn.identifier, 'unemployed2', 0, 'fire')
			  CloseMenu()
		  end
		  
		end
	  },
	
	  Menu = {
		["menu patrons"] = {
		  b = {
			{name = "Menu de recrutement", action = "recrutmenu", ask = "→", askX = true},
			{name = "Virer un membre", action = "virermenu", ask = "→", askX = true}
		  }
		},
		["recrutement"] = {
		  b = {
			{name = "Recruter joueur", action = "recruit", ask = "→", askX = true},
			{name = "Virer joueur", action = "fire", ask = "→", askX = true},
			{name = "Promouvoir joueur", action = "promote", ask = "→", askX = true},
			{name = "Destituer joueur", action = "demote", ask = "→", askX = true},
			{name = "~r~Quitter mon organisation~s~", action = "leavegang", ask = "→", askX = true}
		  }
		},
		["virer membre"] = {
		  b = {}
		},
		["activite"] = {
		  b = {}
		},
	  }
	}
	
	CreateMenu(BossMenu)
	end
end

AddEventHandler('society:openBossMenu', function(type)
	if type and type == 1 then
	OpenBossMenu(ESX.PlayerData.job.name, type)
	elseif type and type == 2 then
	OpenBossMenu(ESX.PlayerData.job2.name, type)
	end
end)

RegisterCommand("leavejob", function()
	TriggerServerEvent("society:leavejob")
end)

RegisterCommand("leavegang", function()
	TriggerServerEvent("society:leavegang")
end)
