local casinopos = {
    {x = 1115.85, y = 220.31, z = -49.44},
}

local casinoEntranceVector = vector3(924.99627685547,47.006057739258,81.104507446289)
local casinoExitVector = vector3(1089.6083984375,206.60050964355,-48.999725341797)

local casinopos2 = {
    {x = casinoEntranceVector.x, y = casinoEntranceVector.y, z = casinoEntranceVector.z},
    {x = casinoExitVector.x, y = casinoExitVector.y, z = casinoExitVector.z}
}


RegisterNetEvent('casino:ouvrirAchatJetons')
AddEventHandler('casino:ouvrirAchatJetons', function()
    local input = KeyboardInput('CASINO_ACHAT_JETONS', 'Combien de jetons voulez-vous acheter ? (1€ = 1 jeton)', '', 10)
    
    if input and input ~= '' then
        local montant = tonumber(input)
        
        if montant and montant > 0 then
            TriggerServerEvent('casino:acheterJetons', montant)
        else
            TriggerEvent('esx:showNotification', 'Montant invalide')
        end
    end
end)

RegisterNetEvent('casino:ouvrirVenteJetons')
AddEventHandler('casino:ouvrirVenteJetons', function()
    local input = KeyboardInput('CASINO_VENTE_JETONS', 'Combien de jetons voulez-vous vendre ?', '', 10)
    
    if input and input ~= '' then
        local montant = tonumber(input)
        
        if montant and montant > 0 then
            TriggerServerEvent('casino:vendreJetons', montant)
        else
            TriggerEvent('esx:showNotification', 'Montant invalide')
        end
    end
end)

function CasinoMenu()
    local CasinoMenuu = {
        Base = { Title = "Casino", HeaderColor = {8, 245, 0} },
        Data = { currentMenu = "casino" },
        Events = {
            onSelected = function(self, _, btn)
                if btn.action == "prendreCoins" then
                    TriggerEvent('casino:ouvrirAchatJetons')
                elseif btn.action == "vendreCoins" then
                    TriggerEvent('casino:ouvrirVenteJetons')
                end
            end
        },
        Menu = {
            ["casino"] = {
                b = {
                    {name = "Acheter Jetons", action = "prendreCoins", ask = "→", askX = true},
                    {name = "Vendre Jetons", action = "vendreCoins", ask = "→", askX = true}
                }
            }
        }
    }
    CreateMenu(CasinoMenuu)
end


local casinopos = {
    {x = 1115.85, y = 220.31, z = -49.44},
}

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isNearAnyShop = false

        for _, shop in ipairs(casinopos) do
            local shopCoords = vector3(shop.x, shop.y, shop.z)
            local distance = #(playerCoords - shopCoords)

            if distance < 1.0 then
                DrawMarker(ZiZouConfig.Marker.Markers.Marker.type, shop.x, shop.y, shop.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ZiZouConfig.Marker.Markers.Marker.x, ZiZouConfig.Marker.Markers.Marker.y, ZiZouConfig.Marker.Markers.Marker.z, ZiZouConfig.Marker.Markers.Marker.r, ZiZouConfig.Marker.Markers.Marker.g, ZiZouConfig.Marker.Markers.Marker.b, ZiZouConfig.Marker.Markers.Marker.a, ZiZouConfig.Marker.Markers.Marker.rotate, false, 2, false, nil, nil, false)
               if distance < 1.5 then
                    isNearAnyShop = true
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le casino.")

                    if IsControlJustReleased(0, 38) then
                        CasinoMenu()
                    end
                end
            end
        end

        if not isNearAnyShop then
            Citizen.Wait(500)
        else
            Citizen.Wait(0)
        end
    end
end)

function CasinoTPenterMenu()
    local CasinoTPMenu = {
        Base = { Title = "Casino", HeaderColor = {8, 245, 0} },
        Data = { currentMenu = "casinoenter" },
        Events = {
            onSelected = function(self, _, btn)
                if btn.action == "tpenter" then
                    SetEntityCoords(PlayerPedId(), casinoExitVector.x, casinoExitVector.y, casinoExitVector.z)
                    
            end
        end
        },
        Menu = {
            ["casinoenter"] = {
                b = {
                    {name = "Entrer dans le casino", action = "tpenter", ask = "→", askX = true}
                }
            }
        }
    }
    CreateMenu(CasinoTPMenu)
end




function CasinoTPexitMenu()
    local CasinoTPeMenu = {
        Base = { Title = "Casino", HeaderColor = {8, 245, 0} },
        Data = { currentMenu = "casinoexit" },
        Events = {
            onSelected = function(self, _, btn)
                if btn.action == "tpexit" then
                    SetEntityCoords(PlayerPedId(), casinoEntranceVector.x , casinoEntranceVector.y, casinoEntranceVector.z)
            end
        end
        },
        Menu = {
            ["casinoexit"] = {
                b = {
                    {name = "Sortir du casino", action = "tpexit", ask = "→", askX = true}
                }
            }
        }
    }
    CreateMenu(CasinoTPeMenu)
end


--[[RegisterCommand("casinoexit", function()
    CasinoTPexitMenu()
end)

RegisterCommand("casinoenter", function()
    CasinoTPenterMenu()
end)]]

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isNearAnyShop = false
        
        for _, shop in ipairs(casinopos2) do
            local shopCoords = vector3(shop.x, shop.y, shop.z)
            local distance = #(playerCoords - shopCoords)
            
            if distance < 10.0 then
                DrawMarker(
                    ZiZouConfig.Marker.Markers.Marker.type, 
                    shop.x, 
                    shop.y, 
                    shop.z - 1.0, 
                    0.0, 0.0, 0.0, 
                    0.0, 0.0, 0.0, 
                    ZiZouConfig.Marker.Markers.Marker.x, 
                    ZiZouConfig.Marker.Markers.Marker.y, 
                    ZiZouConfig.Marker.Markers.Marker.z, 
                    ZiZouConfig.Marker.Markers.Marker.r, 
                    ZiZouConfig.Marker.Markers.Marker.g, 
                    ZiZouConfig.Marker.Markers.Marker.b, 
                    ZiZouConfig.Marker.Markers.Marker.a, 
                    ZiZouConfig.Marker.Markers.Marker.rotate, 
                    false, 2, false, nil, nil, false
                )
                
                if distance < 1.5 then
                    isNearAnyShop = true
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu du casino.")
                    
                    if IsControlJustReleased(0, 38) then
                        -- Déterminer quel menu ouvrir en fonction de la position
                        if #(playerCoords - casinoEntranceVector) < 1.5 then
                            CasinoTPenterMenu()
                        elseif #(playerCoords - casinoExitVector) < 1.5 then
                            CasinoTPexitMenu()
                        end
                    end
                end
            end
        end
        
        if not isNearAnyShop then
            Citizen.Wait(500)
        else
            Citizen.Wait(0)
        end
    end
end)


local blipsInfo = {
    {name="Gouvernement", color=0, id=419, coords={x=-513.12, y=-262.75, z=34.43}},
    {name="Tabac", color=2, id=79, coords={x=2349.91, y=3134.76, z=48.20}},
    {name="Agence Immobilière", color=59, id=475, coords={x=-199.151, y=-575.000, z=39.489}},
    {name="Hôpital", color=8, id=61, coords={x=313.319, y=-591.295, z=42.284}},
    
    -- Points de Braquage
    {name="Braquage", color=75, id=255, coords={x=-2957.67, y=481.46, z=15.70}},
    {name="Braquage", color=75, id=255, coords={x=-107.07, y=6474.80, z=31.63}},
    {name="Braquage", color=75, id=255, coords={x=255.00, y=225.86, z=101.01}},
    {name="Braquage", color=75, id=255, coords={x=1736.32, y=6419.47, z=35.03}},
    {name="Braquage", color=75, id=255, coords={x=1961.24, y=3749.46, z=32.34}},
    {name="Braquage", color=75, id=255, coords={x=-709.17, y=-904.21, z=19.21}},
    {name="Braquage", color=75, id=255, coords={x=1990.57, y=3044.95, z=47.21}},
    {name="Braquage", color=75, id=255, coords={x=-2959.33, y=388.21, z=14.00}},
    {name="Braquage", color=75, id=255, coords={x=1126.80, y=-980.40, z=45.41}},
    {name="Braquage", color=75, id=255, coords={x=-43.40, y=-1749.20, z=29.42}},
    {name="Braquage", color=75, id=255, coords={x=1160.67, y=-314.40, z=69.20}},

    {name="Banque", color=4, id=207, coords={x=150.266, y=-1040.203, z=29.374}},
    {name="Banque", color=4, id=207, coords={x=-1212.980, y=-330.841, z=37.787}},
    {name="Banque", color=4, id=207, coords={x=-2962.582, y=482.627, z=15.703}},
    {name="Banque", color=4, id=207, coords={x=-112.202, y=6469.295, z=31.626}},
    {name="Banque", color=4, id=207, coords={x=314.187, y=-278.621, z=54.170}},
    {name="Banque", color=4, id=207, coords={x=-351.534, y=-49.529, z=49.042}},
    {name="Banque", color=4, id=207, coords={x=241.727, y=220.706, z=106.286}},
    {name="Banque", color=4, id=207, coords={x=4476.75, y=-4464.48, z=4.25}},
    {name="Banque", color=4, id=207, coords={x=1175.064, y=2706.643, z=38.094}},

    -- Station Essence
    {name="Station Essence", color=1, id=415, coords={x=49.4187, y=2778.793, z=58.043}},
    {name="Station Essence", color=1, id=415, coords={x=263.894, y=2606.463, z=44.983}},
    {name="Station Essence", color=1, id=415, coords={x=1039.958, y=2671.134, z=39.550}},
    {name="Station Essence", color=1, id=415, coords={x=1207.260, y=2660.175, z=37.899}},
    {name="Station Essence", color=1, id=415, coords={x=2539.685, y=2594.192, z=37.944}},
    {name="Station Essence", color=1, id=415, coords={x=2679.858, y=3263.946, z=55.240}},
    {name="Station Essence", color=1, id=415, coords={x=2005.055, y=3773.887, z=32.403}},
    {name="Station Essence", color=1, id=415, coords={x=1687.156, y=4929.392, z=42.078}},
    {name="Station Essence", color=1, id=415, coords={x=1701.314, y=6416.028, z=32.763}},
    {name="Station Essence", color=1, id=415, coords={x=179.857, y=6602.839, z=31.868}},
    {name="Station Essence", color=1, id=415, coords={x=-94.4619, y=6419.594, z=31.489}},
    {name="Station Essence", color=1, id=415, coords={x=-2554.996, y=2334.40, z=33.078}},
    {name="Station Essence", color=1, id=415, coords={x=-1800.375, y=803.661, z=138.651}},
    {name="Station Essence", color=1, id=415, coords={x=-1437.622, y=-276.747, z=46.207}},
    {name="Station Essence", color=1, id=415, coords={x=-2096.243, y=-320.286, z=13.168}},
    {name="Station Essence", color=1, id=415, coords={x=-724.619, y=-935.1631, z=19.213}},
    {name="Station Essence", color=1, id=415, coords={x=-526.019, y=-1211.003, z=18.184}},
    {name="Station Essence", color=1, id=415, coords={x=-70.2148, y=-1761.792, z=29.534}},
    {name="Station Essence", color=1, id=415, coords={x=265.648, y=-1261.309, z=29.292}},
    {name="Station Essence", color=1, id=415, coords={x=819.653, y=-1028.846, z=26.403}},
    {name="Station Essence", color=1, id=415, coords={x=1208.951, y=-1402.567, z=35.224}},
    {name="Station Essence", color=1, id=415, coords={x=1181.381, y=-330.847, z=69.316}},
    {name="Station Essence", color=1, id=415, coords={x=620.843, y=269.100, z=103.089}},
    {name="Station Essence", color=1, id=415, coords={x=2581.321, y=362.039, z=108.468}},
    {name="Station Essence", color=1, id=415, coords={x=176.631, y=-1562.025, z=29.263}},

    -- LTD
    {name="LTD", color=2, id=52, coords={x=-48.35, y=-1757.1, z=29.42}},
    {name="LTD", color=2, id=52, coords={x=1136.01, y=-982.14, z=46.42}},
    {name="LTD", color=2, id=52, coords={x=1163.37, y=-323.8, z=69.21}},
    {name="LTD", color=2, id=52, coords={x=-1222.98, y=-907.09, z=12.33}},
    {name="LTD", color=2, id=52, coords={x=-1487.55, y=-379.11, z=40.16}},
    {name="LTD", color=2, id=52, coords={x=-1968.28, y=390.92, z=15.04}},
    {name="LTD", color=2, id=52, coords={x=-3038.94, y=585.95, z=7.91}},
    {name="LTD", color=2, id=52, coords={x=-3241.93, y=1001.46, z=12.83}},
    {name="LTD", color=2, id=52, coords={x=2557.46, y=382.28, z=108.62}},
    {name="LTD", color=2, id=52, coords={x=547.43, y=2671.71, z=42.15}},
    {name="LTD", color=2, id=52, coords={x=2678.85, y=3280.59, z=55.24}},
    {name="LTD", color=2, id=52, coords={x=1961.53, y=3740.74, z=32.34}},
    {name="LTD", color=2, id=52, coords={x=1392.58, y=3604.69, z=34.98}},
    {name="LTD", color=2, id=52, coords={x=1698.39, y=4924.4, z=42.06}},
    {name="LTD", color=2, id=52, coords={x=1729.31, y=6414.06, z=35.04}},
    {name="LTD", color=2, id=52, coords={x=25.67, y=-1346.37, z=29.49}},
    {name="LTD", color=2, id=52, coords={x=-707.655, y=-914.570, z=19.215}},
    {name="LTD", color=2, id=52, coords={x=-2968.109, y=391.575, z=15.043}},
    {name="LTD", color=2, id=52, coords={x=-1820.705, y=792.394, z=138.116}},
    {name="LTD", color=2, id=52, coords={x=1165.320, y=2709.311, z=38.157}},
    {name="LTD", color=2, id=52, coords={x=4818.817, y=-4309.076, z=5.509152}},

    -- Autres points
    {name="Roue de la Fortune", color=26, id=681, coords={x=236.00059509277, y=-880.18023681641, z=30.492071151733}},
    {name="GoFast", color=1, id=229, coords={x=1218.31, y=-3327.31, z=4.53}},
    {name="Pôle Emploie", color=3, id=407, coords={x=-266.1817, y=-961.0322, z=31.22315}},
    {name="Luxury AutoShop", color=0, id=326, coords={x=254.83, y=-283.94, z=54.01}},
    {name="Luxury PlaneShop", color=0, id=307, coords={x=-1267.9, y=-3392.83, z=12.94}},
    {name="~b~Emploie |~w~ Jardinier", color=2, id=109, coords={x=-1356.846, y=130.2325, z=56.2388}},
    {name="~b~Emploie |~w~ Chantier", color=17, id=566, coords={x=-494.2121, y=-1001.223, z=24.59913}},
    {name="~b~Emploie |~w~ Mineur", color=5, id=67, coords={x=2938.7, y=2787.968, z=84.25786}},
    {name="Benny's", color=4, id=72, coords={x=-211.0, y=-1324.1, z=30.8}},
    {name="Mechanics", color=5, id=446, coords={x=-339.4, y=-137.1, z=38.0}},
    {name="BurgerShot", color=1, id=211, coords={x=-1194.06, y=-892.41, z=13.89}},
    {name="L.S.P.D", color=29, id=60, coords={x = 476.27, y = -976.91, z = 33.91}},
    {name="B.C.S.O", color=52, id=60, coords={x=-460.23, y=5991.86, z=30.27}},
    {name="Récolte de bijoux", color=0, id=617, coords={x=-1023.8, y=693.2, z=160.2}},
    {name="Vente des bijoux", color=0, id=617, coords={x=-619.5, y=-228.9, z=37.0}},
    {name="Vigneron", color=19, id=85, coords={x=-1912.3, y=2072.8, z=139.3}},

    {name="Garage", color=53, id=50, coords={x=229.70, y=-800.11, z=29.57}},
    {name="Garage", color=53, id=50, coords={x=236.574, y=-780.820, z=29.659}},
    {name="Garage", color=53, id=50, coords={x=-305.36, y=-890.27, z=30.08}},
    {name="Garage", color=53, id=50, coords={x=437.81, y=-1958.572, z=21.957}},
    {name="Garage", color=53, id=50, coords={x=-2180.62, y=-372.46, z=12.12}},
    {name="Garage", color=53, id=50, coords={x=2707.22, y=1347.2, z=23.52}},
    {name="Garage", color=53, id=50, coords={x=1029.19, y=-771.31, z=57.04}},
    {name="Garage", color=53, id=50, coords={x=4518.96, y=-4527.5, z=3.14}},
    {name="Garage", color=53, id=50, coords={x=-930.71, y=-2098.58, z=8.3}},
    {name="Garage", color=53, id=50, coords={x=2779.72, y=3469.07, z=54.39}},
    {name="Garage", color=53, id=50, coords={x=2552.84, y=4677.43, z=32.92}},
    {name="Garage", color=53, id=50, coords={x=-53.86, y=-1841.89, z=25.45}},
    {name="Garage", color=53, id=50, coords={x=246.1, y=2601.86, z=44.12}},
    {name="Garage", color=53, id=50, coords={x=-410.38, y=1216.04, z=324.64}},
    {name="Garage", color=53, id=50, coords={x=1737.84, y=3719.28, z=32.04}},
    {name="Garage", color=53, id=50, coords={x=128.7822, y=6622.9965, z=29.7828}},
    {name="Garage", color=53, id=50, coords={x=-1184.837, y=-1492.888, z=3.37}},
    {name="Garage", color=53, id=50, coords={x=-1523.913, y=-422.113, z=34.40}},
    {name="Garage", color=53, id=50, coords={x=63.932, y=16.524, z=68.00}},
    {name="Garage", color=29, id=307, coords={x=-975.86, y=-2989.15, z=12.95}},
    {name="Héliport Sud", color=29, id=43, coords={x=-724.79, y=-1444.18, z=4.0}},
    {name="Port Sud", color=29, id=455, coords={x=-722.79, y=-1351.40, z=0.0}},
    {name="Fourrière Sud", color=20, id=524, coords={x=491.520, y=-1332.836, z=28.334}},
    {name="Fourrière Nord", color=20, id=524, coords={x=1177.590, y=2651.501, z=36.809}},
    {name="Fourrière Aéroport Sud", color=20, id=307, coords={x=-1234.91, y=-2276.42, z=12.95}},
    {name="Fourrière Héliport Sud", color=20, id=43, coords={x=-761.57, y=-1453.89, z=4.0}},
    {name="Fourrière Port Sud", color=20, id=455, coords={x=-925.89, y=-1458.2, z=-0.47}},
}

-- Création des blips
for _, info in ipairs(blipsInfo) do
    local blip = AddBlipForCoord(info.coords.x, info.coords.y, info.coords.z)
    SetBlipSprite(blip, info.id)
    SetBlipColour(blip, info.color)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.name)
    EndTextCommandSetBlipName(blip)
end