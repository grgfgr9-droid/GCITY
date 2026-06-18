local InventoryWeight = {
    ["items"] = 0,
    ["wepons"] = 0,
    ["permweapons"] = 0
}

local MoneyData = {
    ["society"] = {name = "Entreprise", color = "~g~", slidemax = {}},
    ["bank"] = {name = "Banque", color = "~b~", slidemax = {}},
    ["money"] = {name = "Liquide", color = "~g~", slidemax = {"Donner", "Jeter"}},
    ["black_money"] = {name = "Argent Sale", color = "~r~", slidemax = {"Donner", "Jeter"}},
    ["coins"] = {name = "Coins", color = "~y~"} -- Ajout des coins avec couleur jaune
}

local WalletData = {
    Licenses = {
        ["idcard"] = {label = "Carte d'identité", slidemax = {"Voir", "Montrer"}},
        ["car"] = {label = "Permis de conduire", slidemax = {"Voir", "Montrer"}},
        ["weapon"] = {label = "Permis de port d'arme", slidemax = {"Voir", "Montrer"}}
    }
}

local AuthorizedVehiclesForTricks = {
    ['blazer'] = true,
    ['blazer3'] = true,
    ['blazer4'] = true
}

local Keys = {}
local KeysOptions = {"Donner", "Jeter"}
local AntiSpamUse = false
local DoorState = {
    FrontLeft = false,
    FrontRight = false,
    BackLeft = false,
    BackRight = false,
    Hood = false,
    Trunk = false
}
local HudDisabled = false


local preferences = {
    ragdollEnabled = true,          -- Activer/Désactiver le ragdoll
    helmetEnabled = true,           -- Activer/Désactiver le casque en moto
    mapEnabled = true,              -- Activer/Désactiver la carte
    meleeEnabled = false,            -- Activer/Désactiver les coups de crosse      -- Activer/Désactiver le réticule
    notificationsEnabled = true,    -- Activer/Désactiver les notifications
    musicEnabled = true,            -- Activer/Désactiver la musique en véhicule
    gpsMarkersEnabled = true        -- Activer/Désactiver les marqueurs GPS
}




local PillSuicide = false

Citizen.CreateThread(function()
    Wait(5000)
    ESX.TriggerServerCallback("personal:getKeys", function(clefs) Keys = clefs end)
end)

RegisterNetEvent('personal:AskForKeys')
AddEventHandler('personal:AskForKeys', function()
    ESX.TriggerServerCallback("personal:getKeys", function(clefs) Keys = clefs end)

end)

function setUniform(value)
  local skin = ESX.PlayerData.skin
    TriggerEvent("caruiskinchanger:getSkin", function(skina)
    if value == "total" then
      TriggerEvent("caruiskinchanger:loadSkin", ESX.PlayerData.skin)
    elseif value == 'torso' then
        if InServiceAdmin then
            ESX.ShowNotification("Vous ne pouvez pas effectuer cette action pendant votre service.")
            return 
        end
        ClearPedTasks(ESX.PlayerData.cache.playerped)

        if skin.torso_1 ~= skina.torso_1 then
            TriggerEvent('caruiskinchanger:loadClothes', skina, {['torso_1'] = skin.torso_1, ['torso_2'] = skin.torso_2, ['tshirt_1'] = skin.tshirt_1, ['tshirt_2'] = skin.tshirt_2, ['arms'] = skin.arms})
        else
            TriggerEvent('caruiskinchanger:loadClothes', skina, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
        end
    elseif value == 'pants' then
        if InServiceAdmin then
            ESX.ShowNotification("Vous ne pouvez pas effectuer cette action pendant votre service.")
            return 
        end
        if skin.pants_1 ~= skina.pants_1 then
            TriggerEvent('caruiskinchanger:loadClothes', skina, {['pants_1'] = skin.pants_1, ['pants_2'] = skin.pants_2})
        else
            if skin.sex == 0 then
                TriggerEvent('caruiskinchanger:loadClothes', skina, {['pants_1'] = 55, ['pants_2'] = 0})
            else
                TriggerEvent('caruiskinchanger:loadClothes', skina, {['pants_1'] = 15, ['pants_2'] = 0})
            end
        end
    elseif value == 'shoes' then
        if InServiceAdmin then
            ESX.ShowNotification("Vous ne pouvez pas effectuer cette action pendant votre service.")
            return 
        end
        if skin.shoes_1 ~= skina.shoes_1 then
            TriggerEvent('caruiskinchanger:loadClothes', skina, {['shoes_1'] = skin.shoes_1, ['shoes_2'] = skin.shoes_2})
        else
            if skin.sex == 0 then
                TriggerEvent('caruiskinchanger:loadClothes', skina, {['shoes_1'] = 54, ['shoes_2'] = 0})
            else
                TriggerEvent('caruiskinchanger:loadClothes', skina, {['shoes_1'] = 47, ['shoes_2'] = 0})
            end
        end
    elseif value == "mask" then
        if InServiceAdmin then
            ESX.ShowNotification("Vous ne pouvez pas effectuer cette action pendant votre service.")
            return 
        end
      ClearPedTasks(ESX.PlayerData.cache.playerped)
      if skin.mask_1 ~= skina.mask_1 then
        TriggerEvent("caruiskinchanger:loadClothes", skina, {["mask_1"] = skin.mask_1, ["mask_2"] = skin.mask_2})
      else
        TriggerEvent("caruiskinchanger:loadClothes", skin, {["mask_1"] = 0})
      end
    elseif value == "helmet" then
        if InServiceAdmin then
            ESX.ShowNotification("Vous ne pouvez pas effectuer cette action pendant votre service.")
            return 
        end
      ClearPedTasks(ESX.PlayerData.cache.playerped)
      if skin.helmet_1 ~= skina.helmet_1 then
        TriggerEvent("caruiskinchanger:loadClothes", skina, {["helmet_1"] = skin.helmet_1, ["helmet_2"] = skin.helmet_2})
      else
        TriggerEvent("caruiskinchanger:loadClothes", skina, {["helmet_1"] = -1})
      end
    end
  end)
  end

function OpenPersonalMenu()
    PersonalMenu = {
        Base = {Title = "Personal", Header = defaultHeader},
        Data = {currentMenu = "menu personel"},
        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                if btn.action == "inventory" then
                    CloseMenu()
                    OpenInventoryMenu()
                elseif btn.action == "docoffi" then
                    CloseMenu()
                    OpenDocMenu()
                elseif btn.action == "vehmanage" then
                    if ESX.PlayerData.cache.invehicle then
                    OpenMenu("gestion vehicule")
                    else
                      ESX.ShowNotification('Vous devez être dans un véhicule pour faire ceci')
                    end
                elseif btn.action == "mototricks" then
                    if ESX.PlayerData.cache.invehicle then
                        local vehicle = ESX.PlayerData.cache.vehicle
                        local vehicleclass = GetVehicleClass(vehicle)
                        if vehicleclass ~= 8 and not AuthorizedVehiclesForTricks[string.lower(GetDisplayNameFromVehicleModel(ESX.Game.GetVehicleProperties(vehicle).model))] then ESX.ShowNotification('Vous devez être en moto pour faire ceci') return end
                      OpenMenu("figures moto")
                      else
                        ESX.ShowNotification('Vous devez être en moto pour faire ceci')
                    end
                elseif btn.action == "misc" then
                    OpenMenu("actions diverses")
                elseif btn.action == "persoo" then
                    OpenMenu("preference perso")
                elseif btn.action == "toggleengine" then
                    if ESX.PlayerData.cache.invehicle then
                        if GetIsVehicleEngineRunning(ESX.PlayerData.cache.vehicle) then
                            SetVehicleEngineOn(ESX.PlayerData.cache.vehicle, false, false, true)
                            SetVehicleUndriveable(ESX.PlayerData.cache.vehicle, true)
                        elseif not GetIsVehicleEngineRunning(ESX.PlayerData.cache.vehicle) then
                            SetVehicleEngineOn(ESX.PlayerData.cache.vehicle, true, false, true)
                            SetVehicleUndriveable(ESX.PlayerData.cache.vehicle, false)
                        end
                    else
                        CloseMenu()
                        ESX.ShowNotification("Vous devez être dans un véhicule pour faire ceci")
                    end
                elseif btn.action == "toggledoor" then
                    if ESX.PlayerData.cache.invehicle then
                                if btn.door == 1 then
                                    if not DoorState.FrontLeft then
                                        DoorState.FrontLeft = true
                                        SetVehicleDoorOpen(ESX.PlayerData.cache.vehicle, 0, false, false)
                                    elseif DoorState.FrontLeft then
                                        DoorState.FrontLeft = false
                                        SetVehicleDoorShut(ESX.PlayerData.cache.vehicle, 0, false, false)
                                    end
                                elseif btn.door == 2 then
                                    if not DoorState.FrontRight then
                                        DoorState.FrontRight = true
                                        SetVehicleDoorOpen(ESX.PlayerData.cache.vehicle, 1, false, false)
                                    elseif DoorState.FrontRight then
                                        DoorState.FrontRight = false
                                        SetVehicleDoorShut(ESX.PlayerData.cache.vehicle, 1, false, false)
                                    end
                                elseif btn.door == 3 then
                                    if not DoorState.BackLeft then
                                        DoorState.BackLeft = true
                                        SetVehicleDoorOpen(ESX.PlayerData.cache.vehicle, 2, false, false)
                                    elseif DoorState.BackLeft then
                                        DoorState.BackLeft = false
                                        SetVehicleDoorShut(ESX.PlayerData.cache.vehicle, 2, false, false)
                                    end
                                elseif btn.door == 4 then
                                    if not DoorState.BackRight then
                                        DoorState.BackRight = true
                                        SetVehicleDoorOpen(ESX.PlayerData.cache.vehicle, 3, false, false)
                                    elseif DoorState.BackRight then
                                        DoorState.BackRight = false
                                        SetVehicleDoorShut(ESX.PlayerData.cache.vehicle, 3, false, false)
                                    end
                                elseif btn.door == 5 then
                                    if not DoorState.Hood then
                                        DoorState.Hood = true
                                        SetVehicleDoorOpen(ESX.PlayerData.cache.vehicle, 4, false, false)
                                    elseif DoorState.Hood then
                                        DoorState.Hood = false
                                        SetVehicleDoorShut(ESX.PlayerData.cache.vehicle, 4, false, false)
                                    end
                                elseif btn.door == 6 then
                                    if not DoorState.Trunk then
                                        DoorState.Trunk = true
                                        SetVehicleDoorOpen(ESX.PlayerData.cache.vehicle, 5, false, false)
                                    elseif DoorState.Trunk then
                                        DoorState.Trunk = false
                                        SetVehicleDoorShut(ESX.PlayerData.cache.vehicle, 5, false, false)
                                    end
                                end
                            else
                        CloseMenu()
                        ESX.ShowNotification("Vous devez être dans un véhicule pour faire ceci")
                    end
                elseif btn.action == "trick" then
                    if not ESX.PlayerData.cache.invehicle then 
                        CloseMenu()
                        ESX.ShowNotification('Vous devez être en moto pour faire ceci')
                        return 
                      else
                        local vehicle = ESX.PlayerData.cache.vehicle
                        local vehicleclass = GetVehicleClass(ESX.PlayerData.cache.vehicle)
                        if vehicleclass ~= 8 and not AuthorizedVehiclesForTricks[string.lower(GetDisplayNameFromVehicleModel(ESX.Game.GetVehicleProperties(vehicle).model))] then CloseMenu() ESX.ShowNotification('Vous devez être en moto pour faire ceci') return end
                        if (GetEntitySpeed(vehicle) * 3.6) > 70 then
                      if string.len(btn.dict) > 0 then
                        RequestAnimDict(btn.dict)
                        while not HasAnimDictLoaded(btn.dict) do
                        Citizen.Wait(100)
                        end
                        TaskPlayAnim(ESX.PlayerData.cache.playerped, btn.dict, btn.anim, 4.0, 4.0, btn.duration, 32, 0, 0, 0, 0)
                        RemoveAnimDict(btn.dict)
                      end
                    else
                        ESX.ShowNotification('Vous devez aller plus vite pour faire des figures')
                    end
                      end
                elseif btn.action == "disablehud" then
                    TriggerEvent('esx:toggleHUD')

                elseif btn.action == "fpsboost" then
                    if btn.slidenum == 1 then
                        SetTimecycleModifier()
                        ClearTimecycleModifier()
                        ClearExtraTimecycleModifier()
                    elseif btn.slidenum == 2 then 
                        SetTimecycleModifier('tunnel')
                        RopeDrawShadowEnabled(false)
                    elseif btn.slidenum == 3 then
                        SetTimecycleModifier('MP_Powerplay_blend')
                        SetExtraTimecycleModifier('reflection_correct_ambient')    
                        RopeDrawShadowEnabled(false)
                    elseif btn.slidenum == 4 then 
                        SetTimecycleModifier('yell_tunnel_nodirect')
                    end
                elseif btn.action == "disablemap" then
                    preferences.mapEnabled = not preferences.mapEnabled 
                    DisplayRadar(preferences.mapEnabled) 
                elseif btn.action == "bmx" then
                    pocketBMX()
                elseif btn.action == "disablemelee" then
                    preferences.meleeEnabled = not preferences.meleeEnabled -- Inverse l'état actuel
                    DisableControlAction(0, 140, not preferences.meleeEnabled) -- Active/Désactive le coup de cross
                elseif btn.action == "togglehelmet" then
                    preferences.helmetEnabled = not preferences.helmetEnabled -- Inverse l'état du casque
                
                    if preferences.helmetEnabled then
                        SetPedHelmet(ESX.PlayerData.cache.playerped, true) -- Mettre le casque
                    else
                        RemovePedHelmet(ESX.PlayerData.cache.playerped, true) -- Retirer le casque
                    end
                elseif btn.action == "toggleragdoll" then
                    preferences.ragdollEnabled = not preferences.ragdollEnabled -- Inverse l'état du ragdoll
                
                    local playerPed = PlayerPedId()
                    SetPedCanRagdoll(playerPed, preferences.ragdollEnabled) 
                elseif btn.action == "togglegps" then
                    preferences.gpsMarkersEnabled = not preferences.gpsMarkersEnabled -- Inverse l'état du GPS
                
                    if not preferences.gpsMarkersEnabled then
                        ClearGpsPlayerWaypoint() -- Supprime le marqueur GPS
                    end

                elseif btn.action == "toggleradio" then
                    preferences.musicEnabled = not preferences.musicEnabled -- Inverse l'état de la radio
                
                    local playerPed = PlayerPedId()
                    if IsPedInAnyVehicle(playerPed, false) then
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                
                        if not preferences.musicEnabled then
                            SetVehicleRadioEnabled(vehicle, false) -- Désactive la radio
                            SetVehRadioStation(vehicle, "OFF") -- Met la radio sur OFF
                        else
                            SetVehicleRadioEnabled(vehicle, true) -- Réactive la radio
                        end
                    end   
                
                elseif btn.action == "bmx" then
                    pocketBMX()
                elseif btn.action == "cyanure" then
                    local confirm = KeyboardInput("CYANURE_CONFIRM", "Confirmer ? Ecrivez oui pour confirmer.", "", 6)
                    if confirm ~= nil and confirm == "oui" then
                    RequestAnimDict("mp_suicide")
                    while not HasAnimDictLoaded("mp_suicide") do
                      Citizen.Wait(100)
                    end
                    TaskPlayAnim(ESX.PlayerData.cache.playerped, "mp_suicide", "pill", 8.0, 1.0, 6000, 1, 0.0, 0, 0, 0)
                    RemoveAnimDict("mp_suicide")
                    Citizen.Wait(5000)
                    PillSuicide = true
                    SetEntityHealth(ESX.PlayerData.cache.playerped, 0)
                    Citizen.Wait(2500)
                    PillSuicide = false
                    end



                elseif btn.action == "sync" then
                    if btn.slidenum == 1 then
                        ESX.SavePlayer()
                    elseif btn.slidenum == 2 then 
                        ExecuteCommand('syncweapon')
                        ESX.ShowNotification("Synchronisation des armes effectuée")
                    elseif btn.slidenum == 3 then 
                        ExecuteCommand('syncperm')
                        ESX.ShowNotification("Synchronisation des armes permanentes effectuée")
                    end

                

                elseif btn.action == "leavejoborgalesang" then
                    if btn.slidenum == 1 then
                        local confirm = KeyboardInput("CYANURE_CONFIRM", "Confirmer ? Ecrivez oui pour confirmer.", "", 6)
                        if confirm ~= nil and confirm == "oui" then
                        ExecuteCommand('leavejob')
                        ESX.ShowNotification("Vous avez bien quitté votre métier.")
                        end
                    elseif btn.slidenum == 2 then 
                        local confirm = KeyboardInput("CYANURE_CONFIRM", "Confirmer ? Ecrivez oui pour confirmer.", "", 6)
                        if confirm ~= nil and confirm == "oui" then
                            ExecuteCommand('leavegang')
                            ESX.ShowNotification("Vous avez bien quitté votre faction.")
                        end
                    end
                elseif btn.action == "openrocktareditor" then
                    CloseMenu()
                    Wait(20)
                    ExecuteCommand("rec")
                elseif btn.action == "redamvocal" then
                    ExecuteCommand('vsync')
                elseif btn.action == "animation" then
                    CloseMenu()
                    ExecuteCommand('animmenu')
                
                elseif btn.action == "vocal3d" then
                    ExecuteCommand('3d')

                elseif btn.action == "dressing" then
                    OpenMenu("dressing")
                elseif btn.action == "gf" then
                    OpenMenugf("gf")
                elseif btn.action == "helmet" then
                    setUniform("helmet")
                  elseif btn.action == "mask" then
                    setUniform("mask")
                  elseif btn.action == "torso" then
                    setUniform("torso")
                  elseif btn.action == "pants" then
                    setUniform("pants")
                  elseif btn.action == "shoes" then
                    setUniform("shoes")
                end
            end
        },
        Menu = {
            ["menu personel"] = {
                b = {
                  --  name = '		    Votre UUID : '..ZiZouConfig.DefaultColorCode..'' .. ESX.PlayerData.uuid, action = 'null'
                    {name = "                       Votre UniqueID : "..ZiZouConfig.DefaultColorCode..'' ..ESX.PlayerData.uuid, action = "null", ask = "", askX = true},
                    {name = "Sac à dos", action = "inventory", ask = "→", askX = true},
                    {name = "Documents officiels", action = "docoffi", ask = "→", askX = true},
                    {name = "Animation", action = "animation", ask = "→", askX = true},
                    {name = "Vêtements", action = "dressing", ask = "→", askX = true},
                }
            },
            ["gestion vehicule"] = {
                b = {
                    {name = "Eteindre / Allumer moteur", action = "toggleengine", ask = "→", askX = true},
                    {name = "Ouvrir / Fermer porte conducteur", action = "toggledoor", door= 1, ask = "→", askX = true},
                    {name = "Ouvrir / Fermer porte passager", action = "toggledoor",door= 2, ask = "→", askX = true},
                    {name = "Ouvrir / Fermer porte arrière gauche", action = "toggledoor",door= 3, ask = "→", askX = true},
                    {name = "Ouvrir / Fermer porte arrière droite", action = "toggledoor",door= 4, ask = "→", askX = true},
                    {name = "Ouvrir / Fermer capot", action = "toggledoor",door= 5, ask = "→", askX = true},
                    {name = "Ouvrir / Fermer coffre", action = "toggledoor",door= 6, ask = "→", askX = true}
                }
            },
            ["figures moto"] = {
                b = {
                    {name = "Figure 1", action = "trick", dict = "rcmextreme2atv", anim = "idle_b", duration = 4866, ask = "→", askX = true},
                    {name = "Figure 2", action = "trick", dict = "rcmextreme2atv", anim = "idle_c", duration = 5600, ask = "→", askX = true},
                    {name = "Figure 3", action = "trick", dict = "rcmextreme2atv", anim = "idle_d", duration = 3566, ask = "→", askX = true},
                    {name = "Figure 4", action = "trick", dict = "rcmextreme2atv", anim = "idle_e", duration = 2999, ask = "→", askX = true},
                    {name = "Figure 5", action = "trick", dict = "rcmextreme2atv", anim = "idle_a", duration = 4799, ask = "→", askX = true},
                }
            },
            ["actions diverses"] = {
                b = {
                    {name = "FPS BOOST", action = "fpsboost", slidemax = {"Aucun", "Minimum", "Modéré", "Maximum"}},
                   {name = "Désactiver le HUD", action = "disablehud", checkbox = HudDisabled},
                   {name = "Sortir/Ranger son bmx", action = "bmx", ask = "→", askX = true},
                   {name = "Ouvrir Rockstar Editor", action = "openrocktareditor", ask = "→", askX = true},
                   {name = "Quitter", action = "leavejoborgalesang", slidemax = {"Métier", "Faction"}},
                   {name = "Vocal 3D", action = "vocal3d", ask = "→", askX = true},
                   {name = "Redémarrer le vocal", action = "redamvocal", ask = "→", askX = true},
            
                   {name = "Synchroniser", action = "sync", slidemax = {"Mon Personnage", "Mes Armes", "Mes Armes Perm"}},
                   {name = "~r~Se suicider", action = "cyanure", ask = "→", askX = true}
                }
            },
            ["preference perso"] = {
                b = {
                   {name = "Activer/Désactiver la Map", action = "disablemap", checkbox = preferences.mapEnabled},
                 --  {name = "Activer/Désactiver Coup de Crosse", action = "disablemelee", checkbox = preferences.meleeEnabled},
                   {name = "Activer/Désactiver Casque Moto", action = "togglehelmet", checkbox = preferences.helmetEnabled},
                   {name = "Activer/Désactiver la musique en véhicule", action = "toggleradio", checkbox = preferences.musicEnabled},
                   {name = "Activer/Désactiver les marqueurs GPS", action = "togglegps", checkbox = preferences.gpsMarkersEnabled},
                   {name = "Activer/Désactiver le Ragdoll", action = "toggleragdoll", checkbox = preferences.ragdollEnabled},

                }
            },
            ["dressing"] = {
                b = {
                    {name = "Enlever/mettre chapeau", action = "helmet", ask = "→", askX = true},
                    {name = "Enlever/mettre masque", action = "mask", ask = "→", askX = true},
                    {name = "Enlever/mettre t-shirt", action = "torso", ask = "→", askX = true},
                    {name = "Enlever/mettre pantalon", action = "pants", ask = "→", askX = true},
                    {name = "Enlever/mettre chaussure", action = "shoes", ask = "→", askX = true},
                }
            }
        }
    }

    if ESX.PlayerData.cache.invehicle then
        local vehicleclass = GetVehicleClass(ESX.PlayerData.cache.vehicle)
            table.insert(PersonalMenu.Menu["menu personel"].b, {name = "Gestion véhicule", action = "vehmanage", ask = "→", askX = true})
        if vehicleclass == 8 or AuthorizedVehiclesForTricks[string.lower(GetDisplayNameFromVehicleModel(ESX.Game.GetVehicleProperties(ESX.PlayerData.cache.vehicle).model))] then

            table.insert(PersonalMenu.Menu["menu personel"].b, {name = "Figures Moto", action = "mototricks", ask = "→", askX = true})
        end
    end
    table.insert(PersonalMenu.Menu["menu personel"].b, {name = "Divers", action = "misc", ask = "→", askX = true})
    table.insert(PersonalMenu.Menu["menu personel"].b, {name = "Préférences Personnel", action = "persoo", ask = "→", askX = true})

    CreateMenu(PersonalMenu)
end

function OpenInventoryMenu()
    local playerPed = ESX.PlayerData.cache.playerped
    InventoryMenu = {
        Base = {Title = "Inventaire", HeaderColor = {255, 255, 255}},
        Data = { currentMenu = "mon inventaire"},
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if btn.action then
                if btn.action == "wallet" then
                    InventoryMenu.Menu["mon portefeuille"].b = {}
                
                    -- Vérifier si les comptes existent avant d'itérer
                    if ESX.PlayerData.accounts then
                        for k, v in pairs(ESX.PlayerData.accounts) do 
                            if MoneyData[v.name] and MoneyData[v.name].slidemax then
                                table.insert(InventoryMenu.Menu["mon portefeuille"].b, {
                                    name = MoneyData[v.name].name .. ": " .. MoneyData[v.name].color .. ESX.Math.GroupDigits(v.money) .. "$~s~",
                                    itemtype = "account",
                                    itemname = v.name,
                                    slidemax = MoneyData[v.name].slidemax
                                })
                            end
                        end
                    end
                
                    -- Vérifier si storepoints existe avant d'itérer
                    table.insert(InventoryMenu.Menu["mon portefeuille"].b, {
                        name = ZiZouConfig.StorePointsName .. ' : ~b~' .. ESX.PlayerData.storepoints, -- Nom à afficher
                        action = "", -- Nom interne de l'élément
                    })
                    
                    
                
                    OpenMenu("mon portefeuille")
                
                elseif btn.action == "keys" then
                    for i = 1, #Keys, 1 do
                        local vehmodel = string.lower(GetDisplayNameFromVehicleModel(Keys[i].name))
                        if not AddonVehicles[vehmodel] then
                        InventoryMenu.Menu["mes clés"].b[i] = {name = GetDisplayNameFromVehicleModel(Keys[i].name).." | "..Keys[i].plate, itemtype = "key", itemname = Keys[i].plate, slidemax = KeysOptions}
                        end
                    end
                    OpenMenu("mes clés")
                elseif btn.action == "items" then
                    InventoryMenu.Menu["mes items"].b = {}
                    for k,v in ipairs(ESX.PlayerData.inventory) do
                        if v.count > 0 then
                          table.insert(InventoryMenu.Menu["mes items"].b, {name = v.label.." ("..v.count..")", itemtype = "standard", itemname = v.name, usable = v.usable, slidemax = {"Utiliser", "Donner", "Jeter"}})
                        end
                    end
                    OpenMenu("mes items")
                elseif btn.action == "weapons" then
                    InventoryMenu.Menu["mes armes"].b = {}
                    for k,v in ipairs(ESX.PlayerData.loadout) do
                        
                        local weaponHash = GetHashKey(v.name)
                        if HasPedGotWeapon(playerPed, weaponHash, false) then
                          local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                          if ammo then
                            ammo = ammo
                          else
                            ammo = 0
                          end
                          table.insert(InventoryMenu.Menu["mes armes"].b, {name = v.label.." ("..ammo..")", itemtype = "weapon", itemname = v.name, slidemax = {"Donner", "Jeter"}})
                        end
                    end
                    OpenMenu("mes armes")
                elseif btn.action == "permweapons" then
                    InventoryMenu.Menu["mes armes"].b = {}
                    for k,v in ipairs(ESX.PlayerData.permloadout) do

                        local weaponHash = GetHashKey(v.name)
                            local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                            if ammo then
                                ammo = ammo
                            else
                                ammo = 0
                            end
                            table.insert(InventoryMenu.Menu["mes armes"].b, {name = v.label.." ("..ammo..")", itemtype = "permweapon", itemname = v.name})
                    end
                    OpenMenu("mes armes")
                end
            else
                if btn.itemtype == "account" then
                    if btn.slidemax then
                        if btn.slidenum == 1 then
                            if btn.itemname == "society" or btn.itemname == "bank" then
                                return
                            end
                            if closestPlayer == -1 or closestDistance >= 2.0 then ESX.ShowNotification("Personne à proximité.") return end
                            local amount = KeyboardInput("INVENTORY_GIVE", "Combien donner ?", "", 6)
                            if tonumber(amount) ~= nil then
                            TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_account", btn.itemname, tonumber(amount))
                            CloseMenu()
                            end
                        elseif btn.slidenum == 2 then
                            if btn.itemname == "society" or btn.itemname == "bank" then
                                return
                            end
                            local amount = KeyboardInput("INVENTORY_DROP", "Combien jeter ?", "", 6)
                            if tonumber(amount) ~= nil then
                            TriggerServerEvent("esx:removeInventoryItem", "item_account", btn.itemname, tonumber(amount))
                            CloseMenu()
                            end
                        end
                    end
                elseif btn.itemtype == "standard" then
                    if btn.slidemax then
                        if btn.slidenum == 1 then
                            if btn.usable then
                                if not AntiSpamUse then
                                  AntiSpamUse = true
                                  TriggerServerEvent("esx:useItem", btn.itemname)
                                  CloseMenu()
                                  OpenInventoryMenu()
                                  Citizen.SetTimeout(1000, function()
                                  AntiSpamUse = false
                                  end)
                                end
                            else
                                CloseMenu()
                                ESX.ShowNotification("Action impossible.")
                            end
                        elseif btn.slidenum == 2 then
                            if closestPlayer == -1 or closestDistance >= 2.0 then ESX.ShowNotification("Personne à proximité.") return end
                            local amount = KeyboardInput("INVENTORY_GIVE", "Combien donner ?", "", 6)
                            if tonumber(amount) ~= nil then
                            TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_standard", btn.itemname, tonumber(amount))
                            CloseMenu()
                            end
                        elseif btn.slidenum == 3 then
                            local amount = KeyboardInput("INVENTORY_DROP", "Combien jeter ?", "", 6)
                            if tonumber(amount) ~= nil then
                            TriggerServerEvent("esx:removeInventoryItem", "item_standard", btn.itemname, tonumber(amount))
                            CloseMenu()
                            end
                        end
                    end
                elseif btn.itemtype == "weapon" then
                    if btn.slidemax then
                        if btn.slidenum == 1 then
                            if closestPlayer == -1 or closestDistance >= 2.0 then ESX.ShowNotification("Personne à proximité.") return end
                            TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_weapon", btn.itemname, nil)
                            CloseMenu()
                        elseif btn.slidenum == 2 then
                            TriggerServerEvent("esx:removeInventoryItem", "item_weapon", btn.itemname, nil)
                            CloseMenu()
                        end
                    end
                elseif btn.itemtype == "license" then
                    if btn.slidemax then
                        if btn.slidenum == 1 then
                            TriggerServerEvent("license:show", GetPlayerServerId(PlayerId()), btn.itemname)
                        elseif btn.slidenum == 2 then
                            if closestPlayer == -1 or closestDistance >= 2.0 then ESX.ShowNotification("Personne à proximité.") return end
                            TriggerServerEvent("license:show", GetPlayerServerId(closestPlayer), btn.itemname)
                        end
                    end
                elseif btn.itemtype == "key" then
                    if btn.slidenum == 1 then
                        if closestPlayer == -1 or closestDistance >= 2.0 then ESX.ShowNotification("Personne à proximité.") return end
                        local confirm = KeyboardInput("KEY_CONFIRM", "Confirmer ? Ecrivez oui pour confirmer.", "", 6)
                        if confirm ~= nil and confirm == "oui" then
                            TriggerServerEvent("personal:updateKey", GetPlayerServerId(closestPlayer), btn.itemname) 
                            CloseMenu()
                        end
                    elseif btn.slidenum == 2 then
                        ESX.ShowNotification("Bientot possible.")
                    end
                elseif btn.itemtype == "bill" then
                    if btn.slidenum == 1 then
                        ESX.TriggerServerCallback('billing:payBill', function()
                            CloseMenu()
                        end, btn.itemname)
                    elseif btn.slidenum == 2 then
                        ESX.ShowNotification("Bientôt disponible !")
                    end
                end
            end
        end
        },
        Menu = {
            ["mon inventaire"] = {
                b = {
                    {name = "Portefeuille", action = "wallet", ask = "→", askX = true}
                }
            },
            ["mon portefeuille"] = {
                b = {}
            },
            ["mes clés"] = {
                b = {}
            },
            ["mes factures"] = {
                b = {}
            },
            ["mes items"] = {
                b = {}
            },
            ["mes armes"] = {
                b = {}
            }
        }
    }

    InventoryWeight["items"] = 0
    for k,v in ipairs(ESX.PlayerData.inventory) do
        if v.count > 0 then
          InventoryWeight["items"] = InventoryWeight["items"] + v.count
        end
    end

    InventoryWeight["weapons"] = #ESX.PlayerData.loadout
    InventoryWeight["permweapons"] = #ESX.PlayerData.permloadout

    table.insert(InventoryMenu.Menu["mon inventaire"].b, {name = "Clés (" .. #Keys .. ")", action = "keys", ask = "→", askX = true})
    table.insert(InventoryMenu.Menu["mon inventaire"].b, {name = "Items (" .. InventoryWeight["items"] .. " / " .. ESX.PlayerData.maxWeight .. ")", action = "items", ask = "→", askX = true})
    table.insert(InventoryMenu.Menu["mon inventaire"].b, {name = "Armes (" .. InventoryWeight["weapons"] .. ")", action = "weapons", ask = "→", askX = true})
    table.insert(InventoryMenu.Menu["mon inventaire"].b, {name = "Armes Permanentes (" .. InventoryWeight["permweapons"] .. ")", action = "permweapons", ask = "→", askX = true})


    CreateMenu(InventoryMenu)
end

function OpenDocMenu()
    local playerPed = ESX.PlayerData.cache.playerped
    DocMenu = {
        Base = {Title = "Inventaire", HeaderColor = {255, 255, 255}},
        Data = { currentMenu = "mon portefeuille"},
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if btn.action then
                if btn.action == "wallet" then
                    DocMenu.Menu["mon portefeuille"].b = {}
                    table.insert(DocMenu.Menu["mon portefeuille"].b, {name = "            ---------------------------------------------------", itemtype = "null", itemname = "separator"})
                    for k, v in pairs(WalletData.Licenses) do 
                        table.insert(DocMenu.Menu["mon portefeuille"].b, {name = v.label, itemtype = "license", itemname = k, slidemax = v.slidemax})
                    end
                    OpenMenu("mon inventaire")
                end
            else
                if  btn.itemtype == "license" then
                    if btn.slidemax then
                        if btn.slidenum == 1 then
                            TriggerServerEvent("license:show", GetPlayerServerId(PlayerId()), btn.itemname)
                        elseif btn.slidenum == 2 then
                            if closestPlayer == -1 or closestDistance >= 2.0 then ESX.ShowNotification("Personne à proximité.") return end
                            TriggerServerEvent("license:show", GetPlayerServerId(closestPlayer), btn.itemname)
                        end
                    end
                end
            end
        end
        },
        Menu = {
            ["mon portefeuille"] = {
                b = {}
            },

        }
    }


    table.insert(DocMenu.Menu["mon portefeuille"].b, {name = "Metier", action = "", ask = ESX.PlayerData.job.label .. ' - ' .. ESX.PlayerData.job.grade_label, askX = true})
    table.insert(DocMenu.Menu["mon portefeuille"].b, {name = "Faction", action = "", ask = ESX.PlayerData.job2.label .. ' - ' .. ESX.PlayerData.job2.grade_label, askX = true})
    table.insert(DocMenu.Menu["mon portefeuille"].b, {name = "               -----------------------------------------------", itemtype = "null", itemname = "separator"})

    for k, v in pairs(WalletData.Licenses) do 
        table.insert(DocMenu.Menu["mon portefeuille"].b, {name = v.label, itemtype = "license", itemname = k, slidemax = v.slidemax})
    end


    CreateMenu(DocMenu)
end

RegisterNetEvent('license:show')
AddEventHandler('license:show', function(type, data)
    if type == 'idcard' then
    ESX.ShowNotification('Prénom : ' .. data.firstname)
    ESX.ShowNotification('Nom de famille : ' .. data.lastname)
    ESX.ShowNotification('Date de naissance : ' .. data.dob)
    elseif type == 'weapon' then
    if data then
        if data.has then
            ESX.ShowNotification('Cette personne a le permis de port d\'arme')
        else
            ESX.ShowNotification('Cette personne n\'a pas le permis de port d\'arme') 
        end        
    end
    elseif type == 'car' then
        if data then
            if data.has then
                ESX.ShowNotification('Cette personne a le permis de conduire')
            else
                ESX.ShowNotification('Cette personne n\'a pas le permis de conduire') 
            end        
        end
    end
end)

function pocketBMX()
    if not bmx then
        local playerPed = ESX.PlayerData.cache.playerped
        local coords = GetEntityCoords(playerPed)
        local vehicle = GetClosestVehicle(coords, 2.0, 0, 71)
        if vehicle then
            local carModel = GetEntityModel(vehicle)
            if carModel == 1131912276 then
                ESX.ShowNotification("Vous avez déjà un BMX sorti.")
            else
                ESX.Game.SpawnVehicle("bmx", ESX.PlayerData.cache.coords, ESX.PlayerData.cache.heading, function(vehicle)
                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    bmx = true
                    ESX.ShowNotification("BMX Sorti.")
                end, "bmx")
            end
        else
            ESX.Game.SpawnVehicle("bmx", ESX.PlayerData.cache.coords, ESX.PlayerData.cache.heading, function(vehicle)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                bmx = true
                ESX.ShowNotification("BMX Sorti.")
            end, "bmx")
        end
    else
        local playerPed = ESX.PlayerData.cache.playerped
        local coords = GetEntityCoords(playerPed)
        local vehicle = GetClosestVehicle(coords, 2.0, 0, 71)
        if vehicle then
            local carModel = GetEntityModel(vehicle)
            if carModel == 1131912276 then
                bmx = false
                ESX.Game.DeleteVehicle(vehicle)
                ESX.ShowNotification("BMX Rangé.")
            else
                ESX.ShowNotification("Aucun bmx à proximité.")
            end
        end
    end
  end


RegisterCommand('rec', function()
    OpenRecordingMenu()
end)

function OpenRecordingMenu()
    local RecordingMenu = {
        Base = { Title = "Rockstar Editor"},
        Data = { currentMenu = "Menu Principal" },
        Events = {
            onSelected = function(self, _, btn)
                if btn.action == "start_record" then
                    if IsRecording() then
                        ESX.ShowNotification("Vous enregistrez déjà un clip. Arrêtez l'enregistrement actuel avant d'en commencer un nouveau !")
                    else
                        StartRecording(1)
                        ESX.ShowNotification("Enregistrement démarré.")
                    end
                elseif btn.action == "stop_record" then
                    if not IsRecording() then
                        ESX.ShowNotification("Vous n'enregistrez actuellement aucun clip. Lancez un enregistrement avant de tenter de l'arrêter.")
                    else
                        StopRecordingAndSaveClip()
                        ESX.ShowNotification("Enregistrement sauvegardé.")
                    end
                end
            end
        },
        Menu = {
            ["Menu Principal"] = {
                b = {
                    {name = "Lancer l'enregistrement", action = "start_record", ask = "→", askX = true},
                    {name = "Arrêter et sauvegarder", action = "stop_record", ask = "→", askX = true}
                }
            }
        }
    }
    CreateMenu(RecordingMenu)
end

