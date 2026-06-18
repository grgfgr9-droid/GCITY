robberiesConfiguration = {

    reseller = {
        model = "a_m_y_business_02",
        waitingScenario = "WORLD_HUMAN_AA_SMOKE",
        busyScenario = "WORLD_HUMAN_CLIPBOARD",
        randomizeLocation = { vector = vector3(526.7914, -1655.516, 29.35936), heading = 51.27629852295, },
    },

    items = {
        ["TV"] = { name = "Téléviseur", resellerValue = 5000, timeToTake = 10 },
        ["CLOTHS"] = { name = "Vêtements", resellerValue = 3000, timeToTake = 15 },
        ["CLOTHSRICHE"] = { name = "Vêtements de Luxe", resellerValue = 7500, timeToTake = 15 },
        ["ECOMP"] = { name = "Composants électroniques", resellerValue = 2000, timeToTake = 4 },
        ["ORANGE"] = { name = "Fruits", resellerValue = 5000, timeToTake = 2 },
        ["TELEPHONE"] = { name = "iPhone", resellerValue = 9000, timeToTake = 4 },
        ["PORNO"] = { name = "Magasine Pornographique", resellerValue = 2500, timeToTake = 1 },
        ["PARFUM"] = { name = "Parfum Channel", resellerValue = 1000, timeToTake = 3 },
        ["TV4K60FPS"] = { name = "TV 4K 60FPS", resellerValue = 5650, timeToTake = 15 },
        ["BOITEBIJOUX"] = { name = "Boite a Bijoux", resellerValue = 6000, timeToTake = 20 },
        ["PCPORTABLE"] = { name = "Asus Rog 144Hz", resellerValue = 3500, timeToTake = 10 },
        ["TABLEAU"] = { name = "Tableau Pablo Picasso", resellerValue = 1500, timeToTake = 10 },
        ["ECRANMAC"] = { name = "Ecran Mac", resellerValue = 4000, timeToTake = 8 },
        ["JAGUAR"] = { name = "Jaguar", resellerValue = 2400, timeToTake = 5 },
        ["PERCEUSE"] = { name = "Perceuse", resellerValue = 3000, timeToTake = 6 },
        ["DEVICE"] = { name = "Device", resellerValue = 5000, timeToTake = 15 },
        ["BOITEOUTILS"] = { name = "Boite a Outils", resellerValue = 4000, timeToTake = 8 },
        ["COMPRESSEUR"] = { name = "Compresseur", resellerValue = 4000, timeToTake = 12 },
        ["PEINTURE"] = { name = "Peinture", resellerValue = 2400, timeToTake = 5 },
        ["CHEVRE"] = { name = "Chevre Mécanique", resellerValue = 3500, timeToTake = 10 },
        ["ASPIRATEUR"] = { name = "Aspirateur Mécanique", resellerValue = 3000, timeToTake = 6 },
        ["BANSHEE"] = { name = "Tableau Banshee", resellerValue = 4000, timeToTake = 8 },
        ["OUTILS"] = { name = "Outils", resellerValue = 2400, timeToTake = 5 },
        ["FEUILLECASH"] = { name = "Feuille Cash", resellerValue = 4000, timeToTake = 8 },
        ["DOCUMENTS"] = { name = "Documents Labo", resellerValue = 500, timeToTake = 2 },
        ["BILLET"] = { name = "Billet Cash Factory", resellerValue = 500, timeToTake = 2 },
        ["BILLET1"] = { name = "Pile de Cash", resellerValue = 550, timeToTake = 10 },
        ["BILLET2"] = { name = "Billet de Cash Factory", resellerValue = 3500, timeToTake = 7 },
        ["PRODUITCOC"] = { name = "Produit Cocaine", resellerValue = 4000, timeToTake = 8 },
        ["COCAINA"] = { name = "Cocaine", resellerValue = 2000, timeToTake = 4 },
        ["CANNA"] = { name = "Cannabis", resellerValue = 5000, timeToTake = 2 },
        ["CANNATRAIT"] = { name = "Cannabis traite", resellerValue = 2000, timeToTake = 5 },
        ["DISQUEDUR"] = { name = "Disque Dur", resellerValue = 2000, timeToTake = 5 },
        ["TABLEAUPAUVRE"] = { name = "Tableau Décoration", resellerValue = 2500, timeToTake = 8 },
        ["BROSSEADENTS"] = { name = "Brosse a dents", resellerValue = 500, timeToTake = 2 },
        ["SECHECHEVEUX"] = { name = "Seche Cheveux", resellerValue = 500, timeToTake = 3 },
        ["LIVRES"] = { name = "Livres", resellerValue = 2000, timeToTake = 8 },
        ["JACK"] = { name = "Bouteille de Jack", resellerValue = 500, timeToTake = 2 },
    },

    minPolice = 0,
    houseRobRegen = 600,
    houses = {
        -- Première maison
        {
            name = "Poor #1",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856),
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(240.8298, -1687.964, 29.69962),
            objects = {
                { object = "TV", position = vector3(257.1346, -995.7486, -99.00864) },
                { object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864) },
                { object = "TV", position = vector3(262.5348, -1002.594, -99.00864) },
                { object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866) },
            },
        },

        -- Motel 1
        {
            name = "Motel #1",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856),
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(-681.9152, 5770.784, 17.511),
            objects = {
                { object = "TV", position = vector3(257.1346, -995.7486, -99.00864) },
                { object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864) },
                { object = "TV", position = vector3(262.5348, -1002.594, -99.00864) },
                { object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866) },
            },
        },

        -- Motel 2
        {
            name = "Motel #2",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856),
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(-702.0698, 5765.004, 17.511),
            objects = {
                { object = "TV", position = vector3(257.1346, -995.7486, -99.00864) },
                { object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864) },
                { object = "TV", position = vector3(262.5348, -1002.594, -99.00864) },
                { object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866) },
            },
        },

        -- Motel 3
        {
            name = "Motel #2",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856),
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(-157.1198, 6409.256, 31.9159),
            objects = {
                { object = "TV", position = vector3(257.1346, -995.7486, -99.00864) },
                { object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864) },
                { object = "TV", position = vector3(262.5348, -1002.594, -99.00864) },
                { object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866) },
            },
        },

        -- Motel 4
        {
            name = "Motel #2",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856),
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(-99.66008, 6347.676, 35.50074),
            objects = {
                { object = "TV", position = vector3(257.1346, -995.7486, -99.00864) },
                { object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864) },
                { object = "TV", position = vector3(262.5348, -1002.594, -99.00864) },
                { object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866) },
            },
        },

        -- Nord Maison 1
        {
            name = "Nord #1",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856),
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(1674.7, 4681.23, 43.0554),
            objects = {
                { object = "TV", position = vector3(257.1346, -995.7486, -99.00864) },
                { object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864) },
                { object = "TV", position = vector3(262.5348, -1002.594, -99.00864) },
                { object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866) },
            },
        },

        -- Nord Maison 2
        {
            name = "Nord #2",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856),
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(1639.286, 4879.404, 42.14068),
            objects = {
                { object = "TV", position = vector3(257.1346, -995.7486, -99.00864) },
                { object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864) },
                { object = "TV", position = vector3(262.5348, -1002.594, -99.00864) },
                { object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866) },
            },
        },

        -- Nord Maison 3
        {
            name = "Nord #3",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(346.4078, -1008.204, -99.19616),
            exitVector = vector3(346.4414, -1012.916, -99.19616),
            outdoorVector = vector3(2566.722, 4283.192, 41.97382),
            objects = {
                { object = "TV4K60FPS", position = vector3(338.2112, -996.6988, -99.19618) },
                { object = "CLOTHS", position = vector3(350.8822, -993.5962, -99.1961) },
                { object = "TABLEAUPAUVRE", position = vector3(347.1834, -998.0684, -99.19618) },
                { object = "BROSSEADENTS", position = vector3(347.2348, -994.2006, -99.19616) },
                { object = "SECHECHEVEUX", position = vector3(351.13, -999.2594, -99.19614) },
                { object = "PORNO", position = vector3(349.491, -997.4902, -99.1962) },
                { object = "LIVRES", position = vector3(345.3794, -997.0596, -99.19622) },
                { object = "JACK", position = vector3(342.3002, -1001.524, -99.19622) },
            },
        },

        -- Nord Maison 4
        {
            name = "Nord #5",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(346.4078, -1008.204, -99.19616),
            exitVector = vector3(346.4414, -1012.916, -99.19616),
            outdoorVector = vector3(-130.752, 6551.894, 29.87264),
            objects = {
                { object = "TV4K60FPS", position = vector3(338.2112, -996.6988, -99.19618) },
                { object = "CLOTHS", position = vector3(350.8822, -993.5962, -99.1961) },
                { object = "TABLEAUPAVURE", position = vector3(347.1834, -998.0684, -99.19618) },
                { object = "BROSSEADENTS", position = vector3(347.2348, -994.2006, -99.19616) },
                { object = "SECHECHEVEUX", position = vector3(351.13, -999.2594, -99.19614) },
                { object = "PORNO", position = vector3(349.491, -997.4902, -99.1962) },
                { object = "LIVRES", position = vector3(345.3794, -997.0596, -99.19622) },
                { object = "JACK", position = vector3(342.3002, -1001.524, -99.19622) },
            },
        },

        -- Nord Maison 5
        {
            name = "Nord #4",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(346.4078, -1008.204, -99.19616),
            exitVector = vector3(346.4414, -1012.916, -99.19616),
            outdoorVector = vector3(-9.582162, 6654.23, 31.70472),
            objects = {
                { object = "TV4K60FPS", position = vector3(338.2112, -996.6988, -99.19618) },
                { object = "CLOTHS", position = vector3(350.8822, -993.5962, -99.1961) },
                { object = "TABLEAUPAUVRE", position = vector3(347.1834, -998.0684, -99.19618) },
                { object = "BROSSEADENTS", position = vector3(347.2348, -994.2006, -99.19616) },
                { object = "SECHECHEVEUX", position = vector3(351.13, -999.2594, -99.19614) },
                { object = "PORNO", position = vector3(349.491, -997.4902, -99.1962) },
                { object = "LIVRES", position = vector3(345.3794, -997.0596, -99.19622) },
                { object = "JACK", position = vector3(342.3002, -1001.524, -99.19622) },
            },
        },

        -- Nord Maison 6
        {
            name = "Nord #6",
            authority = "police",
            timeToGoToReseller = 20, -- minutes
            copsCalledAfter = 5, -- s
            policeBlipDuration = 60, -- s
            maximumTime = 60, -- s
            interiorVector = vector3(346.4078, -1008.204, -99.19616),
            exitVector = vector3(346.4414, -1012.916, -99.19616),
            outdoorVector = vector3(1663.948, 4662.01, 43.38696),
            objects = {
                { object = "TV4K60FPS", position = vector3(338.2112, -996.6988, -99.19618) },
                { object = "CLOTHS", position = vector3(350.8822, -993.5962, -99.1961) },
                { object = "TABLEAUPAUVRE", position = vector3(347.1834, -998.0684, -99.19618) },
                { object = "BROSSEADENTS", position = vector3(347.2348, -994.2006, -99.19616) },
                { object = "SECHECHEVEUX", position = vector3(351.13, -999.2594, -99.19614) },
                { object = "PORNO", position = vector3(349.491, -997.4902, -99.1962) },
                { object = "LIVRES", position = vector3(345.3794, -997.0596, -99.19622) },
                { object = "JACK", position = vector3(342.3002, -1001.524, -99.19622) },
            },
        },

    },
}