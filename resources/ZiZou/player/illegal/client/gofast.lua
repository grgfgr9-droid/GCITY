local MarkersData = {
	size = {2.5, 2.5, 1.0},
	color = {168, 50, 50, 100},
	DrawDistance = 10.0,
	Messages = {
		["pickup"] = "Appyuez sur ~INPUT_CONTEXT~ pour demander une livraison",
        ["delivery"] = "Appyuez sur ~INPUT_CONTEXT~ pour livrer le véhicule"
	}
}

local CurrentGoFastData = nil

local AntiSpamGoFast = false

local IsUsingGoFastSystem = false

local Timer = 0
local TimerText = ""


function ManageGoFastAction(action)
    if action == "pickup" then
        OpenGoFastPickupMenu()
    elseif action == "delivery" then
        ESX.TriggerServerCallback('gofast:RequestDelivery', function(response)
            if response == true then
                StopGoFast()
            end
        end)
        IsUsingGoFastSystem = false
    end
end

function formatTime()
	Timer = Timer - 1
	
	local minutes = math.floor( Timer / 60 )
	local seconds = Timer % 60
	
	local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
    return timeDisplay
end


function StartTimer(time)
    Timer = time
    Citizen.CreateThread(function()
        while Timer > 0 do
            TimerText = "Temps restant : " .. formatTime()
            Wait(1000)
        end
        StopGoFast()
    end)
    Citizen.CreateThread(function()
        while Timer > 0 do
            drawTxt(0.66, 1.44, 1.0,1.0,0.4, TimerText, 255, 255, 255, 255)
            Wait(5)
        end
    end)
end

function OpenGoFastPickupMenu()
    GoFastPickupMenu = {
        Base = { Title = "GoFast", HeaderColor = {140, 32, 48} },
        Data = { currentMenu = "pickup" },
    
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
            if btn.type then
                if not AntiSpamGoFast then
                AntiSpamGoFast = true
                SetTimeout(30 * 60 * 1000, function()
                    AntiSpamGoFast = false
                end)
                ESX.TriggerServerCallback('gofast:RequestGoFast', function(response, vehicle)
                    if response == true and vehicle then
                    Wait(500)
                    local veh = NetworkGetEntityFromNetworkId(vehicle)
                    NetworkRequestControlOfEntity(veh)
                    local timeout = 10
                    while not NetworkHasControlOfEntity(veh) and timeout > 0 do
                        Wait(100)
                        timeout = timeout - 1
                    end
                    TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, veh, -1)                        
                    local GoData = GoFastData[tostring(btn.type)]
                    StartTimer(GoData.time * 60)
                    local blip = AddBlipForCoord(GoData.delivery.x,  GoData.delivery.y,  GoData.delivery.z)
                    SetBlipRoute(blip,  true)                   
                    CurrentGoFastData = {type = tostring(btn.type), delivery = GoData.delivery, blip = blip, vehicle = veh}
                    end
                end, btn.type)
                else
                    ESX.ShowNotification("Veuillez attendre un peu avant de retenter...")
                end
            end
        end,
        onExited = function()
            IsUsingGoFastSystem = false
        end
        },
        Menu = {
            ["pickup"] = {
                b = {
                    {name = "Destination 1 - ~r~10.000$~s~", type = 1, ask = "2 km", askX = true},
                    {name = "Destination 2 - ~r~25.000$~s~", type = 2, ask = "4 km", askX = true},
                    {name = "Destination 3 - ~r~50.000$~s~", type = 3, ask = "5 km", askX = true}
                }
            }
        }
    }
    CreateMenu(GoFastPickupMenu)
end

Citizen.CreateThread(function()
    while not ESX.PlayerData.PassJoin do
        Wait(0)
    end
	while true do
		Citizen.Wait(5)
		local sleep = true
		local InZone = false
    for a,b in pairs(GoFastZones) do
        if #(ESX.PlayerData.cache.coords - b.coords) < MarkersData.DrawDistance and (a == "pickup" or CurrentGoFastData and a == "delivery" .. CurrentGoFastData.type) then
            sleep = false
            DrawMarker(1, b.coords.x, b.coords.y, b.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, MarkersData.size[1], MarkersData.size[2], MarkersData.size[3], MarkersData.color[1], MarkersData.color[2], MarkersData.color[3], MarkersData.color[4], false, true, 2, false, false, false, false)
        end
        if #(ESX.PlayerData.cache.coords - b.coords) < 2.5 and (a == "pickup" or CurrentGoFastData and a == "delivery" .. CurrentGoFastData.type) then
			InZone = true
			if not IsUsingGoFastSystem then
 			ESX.ShowHelpNotification(MarkersData.Messages[b.type])
            if IsControlJustReleased(0, 38) then
                ManageGoFastAction(b.type)
				IsUsingGoFastSystem = true
            end
        end
		end
    end
	if not InZone and IsUsingGoFastSystem then
        CloseMenu()
	end
		if sleep then
		Citizen.Wait(2500)
		end
	end
end)

function StopGoFast()
    if CurrentGoFastData then
        Timer = 0
        RemoveBlip(CurrentGoFastData.blip)
        ESX.Game.DeleteVehicle(CurrentGoFastData.vehicle)
        SetEntityCoords(ESX.PlayerData.cache.playerped, GoFastZones["pickup"].coords)
        CurrentGoFastData = nil
        IsUsingGoFastSystem = false
    end
end

RegisterNetEvent('gofast:cancelled')
AddEventHandler('gofast:cancelled', function()
    StopGoFast()
    ESX.ShowNotification("Livraison annulée, t'es trop lent !")
end)

RegisterNetEvent("gofast:initializePoliceBlip")
AddEventHandler("gofast:initializePoliceBlip", function(gofasttype)
    PlaySoundFrontend(-1, "Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
    ESX.ShowAdvancedNotification("Central de police","~r~Appel téléphonique","Un civil a appellé la police à cause d'un possible GoFast.","CHAR_CALL911",9)

    local GoData = GoFastData[tostring(gofasttype)]

    local blip = AddBlipForCoord(GoData.delivery.x, GoData.delivery.y, GoData.delivery.z)
    SetBlipSprite(blip , 255)
    SetBlipScale(blip , 3.0)
    SetBlipColour(blip, 47)
    PulseBlip(blip)

    Citizen.Wait(1000 * GoData.time * 60)

    RemoveBlip(blip)

end)
