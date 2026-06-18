function RadioMenu(playerFrequency, playerVolume, isMuted, soundsEnabled)
    playerFrequency = playerFrequency or 0
    playerVolume = playerVolume or 50
    isMuted = isMuted or false
    soundsEnabled = soundsEnabled or true

    local pma = exports["pma-voice"]

    local function ReloadMenu()
        CloseMenu()
        Wait(100)
        RadioMenu(playerFrequency, playerVolume, isMuted, soundsEnabled)
    end

    local RadioMenu = {
        Base = {
            Title = "Radio",
            HeaderColor = {8, 245, 0}
        },
        Data = {
            currentMenu = "Radio"
        },
        Events = {
            onSelected = function(self, _, btn, data)
                if btn.action == "modif_freq" then
                    local newFrequency = KeyboardInput("admin", "Fréquence", "")
                    newFrequency = tonumber(newFrequency)

                    if newFrequency and newFrequency > 0 then
                        playerFrequency = newFrequency
                        ESX.ShowNotification("La fréquence a été réglée sur ".. newFrequency .." MHz")
                        ReloadMenu()
                    else
                        ESX.ShowNotification("Fréquence non valide!")
                    end

                elseif btn.action == "connect" then
                    if playerFrequency > 0 then
                        pma:setRadioChannel(playerFrequency)
                        pma:setVoiceProperty("radioEnabled", true)
                        ESX.ShowNotification("Vous êtes connecté à la fréquence: ".. playerFrequency)
                    else
                        ESX.ShowNotification("Aucune fréquence définie")
                    end
                elseif btn.action == "modif_volume" then
                    local newVolume = KeyboardInput("admin", "Volume", "")
                    newVolume = tonumber(newVolume)
                
                    if newVolume then
                        newVolume = math.max(0, math.min(100, newVolume))
                        pma:setRadioVolume(newVolume / 100)
                        playerVolume = newVolume
                        ESX.ShowNotification("Volume réglé à ".. newVolume .."%")
                        ReloadMenu()
                    else
                        ESX.ShowNotification("Volume invalide")
                    end
                elseif btn.action == "disconnect" then
                    pma:setRadioChannel(0)
                    pma:setVoiceProperty("radioEnabled", false)
                    ESX.ShowNotification("Vous êtes déconnecté de la fréquence")
                elseif btn.action == "toggle_sounds" then
                    soundsEnabled = not soundsEnabled
                    pma:setVoiceProperty("micClicks", soundsEnabled)
                    ESX.ShowNotification("Bruitages " .. (soundsEnabled and "activés" or "désactivés"))
                 elseif btn.action == "toggle_mute" then
                    isMuted = not isMuted
                    pma:setVoiceProperty("radioEnabled", not isMuted)
                    ESX.ShowNotification("Mode muet " .. (isMuted and "activé" or "désactivé"))
                elseif btn.action == "view_members" then
                    RequestRadioMembers()
                    self:OpenMenu("Membres")
                end
            end
        },
        Menu = {
            ["Radio"] = {
                b = {
                    {name = "Votre Fréquence: ~b~" .. playerFrequency, action = "modif_freq", ask = "→", askX = true},
                    {name = "Volume: ~b~" .. playerVolume, action = "modif_volume", ask = "→", askX = true},
                    {name = "Se Connecter à la fréquence", action = "connect", ask = "→", askX = true},
                    {name = "Se Déconnecter de la fréquence", action = "disconnect", ask = "→", askX = true},
                    {name = "Désactiver/Activer les bruitages", action = "toggle_sounds", checkbox = soundsEnabled},
                    {name = "Mode muet", action = "toggle_mute", checkbox = isMuted},
                }
            },
        }
    }
    CreateMenu(RadioMenu)
end

RegisterCommand("radio", function()
    ESX.TriggerServerCallback("radio:checkItem", function(hasRadio)
        if hasRadio then
            RadioMenu()
        else
            ESX.ShowNotification("Vous n'avez pas de radio sur vous !")
        end
    end)
end)

