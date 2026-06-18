function OpenStartPickerMenu()
    StartPickerMenu = {
        Base = { Title = "Start", HeaderColor = {255, 255, 255}, Blocked = true},
        Data = { currentMenu = "choisis ton start" },

        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                if btn.action == "preview" then
                    StartPickerMenu.Menu["preview"].b = {}
                    for k, v in pairs(StartPickerConfig.List[btn.key].items) do 
                        table.insert(StartPickerMenu.Menu["preview"].b, {name = v.name, action = "null", ask = "→", askX = true})
                    end
                    table.insert(StartPickerMenu.Menu["preview"].b, {name = "~y~Choisir", key = btn.key, action = "choose", ask = "→", askX = true})

                    OpenMenu("preview")
                elseif btn.action == "choose" then
                    TriggerServerEvent('esx:pickStarter', btn.key)
                    CloseMenu(true)
                    FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
                    StartCreatorEndCinematic()
                end
            end
        },
        Menu = {
            ["choisis ton start"] = {
                b = {
                }
            },
            ["preview"] = {
                b = {

                }
            }
        }
    }

    for k, v in pairs(StartPickerConfig.List) do 
        table.insert(StartPickerMenu.Menu["choisis ton start"].b, {name = v.name, key = k, action = "preview", ask = "→", askX = true})
    end

    CreateMenu(StartPickerMenu)
end