StoreConfig = {}

StoreConfig.Weapons = {
    {
      NameWeapon = "WEAPON_WOLFKNIFE",
      Point = "1000",
      Type = "perm",
      Preview = "https://cdn.discordapp.com/attachments/1338564172644089969/1360968378520440832/z79Ayw5.png?ex=67fd0c13&is=67fbba93&hm=d7669e1e239ac44f30cb5b63c28b825bd67d753089ff38e8924089a617aae89f&format=webp&quality=lossless&width=968&height=968" 
    },
    {
      NameWeapon = "WEAPON_TEC9MF",
      Point = "2500",
      Type = "perm",
      Preview = "https://cdn.discordapp.com/attachments/1338564172644089969/1360968594971820293/tec9mf.png?ex=67fd0c46&is=67fbbac6&hm=0647e727d594f878867a96d464fc8506101ef1816f94968d756594abf46c4fe2&"
    },
    {
        NameWeapon = "WEAPON_HKUMP",
        Point = "3000",
        Type = "perm",
        Preview = "https://cdn.discordapp.com/attachments/1358893645398278166/1360966695077806391/ChatGPT_Image_13_avr._2025_15_15_18.png?ex=67fd0a81&is=67fbb901&hm=69b20e2a0b7b227cca11a4be907d29fc7481a60337d64b6ef7de0a806599b4e5&"
      },
    {
        NameWeapon = "WEAPON_357",
        Point = "2000",
        Type = "perm",
        Preview = "https://cdn.discordapp.com/attachments/1285247546343559168/1360968832935792722/357.png?ex=67fd0c7f&is=67fbbaff&hm=1bd7d5b61aad97a033cc259e2b6b34d343de2f67622df6a89583bff1cf951c6c&"
    },
    {
        NameWeapon = "WEAPON_BLASTM4",
        Point = "3500",
        Type = "perm",
        Preview = "https://cdn.discordapp.com/attachments/1285247546343559168/1360968923897528472/blastm4.png?ex=67fd0c95&is=67fbbb15&hm=084d2f968d80c50357d8220f3be56845e3e51aa6114883da526970303aba20ed&"
    },
    {
        NameWeapon = "WEAPON_M4BEAST",
        Point = "3500",
        Type = "perm",
        Preview = "https://cdn.discordapp.com/attachments/1285247546343559168/1360968992923324476/m4beast.png?ex=67fd0ca5&is=67fbbb25&hm=65f7ea6ca9ac01af3ff8b2b12e18f2486713a874c9b3e460e5f806afdaf03305&"
    },
    {
      NameWeapon = "WEAPON_PPSH41",
      Point = "3500",
      Type = "perm",
      Preview = "https://cdn.discordapp.com/attachments/1338564172644089969/1360969111940890895/9thMUmI.png?ex=67fd0cc1&is=67fbbb41&hm=f60317d1985b37104acd3d987c488debcef696a37600d7a357ffa04e38f4a708&"
    },
    {
      NameWeapon = "WEAPON_SCAR17",
      Point = "3500",
      Type = "perm",
      Preview = "https://cdn.discordapp.com/attachments/1285247546343559168/1360969091048931400/scar17.png?ex=67fd0cbc&is=67fbbb3c&hm=afcd8ec4993bd837415452ac7706b072c6ca50dfc5b96e573934f3491e0f4059&"
    },
    {
      NameWeapon = "WEAPON_COACHGUN",
      Point = "10000",
      Type = "perm",
      Preview = "https://cdn.discordapp.com/attachments/1285247546343559168/1360969158266978425/coachgun.png?ex=67fd0ccc&is=67fbbb4c&hm=5ccb8143e0e4f9397433bd9dd33c695c97fe0cf692eaf1652064135fff21ff98&"
    },
    {
      NameWeapon = "WEAPON_BLUERIOT",
      Point = "11000",
      Type = "perm",
      Preview = "https://cdn.discordapp.com/attachments/1285247546343559168/1360969272062378136/blueriot.png?ex=67fd0ce8&is=67fbbb68&hm=73f09db10c81117d49775aab0fbad0c68f72c2739cb90c55186b1e1980164f0d&"
    },
  }


StoreConfig.Packs = {
    ["illegal"] = {
        name = "Pack ~r~Illegal",
      --  Preview = "https://i.postimg.cc/brfHDSpq/packillegal.png",
        price = 4000,
        type = "illegal",
        loots = {
            {name = "~r~500.000$", type = "money", item = "black_money", amount = 500000},
            {name = "~r~TEC9", type = "weapon", item = "weapon_machinepistol", amount = 250},
            {name = "~r~CHARGEUR", type = "item", item = "clip", amount = 200},
            {name = "~r~BMW M7", type = "vehicle", item = "760M", amount = 1}
        }
    },
    ["legal"] = {
        name = "Pack ~g~Legal",
     --   Preview = "https://i.postimg.cc/YS2P0V8d/packlegal.png",
        price = 3000,
        type = "legal",
        loots = {
            {name = "~g~500.000$", type = "money", item = "money", amount = 500000},
            {name = "~g~X50 EAU", type = "item", item = "water", amount = 50},
            {name = "~g~X50 PAIN", type = "item", item = "bread", amount = 50},
            {name = "~g~BUGATTI", type = "vehicle", item = "CENTURIA", amount = 1},
        }
    }
}

StoreConfig.RoueDrops = {
    ["epic"] = {
        [1] = {name = "BMX X6M", type = "vehicle", item = "x6m", amount = 1, native = false},
        [2] = {name = "200.000$", type = "account", item = "money", amount = 2000000},
        [3] = {name = "yz450f", type = "vehicle", item = "yzfsm", amount = 1, native = false}
    }, 
    ["rare"] = {
        [1] = {name = "50.000$", type = "account", item = "money", amount = 50000},
        [2] = {name = "10 chargeur", type = "item", item = "clip", amount = 1},
        [3] = {name = "25.000$", type = "account", item = "money", amount = 25000}
    },
    ["common"] = {
        [1] = {name = "10.000$", type = "account", item = "money", amount = 10000},
        [2] = {name = "faggio", type = "vehicle", item = "faggio", amount = 1, native = false},
        [3] = {name = "2000$", type = "account", item = "money", amount = 20000}
    }
}

StoreConfig.Vehicles = {
    {name = "Truffade Centuria", data = {
        Point = "3000",
        NameVehicle = "centuria" },
    },
    {name = "Obey BS6", data = {
        Point = "2500",
        NameVehicle = "rs666" },
    },
    {name = "Pegassi Aventado", data = {
        Point = "3000",
        NameVehicle = "aventadors" },
    },
    {name = "Ubermacht M5", data = {
        Point = "2500",
        NameVehicle = "760M" },
    },
    {name = "Pfister GT2BS", data = {
        Point = "2500",
        NameVehicle = "gt2rsmr" },
    },
    {name = "Lampadati Yacht 650", data = {
        Point = "3500",
        NameVehicle = "sr650fly" },
    },
    {name = "Obey BSQ8 Bansory", data = {
        Point = "2500",
        NameVehicle = "rsq8mans" },
    },
    {name = "Obey BS7R", data = {
        Point = "2500",
        NameVehicle = "rs7r" },
    },
    {name = "Benefactor Rocket", data = {
        Point = "3000",
        NameVehicle = "rocket" },
    },
}



AddonVehicles = {
    ['18performante'] = 836213613,
    ['20x5m'] = -658586604,
    ['a45'] = -910466076,
    ['bg700w'] = -1217170464,
    ['bmwm8'] = -1404319008,
    ['kx450f'] = 333512375,
    ['pts21'] = 1694479740,
    ['rmodbolide'] = -1381125554,
    ['rmodbugatti'] = -101696514,
    ['rmodgt63'] = 980885719,
    ['rmodmi8lb'] = -1476696782,
    ['rmodrs6'] = 422090481,
    ['rs7r'] = 1260387191,
    ['rs318'] = 216350205,
    ['tmaxDX'] = -392138597,
    ['urus'] = -520214134,
    ['veneno'] = -42051018,
    ['xadv'] = 1393595816,
}

StoreConfig.Case = {

    ["blue_case"] = {
        name = "BlueCaisse",
        caissename = "blue_case",

        point = 1000, 
        visible = true,
        Preview = "https://i.postimg.cc/nrfsRG9D/blue-case.png",
        list = {
            { money = 30000, tier = 1, label = "~g~30 000$"},
            { weapon = "weapon_machinepistol", amount=1, tier = 4, label = "~y~Tech9"},
            { weapon = "weapon_pistol50", amount=1, tier = 4, label = "~p~Pistolet Cal50"},

            { vehicle = "argento", amount=1, tier = 3, label = "~y~Argento"},
            { bluecoins = 1000, tier = 5, label = "~y~1000 BlueCoins"},
            { black_money = 50000, tier = 1, label = "~r~50 000$"},

            { vip = "vip", expiration = 1, tier = 2, label = "~y~VIP Normal"}, 
            { vip = "diamond", expiration = 1, tier = 2, label = "~b~VIP Diamond"}, 

        }
    },

       ["radiant_case"] = {
        name = "Caisse Radiant",
        caissename = "radiant_case",
        point = 2000, 
        visible = true,
        Preview = "https://i.postimg.cc/J428R4KT/radiant-case.png",
        list = {
            { money = 50000, tier = 2, label = "~g~50 000$"},
            { permweapon = "WEAPON_MENACE", amount=1, tier = 4, label = "~y~menace"},
            { black_money = 50000, tier = 2, label = "~r~50 000$"},

            { vehicle = "argento", tier = 2, label = "~r~Argento"},
            { permweapon = "weapon_sawnoffshotgun", amount=1, tier = 4, label = "~y~Canon Sciée"},
            { vehicle = "sultan2", tier = 3, label = "~r~Sultan2"},

            { vip = "diamond", expiration = 1, tier = 3, label = "~b~VIP Diamant"}, 

        }
    },

    ["ultimate_case"] = {
        name = "Caisse Ultimate",
        caissename = "ultimate_case",
        point = 5000, 
        visible = true,
        Preview = "https://i.postimg.cc/9F4StPtp/ultimate-case.png",
        list = {
            { permweapon = "WEAPON_PISTOLBLACK", amount=1, tier = 4, label = "~y~Pistol550"},
            { permweapon = "WEAPON_CARBINERIFLE6", amount=1, tier = 4, label = "~y~RedAR15"},
            { permweapon = "weapon_blacksniper", amount=1, tier = 4, label = "~y~BlackSniper"},

            { permweapon = "WEAPON_CARBINERIFLE4", amount=1, tier = 4, label = "~y~BlueAR"},
            { permweapon = "WEAPON_CARBINERIFLE7", amount=1, tier = 4, label = "~y~IceAR"},
            { permweapon = "WEAPON_PISTOLWHITE", amount=1, tier = 4, label = "~y~PistolWhite"},
        }
    },

    ["bronze_case"] = {
        name = "Caisse bronze",
        caissename = "bronze_case",
        point = 0, 
        visible = false,
        list = {
            { money = 30000, tier = 1, label = "~g~30 000$"},
            { weapon = "WEAPON_snspistol", amount=1, tier = 4, label = "~y~SNS PISTOL"},
         --   { vehicle = "", amount=1, tier = 3, label = "~y~Rs6"},
           -- { permweapon = "weapon_katana", amount=1, tier = 4, label = "~y~Canon Sciée"},
            { black_money = 50000, tier = 1, label = "~r~50 000$"},
            { vip = "vip", expiration = 1, tier = 3, label = "~y~VIP Normal"}, 

        }
    },

    ["gold_case"] = {
        name = "Caisse gold",
        caissename = "gold_case",
        point = 0, 
        visible = false,
        list = {
            { money = 75000, tier = 1, label = "~g~75 000$"},
            { weapon = "WEAPON_PISTOLPOKA", amount=1, tier = 4, label = "~y~POKA"},
            { vehicle = "scharmann", amount=1, tier = 3, label = "~b~Scharmann"},
            { permweapon = "WEAPON_KATANA2", amount=1, tier = 4, label = "~y~LAZER ROUGE"},
            { bluecoins = 500, tier = 5, label = "~y~500 BlueCoins"},
            { black_money = 100000, tier = 1, label = "~r~100 000$"},
            { vip = "vip", expiration = 1, tier = 2, label = "~b~VIP"}, 
        }
    },

    ["diamond_case"] = {
        name = "Caisse diamond",
        caissename = "diamond_case",
        point = 0, 
        visible = false,
        list = {
            { money = 110000, tier = 1, label = "~g~110 000$"},
            { weapon = "weapon_smg", amount=1, tier = 4, label = "~y~SMG"},
            { vehicle = "tmaxdx", amount=1, tier = 3, label = "~y~TMAX"},
            { permweapon = "WEAPON_KERTUS", amount=1, tier = 3, label = "~y~KERTUS"},
            { bluecoins = 1000, tier = 5, label = "~y~1000 BlueCoins"},
            { black_money = 130000, tier = 1, label = "~r~130 000$"},
            { vip = "vip", expiration = 2, tier = 2, label = "~y~VIP Normal"}, 
            { vip = "diamond", expiration = 2, tier = 2, label = "~b~VIP Diamond"}, 

        }
    }
}

StoreConfig.Chance = {
    [1] = { name = "Common", rate = 50 }, -- tier 1
    [2] = { name = "Rare", rate = 40 }, -- tier 2
    [3] = { name = "Epic", rate = 8 }, -- tier 3 
    [4] = { name = "Unique", rate = 1.7} , -- tier 4 
    [5] = { name = "Legendary", rate = 0.1 }, -- tier 5
}