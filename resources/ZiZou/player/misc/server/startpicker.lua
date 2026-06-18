local AleardyGotStart = {}

RegisterServerEvent("esx:pickStarter")
AddEventHandler("esx:pickStarter", function(key)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Pack = StartPickerConfig.List[key] 

    if not AleardyGotStart[xPlayer.identifier] and PlayersRegistredThisSession[xPlayer.identifier] then
        for k, v in pairs(Pack.items) do
            if v.type == "money" then
                if tonumber(v.amount) then
                    xPlayer.addAccountMoney(v.item, tonumber(v.amount))
                end
            elseif v.type == "weapon" then
                xPlayer.addWeapon(v.item, 0)
            elseif v.type == "vehicle" then
                AssignVehicle(source, xPlayer.getUUID(), v.item, GeneratePlate(), true)
            end
        end
        AleardyGotStart[xPlayer.identifier] = true
        xPlayer.showNotification('Vous avez choisi le pack : ' .. Pack.name)
    end
end)