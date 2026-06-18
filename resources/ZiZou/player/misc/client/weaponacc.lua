local used = {
    ['silencieux'] = 0,
    ['flashlight'] = 0,
    ['grip'] = 0,
    ['yusuf'] = 0
}

local weapons = {}

Citizen.CreateThread(function()
	while ESX.Weapons == nil do
		Wait(0)
	end

	for k, v in pairs(ESX.Weapons) do 
		weapons[GetHashKey(v.name)] = {name = v.name, label = v.label, components = v.components or {}, realcomponents = {}, tints = v.tints or {}}
	end

    for k, v in pairs(weapons) do
        if v.components then
            Citizen.CreateThread(function()
                for c, j in pairs(v.components) do
                    v.realcomponents[j.name] = {label = j.label, hash = j.hash}
                end
            end)
        end
    end
end)

RegisterNetEvent('accessories:use')
AddEventHandler('accessories:use', function(accessory)
    local ped = ESX.PlayerData.cache.playerped
    local currentWeaponHash = GetSelectedPedWeapon(ped)
	local inventory = ESX.PlayerData.inventory
	local itemcount = 0
	    for i=1, #inventory, 1 do
		    if inventory[i].name == accessory then
			    itemcount = inventory[i].count
		    end
	    end

    local accessoryname = accessory

    if accessory == 'yusuf' then
        accessoryname = 'luxary_finish'
    elseif accessory == 'silencieux' then
        accessoryname = 'suppressor'
    elseif accessory == 'clip' then
        if IsPedArmed(ped, 4) then
            hash=GetSelectedPedWeapon(ped)
            if hash~=nil then
              AddAmmoToPed(ESX.PlayerData.cache.playerped, hash, 25)
              TriggerEvent("esx:updateWeaponAmmo", hash)
              ESX.ShowNotification("Tu as utilisé un chargeur !", "success")
            else
              ESX.ShowNotification("Tu n'as pas d'arme en main", "error")
            end
          else
            ESX.ShowNotification("ce type de munision ne convient pas", "error")
          end
        return
    end
    
		if used[accessory] < itemcount then
            if weapons[currentWeaponHash].realcomponents[accessoryname] then
                GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, currentWeaponHash, weapons[currentWeaponHash].realcomponents[accessoryname].hash)  
                ESX.ShowNotification("Vous venez de vous équiper d'un accessoire. Il faudra le rééquiper a chaques retours en ville.", "success")
                used[accessory] = used[accessory] + 1
            else 
                ESX.ShowNotification("Vous n'avez pas d'arme en main ou votre arme ne peux pas supporter cet accessoire.", "error")
            end
		else
			ESX.ShowNotification("Vous avez utilisé tous vos accessoires de ce type.", "error")
		end
end)