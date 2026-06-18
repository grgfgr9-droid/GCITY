ESX.RegisterServerCallback("radio:checkItem", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local item = xPlayer.getInventoryItem("radio")
        if item and item.count > 0 then
            cb(true) -- ✅ Le joueur a une radio
        else
            cb(false) -- ❌ Le joueur n'a pas de radio
        end
    else
        cb(false)
    end
end)
