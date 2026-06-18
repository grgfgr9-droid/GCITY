ZiZouConfig = {}

ZiZouConfig.ServerName = "Virtuel"
ZiZouConfig.LogoURL = "https://i.postimg.cc/X7nrzyHd/VE.png"
ZiZouConfig.Dev = "Dinaz"
ZiZouConfig.ShopURL = "Virtuel.tebex.io"
ZiZouConfig.DiscordURL = "discord.gg/virtuelrp"
ZiZouConfig.ConnectURL = "discord.gg/virtuelrp"
ZiZouConfig.TebexURL = "https://Virtuel.tebex.io"
ZiZouConfig.RichPresenceID = "1359254080165384656"
ZiZouConfig.DefaultColorCode = '~b~'
ZiZouConfig.StorePointsName = 'Virtuelcoins'
ZiZouConfig.DevMode = false
ZiZouConfig.Developers = {
	["8490bda3242ba95a78e74f4203439c4d4366f33d"] = true,
}


ZiZouConfig.Boutique = {

    MasterTeam = {
        Blue = {
            name_btn = "Master Team ~b~Bleu",
            url = "https://example.com/blue",
            price = "50€"
        },
        Orange = {
            name_btn = "Master Team ~o~Orange",
            url = "https://example.com/orange",
            price = "200€"
        },
        Rouge = {
            name_btn = "Master Team ~r~Rouge",
            url = "https://example.com/red",
            price = "300€"
        },
        Jaune = {
            name_btn = "Master Team ~y~Jaune",
            url = "https://example.com/yellow",
            price = "120€"
        }
    },

    Autres = {

        Entreprise = {
            name_btn = "Entreprise",
            price = "50€"
        },
        Organisation = {
            name_btn = "Organisation",
            price = "60€"
        },
        Gang = {
            name_btn = "Gang",
            price = "60€"
        },
        Vehicule_UNIQUE = {
            name_btn = "Véhicule Unique",
            price = "50€"
        },
        ChangeUUID = {
            name_btn = "Changer UUID",
            price = "15€"
        },
        Property_UNIQUE = {
            name_btn = "Propriété Unique",
            price = "100€"
        },
    },
}



ZiZouConfig.Pmenu = {
    Couleur = {
        r = 0,
        g = 0,
        b = 0,
        o = 215
    }
}

ZiZouConfig.Marker = {
    Markers = {
        Marker = {type = 1, x = 3.0, y = 3.0, z = 0.50, r = 28, g = 28, b = 28, a = 200, rotate = false},
        
        --- DROGUES ---
        MarkerDrugs = {type = 1, x = 4.0, y = 4.0, z = 0.50, r = 255, g = 0, b = 0, a = 150, rotate = false},

        --- CASINO ---

        MarkerCasino = {type = 1, x = 3.0, y = 3.0, z = 0.50, r = 0, g = 0, b = 255, a = 200, rotate = false},

        --- GARAGES ---
        MarkerSortie = {type = 1, x = 4.0, y = 4.0, z = 0.80, r = 0, g = 255, b = 0, a = 150, rotate = false}, -- VERT
        MarkerRentrer = {type = 1, x = 4.0, y = 4.0, z = 0.80, r = 255, g = 0, b = 0, a = 150, rotate = false}, -- ROUGE
        MarkerFourriere = {type = 1, x = 4.0, y = 4.0, z = 0.50, r = 255, g = 165, b = 0, a = 150, rotate = false}, -- ORANGE
    }
}


ZiZouConfig.rgbColor = {
    r = 0, 
    g = 128,   
    b = 255   
}

ZiZouConfig.MenuStaff = {
    
    TenueStaff = {
        male = {
            admin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 7,
                ['arms'] = 1,
                ['pants_1'] = 5, ['pants_2'] = 7,
                ['shoes_1'] = 295, ['shoes_2'] = 4,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            },
    
            responsable = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 5,
                ['arms'] = 1,
                ['pants_1'] = 5, ['pants_2'] = 5,
                ['shoes_1'] = 295, ['shoes_2'] = 2,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            },
    
            superadmin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 4,
                ['arms'] = 1,
                ['pants_1'] = 5, ['pants_2'] = 4,
                ['shoes_1'] = 295, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            },
    
            modo = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 3,
                ['arms'] = 1,
                ['pants_1'] = 5, ['pants_2'] = 3,
                ['shoes_1'] = 295, ['shoes_2'] = 8,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        },
    
        female = {
            admin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 7,
                ['arms'] = 18,
                ['pants_1'] = 5, ['pants_2'] = 7,
                ['shoes_1'] = 225, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            },
    
            responsable = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 5,
                ['arms'] = 18,
                ['pants_1'] = 5, ['pants_2'] = 5,
                ['shoes_1'] = 225, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            },
    
            superadmin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 4,
                ['arms'] = 18,
                ['pants_1'] = 5, ['pants_2'] = 4,
                ['shoes_1'] = 225, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            },
    
            modo = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 3,
                ['arms'] = 18,
                ['pants_1'] = 5, ['pants_2'] = 3,
                ['shoes_1'] = 225, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        }
    }
}


ZiZouConfig.ConfigEmploie = {

    LargeurX = 0.4,
    LargeurY = 0.4,
    LargeurZ = 0.4,
    colorR = 170,
    colorG = 0,
    colorB = 255,
    Opacity = 100,
    MarkerSaute = true,
    MarkerTourne = true,

    NomFichier = 'emploie',
    NomBanniere = 'emploie_banniere',

    DataMoney = 'money',

    Position = {
        Emploie = {
            pos = {x = -266.1817, y = -961.0322, z = 31.22315},
            marker = 22,
            text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu des emplois",
        },
        Blips = {
            pos = vector3(-266.1817, -961.0322, 31.22315),
            model = 407,
            taille = 0.5,
            couleur = 3,
            nom = "Pole Emploie",
        },
    },

    PointJardinier = vector3(-1356.86, 130.2243, 56.2388),
    PointChantier = vector3(-1356.86, 130.2243, 56.2388),
    PointMineur = vector3(2832.311, 2795.296, 57.50744),

    CoolDown = 60, 

}

ZiZouConfig.ConfigJardinier = {

    Jardinier = {
        Blips = {
            pos = vector3(-1356.846, 130.2325, 56.2388),
            model = 109,
            taille = 0.9,
            couleur = 2,
            nom = "~b~Emploie |~w~ Jardinier",
        },
        Position = {
            pos = {x = -1357.498, y = 124.9971, z = 56.23861},
            marker = 27,
            text = "Appuyez sur ~INPUT_CONTEXT~ pour prendre votre service",
        },
        BlipsAleatoire = {
            model = 11,
            taille = 0.5,
            couleur = 5,
        },
        Paiementmin = 100, ----- Paiement minimum
        Paiementmax = 200, ----- Paiement maximum
    },
    PointRecolte = {
        {x = -1273.259, y = 165.8247, z = 59.1316},
        {x = -1332.777, y = 128.2539, z = 57.03106},
        {x = -1317.606, y = 101.198, z = 56.18271},
        {x = -1306.003, y = 45.6311, z = 52.66853},
        {x = -1286.856, y = 7.644546, z = 50.28544},
        {x = -1263.493, y = -28.93796, z = 47.39914},
        {x = -1223.981, y = -55.43104, z = 45.14942},
        {x = -1155.596, y = -83.03043, z = 44.32083},
        {x = -1134.503, y = -51.83556, z = 44.96749},
        {x = -1078.5627441406, y = -68.135520935059, z = 44.120445251465},
        {x = -1020.8477783203, y = -112.40477752686, z = 41.555858612061},
        {x = -960.71337890625, y = -94.471939086914, z = 40.272228240967},
        {x = -1027.2775878906, y = -30.501697540283, z = 45.808208465576},
        {x = -1009.4318237305, y = 11.077080726624, z = 49.497318267822},
        {x = -1068.4741210938, y = 62.630500793457, z = 51.283187866211},
        {x = -1119.3110351562, y = 39.947250366211, z = 52.535842895508},
        {x = -1184.8758544922, y = 87.802604675293, z = 57.479278564453},
        {x = -1189.6119384766, y = 145.08807373047, z = 61.213748931885},
        {x = -1127.1060791016, y = 140.37850952148, z = 61.534423828125},
    },
    

}

ZiZouConfig.ConfigChantier = {

    Chantier = {
        Blips = {
            pos = vector3(-494.2121, -1001.223, 24.59913),
            model = 566,
            taille = 0.5,
            couleur = 17,
            nom = "~b~Emploie |~w~ Chantier",
        },
    },
    Position = {
        pos = {x = -510.259765625, y = -1001.6673583984, z = 23.5505027771},
        marker = 27,
        text = "Appuyez sur ~INPUT_CONTEXT~ pour prendre votre service",
    },
    PointRecolte = {
        {x = -492.53564453125, y = -1005.548828125, z = 29.131732940674},
        {x = -482.73641967773, y = -995.95941162109, z = 29.132961273193},
        {x = -482.68838500977, y = -985.31384277344, z = 29.133060455322},
        {x = -466.21759033203, y = -998.72119140625, z = 23.688648223877},
        {x = -464.36645507812, y = -1000.4954833984, z = 23.718034744263},
        {x = -462.95220947266, y = -998.71514892578, z = 23.740737915039},
        {x = -464.56988525391, y = -996.93286132812, z = 23.715475082397},
        {x = -449.68316650391, y = -998.53430175781, z = 23.952608108521},
        {x = -447.59674072266, y = -1000.4187011719, z = 23.985412597656},
        {x = -446.07861328125, y = -998.62908935547, z = 24.009473800659},
        {x = -447.6530456543, y = -996.93292236328, z = 23.984725952148},
        {x = -464.42950439453, y = -1014.8450317383, z = 23.718551635742},
        {x = -462.73272705078, y = -1016.702331543, z = 23.744709014893},
    },
    Paiementmin = 100, ----- Paiement minimum
    Paiementmax = 200, ----- Paiement maximum
}

ZiZouConfig.ConfigMineur = {
    Mineur = {
        Blips = {
            pos = vector3(2938.7, 2787.968, 84.25786),
            model = 67,
            taille = 0.5,
            couleur = 5,
            nom = "~b~Emploie |~w~ Mineur",
        },
    },
    Position = {
        pos = {x = 2832.3083496094, y = 2795.1528320312, z = 57.51212310791},
        marker = 27,
        text = "Appuyez sur ~INPUT_CONTEXT~ pour prendre votre service",
    },
    PointRecolte = {
        {x = 2935.3012695312, y = 2795.9545898438, z = 40.731334686279},
        {x = 2939.0571289062, y = 2786.2375488281, z = 39.824527740479},
        {x = 2946.1357421875, y = 2775.9206542969, z = 39.268779754639},
        {x = 2954.2158203125, y = 2776.7624511719, z = 39.774127960205},
        {x = 2961.2338867188, y = 2782.3168945312, z = 40.110748291016},
        {x = 2971.1599121094, y = 2786.4506835938, z = 39.508743286133},
        {x = 2972.294921875, y = 2794.5634765625, z = 40.768939971924},
        {x = 2966.3830566406, y = 2800.2243652344, z = 41.271293640137},
        {x = 2959.8967285156, y = 2805.4958496094, z = 42.145782470703},
        {x = 2947.94140625, y = 2814.4533691406, z = 42.137493133545},
        {x = 2940.7492675781, y = 2816.4267578125, z = 43.101234436035},
    },
    Paiementmin = 100, ----- Paiement minimum
    Paiementmax = 200, ----- Paiement maximum
}


ZiZouConfig.Spawn = {
    {
        job2 = "jalisco",
        Name = "Craft Zone",
        position = vector3(199.714294, 387.929657, 107.614624)
    }
}

ZiZouConfig.Item = {
    {
        name = "weapon_m9",
        label = "M9",
        quantity = 1,
        pics = "https://i.postimg.cc/1XHMFf4m/weapon-pistol.png",
        ingredients = {
            { name = "feraille", label = "Ferraille", quantity = 2, pics = "https://i.postimg.cc/vTS5r97v/barre-de-fer-removebg-preview.png" },
            { name = "titanium", label = "Titanium", quantity = 2, pics = "https://i.postimg.cc/4dfcjwB5/pierre-crue-d-ilm-C3-A9nite-minerai-titanique-sur-le-blanc-134143488-removebg-preview.png" },
            { name = "plomb", label = "Plomb", quantity = 1, pics = "https://i.postimg.cc/nzwqfBsQ/image-removebg-preview-1.png" }
        }
    },
    {
        name = "weapon_pistol50",
        label = "Calibre 50",
        quantity = 1,
        pics = "https://i.postimg.cc/GmMNNSLL/weapon-pistol50.png",
        ingredients = {
            { name = "feraille", label = "Ferraille", quantity = 3, pics = "https://i.postimg.cc/vTS5r97v/barre-de-fer-removebg-preview.png" },
            { name = "titanium", label = "Titanium", quantity = 3, pics = "https://i.postimg.cc/4dfcjwB5/pierre-crue-d-ilm-C3-A9nite-minerai-titanique-sur-le-blanc-134143488-removebg-preview.png" },
            { name = "plomb", label = "Plomb", quantity = 2, pics = "https://i.postimg.cc/nzwqfBsQ/image-removebg-preview-1.png" }
        }
    },
    {
        name = "weapon_heavypistol",
        label = "Pistolet Lourd",
        quantity = 1,
        pics = "https://i.postimg.cc/W4vDBSXy/weapon-heavypistol.png",
        ingredients = {
            { name = "feraille", label = "Ferraille", quantity = 4, pics = "https://i.postimg.cc/vTS5r97v/barre-de-fer-removebg-preview.png" },
            { name = "titanium", label = "Titanium", quantity = 4, pics = "https://i.postimg.cc/4dfcjwB5/pierre-crue-d-ilm-C3-A9nite-minerai-titanique-sur-le-blanc-134143488-removebg-preview.png" },
            { name = "plomb", label = "Plomb", quantity = 2, pics = "https://i.postimg.cc/nzwqfBsQ/image-removebg-preview-1.png" }
        }
    },
    {
        name = "weapon_glock20",
        label = "Glock 20",
        quantity = 1,
        pics = "https://i.postimg.cc/4NHmnj0M/weapon-glock.png",
        ingredients = {
            { name = "feraille", label = "Ferraille", quantity = 2, pics = "https://i.postimg.cc/vTS5r97v/barre-de-fer-removebg-preview.png" },
            { name = "titanium", label = "Titanium", quantity = 2, pics = "https://i.postimg.cc/4dfcjwB5/pierre-crue-d-ilm-C3-A9nite-minerai-titanique-sur-le-blanc-134143488-removebg-preview.png" },
            { name = "plomb", label = "Plomb", quantity = 1, pics = "https://i.postimg.cc/nzwqfBsQ/image-removebg-preview-1.png" }
        }
    },
   {
        name = "weapon_machinepistol",
        label = "Tec9",
        quantity = 1,
        pics = "https://i.postimg.cc/VNQMYzLD/weapon-machinepistol.png",
        ingredients = {
            { name = "feraille", label = "Ferraille", quantity = 7, pics = "https://i.postimg.cc/vTS5r97v/barre-de-fer-removebg-preview.png" },
            { name = "titanium", label = "Titanium", quantity = 7, pics = "https://i.postimg.cc/4dfcjwB5/pierre-crue-d-ilm-C3-A9nite-minerai-titanique-sur-le-blanc-134143488-removebg-preview.png" },
            { name = "plomb", label = "Plomb", quantity = 5, pics = "https://i.postimg.cc/nzwqfBsQ/image-removebg-preview-1.png" }
        }
    },
       {
        name = "weapon_microsmg",
        label = "UZI",
        quantity = 1,
        pics = "https://i.postimg.cc/5yNLZpNJ/weapon-microsmg.png",
        ingredients = {
            { name = "feraille", label = "Ferraille", quantity = 7, pics = "https://i.postimg.cc/vTS5r97v/barre-de-fer-removebg-preview.png" },
            { name = "titanium", label = "Titanium", quantity = 7, pics = "https://i.postimg.cc/4dfcjwB5/pierre-crue-d-ilm-C3-A9nite-minerai-titanique-sur-le-blanc-134143488-removebg-preview.png" },
            { name = "plomb", label = "Plomb", quantity = 5, pics = "https://i.postimg.cc/nzwqfBsQ/image-removebg-preview-1.png" }
        }
    },
       {
        name = "weapon_minismg",
        label = "SCORPION",
        quantity = 1,
        pics = "https://i.postimg.cc/3NnCRVbW/weapon-minismg.png",
        ingredients = {
            { name = "feraille", label = "Ferraille", quantity = 7, pics = "https://i.postimg.cc/vTS5r97v/barre-de-fer-removebg-preview.png" },
            { name = "titanium", label = "Titanium", quantity = 7, pics = "https://i.postimg.cc/4dfcjwB5/pierre-crue-d-ilm-C3-A9nite-minerai-titanique-sur-le-blanc-134143488-removebg-preview.png" },
            { name = "plomb", label = "Plomb", quantity = 5, pics = "https://i.postimg.cc/nzwqfBsQ/image-removebg-preview-1.png" }
        }
    },
       {
        name = "weapon_sawnoffshotgun",
        label = "CANON SCIE",
        quantity = 1,
        pics = "https://i.postimg.cc/xjHwCRR5/weapon-sawnoffshotgun.png",
        ingredients = {
            { name = "feraille", label = "Ferraille", quantity = 12, pics = "https://i.postimg.cc/vTS5r97v/barre-de-fer-removebg-preview.png" },
            { name = "titanium", label = "Titanium", quantity = 12, pics = "https://i.postimg.cc/4dfcjwB5/pierre-crue-d-ilm-C3-A9nite-minerai-titanique-sur-le-blanc-134143488-removebg-preview.png" },
            { name = "plomb", label = "Plomb", quantity = 10, pics = "https://i.postimg.cc/nzwqfBsQ/image-removebg-preview-1.png" },
        }
    },
}


ZiZouConfig.diselprice = 10
ZiZouConfig.gasprice = 15

ZiZouConfig.FuelDecor = "FUEL_LEVEL"

ZiZouConfig.DisableKeys = { 0,22,23,24,29,30,31,37,44,56,82,140,166,167,168,170,288,289,311,323 }

ZiZouConfig.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

ZiZouConfig.PumpCoord = {
	[1] = {264.95275878906,-1259.4567871094,29.142911911011,30},
	[2] = {819.61047363281,-1028.2071533203,26.404321670532,30},
	[3] = {1208.6068115234,-1402.2863769531,35.224140167236,30},
	[4] = {1180.9593505859,-329.84280395508,69.316436767578,30},
	[5] = {620.80499267578,268.73849487305,103.08948516846,30},
	[6] = {2581.1779785156,362.01254272461,108.46883392334,30},
	[7] = {175.55857849121,-1562.2135009766,29.264209747314,30},
	[8] = {-319.42581176758,-1471.8182373047,30.548692703247,30},
	[9] = {1785.9000244141,3330.9035644531,41.377250671387,30},
	[10] = {49.802303314209,2779.318359375,58.043937683105,30},
	[11] = {263.92358398438,2607.4140625,44.983062744141,30},
	[12] = {1039.1220703125,2671.30859375,39.550872802734,30},
	[13] = {1208.0380859375,2660.4892578125,37.899772644043,30},
	[14] = {2539.3337402344,2594.61328125,37.944820404053,30},
	[15] = {2679.9396972656,3264.0981445313,55.240585327148,30},
	[16] = {2005.0074462891,3774.2006835938,32.40393447876,30},
	[17] = {1687.263671875,4929.6328125,42.078086853027,30},
	[18] = {1702.0052490234,6416.9975585938,32.763767242432,30},
	[19] = {179.82470703125,6602.8408203125,31.868196487427,30},
	[20] = {-94.206100463867,6419.4975585938,31.489490509033,30},
	[21] = {-2555.1257324219,2334.2705078125,33.078022003174,30},
	[22] = {-1799.4152832031,802.8154296875,138.65368652344,30},
	[23] = {-1436.9724121094,-276.55426025391,46.207653045654,30},
	[24] = {-2096.5913085938,-321.48611450195,13.168619155884,30},
	[25] = {-723.298828125,-935.55322265625,19.213928222656,30},
	[26] = {-525.35266113281,-1211.3215332031,18.184829711914,30},
	[27] = {-70.514175415039,-1761.2590332031,29.655626296997,30},
	[28] = {806.7119, -790.429, 26.305, 117.82096099854,30},
	[29] = {814.5635, -790.481, 26.305, 8.6590166091919,30},
}

ZiZouConfig.Classes = {
	[0] = 0.6, -- Compacts
	[1] = 0.6, -- Sedans
	[2] = 0.6, -- SUVs
	[3] = 0.6, -- Coupes
	[4] = 0.6, -- Muscle
	[5] = 0.6, -- Sports Classics
	[6] = 0.6, -- Sports
	[7] = 0.6, -- Super
	[8] = 0.6, -- Motorcycles
	[9] = 0.6, -- Off-road
	[10] = 0.6, -- Industrial
	[11] = 0.6, -- Utility
	[12] = 0.6, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.0, -- Boats
	[15] = 0.0, -- Helicopters
	[16] = 0.0, -- Planes
	[17] = 0.3, -- Service
	[18] = 0.3, -- Emergency
	[19] = 0.6, -- Military
	[20] = 0.6, -- Commercial
	[21] = 0.6, -- Trains
}

ZiZouConfig.FuelUsage = {
	[1.0] = 2.0,
	[0.9] = 1.8,
	[0.8] = 1.6,
	[0.7] = 1.4,
	[0.6] = 1.2,
	[0.5] = 1.0,
	[0.4] = 0.8,
	[0.3] = 0.6,
	[0.2] = 0.4,
	[0.1] = 0.2,
	[0.0] = 0.0,
}

ZiZouConfig.DistanceToVolume = 30.0 

ZiZouConfig.PlayToEveryone = true 

ZiZouConfig.ItemInVehicle = false 

ZiZouConfig.CommandVehicle = "carplay" 

ZiZouConfig.Zones = {
	{
		name = "Mechanic Zone", -- The name of the radio, it doesn't matter
		coords = vector3(-212.52,-1341.59,34.89), -- the position where the music is played
		job = "mechanic", --the job that can change the music
		range = 30.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = false, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-212.53,-1341.61,34.89) -- where the player can change the music
	},
	{
		name = "Vanilla Zone", -- The name of the radio, it doesn't matter
		coords = vector3(105.111,-1303.221,27.788), -- the position where the music is played
		job = "unicorn", --the job that can change the music
		range = 30.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=W9iUh23Xrsg",-- the default link, if nill it won't play nothing
		isplaying = false, -- the music will play when the server start?
		loop = false,-- when the music stops it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-212.53,-1341.61,34.89) -- where the player can change the music
	},
}


ZiZouConfig.PayAccount = 'black_money' -- Account you want the black market to use('black_money', 'money', 'bank')
ZiZouConfig.MarketPed = `a_m_m_og_boss_01` -- Jenkins hash of ped here

ZiZouConfig.Locations = { --[[ Locations black market ped will spawn at random per restart.
					 	  If only one desired, that works too]]--
	[1] = {
		coords = vector3(57.89, -1733.11, 29.31),
		heading = 153.14
	},

	[2] = {
		coords = vector3(57.89, -1733.11, 29.31),
		heading = 275.48
	},

	[3] = {
		coords = vector3(57.89, -1733.11, 29.31),
		heading = 155.51
	},

	[4] = {
		coords = vector3(57.89, -1733.11, 29.31),
		heading = 59.03
	},
}

ZiZouConfig.randomLocation = ZiZouConfig.Locations[math.random(1,#ZiZouConfig.Locations)]

ZiZouConfig.Items = { 

	{
		label = 'Compact Rifle',
		item = 'WEAPON_COMPACTRIFLE',
		price = 1,
		type = 'weapon',
		balle = '30',
		cadence = "3 Balles/sec",
		rarete = "rare",
		typee = "Fusil d'Assault"
	},
}
