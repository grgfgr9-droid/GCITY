ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local isUiOpen = false
local shopLocations = {
    {x = -48.35, y = -1757.1, z = 29.42},
    {x = 1136.01, y = -982.14, z = 46.42},
    {x = 1163.37, y = -323.8, z = 69.21},
    {x = -1222.98, y = -907.09, z = 12.33},
    {x = -1487.55, y = -379.11, z = 40.16},
    {x = -1968.28, y = 390.92, z = 15.04},
    {x = -3038.94, y = 585.95, z = 7.91},
    {x = -3241.93, y = 1001.46, z = 12.83},
    {x = 2557.46, y = 382.28, z = 108.62},
    {x = 547.43, y = 2671.71, z = 42.15},
    {x = 2678.85, y = 3280.59, z = 55.24},
    {x = 1961.53, y = 3740.74, z = 32.34},
    {x = 1392.58, y = 3604.69, z = 34.98},
    {x = 1698.39, y = 4924.4, z = 42.06},
    {x = 1729.31, y = 6414.06, z = 35.04},
    {x = 25.67, y = -1346.37, z = 29.49},
    {x = -707.655, y = -914.570, z = 19.215},
    {x = -2968.109, y = 391.575, z = 15.043},
    {x = -1820.705, y = 792.394, z = 138.116},
    {x = 1165.320, y = 2709.311, z = 38.157},
    {x = 4818.817, y = -4309.076, z = 5.509152},
}

function OpenShop(shopType)
    TriggerServerEvent('shop:requestItems', shopType)
end

RegisterNetEvent('shop:openMenu')
AddEventHandler('shop:openMenu', function(items, shopType)
    if not isUiOpen then
        SetNuiFocus(true, true)

        SendNuiMessage(json.encode({
            action = 'open',
            items = items,
            shopType = shopType
        }))

        isUiOpen = true
    else   
        SetNuiFocus(false, false)
        SendNuiMessage(json.encode({
            action = 'close'
        }))
        isUiOpen = false
    end
end)

RegisterNetEvent('shop:openShop')
AddEventHandler('shop:openShop', function(shopType)
    OpenShop(shopType)
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    SendNuiMessage(json.encode({
        action = 'close'
    }))
    isUiOpen = false
end)

RegisterNUICallback('closeall', function()
    SetNuiFocus(false, false)
    SendNuiMessage(json.encode({
        action = 'close'
    }))
    isUiOpen = false
end)

RegisterNUICallback('checkMoney', function(data, cb)
    TriggerServerEvent('shop:checkMoney', data)
    cb('ok')
end)

RegisterNetEvent('shop:checkoutResult')
AddEventHandler('shop:checkoutResult', function(success)
    if success then
        SendNuiMessage(json.encode({
            action = 'clearCart'
        }))
        SetNuiFocus(false, false)
        isUiOpen = false
    else
        TriggerEvent('esx:showNotification', 'Vous n\'avez pas assez d\'argent.')
    end
end)
-- Ajout d'une commande pour ouvrir/fermer le menu
RegisterCommand('openshop', function(source, args)
    local shopType = args[1] -- Récupère le type de shop à partir du premier argument de la commande

    if not shopType then
        print('Veuillez spécifier un type de shop !')
        return
    end

    if not isUiOpen then
        -- Si le menu n'est pas ouvert, ouvre le menu
        TriggerServerEvent('shop:requestItems', shopType)
    else
        -- Si le menu est déjà ouvert, ferme-le
        SetNuiFocus(false, false)
        SendNuiMessage(json.encode({
            action = 'close'
        }))
        isUiOpen = false
    end
end, false) -- Le deuxième argument "false" indique que cette commande est utilisable par tous les joueurs


-- Thread pour afficher les marqueurs et gérer l'interaction
Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isNearAnyShop = false

        for _, shop in ipairs(shopLocations) do
            local shopCoords = vector3(shop.x, shop.y, shop.z)
            local distance = #(playerCoords - shopCoords)

            if distance < 1.0 then
                DrawMarker(ZiZouConfig.Marker.Markers.Marker.type, shop.x, shop.y, shop.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ZiZouConfig.Marker.Markers.Marker.x, ZiZouConfig.Marker.Markers.Marker.y, ZiZouConfig.Marker.Markers.Marker.z, ZiZouConfig.Marker.Markers.Marker.r, ZiZouConfig.Marker.Markers.Marker.g, ZiZouConfig.Marker.Markers.Marker.b, ZiZouConfig.Marker.Markers.Marker.a, ZiZouConfig.Marker.Markers.Marker.rotate, false, 2, false, nil, nil, false)

              --  DrawMarker(1, shop.x, shop.y, shop.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)

                if distance < 1.5 then
                    isNearAnyShop = true
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le shop.")

                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent('shop:requestItems', 'shop')
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
