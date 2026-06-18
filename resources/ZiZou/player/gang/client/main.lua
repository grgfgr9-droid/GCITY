







local DrawDistance = 5.0

InGangMenu = false
local AlreadyMarker = false
local AlreadyStartGang = false

Gangs = {
    ['jalisco'] = {
        type = 'cartel',
        color = {0, 0, 0},
        ['zones'] = {
            ['cars'] = { coords = vector3(-124.10, 1007.86, 234.73) },
            ['boss'] = { coords = vector3(-112.97, 985.98, 234.75) },
            ['datastore'] = { coords = vector3(-111.48, 999.70, 234.76) }
        }
    },
    ['armenien'] = {
        type = 'mafia',
        color = {255, 102, 102},
        ['zones'] = {
            ['cars'] = { coords = vector3(-3201.04, 836.00, 7.93) },
            ['boss'] = { coords = vector3(-3233.25, 813.65, 13.08) },
            ['datastore'] = { coords = vector3(-3225.95, 811.35, 7.93) }
        }
    },
    ['madrazo'] = {
        type = 'cartel',
        color = {76, 153, 0},
        ['zones'] = {
            ['cars'] = { coords = vector3(1370.83, 1147.51, 112.76) },
            ['boss'] = { coords = vector3(1395.33, 1159.58, 113.33) },
            ['datastore'] = { coords = vector3(1406.90, 1162.18, 113.33) }
        }
    },
    ['mocro'] = {
        type = 'mafia',
        color = {255, 0, 0},
        ['zones'] = {
            ['cars'] = { coords = vector3(-1538.71, 75.50, 55.75) },
            ['boss'] = { coords = vector3(-1528.65, 151.29, 59.80) },
            ['datastore'] = { coords = vector3(-1525.37, 118.67, 54.64) }
        }
    },
    ['medellin'] = {
        type = 'cartel',
        color = {255, 255, 255},
        ['zones'] = {
            ['cars'] = { coords = vector3(1620.34, -2606.66, 52.84) },
            ['boss'] = { coords = vector3(1615.53, -2616.13, 55.87) },
            ['datastore'] = { coords = vector3(1612.71, -2620.16, 52.28) }
        }
    },
    ['tijuana'] = {
        type = 'cartel',
        color = {255, 255, 255},
        ['zones'] = {
            ['cars'] = { coords = vector3(14.89, 548.18, 175.17) },
            ['boss'] = { coords = vector3(8.31, 528.56, 169.63) },
            ['datastore'] = { coords = vector3(-6.97, 530.36, 174.04) }
        }
    },
   ['ballas'] = {
        type = 'gang',
        color = {118, 75, 127},
        ['zones'] = {
            ['cars'] = { coords = vector3(114.14, -1946.17, 19.63) },
            ['boss'] = { coords = vector3(94.48, -1897.53, 20.80) },
            ['datastore'] = { coords = vector3(103.99, -1903.59, 20.85) }
        }
    },
    ['families'] = {
        type = 'gang',
        color = {108, 168, 93},
        ['zones'] = {
            ['cars'] = { coords = vector3(-159.4, -1582.2, 33.7) },
            ['boss'] = { coords = vector3(-137.1, -1609.9, 34.0) },
            ['datastore'] = { coords = vector3(-151.19, -1589.27, 34.03) }
        }
    },
    ['vagos'] = {
        type = 'gang',
        color = {235, 227, 56},
        ['zones'] = {
            ['cars'] = { coords = vector3(323.6, -2027.4, 19.8) },
            ['boss'] = { coords = vector3(364.8, -2064.8, 20.7) },
            ['datastore'] = { coords = vector3(325.47, -2050.26, 19.94) }
        }
    },
    ['crips'] = {
        type = 'gang',
        color = {100, 100, 255},
        ['zones'] = {
            ['cars'] = { coords = vector3(-1088.48, -1674.52, 3.63) },
            ['boss'] = { coords = vector3(-1083.91, -1684.37, 7.60) }, 
            ['datastore'] = { coords = vector3(-1070.51, -1672.63, 3.90) }
        }
    },
    ['bloods'] = {
        type = 'gang',
        color = {204, 47, 47},
        ['zones'] = {
            ['cars'] = { coords = vector3(-1562.74, -388.71, 40.98) },
            ['boss'] = { coords = vector3(-1575.3, -410.2, 47.2) },
            ['datastore'] = { coords = vector3(-1566.52, -401.56, 47.28) }
        }
    },
    ['marabunta'] = {
        type = 'gang',
        color = {75, 106, 156},
        ['zones'] = {
            ['cars'] = { coords = vector3(1422.09, -1505.24, 59.92) },
            ['boss'] = { coords = vector3(1445.8, -1486.6, 62.6) },
            ['datastore'] = { coords = vector3(1445.24, -1488.32, 65.62) }
        }
    },
}

GangsBlips = {
    ["ballas"] = {coords = vector3(83.0, -1924.4, 19.8), name = "Ballas Gang", color = 7, color2 = 7, sprite = 378, radius = 100.0},
    ["families"] = {coords = vector3(-139.3, -1563.896, 34.3), name = "Families Gang", color = 2, color2 = 2, sprite = 378, radius = 100.0},
    ["vagos"] = {coords = vector3(310.5, -2020.1, 20.3), name = "Vagos Gang", color = 5, color2 = 5, sprite = 378, radius = 100.0},
    ["crips"] = {coords = vector3(-1105.6, -1624.7, 4.4), name = "Crips Gang", color = 38, color2 = 38, sprite = 378, radius = 100.0},
    ["bloods"] = {coords = vector3(-1550.63, -405.27, 41.99), name = "Bloods Gang", color = 1, color2 = 1, sprite = 378, radius = 100.0},
    ["marabunta"] = {coords = vector3(1426.47, -1513.62, 60.55), name = "Marabunta Gang", color = 63, color2 = 63, sprite = 378, radius = 100.0},
    ["jalisco"] = {coords = vector3(-113.99, 985.76, 300.0), name = "Cartel De Jalisco", color = 4, color2 = 4, sprite = 378, radius = 100.0},
    ["madrazo"] = {coords = vector3(1370.2, 1146.8, 112.7), name = "Cartel De Madrazo", color = 40, color2 = 40, sprite = 378, radius = 100.0},
    ["armenien"] = {coords = vector3(-3201.68, 836.69, 8.93), name = "Mafia Arméniennes", color = 4, color2 = 4, sprite = 378, radius = 100.0},
    ["mocro"] = {coords = vector3(-1525.37, 118.67, 55.64), name = "Mocro Mafia", color = 4, color2 = 4, sprite = 378, radius = 100.0},
    ["medellin"] = {coords = vector3(1603.62, -2613.42, 53.63), name = "Cartel Medellin", color = 4, color2 = 4, sprite = 378, radius = 100.0},
    ["tijuana"] = {coords = vector3(10.46, 543.03, 175.77), name = "Cartel Tijuana", color = 4, color2 = 4, sprite = 378, radius = 100.0},
}


GangVehicles = {
    ['gang'] = {
        {label = "Primo Custom",model = 'primo2'},
        {label = "Chino",model = 'chino'},
        {label = "Buffalo",model = 'buffalo'},
        {label = "Sanchez",model = 'sanchez2'}
    },
    ['mafia'] = {
        {label = "Baller",model = 'baller2'},
        {label = "Cognoscenti 55",model = 'cog55'},
        {label = "Washington",model = 'washington'},
        {label = "Manchez Scout",model = 'manchez2'}
    },
    ['cartel'] = {
        {label = "Baller",model = 'baller2'},
        {label = "Schafter V12",model = 'schafter4'},
        {label = "Granger",model = 'granger'},
        {label = "Manchez Scout",model = 'manchez2'}
    }
}

local HelpMessages = {
    ['cars'] = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu véhicules",
    ['boss'] = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu patron",
    ['datastore'] = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre"
}

Citizen.CreateThread(function()
	for k,zone in pairs(GangsBlips) do
        local blip = AddBlipForRadius(zone.coords, zone.radius)
        SetBlipHighDetail(blip, true)
          SetBlipColour(blip, zone.color2)
          SetBlipAlpha (blip, 128)
          blip = AddBlipForCoord(zone.coords)
          SetBlipHighDetail(blip, true)
          SetBlipSprite (blip, zone.sprite)
          SetBlipScale  (blip, 0.5)
          SetBlipColour (blip, zone.color)
          SetBlipAsShortRange(blip, true)
      
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(zone.name)
          EndTextCommandSetBlipName(blip)
  end
end)

function StartGangSystem()
    if AlreadyStartGang then
        return
    end
    AlreadyStartGang = true
    Citizen.CreateThread(function()
        while Gangs[ESX.PlayerData.job2.name] do
            Citizen.Wait(5)
            local sleep = true
            local inMarker = false
            local a = ESX.PlayerData.job2.name
            local b = Gangs[ESX.PlayerData.job2.name]
                for i, j in pairs(b["zones"]) do
                    if not Gangs[ESX.PlayerData.job2.name] then return end
                    local distance = GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, j.coords.x, j.coords.y, j.coords.z, true)
                    if (distance < DrawDistance) then
                        sleep = false
                        local gangcolor = Gangs[ESX.PlayerData.job2.name].color
                        DrawMarker(1, j.coords.x, j.coords.y, j.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 4.0, 4.0, 0.5, gangcolor[1], gangcolor[2], gangcolor[3], 200, false, true, 2, false, false, false, false)
                    end
                    if (distance < 2.0) then
                        inMarker = true
                        AlreadyMarker = true
                        if not InGangMenu then
                            ESX.ShowHelpNotification(HelpMessages[i])
                            if IsControlJustReleased(0, 38) then
                                ManageGangAction(i)
                            end
                        end
                    end
                end
            if AlreadyMarker and not inMarker then
                InGangMenu = false
                AlreadyMarker = false
                CloseMenu()
            end
            if sleep then
                Citizen.Wait(2000)
            end
        end
        AlreadyStartGang = false
    end)
end