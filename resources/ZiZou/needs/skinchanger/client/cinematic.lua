RegisterCommand("anim", function()
    StartCreatorEndCinematic()
end)

local PlayerProps = {}

function DestroyAllProps()
	for _, v in pairs(PlayerProps) do
		DeleteEntity(v)
	end

	PlayerHasProp = false
end

function StartCreatorEndCinematic()
    DoScreenFadeOut(1000)
    local blockControls = true
    pPed = ESX.PlayerData.cache.playerped
    DisplayRadar(false)
    TriggerEvent('esx:displayHud', false)
    TriggerEvent('esx:ToggleCinematic')
    PlayUrl("cin_music", "https://www.youtube.com/watch?v=F1Vx-9TUyzA", 0.2, false)

    Citizen.CreateThread(function()
        while blockControls do
            DisableControlAction(1, 1, true)
            DisableControlAction(1, 2, true)
            DisableControlAction(1, 4, true)
            DisableControlAction(1, 6, true)
            DisableControlAction(1, 270, true)
            DisableControlAction(1, 271, true)
            DisableControlAction(1, 272, true)
            DisableControlAction(1, 273, true)
            DisableControlAction(1, 282, true)
            DisableControlAction(1, 283, true)
            DisableControlAction(1, 284, true)
            DisableControlAction(1, 285, true)
            DisableControlAction(1, 286, true)
            DisableControlAction(1, 290, true)
            DisableControlAction(1, 291, true)
            Wait(5)
            for v in EnumeratePeds() do
                if v ~= pPed then
                    SetEntityAlpha(v, 0, 0)
                    SetEntityNoCollisionEntity(pPed, v, false)
                    NetworkConcealPlayer(NetworkGetPlayerIndexFromPed(v), true, 1)
                end
            end
        end
        for v in EnumeratePeds() do
            if v ~= pPed then
                ResetEntityAlpha(v)
                SetEntityNoCollisionEntity(v, pPed, true)
                NetworkConcealPlayer(NetworkGetPlayerIndexFromPed(v), false, 1)
            end
        end
    end)
    TriggerEvent('esx:toggleLogo')
    while not IsScreenFadedOut() do Wait(3000) end
    Wait(2000)
    NetworkOverrideClockTime(18, 00, 0)
    SetOverrideWeather("EXTRASUNNY")
    
    -- Position de départ
    SetEntityCoordsNoOffset(pPed, -555.66, -626.33, 34.68, false, false, false)
    SetEntityHeading(pPed, 180.0) -- Ajuste la rotation du joueur

    DoScreenFadeIn(1500)

    
    -- Faire marcher le personnage jusqu'à sa destination
    ClearPedTasks(pPed)
    TaskGoToCoordAnyMeans(pPed, -555.63, -642.11, 33.23, 1.0, 0, 0, 786603, 0)

    Wait(5000)
    blockControls = false
    TriggerEvent('esx:displayHud', true)
    DisplayRadar(true)
    
    -- Gestion du son de la musique
    local vol = 1.0
    while vol > 0.0 do
        vol = getVolume("cin_music") - 0.02
        setVolume("cin_music", vol)
        Wait(500)
    end
    Destroy("cin_music")
    
    ClearPedTasks(ESX.PlayerData.cache.playerped)
    TriggerEvent('esx:StopAnims')
    TriggerEvent('esx:toggleLogo')
    TriggerEvent('esx:ToggleCinematic')
    ESX.ShowNotification("Bienvenue à vous sur " .. ZiZouConfig.ServerName .. " !")
    ESX.ShowNotification("N'oubliez pas le /afk qui vous permet de gagner de l'argent en étant afk !")
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = ESX.PlayerData.cache.playerped
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
