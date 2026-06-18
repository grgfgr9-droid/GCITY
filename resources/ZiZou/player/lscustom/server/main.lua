ESX.RegisterServerCallback('esx:buyLSCustom', function(source, cb, data)
	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer and data then
        local vehicle = GetGarageVehicle(data.vehicle.plate)
        if CheckIsMechanic(xPlayer.job.name) and vehicle and data.price >= 0 then
            local societyAccount = GetSharedAccount('society_' .. xPlayer.job.name)

            if societyAccount and vehicle.vehicle.model == data.vehicle.model then
                if societyAccount.money >= data.price then
                    xPlayer.showNotification("Achat Effectué !")
                    societyAccount.removeMoney(data.price)
                    MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
                        ['@plate'] = data.vehicle.plate,
                        ['@vehicle'] = json.encode(data.vehicle)
                    })
                    local newprops = GetGarageVehicle(data.vehicle.plate)
                    newprops.vehicle = data.vehicle
                    UpdateGarageVehicle(data.vehicle.plate, newprops)
                    cb(true)
                else
                    xPlayer.showNotification("Vous n\'avez pas assez d\'argent dans l\'entreprise !")
                    cb(false)
                end
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        cb(false)
    end
end)