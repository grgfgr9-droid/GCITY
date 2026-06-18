RegisterServerEvent('casino:acheterJetons')
AddEventHandler('casino:acheterJetons', function(montant)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    montant = tonumber(montant)
    if not montant or montant <= 0 then
        TriggerClientEvent('esx:showNotification', _source, "Montant invalide")
        return
    end
    
    -- Vérifier si le joueur a assez d'argent
    local argentDuJoueur = xPlayer.getAccount('bank').money
    if argentDuJoueur < montant then
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas assez d'argent")
        return
    end

    xPlayer.removeAccountMoney('bank', montant)
    xPlayer.addInventoryItem('jeton', montant)

    TriggerClientEvent('esx:showNotification', _source, "Vous avez acheté " .. montant .. " jetons")
end)

RegisterServerEvent('casino:vendreJetons')
AddEventHandler('casino:vendreJetons', function(montant)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    montant = tonumber(montant)
    if not montant or montant <= 0 then
        TriggerClientEvent('esx:showNotification', _source, "Montant invalide")
        return
    end
    
    local jetons = xPlayer.getInventoryItem('jeton')
    if jetons.count < montant then
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas assez de jetons")
        return
    end

    xPlayer.removeInventoryItem('jeton', montant)
    xPlayer.addAccountMoney('bank', montant)
    TriggerClientEvent('esx:showNotification', _source, "Vous avez vendu " .. montant .. " jetons")
end)