local holstered = true

local recoils = {
	[453432689] = 0.3, -- PISTOL
	[3219281620] = 0.3, -- PISTOL MK2
	[1593441988] = 0.2, -- COMBAT PISTOL
	[584646201] = 0.1, -- AP PISTOL
	[2578377531] = 0.6, -- PISTOL .50
	[324215364] = 0.2, -- MICRO SMG
	[736523883] = 0.1, -- SMG
	[2024373456] = 0.1, -- SMG MK2
	[4024951519] = 0.1, -- ASSAULT SMG
	[3220176749] = 5.2, -- ASSAULT RIFLE
	[961495388] = 0.2, -- ASSAULT RIFLE MK2
	[2210333304] = 0.1, -- CARBINE RIFLE
	[4208062921] = 0.1, -- CARBINE RIFLE MK2
	[2937143193] = 0.1, -- ADVANCED RIFLE
	[2634544996] = 0.1, -- MG
	[2144741730] = 0.1, -- COMBAT MG
	[3686625920] = 0.1, -- COMBAT MG MK2
	[487013001] = 0.4, -- PUMP SHOTGUN
	[1432025498] = 0.35, -- PUMP SHOTGUN MK2
	[2017895192] = 0.7, -- SAWNOFF SHOTGUN
	[3800352039] = 0.4, -- ASSAULT SHOTGUN
	[2640438543] = 0.2, -- BULLPUP SHOTGUN
	[911657153] = 0.1, -- STUN GUN
	[100416529] = 0.5, -- SNIPER RIFLE
	[205991906] = 0.7, -- HEAVY SNIPER
	[177293209] = 0.6, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.2, -- SNS PISTOL
	[1627465347] = 0.1, -- GUSENBERG
	[3231910285] = 0.2, -- SPECIAL CARBINE
	[-1768145561] = 0.15, -- SPECIAL CARBINE MK2
	[3523564046] = 0.5, -- HEAVY PISTOL
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[-2066285827] = 0.15, -- BULLPUP RIFLE MK2
	[137902532] = 0.4, -- VINTAGE PISTOL
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 0.2, -- HEAVY SHOTGUN
	[3342088282] = 0.3, -- MARKSMAN RIFLE
	[1785463520] = 0.25, -- MARKSMAN RIFLE MK2
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.9, -- FLARE GUN
	[171789620] = 0.2, -- COMBAT PDW
	[3696079510] = 0.9, -- MARKSMAN PISTOL
	[1834241177] = 2.4, -- RAILGUN
	[3675956304] = 0.3, -- MACHINE PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.6, -- REVOLVER MK2
	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.3, -- COMPACT RIFLE
	[317205821] = 0.2, -- AUTO SHOTGUN
	[125959754] = 0.5, -- COMPACT LAUNCHER
	[3173288789] = 0.1, -- MINI SMG		
}

Citizen.CreateThread(function()
    local playerPed = PlayerPedId()  -- On récupère le playerped une fois
    local playerId = PlayerId()  -- On récupère PlayerId une fois
    while true do
        if IsPedArmed(playerPed, 6) then 
            SetPlayerLockon(playerId, false)
            Citizen.Wait(100)  -- On attend 100 ms si le joueur est armé
        else
            SetPlayerLockon(playerId, true)
            Citizen.Wait(1000)  -- On attend 1000 ms s'il n'est pas armé
        end
    end
end)


Citizen.CreateThread(function()
    while not ESX.PlayerData.PassJoin do
        Wait(0)
    end
	while true do
		Citizen.Wait(500)
		if IsPedShooting(ESX.PlayerData.cache.playerped) then
			local _,wep = GetCurrentPedWeapon(ESX.PlayerData.cache.playerped)
			_,cAmmo = GetAmmoInClip(ESX.PlayerData.cache.playerped, wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				if GetFollowPedCamViewMode() ~= 4 then
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						SetGameplayCamRelativePitch(p+0.1, 0.2)
						tv = tv+0.1
					until tv >= recoils[wep]
				else
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						if recoils[wep] > 0.1 then
							SetGameplayCamRelativePitch(p+0.6, 1.2)
							tv = tv+0.6
						else
							SetGameplayCamRelativePitch(p+0.016, 0.333)
							tv = tv+0.1
						end
					until tv >= recoils[wep]
				end
			end
		end
	end
end)

local holstered = true
local canFire = true

local weapons = {
    "WEAPON_BAT",
	"WEAPON_APPISTOL",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_MICROSMG",
    "WEAPON_COMBATPDW",
    "WEAPON_SMG",
    "WEAPON_PISTOL",
    "WEAPON_SNSPISTOL",
    "WEAPON_PISTOL50",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_DOUBLEACTION",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_CARBINERIFLE",
    "WEAPON_GUSENBERG"
}

local weaponsBags = {
	"WEAPON_CROWBAR",
    "WEAPON_BAT",
    "WEAPON_MICROSMG",
    "WEAPON_COMBATPDW",
    "WEAPON_SMG",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_CARBINERIFLE",
    "WEAPON_GUSENBERG"
}

Citizen.CreateThread(function()
    while not ESX.PlayerData.PassJoin do
        Citizen.Wait(100) -- Augmentation du délai pour éviter une boucle infinie trop gourmande
    end
    
    while true do
        Citizen.Wait(500)
        local ped = ESX.PlayerData.cache.playerped
        
        if DoesEntityExist(ped) and not ESX.PlayerData.IsDead and not IsPedInAnyVehicle(ped, true) then
            holstered, canFire = not CheckWeapon(ped), true
            SetPedComponentVariation(ped, 0, 0, 0, 0)
        end
    end
end)





function CheckWeaponBags(ped)
    for i = 1, #weaponsBags do
        if GetHashKey(weaponsBags[i]) == GetSelectedPedWeapon(ped) then
            return true
        end
    end
    return false
end

function CheckWeapon(ped)
    for i = 1, #weapons do
        if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
            return true
        end
    end
    return false
end

function loadAnimDictWeapon(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(500)
    end
end

Citizen.CreateThread(function()
    while not ESX.PlayerData.PassJoin do
        Wait(100)
      end
  while true do
	Citizen.Wait(5)
     if not canFire or ESX.PlayerData.jail.time > 0 then
      local player = ESX.PlayerData.cache.playerped
      DisablePlayerFiring(player, true)
      DisableControlAction(0, 25, true)
      DisableControlAction(2, 37, true)
      DisableControlAction(0, 106, true)
	  DisableControlAction(0, 140, true)
     else
     Citizen.Wait(250)
     end
  end
end)

-- Desactive coup de crosse
Citizen.CreateThread(function()
    local playerPed = PlayerPedId()  -- On récupère playerped une fois
    while true do
        if IsPedArmed(playerPed, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            Citizen.Wait(100)  -- On attend 100 ms si le joueur est armé
        else
            Citizen.Wait(1000)  -- On attend 1000 ms si le joueur n'est pas armé
        end
    end
end)
