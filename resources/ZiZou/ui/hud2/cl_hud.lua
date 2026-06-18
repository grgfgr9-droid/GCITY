local uiFaded = false
local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    while ESX.GetPlayerData().job2 == nil do
        Citizen.Wait(100)
    end

    local xPlayer = ESX.GetPlayerData()
    local money, black_money, bank = 0, 0, 0

    for i = 1, #xPlayer.accounts, 1 do
        if xPlayer.accounts[i].name == 'money' then
            money = ESX.Math.GroupDigits(xPlayer.accounts[i].money) .. ' $'
        elseif xPlayer.accounts[i].name == 'black_money' then
            black_money = ESX.Math.GroupDigits(xPlayer.accounts[i].money) .. ' $'
        elseif xPlayer.accounts[i].name == 'bank' then
            bank = ESX.Math.GroupDigits(xPlayer.accounts[i].money) .. ' $'
        end
    end

    while not FirstActivate do 
        Wait(2000)
        SendNUIMessage({
            action = 'setInfos',
            infos = {
                {
                    name = 'money',
                    value = money
                },
                {
                    name = 'black_money',
                    value = black_money
                },
                {
                    name = 'bank',
                    value = bank
                }
            }
        })

        local playerIdHUD = GetPlayerServerId(PlayerId())

        SendNUIMessage({
            action = 'setId',
            value = playerIdHUD
        })
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    local money, black_money, bank = 0, 0, 0

    for i = 1, #xPlayer.accounts, 1 do
        if xPlayer.accounts[i].name == 'money' then
            money = ESX.Math.GroupDigits(xPlayer.accounts[i].money) .. ' $'
        elseif xPlayer.accounts[i].name == 'black_money' then
            black_money = ESX.Math.GroupDigits(xPlayer.accounts[i].money) .. ' $'
        elseif xPlayer.accounts[i].name == 'bank' then
            bank = ESX.Math.GroupDigits(xPlayer.accounts[i].money) .. ' $'
        end
    end

    SendNUIMessage({
        action = 'setInfos',
        infos = {
            {
                name = 'money',
                value = money
            },
            {
                name = 'black_money',
                value = black_money
            },
            {
                name = 'bank',
                value = bank
            }
        }
    })

    local playerIdHUD = GetPlayerServerId(PlayerId())

    SendNUIMessage({
        action = 'setId',
        value = playerIdHUD
    })
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    local value = ESX.Math.GroupDigits(account.money) .. ' $'

    if account.name == 'black_money' then
        SendNUIMessage({
            action = 'setInfos',
            infos = {
                {
                    name = 'black_money',
                    value = value
                }
            }
        })
    elseif account.name == 'bank' then
        SendNUIMessage({
            action = 'setInfos',
            infos = {
                {
                    name = 'bank',
                    value = value
                }
            }
        })
    elseif account.name == 'money' then
        SendNUIMessage({
            action = 'setInfos',
            infos = {
                {
                    name = 'money',
                    value = value
                }
            }
        })
    end
end)

nbPlayerTotal = 0
RegisterNetEvent("ui:update")
AddEventHandler("ui:update", function(nbPlayerTotal)
    SendNUIMessage({
        type = "online-count",
        onlineCount = nbPlayerTotal
    })
end)

AddEventHandler('tempui:toggleUi', function(value)
    uiFaded = value

    if uiFaded then
        SendNUIMessage({action = 'fadeUi', value = true})
    else
        SendNUIMessage({action = 'fadeUi', value = false})
    end
end)

RegisterNUICallback('firstactivate', function()
    FirstActivate = true
end)

Citizen.CreateThread(function()
    local uiComponents = {'infos', 'statuts'}
    local inFrontend = false

    -- Initialiser les messages NUI une seule fois
    SendNUIMessage({action = 'hideUi2', value = false})
    for _, component in ipairs(uiComponents) do
        SendNUIMessage({action = 'hideComponent', component = component, value = false})
    end

    while true do
        Citizen.Wait(250)  -- Optimisation du temps d'attente

        -- Si l'UI n'est pas en train de s'estomper (par exemple : fade-out)
        if not uiFaded then
            local isInFrontend = IsPauseMenuActive() or IsPlayerSwitchInProgress()

            -- Ne changer l'état que si nécessaire pour éviter les messages inutiles
            if isInFrontend ~= inFrontend then
                inFrontend = isInFrontend
                SendNUIMessage({action = 'hideUi2', value = inFrontend})
            end
        end
    end
end)

