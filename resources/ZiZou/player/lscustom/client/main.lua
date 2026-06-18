local tempData = { veh = 0 }

local listCouleurType = {
	{ name = "Couleur", slidemax = 159, pr = 75 },
	{ name = "Couleur custom" },
}

local availableModsBenny = {30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 44, 45, 48, 49, 50}
local firstPerson = {27, 28, 29, 30, 33, 32, 34}
local capotOpen = {39, 40, 45}
local coffreOpen = {37}
local HasAlreadyEnteredMarker = false

local modificationList = {
	{ id = 0, name = "Aileron", pr = 400 },
	{ id = 1, name = "PC Avant", pr = 300 },
	{ id = 2, name = "PC ArriÃ¨re", pr = 300 },
	{ id = 3, name = "Carroserie", pr = 250 },
	{ id = 4, name = "Pot d'Ã©chappement", pr = 400 },
	{ id = 5, name = "Cadre", pr = 400 },
	{ id = 6, name = "Calandre", pr = 300 },
	{ id = 7, name = "Capot", pr = 400 },
	{ id = 8, name = "GB gauche", pr = 250 },
	{ id = 9, name = "GB droit", pr = 250 },
	{ id = 10, name = "ToÃ®t", pr = 250 },
	{ id = 25, name = "Support plaque", pr = 250 },
	{ id = 26, name = "Plaque avant", pr = 250 },
	{ id = 27, name = "Style intÃ©rieur", pr = 250 }, -- first person
	{ id = 28, name = "Figurine", pr = 250 },  -- first person
	{ id = 29, name = "Motif dashboard", pr = 250 }, -- first person
	{ id = 30, name = "Cadran", pr = 250 },  -- first person
	{ id = 31, name = "Haut-parleur portes", pr = 250 },
	{ id = 32, name = "Motif siÃ¨ges", pr = 250 },
	{ id = 33, name = "Volant", pr = 250 },
	{ id = 34, name = "Levier", pr = 250 },
	{ id = 35, name = "Logo custom", pr = 250 },
	{ id = 36, name = "ICE", pr = 250 },
	{ id = 37, name = "Haut-parleur coffre", pr = 250 }, -- ouvrir coffre
	{ id = 38, name = "Hydrolique", pr = 250 },
	{ id = 39, name = "Moteur", pr = 250 }, -- ouvrir capot
	{ id = 40, name = "Filtres Ã  air", pr = 250 }, -- ouvrir capot
	{ id = 41, name = "Entretoises", pr = 250 },
	{ id = 42, name = "Arc couverture", pr = 250 },
	{ id = 43, name = "Antenne", pr = 250 },
	{ id = 44, name = "Motif extÃ©rieur", pr = 250 },
	{ id = 45, name = "RÃ©servoir", pr = 250 },
	{ id = 46, name = "FenÃªtre", pr = 250 },
	{ id = 48, name = "Style", pr = 250 },
}

local DoesEntityExist = DoesEntityExist
local IsControlJustPressed = IsControlJustPressed

local function ShouldWeCloseTheMenu()
    local playerPed = ESX.PlayerData.cache.playerped
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	if tempData.veh == 0 or not DoesEntityExist(tempData.veh) or not vehicle or not (GetPedInVehicleSeat(tempData.veh, -1) == ESX.PlayerData.cache.playerped) then
		CloseMenu()
		return true
	end
end

local formerVehData = {}

local slideFunction = {
	["couleur intÃ©rieur"] = function(veh, b)
		SetVehicleInteriorColour(veh, b.slidenum and b.slidenum - 1 or 0)
	end,
	["effet couleur"] = function(veh, b)
		local _, w = GetVehicleExtraColours(veh)
		SetVehicleExtraColours(veh, b.slidenum and b.slidenum - 1 or 0, w)
	end,
	["couleur principale"] = function(veh, b, id)
		if b.RGBA then
			local r, g, bb = GetVehicleCustomPrimaryColour(veh)
			ClearVehicleCustomPrimaryColour(veh)
			SetVehicleCustomPrimaryColour(veh, b.RGBA[1] or r, b.RGBA[2] or g, b.RGBA[3] or bb)
		else
			local _, s = GetVehicleColours(veh)
			local color = (b.slidenum or 1) - 1
			ClearVehicleCustomPrimaryColour(veh)
			SetVehicleColours(veh, color, s)
		end
	end,
	["couleur secondaire"] = function(veh, b, id)
		if b.RGBA then
			local r, g, bb = GetVehicleCustomSecondaryColour(veh)
			ClearVehicleCustomSecondaryColour(veh)
			SetVehicleCustomSecondaryColour(veh, b.RGBA[1] or r, b.RGBA[2] or g, b.RGBA[3] or bb)
		else
			local p = GetVehicleColours(veh)
			local color = (b.slidenum or 1) - 1

			ClearVehicleCustomSecondaryColour(veh)
			SetVehicleColours(veh, p, color)
		end
	end,
	["klaxon"] = function(veh, b) SetVehicleMod(veh, 14, b.slidenum - 2, false) end,
	["type de roue"] = function(veh, b, id, menuData, self)
		local allMenu = self.Menu[menuData.currentMenu]
		if not allMenu or not allMenu.b or not allMenu.b[2] then return end
		SetVehicleWheelType(veh, b.slidenum - 1)
		allMenu.b[2].slidenum = 1
		allMenu.b[2].slidemax = GetNumVehicleMods(veh, 23) - 1
	end,
	["modÃ¨le roues principales"] = function(veh, b) SetVehicleMod(veh, 23, b.slidenum - 2, GetVehicleModVariation(veh, 23)) end,
	["modÃ¨le roues arriÃ¨res"] = function(veh, b) SetVehicleMod(veh, 24, b.slidenum - 2, GetVehicleModVariation(veh, 24)) end,
	["couleur roue"] = function(veh, b)
		local a = GetVehicleExtraColours(veh)
		SetVehicleExtraColours(veh, a, b.slidenum and b.slidenum - 1 or 0)
	end,
	["roues customs"] = function(veh, b)
		local enabled = b.slidenum == 2 or false
		SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), enabled)
	end,
	["roues customs arriÃ¨res"] = function(veh, b)
		local enabled = b.slidenum == 2 or false
		SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), enabled)
	end,
	["teinte fenÃªtre"] = function(veh, b) SetVehicleWindowTint(veh, b.slidenum and b.slidenum - 1 or 0) end,
	["couleur tableau de bord"] = function(veh, b) SetVehicleDashboardColour(veh, b.slidenum and b.slidenum - 1 or 0) end,
	["modÃ¨le plaque"] = function(veh, b) SetVehicleNumberPlateTextIndex(veh, b.slidenum and b.slidenum - 1 or 0) end,
	["neons"] = function(veh, b)
		local r, g, bb = GetVehicleNeonLightsColour(veh)
		if b.RGBA then SetVehicleNeonLightsColour(veh, b.RGBA[1] or r, b.RGBA[2] or g, b.RGBA[3] or bb) end
	end,
	["modifications custom"] = function(veh, b) SetVehicleMod(veh, b.id, b.slidenum and b.slidenum - 2 or - 1) end,
	["performances"] = function(veh, b) SetVehicleMod(veh, b.id, b.slidenum and b.slidenum - 2 or - 1) end,
	["modifications benny's"] = function(veh, b) SetVehicleMod(veh, b.id, b.slidenum and b.slidenum - 2 or - 1) end,
	["roues"] = function(veh, b)
		local r, g, bb = GetVehicleTyreSmokeColor(veh)
		if b.RGBA then SetVehicleTyreSmokeColor(veh, b.RGBA[1] or r, b.RGBA[2] or g, b.RGBA[3] or bb) end
	end,
	["livery"] = function(veh, b) SetVehicleLivery(veh, b.slidenum and b.slidenum - 1) end,
	["couleur des phares"] = function(veh, b) SetVehicleXenonLightsColour(veh, b.slidenum and b.slidenum - 1) end,
	["accessoires"] = function(veh, b) SetVehicleExtra(veh, b.id, ((b.slidenum ~= nil and b.slidenum == 1) and 1) or ((b.slidenum ~= nil and b.slidenum == 2) and 0)) end,
}

local function onSlide(menuData, currentButton, currentSlt, self)
	local currentMenu, buttonName = menuData.currentMenu, string.lower(currentButton.name)
	local lastMenu = menuData.back[#menuData.back]

	if ShouldWeCloseTheMenu() then return end
	local slidenum = currentButton.slidenum and currentButton.slidenum - 1 or 0
	if currentMenu == "couleur principale" or currentMenu == "couleur secondaire" then -- extra args
		buttonName = currentMenu
		if currentSlt == 1 then currentButton.pType = slidenum end
	elseif currentMenu == "couleur custom" then
		buttonName = lastMenu.menu
		currentButton.RGBA = { [currentSlt] = slidenum }
	elseif currentMenu == "modifications custom" or (currentMenu == "roues" and currentSlt == 5) or currentMenu == "modifications benny's" or currentMenu == "performances" then
		buttonName = currentMenu
	end

	local slideFunc = slideFunction[buttonName] or slideFunction[currentMenu]
	--[[if LSCustomMenuType == "upgrades" then
		slideFunc = slideFunction["performances"]
	end]]
	if slideFunc then
		slideFunc(tempData.veh, currentButton, currentSlt, menuData, self)
	end
end

local function GetModObjects(veh, mod)
	local tbl = {"DÃ©faut"}
	for i = 0, tonumber(GetNumVehicleMods(veh,mod)) - 1 do
		local toBeInserted = "0"
		local labelName = GetModTextLabel(veh,mod,i)
		if labelName ~= nil then
			local name = tostring(GetLabelText(labelName))
			if name ~= "NULL" then
				toBeInserted = name
			end
		end
		tbl[#tbl + 1] = toBeInserted
	end

	return tbl
end

local function getAllCustomFromVeh(BENNY)
	local veh, tbl = tempData.veh, {}
	if ShouldWeCloseTheMenu() then return tbl end

	for _,v in pairs(modificationList) do
		local INSIDE = tableHasValue(availableModsBenny, v.id)
		if BENNY and INSIDE or not BENNY and not INSIDE then
			local num = GetNumVehicleMods(veh, v.id)
			if num and num > 0 then
				tbl[#tbl + 1] = { name = v.name, slidemax = GetModObjects(veh, v.id), customSlidenum = GetVehicleMod(veh, v.id) + 2, id = v.id, pr = v.pr or 200 }
			end
		end
	end

	return tbl
end

local function getExtraFromVehicle()
	local veh, tbl = tempData.veh, {}
	if ShouldWeCloseTheMenu() then return {} end

	for i = 0, 20 do
		if DoesExtraExist(veh, i) then
			tbl[#tbl + 1] = { name = "Extra #" .. i, id = i, slidemax = {"OFF", "ON"}, customSlidenum = function() return IsVehicleExtraTurnedOn(veh, i) and 2 or 1 end, pr = 50 }
		end
	end

	return tbl
end

local function onButtonSelected(this, currentSlt, old, currentButton)
	if ShouldWeCloseTheMenu() or not currentButton or not currentButton.name then return end

	SetVehicleDoorShut(tempData.veh, 5, true)
	SetVehicleDoorShut(tempData.veh, 4, true)
	if GetFollowVehicleCamViewMode() == 4 then SetFollowVehicleCamViewMode(0) end

	if currentButton.id then
		local shouldOpenTrunk = tableHasValue(coffreOpen, currentButton.id)
		local shouldOpenCapot = tableHasValue(capotOpen, currentButton.id)
		local shouldToggleFirst = tableHasValue(firstPerson, currentButton.id)

		if shouldOpenTrunk or shouldOpenCapot then
			SetVehicleDoorOpen(tempData.veh, shouldOpenTrunk and 5 or 4, false, true)
		end

		if shouldToggleFirst then
			SetFollowVehicleCamViewMode(4)
		end
	end
end

local function canPayCustom(user, price)
	return true
end

local function onSelected(self, menuData, currentButton, currentSlt, allButtons)
	local currentMenu, customPr = menuData.currentMenu
	local buttonName, user = string.lower(currentButton.name), ESX.PlayerData
	local checkbox = currentButton.checkbox ~= nil and currentButton.checkbox()

	if currentMenu == "couleur custom" then currentMenu = menuData.back[#menuData.back].menu end
	if currentButton.name == "couleur custom" or currentMenu == "menu de personnalisation" then return end

	if user and (not currentButton.pr or canPayCustom(user, currentButton.pr)) then
		if currentButton.toggle then
			local enable = not checkbox
			ToggleVehicleMod(tempData.veh, currentButton.toggle, enable)
			if not enable then customPr = 0 end
			formerVehData.mods[currentButton.toggle] = enable and 1 or -1
		elseif currentMenu == "performances" and currentButton.id then
			customPr = currentButton.pr * currentButton.slidenum
			if not canPayCustom(user, customPr) then return end
			formerVehData.mods[currentButton.id] = currentButton.slidenum - 2
		elseif (currentMenu == "modifications custom" or currentMenu == "modifications benny's" or currentMenu == "modifications classiques") and currentButton.id then
			local id = currentButton.slidenum - 2
			customPr = id == -1 and 0 or currentButton.pr
			if not canPayCustom(user, customPr) then return end
			formerVehData.mods[currentButton.id] = id
		elseif currentMenu == "modifications classiques" then
			if buttonName == "teinte fenÃªtre" then
				formerVehData.win = currentButton.slidenum - 1
			elseif buttonName == "modÃ¨le plaque" then
				formerVehData.pl = currentButton.slidenum - 1
			elseif buttonName == "livery" then
				formerVehData.t = currentButton.slidenum - 1
			elseif buttonName == "couleur des phares" then
				formerVehData.he = currentButton.slidenum - 1
			end
		elseif currentMenu == "neons" then
			if currentButton.checkbox ~= nil then
				local enable = not checkbox
				SetVehicleNeonLightEnabled(tempData.veh, currentSlt - 1, enable)
				formerVehData.neon[1] = formerVehData.neon[1] or {}
				formerVehData.neon[1][currentSlt] = enable
				if not enable then customPr = 0 end
			else
				customPr = 250
				if not canPayCustom(user, customPr) then return end
				formerVehData.neon[2] = { allButtons[1].slidenum or 0, allButtons[2].slidenum or 0, allButtons[3].slidenum or 0 }
			end
		elseif currentMenu == "couleur principale" or currentMenu == "couleur secondaire" then
			if currentButton.name == "Type" then return end
			customPr = currentButton.pr
			if not customPr or not canPayCustom(user, customPr) then return end

			local boolSecondary = currentMenu == "couleur secondaire"
			formerVehData[boolSecondary and "cs" or "c"] = boolSecondary and table.pack(GetVehicleCustomSecondaryColour(tempData.veh)) or table.pack(GetVehicleCustomPrimaryColour(tempData.veh))
		elseif currentMenu == "peintures" then
			if buttonName == "couleur intÃ©rieur" then
				formerVehData.intC = currentButton.slidenum - 1
			elseif buttonName == "couleur tableau de bord" then
				formerVehData.da = currentButton.slidenum - 1
			elseif buttonName == "effet couleur" then
				formerVehData.c2 = formerVehData.c2 or {}
				formerVehData.c2[1] = currentButton.slidenum - 1
			end
		elseif currentMenu == "roues" then
			if buttonName == "couleur roue" then
				formerVehData.c2 = formerVehData.c2 or {}
				formerVehData.c2[2] = currentButton.slidenum - 1
			elseif buttonName == "roues customs" then
				formerVehData.cw = formerVehData.cw or {}
				formerVehData.cw[1] = currentButton.slidenum - 1
			elseif buttonName == "roues customs arriÃ¨res" then
				formerVehData.cw = formerVehData.cw or {}
				formerVehData.cw[2] = currentButton.slidenum - 1
			elseif currentButton.id then
				formerVehData.wt = allButtons[1].slidenum - 1
				formerVehData.mods[currentButton.id] = currentButton.slidenum - 2
			elseif currentButton.slidemax then
				customPr = 250
				if not canPayCustom(user, customPr) then return end
				formerVehData.tr = table.pack(GetVehicleTyreSmokeColor(tempData.veh))
			end
		elseif currentMenu == "accessoires" then
			formerVehData.ext = formerVehData.ext or {}
			if currentButton.slidenum == 2 then
				formerVehData.ext[currentButton.id] = 0
			else
				formerVehData.ext[currentButton.id] = 1
			end
		end

		local currentMenu = self.Data.currentMenu
		local useMult = currentMenu == "performances" and currentButton.slidemax
		local price = customPr or currentButton.pr
		if price then
			if useMult then
			    price = price * (currentButton.slidenum or 1)
			end
			price = math.floor((price * tempData.price) / 10000)
			if useMult then
				price = math.floor(price / 40)
			end
			ESX.TriggerServerCallback("esx:buyLSCustom", function(validate)
				if validate then
					SetVehicleCustom(tempData.veh, formerVehData)
				end
			end, {price = price, vehicle = ESX.Game.GetVehicleProperties(tempData.veh)})
		end
	else
		ESX.ShowNotification("~r~Vous ne pouvez pas payer.~s~")
	end
end

local function onRender(self, allButtons, currentButton)
	local currentMenu = self.Data.currentMenu
	if currentMenu == "menu de personnalisation" or not currentButton then return end
	local useMult = currentMenu == "performances" and currentButton.slidemax
	local price = currentButton.pr

	if price then
		if useMult then
			price = price * (currentButton.slidenum or 1)
		end
		price = math.floor((price * tempData.price) / 10000)
		if useMult then
			price = math.floor(price / 40)
			price = price * 4
		end
		DrawText2(0, "~g~" .. price .. "$", 3.0, 1.0, .825, {255, 255, 255}, true, 2)
	end
end

function GetCurrentVehiclePrice()
	local vehicle = GetEntityModel(tempData.veh)
	local found = false
	for k, v in pairs(Vehicles) do
		if tostring(vehicle) == tostring(GetHashKey(v.model)) then
			tempData.price = v.price
			found = true
		end
	end
	if not found then
		tempData.price = 1500000
	end
end

local menuOpen
LSCustomMenuType = ""
local LSCustomMenu = {
	Base = { Header = {"shopui_title_supermod", "shopui_title_supermod"}, Title = "" },
	Data = { currentMenu = "menu de personnalisation" },
	Events = {
		onOpened = function()
			RequestStreamedTextureDict("shopui_title_supermod", false)
			tempData.veh = ESX.PlayerData.cache.vehicle
			tempData.price = 0
			GetCurrentVehiclePrice()
			SetVehicleModKit(tempData.veh, 0)
			formerVehData = GetCustomData(tempData.veh, false, true)
			FreezeEntityPosition(tempData.veh, true)
			SetEntityInvincible(tempData.veh, true)
			SetStreamedTextureDictAsNoLongerNeeded("shopui_title_supermod")
		end,
		onRender = onRender,
		onSlide = onSlide,
		onSelected = onSelected,
		onButtonSelected = onButtonSelected,
		onExited = function()
			FreezeEntityPosition(tempData.veh, false)
			SetEntityInvincible(tempData.veh, false)
			SetVehicleCustom(tempData.veh, formerVehData)
			tempData = {}
			formerVehData = {}
			menuOpen = nil
		end
	},
	Menu = {
		["menu de personnalisation"] = {
			b = {
				{ name = "Peintures", canSee = function() return LSCustomMenuType == "cosmetics" end },
				{ name = "Roues", canSee = function() return LSCustomMenuType == "cosmetics" end },
				{ name = "Modifications classiques", canSee = function() return LSCustomMenuType == "cosmetics" end },
				{ name = "Modifications custom", canSee = function() return LSCustomMenuType == "cosmetics" end },
				{ name = "Modifications Benny's", canSee = function() return LSCustomMenuType == "cosmetics" end },
				{ name = "Performances", canSee = function() return LSCustomMenuType == "upgrades" end },
				{ name = "Neons", canSee = function() return IsThisModelACar(GetEntityModel(tempData.veh)) and LSCustomMenuType == "cosmetics" end },
				{ name = "Accessoires", canSee = function() return LSCustomMenuType == "cosmetics" end },
			}
		},
		["modifications classiques"] = {
			b = {
				{ name = "Klaxon", pr = 80, id = 14, slidemax = function() return GetNumVehicleMods(tempData.veh, 14) - 1 end, customSlidenum = function() return GetVehicleMod(tempData.veh, 14) + 2 end },
				{ name = "Teinte fenÃªtre", pr = 200, slidemax = {"Normale", "Noire", "FumÃ©e noire", "FumÃ©e simple", "Stock", "Limousine"}, customSlidenum = function() return math.max(1, math.min(10, GetVehicleWindowTint(tempData.veh) + 1)) end },
				{ name = "Phares xenons", pr = 200, toggle = 22, checkbox = function() return IsToggleModOn(tempData.veh, 22) ~= false end },
				{ name = "ModÃ¨le plaque", pr = 150, slidemax = {"DÃ©faut", "San Andreas noir", "San Andreas bleu", "San Andreas blanc", "Simple blanche", "Yankton blanche"}, customSlidenum = function() return GetVehicleNumberPlateTextIndex(tempData.veh) + 1 end },
				{ name = "Livery", pr = 700, slidemax = function() return GetVehicleLiveryCount(tempData.veh) - 1 end },
				{ name = "Couleur des phares", pr = 250, slidemax = 12 },
			}
		},
		["roues"] = {
			slidertime = 75,
			b = {
				{ name = "Type de roue", slidemax = {"Sport", "Muscle", "Lowrider", "SUV", "Offroad", "Tuner", "Moto", "High end", "Bespokes Originals", "Bespokes Smokes"}, customSlidenum = function() return GetVehicleWheelType(tempData.veh) + 1 end },
				{ name = "ModÃ¨le roues principales", pr = 300, id = 23, slidemax = function() return GetNumVehicleMods(tempData.veh, 23) - 1 end },
				{ name = "ModÃ¨le roues arriÃ¨res", pr = 300, id = 24, slidemax = function() return GetNumVehicleMods(tempData.veh, 24) - 1 end, canSee = function() return IsThisModelABike(GetEntityModel(tempData.veh)) end },
				{ name = "Couleur roue", pr = 90, slidemax = 160 },
				{ name = "FumÃ©e pneus", pr = 3000, toggle = 20, checkbox = function() return IsToggleModOn(tempData.veh, 20) ~= false end },
				{ name = "Couleur custom", pr = 200 },
				{ name = "Roues customs", pr = 90, slidemax = {"DÃ©sactiver", "Activer"}, customSlidenum = function() return GetVehicleModVariation(tempData.veh, 23) == 1 and 2 or 1 end},
				{ name = "Roues customs arriÃ¨res", pr = 90, slidemax = {"DÃ©sactiver", "Activer"}, customSlidenum = function() return GetVehicleModVariation(tempData.veh, 24) == 1 and 2 or 1 end, canSee = function() return IsThisModelABike(GetEntityModel(tempData.veh)) end},
			}
		},
		["performances"] = {
			b = {
				{ name = "Suspension", pr = 400, slidemax = function() return table.move({"Stock", "RabaissÃ©e", "Rue", "Sport", "Course"}, 1, GetNumVehicleMods(tempData.veh, 15) + 1, 1, {}) end, customSlidenum = function() return GetVehicleMod(tempData.veh, 15) + 2 end, id = 15 },
				{ name = "Transmission", pr = 500, slidemax = function() return table.move({"Stock","Rue", "Sport", "Course"}, 1, GetNumVehicleMods(tempData.veh, 13) + 1, 1, {}) end, customSlidenum = function() return GetVehicleMod(tempData.veh, 13) + 2 end, id = 13 },
				{ name = "Moteur", pr = 2400, slidemax = function() return table.move({"Stock", "Evo 1", "Evo 2", "Evo 3", "Evo max"}, 1, GetNumVehicleMods(tempData.veh, 11) + 1, 1, {}) end, customSlidenum = function() return GetVehicleMod(tempData.veh, 11) + 2 end, id = 11 },
				{ name = "Frein", pr = 1000, slidemax = function() return table.move({"Stock", "Rue", "Sport", "Course"}, 1, GetNumVehicleMods(tempData.veh, 11) + 1, 1, {}) end, customSlidenum = function() return GetVehicleMod(tempData.veh, 12) + 2 end, id = 12 },
				{ name = "Turbo", pr = 5000, toggle = 18, checkbox = function() return IsToggleModOn(tempData.veh, 18) ~= false end, canSee = function() return IsThisModelACar(GetEntityModel(tempData.veh)) end },
			}
		},
		["peintures"] = {
			slidertime = 75,
			b = {
				{ name = "Couleur principale" },
				{ name = "Couleur secondaire" },
				{ name = "Couleur intÃ©rieur", slidemax = 158, pr = 125 },
				{ name = "Couleur tableau de bord", slidemax = 158, pr = 125 },
				{ name = "Effet couleur", slidemax = 158, pr = 300 },
			}
		},
		["couleur custom"] = { slidertime = 25, b = { { name = "Rouge", slidemax = 255, pr = 50 }, { name = "Vert", slidemax = 255, pr = 50 }, { name = "Bleu", slidemax = 255, pr = 50 } } },
		["couleur principale"] = { slidertime = 75, b = listCouleurType },
		["couleur secondaire"] = { slidertime = 75, b = listCouleurType },
		["accessoires"] = {
			b = getExtraFromVehicle
		},
		["neons"] = {
			b = {
				{ name = "NÃ©on gauche", pr = 1500, checkbox = function() return IsVehicleNeonLightEnabled(tempData.veh, 0) == 1 end },
				{ name = "NÃ©on droit", pr = 1500, checkbox = function() return IsVehicleNeonLightEnabled(tempData.veh, 1) == 1 end },
				{ name = "NÃ©on avant", pr = 1500, checkbox = function() return IsVehicleNeonLightEnabled(tempData.veh, 2) == 1 end },
				{ name = "NÃ©on arriÃ¨re", pr = 1500, checkbox = function() return IsVehicleNeonLightEnabled(tempData.veh, 3) == 1 end },
				{ name = "Couleur custom", pr = 330 }
			}
		},
		["modifications custom"] = {
			b = function() return getAllCustomFromVeh() end
		},
		["modifications benny's"] = {
			b = function() return getAllCustomFromVeh(true) end
		}
	}
}

function OpenLSCustomMenu(Type)
	if CheckIsMechanic(ESX.PlayerData.job.name) then
		menuOpen = true
		LSCustomMenuType = Type
		CreateMenu(LSCustomMenu)
	end
end

local toggleMods = {18, 20, 22}
function GetCustomData(veh, boolColor, boolAll)
	local mods = {}
	for i = 0,48 do
		local idMod = tableHasValue(toggleMods, i) and tonumber(IsToggleModOn(veh, i)) or GetVehicleMod(veh, i)
		if idMod or boolAll then
			mods[i] = idMod ~= -1 and idMod
		end
	end

	local ext = {}
	for i = 0, 20 do
		if DoesExtraExist(veh, i) then
			local hasExtra = IsVehicleExtraTurnedOn(veh, i)
			if hasExtra then
				ext[i] = 0
			elseif not hasExtra then
				ext[i] = 1
			end
		end
	end

	local colors, extra_colors, secondaryColor, pl, win, wt, neon, tr, tgn, intC, da = table.pack(GetVehicleCustomPrimaryColour(veh)), table.pack(GetVehicleExtraColours(veh)), table.pack(GetVehicleCustomSecondaryColour(veh)), GetVehicleNumberPlateTextIndex(veh), GetVehicleWindowTint(veh), GetVehicleWheelType(veh), table.pack(GetVehicleNeonLightsColour(veh)), table.pack(GetVehicleTyreSmokeColor(veh)), { IsVehicleNeonLightEnabled(veh, 0), IsVehicleNeonLightEnabled(veh, 1), IsVehicleNeonLightEnabled(veh, 2), IsVehicleNeonLightEnabled(veh, 3) }, GetVehicleInteriorColour(veh), GetVehicleDashboardColour(veh)
	local ty1, _, _ = GetVehicleModColor_1(veh)
	local ty2, _, _ = GetVehicleModColor_2(veh)

	return { ext = ext, t = GetVehicleLivery(veh), da = da, intC = intC, ty1 = boolColor and ty1, ty2 = boolColor and ty2, tr = tr, pl = pl == -1 and 0 or pl, win = win, neon = { tgn, neon }, wt = wt, c = colors, cs = secondaryColor, c2 = extra_colors, mods = mods, he = GetVehicleXenonLightsColour(veh) }
end

function SetVehicleCustom(veh, c, colors)
	SetVehicleModKit(veh, 0)
	
	if c.c then
		ClearVehicleCustomPrimaryColour(veh)
		if colors and colors.ty1 then
			SetVehicleModColor_1(veh, colors.ty1)
		end
		SetVehicleCustomPrimaryColour(veh, c.c[1] or c.c["1"], c.c[2] or c.c["2"], c.c[3] or c.c["3"] or 0)
	end

	if c.cs then
		ClearVehicleCustomSecondaryColour(veh)
		if colors and colors.ty2 then
			SetVehicleModColor_2(veh, colors.ty2)
		end
		SetVehicleCustomSecondaryColour(veh, c.cs[1] or c.cs["1"], c.cs[2] or c.cs["2"], c.cs[3] or c.cs["3"] or 0)
	end

	if c.intC then SetVehicleInteriorColour(veh, c.intC) end
	if c.c2 then SetVehicleExtraColours(veh, c.c2[1] or c.c2["1"], c.c2[2] or c.c2["2"]) end
	if c.pl and c.pl >= 0 then SetVehicleNumberPlateTextIndex(veh, c.pl) end
	if c.neon and c.neon[1] then
		c.neon[1] = type(c.neon[1]) ~= "table" and {} or c.neon[1]
		for k,v in pairs(c.neon[1]) do
			SetVehicleNeonLightEnabled(veh, k - 1, v)
		end
		SetVehicleNeonLightsColour(veh, c.neon[2][1] or c.neon[2]["1"], c.neon[2][2] or c.neon[2]["2"], c.neon[2][3] or c.neon[2]["3"])
	end
	if c.win then SetVehicleWindowTint(veh, c.win) end
	if c.wt then SetVehicleWheelType(veh, c.wt) end
	if c.da then SetVehicleDashboardColour(veh, c.da) end
	if c.he then SetVehicleXenonLightsColour(veh, c.he) end
	if c.mods then
		for n,l in pairs(c.mods) do
			local modId = tonumber(n)
			local modValue = tonumber(l)

			if not tableHasValue(toggleMods, modId) then
				SetVehicleMod(veh, modId, modValue or -1)
			else
				ToggleVehicleMod(veh, modId, modValue and modValue >= 0)
			end
		end
	end
	if c.t then SetVehicleLivery(veh, c.t) end
	if c.tr and #c.tr > 2 then SetVehicleTyreSmokeColor(veh, c.tr[1] or c.tr["1"], c.tr[2] or c.tr["2"], c.tr[3] or c.tr["3"]) end
	if c.ext then
		for i = 0, 20 do
			if DoesExtraExist(veh, i) then
				if c.ext[i] ~= nil then
					SetVehicleExtra(veh, i, c.ext[i])
				end
			end
		end
	end
end

function tableHasValue(tbl, value, k)
	if not tbl or not value or type(tbl) ~= "table" then return end
	for _,v in pairs(tbl) do
		if k and v[k] == value or v == value then return true, _ end
	end
end

function table.GetKeys( tab, safeKeys )
	local keys = {}
	local id = 1

	for k, v in pairs( tab ) do
		keys[ id ] = safeKeys and SQLStr(k) or k
		id = id + 1
	end
	return keys
end