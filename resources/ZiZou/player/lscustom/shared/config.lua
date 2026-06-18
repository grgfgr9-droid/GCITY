
LSCustomConfig                   = {}
LSCustomConfig.DrawDistance      = 10.0
LSCustomConfig.IsMechanicJobOnly = true

LSCustomConfig.Zones = {
    ls1 = {
        Pos   = { x = -211.0328, y = -1324.1071, z = 30.8804},
        Size  = {x = 3.0, y = 3.0, z = 0.2},
        Color = {r = 204, g = 204, b = 0},
		Marker = 1,
		job = 'bennys',
        Name  = "Bennys Customs",
        Hint  = "appuyez sur ~INPUT_PICKUP~ pour personnaliser le véhicule."
	},
	ls2 = {
        Pos   = { x = -339.4, y = -137.1, z = 38.0},
        Size  = {x = 3.0, y = 3.0, z = 0.2},
        Color = {r = 204, g = 204, b = 0},
		Marker = 1,
		job = 'mechanic',
        Name  = "Mechanic customs",
        Hint  = "appuyez sur ~INPUT_PICKUP~ pour personnaliser le véhicule."
	},
}

LSCustomConfig.Colors = {
	{ label = 'Noir', value = 'black'},
	{ label = 'Blanc', value = 'white'},
	{ label = 'Gris', value = 'grey'},
	{ label = 'Rouge', value = 'red'},
	{ label = 'Pink', value = 'pink'},
	{ label = 'Blue', value = 'blue'},
	{ label = 'Jaune', value = 'yellow'},
	{ label = 'Vert', value = 'green'},
	{ label = 'orange', value = 'orange'},
	{ label = 'brown', value = 'brown'},
	{ label = 'purple', value = 'purple'},
	{ label = 'chrome', value = 'chrome'},
	{ label = 'gold', value = 'gold'},
}

function GetColors(color)
    local colors = {}
if color == 'black' then
	colors = {
		{ index = 0, label = "Noir"},
		{ index = 1, label = "Graphite"},
		{ index = 2, label = "Noir Méttallisé"},
		{ index = 3, label = "Acier Fondu"},
		{ index = 11, label = "Noir Anthracite"},
		{ index = 12, label = "Noir Mat"},
		{ index = 15, label = "Nuit Sombre"},
		{ index = 16, label = "Noir Profond"},
		{ index = 21, label = "Pétrol"},
		{ index = 147, label = "Carbon"},
	}
elseif color == 'white' then
	colors = {
		{ index = 106, label = "Vanille"},
		{ index = 107, label = "Crème"},
		{ index = 111, label = "Blanc"},
		{ index = 112, label = "Blanc Polair"},
		{ index = 113, label = "Beige"},
		{ index = 121, label = "Blanc Mat"},
		{ index = 122, label = "Neige"},
		{ index = 131, label = "Coton"},
		{ index = 132, label = "Albâtre"},
		{ index = 134, label = "Blanc Pure"},
	}
elseif color == 'grey' then
	colors = {
		{ index = 4, label = "Argenté"},
		{ index = 5, label = "Gris Métallisé"},
		{ index = 6, label = "Acier Laminé"},
		{ index = 7, label = "Gris Foncé"},
		{ index = 8, label = "Gris Rocheux"},
		{ index = 9, label = "Gris Nuit"},
		{ index = 10, label = "Aluminium"},
		{ index = 13, label = "Gris Mat"},
		{ index = 14, label = "Gris Clair"},
		{ index = 17, label = "Gris Bitume"},
		{ index = 18, label = "Gris Béton"},
		{ index = 19, label = "Argent Sombre"},
		{ index = 20, label = "Magnésite"},
		{ index = 22, label = "Nickel"},
		{ index = 23, label = "Zinc"},
		{ index = 24, label = "Dolomite"},
		{ index = 25, label = "Argent Bleuté"},
		{ index = 26, label = "Titane"},
		{ index = 66, label = "Acier Bleui"},
		{ index = 93, label = "Champagne"},
		{ index = 144, label = "Gris Chasseur"},
		{ index = 156, label = "Gris"},
	}
elseif color == 'red' then
	colors = {
		{ index = 27, label = "Rouge"},
		{ index = 28, label = "Rouge Turin"},
		{ index = 29, label = "Coquelicot"},
		{ index = 30, label = "Rouge Cuivré"},
		{ index = 31, label = "Rouge Cardinal"},
		{ index = 32, label = "Rouge Brique"},
		{ index = 33, label = "Grenat"},
		{ index = 34, label = "Pourpre"},
		{ index = 35, label = "Framboise"},
		{ index = 39, label = "Rouge Mat"},
		{ index = 40, label = "Rouge Foncé"},
		{ index = 43, label = "Rouge Pulpeux"},
		{ index = 44, label = "Rouge Brillant"},
		{ index = 46, label = "Rouge Pale"},
		{ index = 143, label = "Rouge Vin"},
		{ index = 150, label = "Volcano"},
	}
elseif color == 'pink' then
	colors = {
		{ index = 135, label = "Rose Electrique"},
		{ index = 136, label = "Rose Saumon"},
		{ index = 137, label = "Rose Dragée"},
	}
elseif color == 'blue' then
	colors = {
		{ index = 54, label = "Topaze"},
		{ index = 60, label = "Bleu clair"},
		{ index = 61, label = "Bleu galaxy"},
		{ index = 62, label = "Bleu foncé"},
		{ index = 63, label = "Bleu azur"},
		{ index = 64, label = "Bleu marine"},
		{ index = 65, label = "Lapis lazuli"},
		{ index = 67, label = "Bleu diamant"},
		{ index = 68, label = "Surfer"},
		{ index = 69, label = "Pastel"},
		{ index = 70, label = "Bleu celeste"},
		{ index = 73, label = "Bleu rally"},
		{ index = 74, label = "Bleu paradis"},
		{ index = 75, label = "Bleu nuit"},
		{ index = 77, label = "Bleu cyan"},
		{ index = 78, label = "Cobalt"},
		{ index = 79, label = "Bleu electrique"},
		{ index = 80, label = "Bleu horizon"},
		{ index = 82, label = "Bleu métallisé"},
		{ index = 83, label = "Aigue marine"},
		{ index = 84, label = "Bleu agathe"},
		{ index = 85, label = "Zirconium"},
		{ index = 86, label = "Spinelle"},
		{ index = 87, label = "Tourmaline"},
		{ index = 127, label = "Paradis"},
		{ index = 140, label = "Bubble gum"},
		{ index = 141, label = "Bleu minuit"},
		{ index = 146, label = "Bleu interdit"},
		{ index = 157, label = "Bleu glacier"},
	}
elseif color == 'yellow' then
	colors = {
		{ index = 42, label = "Jaune"},
		{ index = 88, label = "Jaune Blé"},
		{ index = 89, label = "Jaune Rally"},
		{ index = 91, label = "Jaune Clair"},
		{ index = 126, label = "Jaune Pâle"},
	}
elseif color == 'green' then
	colors = {
		{ index = 49, label = "Vert Foncé"},
		{ index = 50, label = "Vert Rally"},
		{ index = 51, label = "Vert Sapin"},
		{ index = 52, label = "Vert Olive"},
		{ index = 53, label = "Vert Clair"},
		{ index = 55, label = "Vert Lime"},
		{ index = 56, label = "Vert Forêt"},
		{ index = 57, label = "Vert Pelouse"},
		{ index = 58, label = "Vert Impérial"},
		{ index = 59, label = "Vert Bouteille"},
		{ index = 92, label = "Vert Citrus"},
		{ index = 125, label = "Vert Anis"},
		{ index = 128, label = "Kaki"},
		{ index = 133, label = "Vert Army"},
		{ index = 151, label = "Vert Sombre"},
		{ index = 152, label = "Vert Chasseur"},
		{ index = 155, label = "Amarylisse"},
	}
elseif color == 'orange' then
	colors = {
		{ index = 36, label = "Tangerine"},
		{ index = 38, label = "Orange"},
		{ index = 41, label = "Orange Mat"},
		{ index = 123, label = "Orange Clair"},
		{ index = 124, label = "Pèche"},
		{ index = 130, label = "Citrouille"},
		{ index = 138, label = "Orange Lambo"},
	}
elseif color == 'brown' then
	colors = {
		{ index = 45, label = "Cuivre"},
		{ index = 47, label = "Marronclair"},
		{ index = 48, label = "Marron Foncé"},
		{ index = 90, label = "Bronze"},
		{ index = 94, label = "Marron Métallisé"},
		{ index = 95, label = "Expresso"},
		{ index = 96, label = "Chocolat"},
		{ index = 97, label = "Terre Cuite"},
		{ index = 98, label = "Marbre"},
		{ index = 99, label = "Sable"},
		{ index = 100, label = "Sépia"},
		{ index = 101, label = "Bison"},
		{ index = 102, label = "Palmier"},
		{ index = 103, label = "Caramel"},
		{ index = 104, label = "Rouille"},
		{ index = 105, label = "Chataigne"},
		{ index = 108, label = "Marron"},
		{ index = 109, label = "Noisette"},
		{ index = 110, label = "Coquillage"},
		{ index = 114, label = "Acajou"},
		{ index = 115, label = "Chaudron"},
		{ index = 116, label = "Blond"},
		{ index = 129, label = "Gravillon"},
		{ index = 153, label = "Terre Foncé"},
		{ index = 154, label = "Désert"},
	}
elseif color == 'purple' then
	colors = {
		{ index = 71, label = "Indigo"},
		{ index = 72, label = "Violet Profond"},
		{ index = 76, label = "Violet Foncé"},
		{ index = 81, label = "Améthyste"},
		{ index = 142, label = "Violet Mystique"},
		{ index = 145, label = "Violet Métallisé"},
		{ index = 148, label = "Violet Mat"},
		{ index = 149, label = "Violet Profond Mat"},
	}
elseif color == 'chrome' then
	colors = {
		{ index = 117, label = "Chrome Brushed"},
		{ index = 118, label = "Chrome Noir"},
		{ index = 119, label = "Aluminum Brossé"},
		{ index = 120, label = "Chrome"},
	}
elseif color == 'gold' then
	colors = {
		{ index = 37, label = "Or"},
		{ index = 158, label = "Or Pure"},
		{ index = 159, label = "Or Brossé"},
		{ index = 160, label = "Or Clair"},
	}
end
    return colors
end

function GetWindowName(index)
	if (index == 1) then
		return "Pure Black"
	elseif (index == 2) then
		return "Darksmoke"
	elseif (index == 3) then
		return "Lightsmoke"
	elseif (index == 4) then
		return "Limo"
	elseif (index == 5) then
		return "Green"
	else
		return "Unknown"
	end
end

function GetHornName(index)
	if (index == 0) then
		return "Truck Horn"
	elseif (index == 1) then
		return "Cop Horn"
	elseif (index == 2) then
		return "Clown Horn"
	elseif (index == 3) then
		return "Musical Horn 1"
	elseif (index == 4) then
		return "Musical Horn 2"
	elseif (index == 5) then
		return "Musical Horn 3"
	elseif (index == 6) then
		return "Musical Horn 4"
	elseif (index == 7) then
		return "Musical Horn 5"
	elseif (index == 8) then
		return "Sad Trombone"
	elseif (index == 9) then
		return "Classical Horn 1"
	elseif (index == 10) then
		return "Classical Horn 2"
	elseif (index == 11) then
		return "Classical Horn 3"
	elseif (index == 12) then
		return "Classical Horn 4"
	elseif (index == 13) then
		return "Classical Horn 5"
	elseif (index == 14) then
		return "Classical Horn 6"
	elseif (index == 15) then
		return "Classical Horn 7"
	elseif (index == 16) then
		return "Scale - Do"
	elseif (index == 17) then
		return "Scale - Re"
	elseif (index == 18) then
		return "Scale - Mi"
	elseif (index == 19) then
		return "Scale - Fa"
	elseif (index == 20) then
		return "Scale - Sol"
	elseif (index == 21) then
		return "Scale - La"
	elseif (index == 22) then
		return "Scale - Ti"
	elseif (index == 23) then
		return "Scale - Do"
	elseif (index == 24) then
		return "Jazz Horn 1"
	elseif (index == 25) then
		return "Jazz Horn 2"
	elseif (index == 26) then
		return "Jazz Horn 3"
	elseif (index == 27) then
		return "Jazz Horn Loop"
	elseif (index == 28) then
		return "Star Spangled Banner 1"
	elseif (index == 29) then
		return "Star Spangled Banner 2"
	elseif (index == 30) then
		return "Star Spangled Banner 3"
	elseif (index == 31) then
		return "Star Spangled Banner 4"
	elseif (index == 32) then
		return "Classical Horn 8 Loop"
	elseif (index == 33) then
		return "Classical Horn 9 Loop"
	elseif (index == 34) then
		return "Classical Horn 10 Loop"
	elseif (index == 35) then
		return "Classical Horn 8"
	elseif (index == 36) then
		return "Classical Horn 9"
	elseif (index == 37) then
		return "Classical Horn 10"
	elseif (index == 38) then
		return "Funeral Loop"
	elseif (index == 39) then
		return "Funeral"
	elseif (index == 40) then
		return "Spooky Loop"
	elseif (index == 41) then
		return "Spooky"
	elseif (index == 42) then
		return "San Andreas Loop"
	elseif (index == 43) then
		return "San Andreas"
	elseif (index == 44) then
		return "Liberty City Loop"
	elseif (index == 45) then
		return "Liberty City"
	elseif (index == 46) then
		return "Festive 1 Loop"
	elseif (index == 47) then
		return "Festive 1"
	elseif (index == 48) then
		return "Festive 2 Loop"
	elseif (index == 49) then
		return "Festive 2"
	elseif (index == 50) then
		return "Festive 3 Loop"
	elseif (index == 51) then
		return "Festive 3"
	else
		return "Unknown Horn"
	end
end

function GetNeons()
	local neons = {
	    { label = "Blanc", 			r = 255, 	g = 255, 	b = 255},
	    { label = "Slate Gray", 	r = 112, 	g = 128, 	b = 144},
	    { label = "Blue", 			r = 0, 		g = 0, 		b = 255},
	    { label = "Light Blue", 	r = 0, 		g = 150, 	b = 255},
	    { label = "Navy Blue", 		r = 0, 		g = 0, 		b = 128},
	    { label = "Sky Blue", 		r = 135, 	g = 206, 	b = 235},
	    { label = "Turquoise", 		r = 0, 		g = 245, 	b = 255},
	    { label = "Mint Green", 	r = 50, 	g = 255, 	b = 155},
	    { label = "Lime Green", 	r = 0, 		g = 255, 	b = 0},
	    { label = "Olive", 			r = 128, 	g = 128, 	b = 0},
	    { label = "Jaune", 		r = 255, 	g = 255, 	b = 0},
	    { label = "Or", 			r = 255, 	g = 215, 	b = 0},
	    { label = "Orange", 		r = 255, 	g = 165, 	b = 0},
	    { label = "Blé", 			r = 245, 	g = 222, 	b = 179},
	    { label = "Rouge", 			r = 255, 	g = 0, 		b = 0},
	    { label = "Rose", 			r = 255, 	g = 161, 	b = 211},
	    { label = "Rose Clair", 	r = 255, 	g = 0, 		b = 255},
	    { label = "Violet", 		r = 153, 	g = 0, 		b = 153},
	    { label = "Ivory", 			r = 41, 	g = 36, 	b = 33}
   	}
   	return neons
end

function GetPlatesName(index)
	if (index == 0) then
		return "Bleu sur blanc 1"
	elseif (index == 1) then
		return "Jaune sur noir"
	elseif (index == 2) then
		return "Jaune sur bleu"
	elseif (index == 3) then
		return "Bleu sur blanc 2"
	elseif (index == 4) then
		return "Bleur sur blanc 3"
	end
end

LSCustomConfig.Menus = {
	main = {
		label = 'PitStop R&U',
		parent = nil,
		cosmetics = "Cosmétiques",
		upgrades = "Upgrades"	
	},
	upgrades = {
		label = "Upgrades",
		parent = 'main',
		modEngine = "Moteur",
		modBrakes = "Freins",
		modTransmission = "Transmission",
		modSuspension = "Suspension",
		modArmor = "Blindage",
		modTurbo = "Turbo"
	},
	modEngine = {
		label = "Moteur",
		parent = 'upgrades',
		modType = 11,
		price = {10, 15, 20, 30}
	},
	modBrakes = {
		label = "Freins",
		parent = 'upgrades',
		modType = 12,
		price = {4, 8, 12, 18}
	},
	modTransmission = {
		label = "Transmission",
		parent = 'upgrades',
		modType = 13,
		price = {10, 15, 20}
	},
	modSuspension = {
		label = "Suspension",
		parent = 'upgrades',
		modType = 15,
		price = {3, 6, 9, 16, 26}
	},
	modArmor = {
		label = "Blindage",
		parent = 'upgrades',
		modType = 16,
		price = {50, 55, 65, 75, 85, 105}
	},
	modTurbo = {
		label = "Turbo",
		parent = 'upgrades',
		modType = 17,
		price = {40}
	},
	cosmetics = {
		label               = "Cosmétiques",
		parent              = 'main',
		bodyparts           = "Carosserie",
		windowTint          = "Teinte des fenêtres",
		modHorns            = "Klaxon",
		neonColor           = "Neons",
		resprays            = "Peintures",
		modXenon            = "Phares",
		plateIndex          = "Plaques",
		wheels              = "Roues",
		modPlateHolder   	= 'Plaque - Contour',
		modVanityPlate   	= 'Plaque - Avant',
		modTrimA    		= 'Intérieur',
		modOrnaments    	= 'Ornements',
		modDashboard    	= 'Tableau de bord',
		modDial    			= 'Compteur de vitesse',
		modDoorSpeaker    	= 'Sono portière',
		modSeats    		= 'Sièges',
		modSteeringWheel    = 'Volant',
		modShifterLeavers   = 'Levier de vitesse',
		modAPlate    		= 'Plage arrière',
		modSpeakers    		= 'Sono',
		modTrunk    		= 'Coffre',
		modHydrolic    		= 'Hydrolique',
		modEngineBlock    	= 'Bloc moteur',
		modAirFilter    	= 'Filtre à air',
		modStruts    		= 'Struts',
		modArchCover    	= 'Cache-roues',
		modAerials    		= 'Antennes',
		modTrimB    		= 'Ailes',
		modTank    			= 'Réservoir',
		modWindows    		= 'Fenêtres',
		modLivery    		= 'Stickers'
	},

	modPlateHolder = {
		label = 'Plaque - Contour',
		parent = 'cosmetics',
		modType = 25,
		price = 3.49
	},
	modVanityPlate = {
		label = 'Plaque - Avant',
		parent = 'cosmetics',
		modType = 26,
		price = 1.1
	},
	modTrimA = {
		label = 'Intérieur',
		parent = 'cosmetics',
		modType = 27,
		price = 6.98
	},
	modOrnaments = {
		label = 'Ornements',
		parent = 'cosmetics',
		modType = 28,
		price = 0.9
	},
	modDashboard = {
		label = 'Tableau de bord',
		parent = 'cosmetics',
		modType = 29,
		price = 4.65
	},
	modDial = {
		label = 'Compteur de vitesse',
		parent = 'cosmetics',
		modType = 30,
		price = 4.19
	},
	modDoorSpeaker = {
		label = 'Sono portière',
		parent = 'cosmetics',
		modType = 31,
		price = 5.58
	},
	modSeats = {
		label = 'Siège',
		parent = 'cosmetics',
		modType = 32,
		price = 4.65
	},
	modSteeringWheel = {
		label = 'Volant',
		parent = 'cosmetics',
		modType = 33,
		price = 4.19
	},
	modShifterLeavers = {
		label = 'Levier de vitesse',
		parent = 'cosmetics',
		modType = 34,
		price = 3.26
	},
	modAPlate = {
		label = 'Plage arrière',
		parent = 'cosmetics',
		modType = 35,
		price = 4.19
	},
	modSpeakers = {
		label = 'Sono',
		parent = 'cosmetics',
		modType = 36,
		price = 6.98
	},
	modTrunk = {
		label = 'Coffre',
		parent = 'cosmetics',
		modType = 37,
		price = 5.58
	},
	modHydrolic = {
		label = 'Hydrolique',
		parent = 'cosmetics',
		modType = 38,
		price = 5.12
	},
	modEngineBlock = {
		label = 'Bloc moteur',
		parent = 'cosmetics',
		modType = 39,
		price = 5.12
	},
	modAirFilter = {
		label = 'Filtre a air',
		parent = 'cosmetics',
		modType = 40,
		price = 3.72
	},
	modStruts = {
		label = 'Struts',
		parent = 'cosmetics',
		modType = 41,
		price = 6.51
	},
	modArchCover = {
		label = 'Cache-roues',
		parent = 'cosmetics',
		modType = 42,
		price = 4.19
	},
	modAerials = {
		label = 'Antennes',
		parent = 'cosmetics',
		modType = 43,
		price = 1.12
	},
	modTrimB = {
		label = 'Ailes',
		parent = 'cosmetics',
		modType = 44,
		price = 6.05
	},
	modTank = {
		label = 'Réservoir',
		parent = 'cosmetics',
		modType = 45,
		price = 4.19
	},
	modWindows = {
		label = 'Fenêtres',
		parent = 'cosmetics',
		modType = 46,
		price = 4.19
	},
	modLivery = {
		label = 'Stickers',
		parent = 'cosmetics',
		modType = 48,
		price = 9.3
	},

	wheels = {
		label = "Roues",
		parent = 'cosmetics',
		modFrontWheelsTypes = "Types de jantes",
		modFrontWheelsColor = "Couleurs de jantes",
		tyreSmokeColor = "Fumée des pneus"
	},
	modFrontWheelsTypes = {
		label               = "Types de jantes",
		parent              = 'wheels',
		modFrontWheelsType0 = "Sport",
		modFrontWheelsType1 = "Muscle",
		modFrontWheelsType2 = "Lowrider",
		modFrontWheelsType3 = "SUV",
		modFrontWheelsType4 = "Tout Terrain",
		modFrontWheelsType5 = "Tuning",
		modFrontWheelsType6 = "Moto",
		modFrontWheelsType7 = "Haut de Gamme"
	},
	modFrontWheelsType0 = {
		label = "Sport",
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 0,
		price = 4.65
	},
	modFrontWheelsType1 = {
		label = "Muscle",
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 1,
		price = 4.19
	},
	modFrontWheelsType2 = {
		label = "Lowrider",
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 2,
		price = 4.65
	},
	modFrontWheelsType3 = {
		label = "SUV",
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 3,
		price = 4.19
	},
	modFrontWheelsType4 = {
		label = "Tout Terrain",
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 4,
		price = 4.19
	},
	modFrontWheelsType5 = {
		label = "Tuning",
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 5,
		price = 5.12
	},
	modFrontWheelsType6 = {
		label = "Moto",
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 6,
		price = 3.26
	},
	modFrontWheelsType7 = {
		label = "Haut de gamme",
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 7,
		price = 5.12
	},
	modFrontWheelsColor = {
		label = 'Peinture Jantes',
		parent = 'wheels'
	},
	wheelColor = {
		label = 'Peinture Jantes',
		parent = 'modFrontWheelsColor',
		modType = 'wheelColor',
		price = 0.66
	},
	plateIndex = {
		label = "Plaques",
		parent = 'cosmetics',
		modType = 'plateIndex',
		price = 1.1
	},
	resprays = {
		label = "Peinture",
		parent = 'cosmetics',
		primaryRespray = "Primaire",
		secondaryRespray = "Secondaire",
		pearlescentRespray = "Nacré",
	},
	primaryRespray = {
		label = "Primaire",
		parent = 'resprays',
	},
	secondaryRespray = {
		label = 'Secondaire',
		parent = 'resprays',
	},
	pearlescentRespray = {
		label = "Nacré",
		parent = 'resprays',
	},
	color1 = {
		label = "Primaire",
		parent = 'primaryRespray',
		modType = 'color1',
		price = 1.12
	},
	color2 = {
		label = "Secondaire",
		parent = 'secondaryRespray',
		modType = 'color2',
		price = 0.66
	},
	pearlescentColor = {
		label = "Nacré",
		parent = 'pearlescentRespray',
		modType = 'pearlescentColor',
		price = 0.88
	},
	modXenon = {
		label = "Phare",
		parent = 'cosmetics',
		modType = 22,
		price = 3.72
	},
	bodyparts = {
		label = "carosserie",
		parent = 'cosmetics',
		modFender = "Aile Gauche",
		modRightFender = "Aile Droite",
		modSpoilers = "Aileron",
		modSideSkirt = "Base de caisse",
		modFrame = "Cage",
		modHood = "Capot",
		modGrille = "Grille",
		modRearBumper = "Pare-choc Arrière",
		modFrontBumper = "Pare-choc Avant",
		modExhaust = "Pot d'échappement",
		modRoof = "Toit"
	},
	modSpoilers = {
		label = "Aileron",
		parent = 'bodyparts',
		modType = 0,
		price = 4.65
	},
	modFrontBumper = {
		label = "Aile Gauche",
		parent = 'bodyparts',
		modType = 1,
		price = 5.12
	},
	modRearBumper = {
		label = "Pare-choc Arrière",
		parent = 'bodyparts',
		modType = 2,
		price = 5.12
	},
	modSideSkirt = {
		label = "Base de caisse",
		parent = 'bodyparts',
		modType = 3,
		price = 4.65
	},
	modExhaust = {
		label = "Pot d'échappement",
		parent = 'bodyparts',
		modType = 4,
		price = 5.12
	},
	modFrame = {
		label = "Cage",
		parent = 'bodyparts',
		modType = 5,
		price = 5.12
	},
	modGrille = {
		label = "Grille",
		parent = 'bodyparts',
		modType = 6,
		price = 3.72
	},
	modHood = {
		label = "Capot",
		parent = 'bodyparts',
		modType = 7,
		price = 4.88
	},
	modFender = {
		label = "Aile Droite",
		parent = 'bodyparts',
		modType = 8,
		price = 5.12
	},
	modRightFender = {
		label = "Aile Gauche",
		parent = 'bodyparts',
		modType = 9,
		price = 5.12
	},
	modRoof = {
		label = "Toit",
		parent = 'bodyparts',
		modType = 10,
		price = 5.58
	},
	windowTint = {
		label = "Teines de Fenêtres",
		parent = 'cosmetics',
		modType = 'windowTint',
		price = 1.12
	},
	modHorns = {
		label = "Klaxon",
		parent = 'cosmetics',
		modType = 14,
		price = 1.12
	},
	neonColor = {
		label = "Néons",
		parent = 'cosmetics',
		modType = 'neonColor',
		price = 1.12
	},
	tyreSmokeColor = {
		label = "Fumée de pneus",
		parent = 'wheels',
		modType = 'tyreSmokeColor',
		price = 1.12
	}

}