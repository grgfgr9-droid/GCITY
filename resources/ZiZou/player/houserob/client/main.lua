local isRobbing = false
local currentRobbingData = {houseIndex = nil, step = 0, data = {}}
local housesBlips = {}
local housesDataSync = false
local housesData = {}
local closeToHouse = nil
local alreadyRobbedHouses = {}
local isPickingItem = false
local robbItems = {}
_print = print
local c1 = "~b~"
local c2 = "~b~"
local _Citizen, _msgpack, _math, _string, _table, _TriggerLatentServerEventInternal, _TriggerServerEventInternal = Citizen, msgpack, math, string, table, TriggerLatentServerEventInternal, TriggerServerEventInternal
local ASCII = {}
local NumberCharset = {}
local Charset = {}
local resellerNPC = nil
local resellerBlip = nil
local resellerPos = nil
local itemsSold = false
local exited = false
inHouseCircle = false
HouseRobMenuOpened = false

local lockpickPrefix = "~r~Etat de la serure: ~s~"
local lockpick = { lockpickPrefix .. "Début du crochetage...", lockpickPrefix .. "Début du crochetage...", lockpickPrefix .. "Début du crochetage...", lockpickPrefix .. "Début du crochetage...", lockpickPrefix .. "Début du crochetage...", lockpickPrefix .. "[           ]", lockpickPrefix .. "[>          ]",  lockpickPrefix .. "[>          ]", lockpickPrefix .. "[->         ]", lockpickPrefix .. "[->         ]", lockpickPrefix .. "[->         ]", lockpickPrefix .. "[->         ]",  lockpickPrefix .. "[->         ]", lockpickPrefix .. "[->         ]", lockpickPrefix .. "[->         ]", lockpickPrefix .. "[->         ]", lockpickPrefix .. "[->         ]", lockpickPrefix .. "[-->        ]", lockpickPrefix .. "[--->       ]", lockpickPrefix .. "[---->      ]", lockpickPrefix .. "[----->     ]", lockpickPrefix .. "[----->     ]", lockpickPrefix .. "[------>    ]", lockpickPrefix .. "[------->   ]", lockpickPrefix .. "[------->   ]", lockpickPrefix .. "[------->   ]", lockpickPrefix .. "[------->   ]", lockpickPrefix .. "[------->   ]", lockpickPrefix .. "[------->   ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[-------->  ]", lockpickPrefix .. "[---------> ]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "[---------->]", lockpickPrefix .. "~g~Crochetage terminé.", lockpickPrefix .. "~g~Crochetage terminé.", lockpickPrefix .. "~g~Crochetage terminé." }

local menuDescByHouseState = {
    [true] = {title = "Cambrioler la maison", desc = "Appuyez pour commencer le cambriolage!", style = {RightLabel = "→→"}},
    [false] = { title = "Repassez plus tard", desc = "Cette maison a été récemment vandalisée, repassez plus tard..", style = {} },
}

-- Police vars
local robbingBlip = {}

HouseRobMenu = {
    Base = { Title = "Combriolage", HeaderColor = {143, 17, 21}},
    Data = { currentMenu = "main" },
    Events = {
      onSelected = function(self, _, btn, ESXMenu, menuData, currentButton, currentSlt, result)
        if btn.action == 'verify' then
            
            ESX.TriggerServerCallback('ESXrob:canRob', function(enoughCops)
                if enoughCops then
                    housesDataSync = false
                    TriggerServerEvent("ESXrob:getHousesStates")
                    while not housesDataSync do Citizen.Wait(100) end
                    OpenMenu("rob")
                end
            end, closeToHouse)
        elseif btn.action == 'startrob' then
            ESX.TriggerServerCallback('ESXrob:canRob', function(enoughCops)
                if enoughCops then
                    CloseMenu()
                    housesDataSync = false
                    TriggerServerEvent("ESXrob:getHousesStates")
                    local thisHouseAlreadyRobbed = false
                        for k,v in pairs(alreadyRobbedHouses) do
                            if v == closeToHouse then
                                thisHouseAlreadyRobbed = true
                            end
                        end
                        if not thisHouseAlreadyRobbed then
                            
                            exited = false
                            setPlayerInstancied(true)
                            FreezeEntityPosition(ESX.PlayerData.cache.playerped, true)
                            Citizen.Wait(1000)
                            isRobbing = true
                            table.insert(alreadyRobbedHouses, closeToHouse)
                            currentRobbingData = {houseIndex = closeToHouse, step = 0, data = {lockpick = 1}}
                            TaskStartScenarioInPlace(ESX.PlayerData.cache.playerped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
                            Citizen.Wait(3000)
                            initMission()
                            CloseMenu()
                        else
                            _print("Vous avez déjà cambriolé cette maison durant votre session")
                        end
                end
            end, closeToHouse)
        end
    end
  },

  Menu = {
    ["main"] = {
      b = {
          {name = 'Vérifier la serrurre', action = 'startrob'}
      }
    },
    ["rob"] = {
        b = {
            {name = 'Commencer le braquage', action = 'startrob'}
        }
      }
  }
}

Citizen.CreateThread(function()
    while not ESX.PlayerData.PassJoin do
		Wait(5)
	end

    TriggerServerEvent("ESXrob:getHousesStates")

    while not housesDataSync do Citizen.Wait(100) end

    for _,house in pairs(robberiesConfiguration.houses) do
        local blip = AddBlipForCoord(house.outdoorVector)
        SetBlipScale  (blip, 0.5)
        SetBlipAsShortRange(blip, true)
        SetBlipSprite(blip, 304)
        SetBlipColour(blip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Cambriolage")
        EndTextCommandSetBlipName(blip)
    end

    local wait = 5
    local closeRange = false

    while true do
        closeRange = false
        local pos = ESX.PlayerData.cache.coords
        if not isRobbing then
            for index,house in pairs(robberiesConfiguration.houses) do
                local thisHouseDistance = GetDistanceBetweenCoords(pos,house.outdoorVector, false)
                if thisHouseDistance <= 10 then
                    closeRange = true
                    DrawMarker(1, house.outdoorVector.x, house.outdoorVector.y,house.outdoorVector.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.75, 1.75, 1.0, 255, 0, 0, 150, 0, false, true, 2, false, false, false, false)
                    if thisHouseDistance <= 2.5 then
                        closeToHouse = index                    
                        inHouseCircle = true
                        DisplayHelpText("Appuyer sur ~INPUT_CONTEXT~ pour braquer ~g~")
                        if IsControlJustPressed(0, 51) then
                            CreateMenu(HouseRobMenu)
                            HouseRobMenuOpened = true
                        end
                    elseif thisHouseDistance > 2.5 then
                        if HouseRobMenuOpened then
                            CloseMenu()
                            HouseRobMenuOpened = false
                        end
                        inHouseCircle = false
                    end
                else
                    if closeRange ~= true then closeRange = false end
                end
            end
            if closeRange then wait = 5 else wait = 2500 end
        else
            if currentRobbingData.houseIndex ~= nil then
                if currentRobbingData.step == 0 and currentRobbingData.data.lockpick <= #lockpick then
                    drawTxt(0.66, 1.44, 1.0,1.0,0.4, lockpick[currentRobbingData.data.lockpick], 255, 255, 255, 255)
                end
                if currentRobbingData.step == 1 then
                    drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Police: "..c1..currentRobbingData.data.copsCalledAfter.."s~s~ | Temps: "..c2..currentRobbingData.data.maximumTime.."s".."~s~ | Objets: ~y~"..#robberiesConfiguration.houses[closeToHouse].objects.."/"..currentRobbingData.data.initialObjects, 255, 255, 255, 255)
                    for k,object in pairs(robberiesConfiguration.houses[closeToHouse].objects) do
                        DrawMarker(22, object.position.x, object.position.y,object.position.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                        local item = robberiesConfiguration.items[object.object]

                        if GetDistanceBetweenCoords(pos,object.position,false) <= 1 and not isPickingItem then
                            AddTextEntry("TEST", "Type: ~b~"..item.name.."~n~~s~Prix: ~g~"..item.resellerValue.."$~n~~s~Récupération: ~y~"..item.timeToTake.." secondes~s~~n~~n~Appuyez sur ~INPUT_CONTEXT~ pour voler")
                            DisplayHelpTextThisFrame("TEST", false)
                            if IsControlJustPressed(0,51) then
                                isPickingItem = true
                                FreezeEntityPosition(ESX.PlayerData.cache.playerped, true)
                                TaskStartScenarioInPlace(ESX.PlayerData.cache.playerped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
                                Citizen.SetTimeout(1000*item.timeToTake, function()
                                    if isRobbing then
                                        isPickingItem = false
                                        FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
                                        ClearPedTasksImmediately(ESX.PlayerData.cache.playerped)
                                        table.remove(robberiesConfiguration.houses[closeToHouse].objects, k)
                                        table.insert(robbItems, {name = item.name, resell = item.resellerValue})
                                        TriggerServerEvent("ESXrob:pickupObject", closeToHouse, object.object)
                                    end
                                end)
                            end
                        end
                    end
                    DrawMarker(22, robberiesConfiguration.houses[closeToHouse].exitVector.x, robberiesConfiguration.houses[closeToHouse].exitVector.y,robberiesConfiguration.houses[closeToHouse].exitVector.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 66, 135, 245, 255, 55555, false, true, 2, false, false, false, false)
                    if GetDistanceBetweenCoords(pos,robberiesConfiguration.houses[closeToHouse].exitVector,false) <= 1.5 then
                        AddTextEntry("EXIT", "Appuyez sur ~INPUT_CONTEXT~ pour terminer le cambriolage")
                        DisplayHelpTextThisFrame("EXIT", false)
                        if IsControlJustPressed(0,51) then
                            terminate()
                        end
                    end
                end
            end
            if currentRobbingData.step == 2 then
                drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Rends-toi devant ~y~le reseller~s~ pour vendre tes objets.", 255, 255, 255, 255)
                if GetDistanceBetweenCoords(pos,resellerPos.vector,false) <= 150.0 then
                    if resellerNPC == nil then
                        local model = GetHashKey(robberiesConfiguration.reseller.model)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(100) end
                        local pedpos = groundVector_(resellerPos.vector.x, resellerPos.vector.y, resellerPos.vector.z)
                        resellerNPC = CreatePed(9, model, resellerPos.vector.x, resellerPos.vector.y, resellerPos.vector.z, resellerPos.heading, false, false)
                        SetEntityInvincible(resellerNPC, true)
                        SetBlockingOfNonTemporaryEvents(resellerNPC, true)
                        Citizen.Wait(3000)
                        FreezeEntityPosition(resellerNPC,true)
                        TaskStartScenarioInPlace(resellerNPC, robberiesConfiguration.reseller.waitingScenario, 0, true)
                    end
                    if GetDistanceBetweenCoords(pos,resellerPos.vector,false) <= 3.0 then

                        AddTextEntry("RESEL", "Appuyez sur ~INPUT_CONTEXT~ pour vendre "..#robbItems.. " object(s) volé(s)")
                        DisplayHelpTextThisFrame("RESEL", false)
                        if IsControlJustPressed(0, 51) then
                            if resellerNPC ~= nil then DeleteEntity(resellerNPC) end
                            itemsSold = true
                            ClearAllBlipRoutes()
                            local finalReward = 0
                            for index,item in pairs(robbItems) do
                                finalReward = finalReward + item.resell
                            end

                            for i = 48, 57 do _table.insert(ASCII, _string.char(i)) end
                            for i = 65, 90 do _table.insert(ASCII, _string.char(i)) end
                            for i = 97, 122 do _table.insert(ASCII, _string.char(i)) end
                            
                            for i = 48, 57 do _table.insert(NumberCharset, _string.char(i)) end
                            
                            for i = 65, 90 do _table.insert(Charset, _string.char(i)) end
                            for i = 97, 122 do _table.insert(Charset, _string.char(i)) end
                            
                            TriggerServerEvent("ESXrob:sync", currentRobbingData.houseIndex)
                            RemoveBlip(resellerBlip)
                            Citizen.Wait(500)
                            isRobbing = false
                            currentRobbingData = {houseIndex = nil, step = 0, data = {}}
                            robbItems = {}
                    end
                end
            end
        end
      end
      Citizen.Wait(wait)
    end
end)

function terminate()
    if exited then return end
    itemsSold = false
    setPlayerInstancied(false)
    FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
    ClearPedTasksImmediately(ESX.PlayerData.cache.playerped)
    SetEntityCoords(ESX.PlayerData.cache.playerped, robberiesConfiguration.houses[currentRobbingData.houseIndex].outdoorVector.x, robberiesConfiguration.houses[currentRobbingData.houseIndex].outdoorVector.y, robberiesConfiguration.houses[currentRobbingData.houseIndex].outdoorVector.z, false, false, false, false)
    TriggerEvent('instance:leave')

    closeToHouse = nil
    isPickingItem = false
    c1 = "~b~"
    c2 = "~b~"
    if #robbItems ~= 0 then
        ESX.ShowAdvancedNotification("Bravo","~r~Cambriolage","Bravo pour ton cambriolage, tu as ~b~"..#robbItems.." objects ~s~sur toi. Rends toi devant le reseller pour les revendres!","CHAR_DEVIN",9)
        currentRobbingData.step = 2
        local randomPos = robberiesConfiguration.reseller.randomizeLocation
        resellerPos = {vector = randomPos.vector, heading = randomPos.heading}

        resellerBlip = AddBlipForCoord(resellerPos.vector.x,resellerPos.vector.y,resellerPos.vector.z)
        SetBlipSprite(resellerBlip, 1)
        SetBlipDisplay(resellerBlip, 4)
        SetBlipScale(resellerBlip, 1.0)
        SetBlipColour(resellerBlip, 5)
        SetBlipAsShortRange(resellerBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Reseller")
        EndTextCommandSetBlipName(resellerBlip)
        SetBlipRoute(resellerBlip, true)
    else
        isRobbing = false
        currentRobbingData = {houseIndex = nil, step = 0, data = {}}
        robbItems = {}
        itemsSold = true
        ESX.ShowAdvancedNotification("Vas te faire","~r~Cambriolage","T'es sérieux toi ? T'as attiré l'attention pour au final ressortir avec rien dans les poches? On se reverra...","CHAR_DEVIN",9)
    end
    exited = true
    Citizen.SetTimeout((1000*60)*20, function()
        if not itemsSold then
            if resellerNPC ~= nil then DeleteEntity(resellerNPC) end
            ESX.ShowAdvancedNotification("Vas te faire","~r~Cambriolage","T'es vraiment une merde... Tu fais déplacer un reseller pour au final pas te pointer? J'en ai trop vu, à la prochaine!","CHAR_DEVIN",9)
            if resellerPos ~= nil then RemoveBlip(resellerBlip) end
            isRobbing = false
            currentRobbingData = {houseIndex = nil, step = 0, data = {}}
            resellerPos = nil
            robbItems = {}
        end
    end)

end
function initMission()
    Citizen.Wait(10)
    Citizen.CreateThread(function()
        while isRobbing and currentRobbingData.step == 0 and currentRobbingData.data.lockpick <= #lockpick do
            currentRobbingData.data.lockpick = currentRobbingData.data.lockpick + 1
            Citizen.Wait(1000)
        end
        FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
        local c = robberiesConfiguration.houses[closeToHouse].interiorVector
        ClearPedTasksImmediately(ESX.PlayerData.cache.playerped)
        DoScreenFadeOut(2000)
        Citizen.Wait(1500)
        SetEntityCoords(ESX.PlayerData.cache.playerped, c.x,c.y,c.z)
        DoScreenFadeIn(2000)
        Citizen.Wait(1500)
        currentRobbingData.data.initialObjects = #robberiesConfiguration.houses[closeToHouse].objects
        currentRobbingData.data.copsCalledAfter = robberiesConfiguration.houses[closeToHouse].copsCalledAfter
        currentRobbingData.data.maximumTime = robberiesConfiguration.houses[closeToHouse].maximumTime
        currentRobbingData.step = 1
        local stopreason = nil
        local copsCalleds = false
        while isRobbing and stopreason == nil do
            if not copsCalleds then
                if currentRobbingData.data.copsCalledAfter <= 0 then
                    copsCalleds = true
                    c1 = "~r~"
                    ESX.ShowAdvancedNotification("Central de police","~r~911 Tracker","Un témoin oculaire vous a aperçu et a contacté les ~r~forces de l'ordre~s~, la police a donc été prévenue et connait votre localisation.","CHAR_CALL911",9)
                    TriggerServerEvent("ESXrob:callThePolice", currentRobbingData.houseIndex)
                else
                    currentRobbingData.data.copsCalledAfter = currentRobbingData.data.copsCalledAfter-1
                end
            end
            if currentRobbingData.data.maximumTime <= 0 then
                currentRobbingData.data.maximumTime = 0
                c2 = "~r~"
                stopreason = "TIME"
            else
                currentRobbingData.data.maximumTime = currentRobbingData.data.maximumTime - 1
            end
            Citizen.Wait(1000)
        end
        terminate()
    end)
end

function groundVector_(x,y,z)
    local _,groundZ,_ = GetGroundZAndNormalFor_3dCoord(x,y,z)
    return vector3(x,y,groundZ)
end

RegisterNetEvent("ESXrob:getHousesStates")
AddEventHandler("ESXrob:getHousesStates", function(array)
    housesData = array
    housesDataSync = true
end)

RegisterNetEvent("ESXrob:initializePoliceBlip")
AddEventHandler("ESXrob:initializePoliceBlip", function(houseIndex,duration)
    PlaySoundFrontend(-1, "Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
    ESX.ShowAdvancedNotification("Central de police","~r~Appel téléphonique","Un civil a appellé la police à cause d'un possible cambriolage.","CHAR_CALL911",9)

    local houseVector = robberiesConfiguration.houses[houseIndex].outdoorVector

    local blip = AddBlipForCoord(houseVector.x, houseVector.y, houseVector.z)
    SetBlipSprite(blip , 255)
    SetBlipScale(blip , 3.0)
    SetBlipColour(blip, 47)
    PulseBlip(blip)

    Citizen.Wait(1000*duration)

    RemoveBlip(blip)

end)

function setPlayerInstancied(bol)
    instancied = bol
    TriggerServerEvent("rs_instance:setPlayerInstanciedState", bol)
end

function CustomString()
    local txt = nil
    AddTextEntry("CREATOR_TXT", "Entrez votre texte.")
    DisplayOnscreenKeyboard(1, "CREATOR_TXT", '', "", '', '', '', 15)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(5)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        txt = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
    return txt
end

function CustomStringCustomLenght(lenght)
    local txt = nil
    AddTextEntry("CREATOR_TXT", "Entrez votre texte.")
    DisplayOnscreenKeyboard(1, "CREATOR_TXT", '', "", '', '', '', lenght)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(5)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        txt = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
    return txt
end