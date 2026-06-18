local ItemSelectionner = nil

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for k, v in pairs(ZiZouConfig.Spawn) do
            local dist = #(v.position - playerCoords)

            if dist <= 4.0 then
                sleep = 0
                DrawMarker(26, v.position.x, v.position.y, v.position.z - 1.0, 
                0, 0, 0, 0, 0, 0, 
                1.0, 1.0, 1.0, 0, 255, 0, 150, false, false, 2, false, nil, nil, false)
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu')
            end

            if dist <= 1.0 and IsControlJustPressed(0, 38) then
                if ESX.PlayerData.job2.name == v.job2 then
                TriggerServerEvent('craft:openMenu')
                else
                    ESX.ShowNotification("Vous n'avez pas la permission d'ouvrir ce menu")
                end
            end
        end

        Wait(sleep)
    end
end)



RegisterNetEvent('craft:envoieitems')
AddEventHandler('craft:envoieitems', function(items, ingredients)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openMenu",
        items = items,
        ingredients = ingredients
    })
end)

RegisterNUICallback("modelPerso", function(data, cb)
    local quantiter = KeyboardInput("ADMIN_WIPE", "Quantité", "", 100)

    if not quantiter or quantiter == "" or tonumber(quantiter) <= 0 then
        TriggerEvent('esx:showNotification', 'Quantité invalide')
        return
    end

    TriggerServerEvent('craft:verifierIngrédients', data.name, tonumber(quantiter))
end)


RegisterNetEvent('craft:demarrerFabrication')
AddEventHandler('craft:demarrerFabrication', function(itemName, quantiter)
    local playerPed = PlayerPedId()

    FreezeEntityPosition(playerPed, true)

    exports['progressbar']:run(180,'Création de l\'arme','#E14127')
    Citizen.Wait(180000) 

    TriggerServerEvent('craft:fabriquer', itemName, quantiter)
    FreezeEntityPosition(playerPed, false)
end)


RegisterNUICallback("closeMenu", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

