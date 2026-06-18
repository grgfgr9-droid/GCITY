local fov = 70
local disabledControls = {
    30,     -- A and D (Character Movement)
    31,     -- W and S (Character Movement)
    21,     -- LEFT SHIFT
    36,     -- LEFT CTRL
    22,     -- SPACE
    44,     -- Q
    38,     -- E
    71,     -- W (Vehicle Movement)
    72,     -- S (Vehicle Movement)
    59,     -- A and D (Vehicle Movement)
    60,     -- LEFT SHIFT and LEFT CTRL (Vehicle Movement)
    85,     -- Q (Radio Wheel)
    86,     -- E (Vehicle Horn)
    15,     -- Mouse wheel up
    14,     -- Mouse wheel down
    37,     -- Controller R1 (PS) / RT (XBOX)
    80,     -- Controller O (PS) / B (XBOX)
    228,    -- 
    229,    -- 
    166,    -- F5
    167,    -- F6
    311,    -- K
    172,    -- 
    173,    -- 
    37,     -- 
    44,     -- 
    178,    -- 
    244,    -- 
}

local initialCam = { 
	posX = 156.59,
	posY = -1191.69,
	posZ = 417.24,

	rotX = -30.0,
	rotY = 0.0,
	rotZ = 30.0
}

local camActive = false
local cam = nil

local isFirstTime = true
local isLoading = true
local isReady = false

local function ShowJoinSystemText(text) 
    ClearPrints()
    SetTextFont(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextDropShadow()

    -- Afficher le texte à une position spécifique
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.5, 0.95) -- Modifier la hauteur ici (ex: 0.75 pour plus haut)
end


Citizen.CreateThread(function()
Citizen.Wait(1000)
if isFirstTime then
StartCamera()
end
end)

Citizen.CreateThread(function()
while not ESX.IsPlayerLoaded() do
Citizen.Wait(1000)

end
isLoading = false
end)

Citizen.CreateThread(function ()
while isLoading do
ShowJoinSystemText("~w~" .."Chargement du joueur...")
Citizen.Wait(2)
end

while not isReady do
	AddTextEntry("GtaCity", "<p align='center'><font size='120'></font></p><p align='center'><font size='30'>~a~</font></p>")
  ShowJoinSystemText("~w~Appuyer sur " .. ZiZouConfig.DefaultColorCode .."ESPACE~w~ pour Apparaître.")
  if (IsDisabledControlJustReleased(1, 22)) then
    StopCamera()
    isReady = true
  end
Citizen.Wait(2)
end

isFirstTime = false
end)

function StartCamera()
	toggleLogo()

	SetAudioFlag("LoadMPData", 1)

	TriggerEvent('esx:displayHud', false)

	camActive = true

	Citizen.CreateThread(function()
		while true do
		  Citizen.Wait(2)
			  if camActive then
				  DisableFirstPersonCamThisFrame()
				  BlockWeaponWheelThisFrame()
				  for k, v in pairs(disabledControls) do
				  DisableControlAction(0, v, true)
				  end
			HideHudAndRadarThisFrame()
		  else
			break
		  end
		  end
	  end)

	ClearFocus()

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", initialCam.posX, initialCam.posY, initialCam.posZ, initialCam.rotX, initialCam.rotY, initialCam.rotZ, fov * 1.0)
	NetworkOverrideClockTime(19, 30, 00);
	SetCamActive(cam, true)
	RenderScriptCams(true, false, 0, true, false)
    	
	SetCamAffectsAiming(cam, false)
	ShakeCam(cam, "HAND_SHAKE", 0.50)


end

function StopCamera()
	DoScreenFadeOut(100)
  Citizen.Wait(100)

	camActive = false

	ClearFocus()

	RenderScriptCams(false, false, 0, true, false)
	DestroyCam(cam, false)
    
	offsetRotX = 0.0
	offsetRotY = 0.0
	offsetRotZ = 0.0

	isAttached = false

	speed       = 1.0
	precision   = 1.0
	currFov     = GetGameplayCamFov()

	cam = nil

	FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
	SetEntityVisible(ESX.PlayerData.cache.playerped, true, true)

	TriggerEvent('esx:displayHud', true)
	TriggerEvent('esx:displayHud2', false)
	toggleLogo()
	local playerPed = ESX.PlayerData.cache.playerped
    if ESX.PlayerData.coords then
	    DoScreenFadeIn(2500)
	    SetEntityCoords(playerPed, ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z)
	else
	    DoScreenFadeIn(2500)
	    SetEntityCoords(playerPed, 300.4, 200.13, 103.35)
		SetEntityHeading(playerPed, 160.57)
	end
	ResurrectPed(playerPed)
	SetEntityHealth(playerPed, 200)
	ClearPedBloodDamage(playerPed)
	ClearPedTasksImmediately(playerPed)

TriggerEvent("esx:passjoin")
TriggerServerEvent("esx:passjoin")

Citizen.CreateThread(function()
  local playerPed = ESX.PlayerData.cache.playerped
  SetEntityInvincible(playerPed, true)
  Citizen.Wait(10000)
  SetEntityInvincible(playerPed, false)
end)
end