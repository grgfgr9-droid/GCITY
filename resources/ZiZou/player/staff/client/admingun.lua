delGunStaffActive = false

function GetPlayerIdFromPed(id)
    for i = 0, 900000 do
        if NetworkIsPlayerActive(i) and GetPlayerPed(i) == id then
            return GetPlayerServerId(i)
        end
    end
    return 0
end

local BanOption = {"1 jours", "2 jours", "3 jours", "1 semaine", "Permanent"}


function boolStaffGun()
    local playerPed = PlayerPedId()
    local weaponHash = GetHashKey("weapon_snspistol_mk2")
    local isAdmin = ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple"
    
    -- Donner l'arme une seule fois si pas encore reçue
    if not HasPedGotWeapon(playerPed, weaponHash, false) then
        GiveWeaponToPed(playerPed, weaponHash, 255, false, true)
    end

    -- Désactiver les dégâts et régler les munitions du chargeur
    SetWeaponDamageModifier(weaponHash, 0.0)
    SetAmmoInClip(playerPed, weaponHash, 6)

    -- Création d'un thread pour la détection des tirs
    CreateThread(function()
        while true do
            local playerPed = PlayerPedId()
            local weapon = GetSelectedPedWeapon(playerPed)

            if IsControlJustReleased(0, 24) then -- Si le joueur tire
                if isAdmin or weapon == weaponHash then
                    local result, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                    
                    if entity ~= 0 then
                        if IsEntityAPed(entity) and IsPedAPlayer(entity) then
                            local targetPlayer = GetPlayerIdFromPed(entity)
                            if targetPlayer ~= 0 then
                                openPlayerMenu(targetPlayer)
                            end
                        elseif IsEntityAVehicle(entity) then
                            showVehicleMenu(entity)
                        else
                            local vehicle = GetVehiclePedIsIn(entity, false)
                            if vehicle ~= 0 then
                                showVehicleMenu(vehicle)
                            end
                        end
                    end
                end
            end

            Wait(10) -- Optimisation de la boucle (évite une attente trop courte)
        end
    end)
end




AddEventHandler("ESX:staffgun", function()
    delGunStaffActive = not delGunStaffActive
    if delGunStaffActive then
          GiveWeaponToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", 255, false, true)
          GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE")
          GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_AT_PI_SUPP_02")
          GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_SNSPISTOL_MK2_CLIP_02")
          GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_AT_PI_RAIL_02")
          GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_AT_PI_FLSH_03")
          SetPedInfiniteAmmo(ESX.PlayerData.cache.playerped, true, "weapon_snspistol_mk2")
          boolStaffGun()
    else
          RemoveWeaponFromPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2")
          SetPedInfiniteAmmo(ESX.PlayerData.cache.playerped, false, "weapon_snspistol_mk2")
          SetPedInfiniteAmmo(ESX.PlayerData.cache.playerped, false)
          delGunStaffActive = false
      end
  end)
  


function openPlayerMenu(targetPlayer)
    local ESXPlayerMenuZiZouLeKhoBendejo = {
        Base = { Title = "Staff", HeaderColor = {ZiZouConfig.Pmenu.Couleur.r, ZiZouConfig.Pmenu.Couleur.g, ZiZouConfig.Pmenu.Couleur.b} },
        Data = { currentMenu = "Options Joueur" },
        Events = {
            onSelected = function(self, _, btn)
                if btn.action == "staffgungoto" then
                    if noclipse == false then
                        admin_no_clip()
                        end
                        TriggerServerEvent("staff:Teleport2", "goto", tonumber(targetPlayer))
                elseif btn.action == "teleportoptionstaffgun" then
                    if btn.slidenum == 1 then
                        TriggerServerEvent("staff:Teleport2", "bring", tonumber(targetPlayer))
                        CloseMenu()
                    elseif btn.slidenum == 2 then 
                        TriggerServerEvent("staff:Teleport2", "bringback", tonumber(targetPlayer))
                        CloseMenu()
                    end
                elseif btn.action == "kickstaffgun" then
                 local raisonkickcaca = KeyboardInput("Raison du kick", "", "", 1000)
                    if raisonkickcaca and raisonkickcaca ~= "" then
                        TriggerServerEvent("admin:kick", tonumber(targetPlayer), raisonkickcaca)
                       -- TriggerServerEvent("staff:kick", tonumber(targetPlayer), raisonkickcaca)
                    else
                        ESX.ShowNotification("Veuillez entrer une raison pour le kick.")
                    end
                elseif btn.action == "jaillstaffgun" then
                    local time = 10
                    if btn.slidenum == 1 then
                      time = 10
                    elseif btn.slidenum == 2 then
                      time = 30
                    elseif btn.slidenum == 3 then
                      time = 60
                    elseif btn.slidenum == 4 then
                      time = 24 * 60
                    elseif btn.slidenum == 5 then
                      time = 7 * 24 * 60
                    elseif btn.slidenum == 6 then
                      time = 0
                    end
                    if btn.slidenum == 6 then
                    TriggerServerEvent('admin:JailPlayer', tonumber(targetPlayer), time, "")
                    else
                      local reason = KeyboardInput("ADMIN_JAIL", "Raison du jail ?", "", 100)
                      if reason ~= nil then
                          TriggerServerEvent('admin:JailPlayer', tonumber(targetPlayer), time, reason)
                      end
                    end
                elseif btn.action == "reanimerstaffzizou" then
                    ExecuteCommand("revive "..targetPlayer.."")
                elseif btn.action == "soignerstaffzizou" then
                    ExecuteCommand("heal "..targetPlayer.."")
                elseif btn.action == "pointgpsmapstaffzizou" then
                    TriggerServerEvent("staff:SetGPS", tonumber(targetPlayer))
                elseif btn.action == "sendmsgstaffzizou" then
                    local msg = KeyboardInput("ADMIN_MSG", "Votre message ?", "", 100)
                    if msg ~= nil then
                    TriggerServerEvent("admin:SendMessageToPlayer", tonumber(targetPlayer), msg)
                    end
                elseif btn.action == "wipearme" then
                    local reason = KeyboardInput("ADMIN_WIPE", "Raison du wipe ?", "", 100)
                    if reason ~= nil then
                        TriggerServerEvent("admin:WipeArme", tonumber(targetPlayer), reason)
                    end
                elseif btn.action == "gotoplayer" then
                    TriggerServerEvent("admin:GoToPlayer", tonumber(targetPlayer))

                elseif btn.action == "setidentity" then
                    TriggerServerEvent("admin:MakePlayerRegister", tonumber(targetPlayer))


                elseif btn.action == "bann" then
                    local msg = KeyboardInput("ADMIN_BAN", "Raison du ban ?", "", 100)
                    if msg ~= nil then
                      if btn.slidenum == 1 then
                        TriggerServerEvent("BanSql:ban", tonumber(targetPlayer), msg, 1)
                      elseif btn.slidenum == 2 then
                        TriggerServerEvent("BanSql:ban", tonumber(targetPlayer), msg, 2)
                      elseif btn.slidenum == 3 then
                        TriggerServerEvent("BanSql:ban", tonumber(targetPlayer), msg, 3)
                      elseif btn.slidenum == 4 then
                        TriggerServerEvent("BanSql:ban", tonumber(targetPlayer), msg, 7)
                      elseif btn.slidenum == 5 then
                        TriggerServerEvent("BanSql:ban", tonumber(targetPlayer), msg, 0)
                      end
                    end


                elseif btn.action == "wipearmess" then
                    if btn.slidenum == 1 then
                        if ESX.PlayerData.group == "responsable" or ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
                            CloseMenu()
                            ExecuteCommand("wipe " .. tonumber(targetPlayer))
                        else
                            ESX.ShowNotification("Vous avez pas la permission")
                        end  
                    elseif btn.slidenum == 2 then 
                        if ESX.PlayerData.group == "owner" then
                            local reason = KeyboardInput("ADMIN_WIPE", "Raison du wipe ?", "", 100)
                            if reason ~= nil then
                                TriggerServerEvent("admin:WipeArme", tonumber(targetPlayer), reason)
                            end
                        else
                            ESX.ShowNotification("Vous avez pas la permission")
                        end  
                    end 
                elseif btn.action == "tpposssss" then
                    if btn.slidenum == 1 then
                        TriggerServerEvent("staff:Teleport1", "bring", tonumber(targetPlayer))
                    
                    elseif btn.slidenum == 2 then 
                        TriggerServerEvent("staff:Teleport1", "bringback", tonumber(targetPlayer))
                        
                    elseif btn.slidenum == 3 then 
                        TriggerServerEvent("staff:Teleport1", "tppc", tonumber(targetPlayer))
                        
                    end 
                elseif btn.action == "setjob" then
                    local job = KeyboardInput("ADMIN_SETJOB", "Le métier", "", 100)
                    if job ~= nil then
                        local grade = KeyboardInput("ADMIN_SETJOB_GRADE", "Le grade", "", 1)
                        if tonumber(grade) ~= nil then
                            
                    TriggerServerEvent("admin:setJob", tonumber(SelectedPlayer), job, grade, 1)
                        end
                    end

                elseif btn.action == "setjob2" then
                    local job = KeyboardInput("ADMIN_SETJOB2", "Le gang", "", 100)
                    if job ~= nil then
                        local grade = KeyboardInput("ADMIN_SETJOB2_GRADE", "Le grade", "", 1)
                        if tonumber(grade) ~= nil then
                            
                    TriggerServerEvent("admin:setJob", tonumber(SelectedPlayer), job, grade, 2)
                        end
                    end
                elseif btn.action == "freezestaffgun" then
                    if btn.slidenum == 1 then
                        TriggerServerEvent("admin:freeze", tonumber(targetPlayer), true)
                       elseif btn.slidenum == 2 then
                        TriggerServerEvent("admin:freeze", tonumber(targetPlayer), false)
                       end
                end
            end
        },
        Menu = {
            ["Options Joueur"] = {
                b = {
                    {name = "Me téléporter au joueur", action = "gotoplayer", ask = "→", askX = true},
                    {name = "Téléporter", action = "tpposssss", slidemax = {"Ma position", "Bring back", "Parking Central"}},
                    {name = "Réanimer", action = "reanimerstaffzizou", ask = "→", askX = true},
                    {name = "Soigner", action = "soignerstaffzizou", ask = "→", askX = true},
                    {name = "Point GPS sur la map", action = "pointgpsmapstaffzizou", ask = "→", askX = true},
                    {name = "Envoyer un message privé", action = "sendmsgstaffzizou", ask = "→", askX = true},
                    {name = "Register", action = "setidentity", ask = "→", askX = true},
                    {name = "Wipe", action = "wipearmess", slidemax = {"Normal", "~r~ALL"}},
                    {name = "Kick", action = "kickstaffgun",  ask = "→", askX = true},
                    {name = "Jail", action = "jaillstaffgun", slidemax = {"10 minutes", "30 minutes", "1 heure", "1 jour", "1 semaine", "Unjail"}},
                    {name = "Freeze", action = "freezestaffgun", slidemax = {"Freeze le joueur", "Defreeze le joueur"}},
                }
            }
        }
    }

    if ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "owner" or ESX.PlayerData.group == "purple" then
        table.insert(ESXPlayerMenuZiZouLeKhoBendejo.Menu["Options Joueur"].b, {name = "Register", action = "register", ask = "→", askX = true})
      --  table.insert(ESXPlayerMenuZiZouLeKhoBendejo.Menu["Options Joueur"].b, {name = "Bannir", action = "bann", slidemax = BanOption})
        table.insert(ESXPlayerMenuZiZouLeKhoBendejo.Menu["Options Joueur"].b, {name = "Mettre un métier", action = "setjob", ask = "→", askX = true})
        table.insert(ESXPlayerMenuZiZouLeKhoBendejo.Menu["Options Joueur"].b, {name = "Mettre une organisation", action = "setjob2", ask = "→", askX = true})
    end
    
    if ESX.PlayerData.group == "owner" then 
        table.insert(ESXPlayerMenuZiZouLeKhoBendejo.Menu["Options Joueur"].b, {name = "Bannir", action = "bann", slidemax = BanOption})
    end


    CreateMenu(ESXPlayerMenuZiZouLeKhoBendejo)
end




























function showVehicleMenu(veh)
    local ESXVehicleMenuZiZouLeKhoBendejo = {
        Base = { Title = "Staff", HeaderColor = {8, 245, 0} },
        Data = { currentMenu = "Options Véhicules" },
        Events = {
            onSelected = function(self, _, btn)
                if btn.action == "supprimervehzizou" then
                    DeleteEntity(veh)
                    ESX.ShowNotification("~g~Véhicule supprimé")
                elseif btn.action == "repairvehzizou" then
                    NetworkRequestControlOfEntity(veh)
                    while not NetworkHasControlOfEntity(veh) do
                        Wait(1)
                    end
                    SetVehicleFixed(veh)
                    ESX.ShowNotification('Le ~b~véhicule~s~ a été réparé')
                elseif btn.action == "openvehforcezizou" then
                    SetVehicleDoorsLocked(veh, 1)
                    SetVehicleDoorsLockedForPlayer(veh, PlayerPedId(), false)
                    ESX.ShowNotification("~g~Véhicule déverrouillé")
                elseif btn.action == "returnvehzizou" then
                    local vehPos = GetEntityCoords(veh)
                    local vehHeading = GetEntityHeading(veh) + 180.0
                    SetEntityHeading(veh, vehHeading)
                    SetEntityCoordsNoOffset(veh, vehPos.x, vehPos.y, vehPos.z, true, true, true)
                    ESX.ShowNotification("~b~Véhicule retourné")
                elseif btn.action == "cleanvehzizou" then
                    NetworkRequestControlOfEntity(veh)
                    while not NetworkHasControlOfEntity(veh) do
                        Wait(1)
                    end
                    SetVehicleDirtLevel(veh, 0.0)
                    ESX.ShowNotification("~g~Le véhicule a été nettoyé et réparé")
                elseif btn.action == "updatecolorvehzizou" then
                    local inputR = KeyboardInput("R (Rouge, 0-255) :", "R (Rouge, 0-255) :", "", 5)
                    local inputG = KeyboardInput("G (Vert, 0-255) ", "G (Vert, 0-255) :", "", 200)
                    local inputB = KeyboardInput("B (Bleu, 0-255) :", "B (Bleu, 0-255) :", "", 200)

                    local r = tonumber(inputR)
                    local g = tonumber(inputG)
                    local b = tonumber(inputB)

                    if r and g and b and r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 then
                        NetworkRequestControlOfEntity(veh)
                        while not NetworkHasControlOfEntity(veh) do
                            Wait(1)
                        end

                        SetVehicleCustomPrimaryColour(veh, r, g, b)
                        SetVehicleCustomSecondaryColour(veh, r, g, b)
                        ESX.ShowNotification("~b~La couleur a été changée en : ~s~RGB(" .. r .. ", " .. g .. ", " .. b .. ")")
                    else
                        ESX.ShowNotification("~r~Valeurs RGB invalides.")
                    end
                end
            end
        },
        Menu = {
            ["Options Véhicules"] = {
                b = {
                    {name = "Supprimer le véhicule", action = "supprimervehzizou", ask = "→", askX = true},
                    {name = "Réparer le véhicule", action = "repairvehzizou", ask = "→", askX = true},
                    {name = "Ouvrir le véhicule de force", action = "openvehforcezizou", ask = "→", askX = true},
                    {name = "Retourner le véhicule", action = "returnvehzizou", ask = "→", askX = true},
                    {name = "Nettoyer le véhicule", action = "cleanvehzizou", ask = "→", askX = true},
                    {name = "Modifier la couleur du véhicule", action = "updatecolorvehzizou", ask = "→", askX = true}
                }
            }
        }
    }
    CreateMenu(ESXVehicleMenuZiZouLeKhoBendejo)
end

