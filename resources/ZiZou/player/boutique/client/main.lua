local weaponTintList = {
"WEAPON_PISTOL",
"WEAPON_PISTOL50",
"WEAPON_APPISTOL",
"WEAPON_ASSAULTRIFLE",
"WEAPON_COMPACTRIFLE",
"WEAPON_CARBINERIFLE",
"WEAPON_MICROSMG",
"WEAPON_SMG",
}

local WeaponTintIndexes = {
	["gold"] = 2,
	["blue"] = 5,
	["pink"] = 3,
	["orange"] = 6,
	["green"] = 1,
	["platine"] = 7
}

local AvantagesRanks = {
	["vip"] = {
		{name = "L'aide de l'état est multipliée par 1.5"},
		{name = "Accès à des armes exclusives dans l'ammu-nation et le marché noir"},
		{name = "Le /afk vous rapporte 1500$ toutes les 10 minutes au lieu de 1000$"},
		{name = "Les prix de revente des drogues est multiplié par 1.25"},
		{name = "Vous pouvez appliquer des skins d'armes avec le menu VIP f11"},
		{name = "Vous ne perdez pas vos armes lorsque vous mourrez (seulement si vous attendez de respawn à l'hopital)"}
	},
	["diamond"] = {
		{name = "L'aide de l'état est multipliée par 2"},
		{name = "Accès à des armes exclusives dans l'ammu-nation et le marché noir"},
		{name = "Le /afk vous rapporte 2500$ toutes les 10 minutes au lieu de 1000$"},
		{name = "Les prix de revente des drogues est multiplié par 1.5"},
		{name = "Vous pouvez appliquer des skins d'armes avec le menu VIP f11"},
		{name = "Vous ne perdez pas vos armes lorsque vous mourrez (seulement si vous attendez de respawn à l'hopital)"}
	}
}

-- Perm Weapons Sync
RegisterCommand("syncperm", function()
	TriggerEvent('esx:restorePermLoadout')
end)

function OpenCaisseMenu()
    menuOpen = true
    caisseMenu.Menu["Ouvre ta caisse !"].b = {}

    for caseName, case in pairs(StoreConfig.Case) do
        if case.visible then
            table.insert(caisseMenu.Menu["Ouvre ta caisse !"].b, {
                name = case.name,
                ask = case.point .. " points",
                askX = true,
                action = "open_case",
                value = caseName
            })
        end
    end

    caisseMenu.Events.onSelected = function(self, _, btn)
        if btn.action == "open_case" then
            TriggerServerEvent('store:openCase', btn.value)
        end
    end

    CreateMenu(caisseMenu)
end


function TintWeapon(model, tint)
	for _, TintNum in pairs(weaponTintList) do
		if model == GetHashKey(TintNum) then
			SetPedWeaponTintIndex(ESX.PlayerData.cache.playerped, GetHashKey(TintNum), tint)
		end
	end
end

StoreMenu = {
	Base = { Title = "Boutique", HeaderColor = {255, 0, 0}, Blocked = false},
	Data = { currentMenu = "boutique" },
  
	Events = {
	  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
        if btn.action == 'weapons' then
            StoreMenu.Menu["Armes"].b = {}
            for _,item in ipairs(StoreConfig.Weapons) do
				if item.Type == 'normal' then
					
                table.insert(StoreMenu.Menu["Armes"].b, {name = ESX.GetWeaponLabel(item.NameWeapon), item = item.NameWeapon, weatype = item.Type, type = 'weapon', action = 'buyitem', sprite = item.Preview, ask = item.Point .. ' ~b~' .. ZiZouConfig.StorePointsName, askX = true})
				elseif item.Type == 'perm' then
				table.insert(StoreMenu.Menu["Armes"].b, {name = '~r~[PERM] ' .. ESX.GetWeaponLabel(item.NameWeapon), item = item.NameWeapon, weatype = item.Type, type = 'weapon', action = 'buyitem', sprite = item.Preview, ask = item.Point .. ' ~b~' .. ZiZouConfig.StorePointsName, askX = true})
			end
			end
            OpenMenu("Armes")



        elseif btn.action == 'vehicles' then
			CloseMenu()
			StartBoutiquePreview()
		elseif btn.action == 'showpacks' then
			StoreMenu.Menu["packpreview"].b = {} 
		
			for key, item in pairs(StoreConfig.Packs) do
				table.insert(StoreMenu.Menu["packpreview"].b, {name = item.name, item = key,  type = item.type, prix = item.price,  action = 'previewpack', sprite = item.Preview, ask = tostring(item.price) .. ' ~b~' .. ZiZouConfig.StorePointsName,  askX = true})
			end
		
			OpenMenu("packpreview") 

		elseif btn.action == 'caisses' then
			StoreMenu.Menu["caisses"].b = {} 
			

		
			for key, item in pairs(StoreConfig.Case) do
				if item.visible then
				table.insert(StoreMenu.Menu["caisses"].b, {name = item.name, type = "caisse" , weatype = '', action = 'buycaisse', item = item.caissename, sprite = item.Preview, ask = tostring(item.point) .. ' ~b~' .. ZiZouConfig.StorePointsName,  askX = true})
			end
		end

 
            OpenMenu("caisses")




		elseif btn.action == 'openLink' then
			SendNUIMessage({
				action = 'openLink',
				url = ZiZouConfig.TebexURL
			})

		elseif btn.action == 'openticketdiscord' then
ESX.ShowNotification('Veuillez créer un ticket sur le discord de : '.. ZiZouConfig.ServerName..'\nLe voici : ' .. ZiZouConfig.DiscordURL)
		
		elseif btn.action == 'openmtblue' then
			SendNUIMessage({
				action = 'openLink',
				url = ZiZouConfig.Boutique.MasterTeam.Blue.url
			})

		elseif btn.action == 'openmtjaune' then
			
			SendNUIMessage({
				action = 'openLink',
				url = ZiZouConfig.Boutique.MasterTeam.Jaune.url
			})

		elseif btn.action == 'openmtorange' then
		
			SendNUIMessage({
				action = 'openLink',
				url = ZiZouConfig.Boutique.MasterTeam.Orange.url
			})
		elseif btn.action == 'openmtrouge' then
			SendNUIMessage({
				action = 'openLink',
				url = ZiZouConfig.Boutique.MasterTeam.Rouge.url
			})

		elseif btn.action == 'previewpack' then
            StoreMenu.Menu["preview pack"].b = {}
			table.insert(StoreMenu.Menu["preview pack"].b, {name = '~y~Acheter Le Pack', item = btn.item, weatype = '', type = 'pack', action = 'buyitem', ask = btn.prix .. ' ~b~' .. ZiZouConfig.StorePointsName, askX = true})
            for _,item in ipairs(StoreConfig.Packs[btn.item].loots) do
                table.insert(StoreMenu.Menu["preview pack"].b, {name = item.name, item = item.item, type = 'pack', action = 'null'})
            end
            OpenMenu("preview pack")

        elseif btn.action == 'info' then
            StoreMenu.Menu["Informations"].b = {}
            table.insert(StoreMenu.Menu["Informations"].b, {name = 'UUID : ~r~' .. ESX.PlayerData.uuid, action = 'null'})
            table.insert(StoreMenu.Menu["Informations"].b, {name = 'Grade : ~b~' .. ESX.PlayerData.rank, action = 'null'})
            table.insert(StoreMenu.Menu["Informations"].b, {name = ZiZouConfig.StorePointsName .. ' : ~y~' .. ESX.PlayerData.storepoints, action = 'null'})
            table.insert(StoreMenu.Menu["Informations"].b, {name = "Contact : " .. ZiZouConfig.DiscordURL, action = "null"})
            
            OpenMenu("Informations")


		elseif btn.action == 'masterteam' then
            OpenMenu("MasterTeam")

		elseif btn.action == 'autres' then
            OpenMenu("Autres")

        elseif btn.action == 'buyitem' then
            TriggerServerEvent('store:buyItem', btn.type, btn.item, btn.weatype)
            CloseMenu()
			SendNUIMessage({
				action = 'hidePreviewImagee'
			})

		elseif btn.action == 'buycaisse' then
			local caisseName = btn.item
			local caissePoint = 0

			for k, v in pairs(StoreConfig.Case) do
				if v.caissename == caisseName then
					caissePoint = v.point
					break
				end
			end

			TriggerServerEvent('store:achatCaisse', caisseName, caissePoint)
			SendNUIMessage({
				action = 'hidePreviewImagee'
			})
			CloseMenu()


		elseif btn.action == 'buyrank' then
            TriggerServerEvent('store:buyItem', btn.type, btn.item, btn.weatype)
            CloseMenu()
			SendNUIMessage({
				action = 'hidePreviewImage'
			})
		elseif btn.action == "ranks" then
			OpenMenu("Grades")
		elseif btn.action == "previewrank" then
			if AvantagesRanks[btn.item] then
				StoreMenu.Menu["preview grade"].b = {}
				table.insert(StoreMenu.Menu["preview grade"].b, {name = "Acheter le grade " .. string.upper(btn.item) .. " (1 mois) : " .. btn.ask, action = "buyitem", item = btn.item, type = "rank"})
			    for k, v in pairs(AvantagesRanks[btn.item]) do 
					table.insert(StoreMenu.Menu["preview grade"].b, {name = v.name, action = "null"})
				end
				OpenMenu("preview grade")
			end
        end
	end,
	onButtonSelected = function(currentaMenu, k, j, btn, self)
		if btn.sprite then
			SendNUIMessage({
				action = 'showPreviewImagePack',
				image = btn.sprite
			})
		else
			SendNUIMessage({
				action = 'hidePreviewImagee'
			})
		end 
	end
  },
  
  Menu = {
	["boutique"] = {
	  b = {
	  }
	},
    ["Armes"] = {
        b = {
        }
    },
	["packpreview"] = {
        b = {
        }
    },
    ["Vehicules"] = {
        b = {
        }
    },
	["caisses"] = {
        b = {
        }
    },
	["Grades"] = {
        b = {
			{name = "Grade ~y~VIP~s~ (1 Mois)", action = "buyrank", item = "vip", type = "rank", ask = '1.000' .. ' ~b~' .. ZiZouConfig.StorePointsName, askX = true},
			{name = "Grade ~b~DIAMOND~s~ (1 Mois)", action = "buyrank", item = "diamond", type = "rank", ask = '2.000' .. ' ~b~' .. ZiZouConfig.StorePointsName, askX = true}
        }
    },
    ["pack"] = {
        b = {
			{name = '~r~' .. 'Pack Illegal', item = 'illegal', type = 'pack', prix = 3000, action = 'previewpack', ask = '3.000' .. ' ~b~' .. ZiZouConfig.StorePointsName, askX = true},
			{name = '~g~' .. 'Pack legal', item = 'legal', type = 'pack', prix = 2500, action = 'previewpack', ask = '2.500' .. ' ~b~' .. ZiZouConfig.StorePointsName, askX = true}
        }
    },
	["preview pack"] = {
        b = {
			
        }
    },
	["preview grade"] = {
        b = {
			
        }
    },
    ["Informations"] = {
        b = {
        }
    },
	["Autres"] = {
        b = {
			{name = ZiZouConfig.Boutique.Autres.ChangeUUID.name_btn, action = 'openticketdiscord', ask = ZiZouConfig.Boutique.Autres.ChangeUUID.price, askX = true},
			{name = ZiZouConfig.Boutique.Autres.Vehicule_UNIQUE.name_btn, action = 'openticketdiscord', ask = ZiZouConfig.Boutique.Autres.Vehicule_UNIQUE.price, askX = true},
			{name = ZiZouConfig.Boutique.Autres.Property_UNIQUE.name_btn, action = 'openticketdiscord', ask = ZiZouConfig.Boutique.Autres.Property_UNIQUE.price, askX = true},
			{name = ZiZouConfig.Boutique.Autres.Entreprise.name_btn, action = 'openticketdiscord', ask = ZiZouConfig.Boutique.Autres.Entreprise.price, askX = true},
			{name = ZiZouConfig.Boutique.Autres.Organisation.name_btn, action = 'openticketdiscord', ask = ZiZouConfig.Boutique.Autres.Organisation.price, askX = true},
			{name = ZiZouConfig.Boutique.Autres.Gang.name_btn, action = 'openticketdiscord', ask = ZiZouConfig.Boutique.Autres.Gang.price, askX = true},
        }
    },
	["MasterTeam"] = {
        b = {
			{name = ZiZouConfig.Boutique.MasterTeam.Blue.name_btn, action = 'openmtblue', ask = ZiZouConfig.Boutique.MasterTeam.Blue.price, askX = true},
			{name = ZiZouConfig.Boutique.MasterTeam.Jaune.name_btn, action = 'openmtjaune', ask = ZiZouConfig.Boutique.MasterTeam.Jaune.price, askX = true},
			{name = ZiZouConfig.Boutique.MasterTeam.Orange.name_btn, action = 'openmtorange', ask = ZiZouConfig.Boutique.MasterTeam.Orange.price, askX = true},
			{name = ZiZouConfig.Boutique.MasterTeam.Rouge.name_btn, action = 'openmtrouge', ask = ZiZouConfig.Boutique.MasterTeam.Rouge.price, askX = true},
        }
    },
  }
}

function OpenStoreMenu()
	StoreMenu.Menu["boutique"].b = {}
	table.insert(StoreMenu.Menu["boutique"].b, {name = '		    Votre UUID : '..ZiZouConfig.DefaultColorCode..'' .. ESX.PlayerData.uuid, action = 'null'})
	table.insert(StoreMenu.Menu["boutique"].b, {name = '		    Vos '..ZiZouConfig.StorePointsName..': ~y~' .. ESX.PlayerData.storepoints, action = 'null'})
	table.insert(StoreMenu.Menu["boutique"].b, {name = "                     Achetez des "..ZiZouConfig.StorePointsName.."",action = "openLink", })
	table.insert(StoreMenu.Menu["boutique"].b, {name = "Véhicules", action = "vehicles", ask = "→", askX = true})
    table.insert(StoreMenu.Menu["boutique"].b, {name = "Armes", action = "weapons", ask = "→", askX = true, selected = true})
	table.insert(StoreMenu.Menu["boutique"].b, {name = "Grades VIP", action = "ranks", ask = "→", askX = true})
    table.insert(StoreMenu.Menu["boutique"].b, {name = "Packs", action = "showpacks", ask = "→", askX = true})
	table.insert(StoreMenu.Menu["boutique"].b, {name = "Caisses Mystères", action = "caisses", ask = "→", askX = true})
	--table.insert(StoreMenu.Menu["boutique"].b, {name = "Master Team", action = "masterteam", ask = "→", askX = true})
	table.insert(StoreMenu.Menu["boutique"].b, {name = "Autres", action = "autres", ask = "→", askX = true})
 --   table.insert(StoreMenu.Menu["boutique"].b, {name = "Informations", action = "info", ask = "→", askX = true})

    CreateMenu(StoreMenu)
end

RegisterCommand("+store", function()
    OpenStoreMenu()
end)

RegisterKeyMapping("+store", "Boutique", "keyboard", "f1")