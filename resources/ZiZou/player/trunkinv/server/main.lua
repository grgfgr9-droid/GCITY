local VehiclesCapacities = {
    [GetHashKey('guardian')] = 200,
    [GetHashKey('sanding')] = 150,
    [GetHashKey('kamacho')] = 120,
    [GetHashKey('baller')] = 80,
    [GetHashKey('baller2')] = 80,
    [GetHashKey('baller3')] = 80,
    [GetHashKey('calvalcade')] = 80,
    [GetHashKey('contender')] = 150,
    [GetHashKey('dubsta')] = 80,
    [GetHashKey('dubsta2')] = 80,
    [GetHashKey('granger')] = 120,
    [GetHashKey('gresley')] = 80,
    [GetHashKey('hentley')] = 80,
    [GetHashKey('landstalker')] = 80,
    [GetHashKey('mesa')] = 80,
    [GetHashKey('mesa3')] = 120,
    [GetHashKey('patriot')] = 120,
    [GetHashKey('raduis')] = 80,
    [GetHashKey('rocoto')] = 80,
    [GetHashKey('seminole')] = 80,
    [GetHashKey('xls')] = 80,
    [GetHashKey('bison')] = 120,
    [GetHashKey('bobcatxl')] = 80,
    [GetHashKey('burrito')] = 300,
    [GetHashKey('camper')] = 300,
    [GetHashKey('burrito2')] = 300,
    [GetHashKey('burrito3')] = 300,
    [GetHashKey('burrito4')] = 300,
    [GetHashKey('burrito5')] = 300,
    [GetHashKey('burrito6')] = 300,
    [GetHashKey('journey')] = 300,
    [GetHashKey('minivan')] = 120,
    [GetHashKey('moonbeam')] = 300,
    [GetHashKey('moonbeam2')] = 300,
    [GetHashKey('paradise')] = 300,
    [GetHashKey('rumpo')] = 300,
    [GetHashKey('rumpo2')] = 300,
    [GetHashKey('rumpo3')] = 300,
    [GetHashKey('surfer')] = 300,
    [GetHashKey('youga')] = 300,
    [GetHashKey('youga2')] = 300,
    [GetHashKey('mule')] = 500,
    [GetHashKey('squaddie')] = 300,
    [GetHashKey('buzzard2')] = 500,
    [GetHashKey('luxor2')] = 300,
    [GetHashKey('luxor')] = 300,
    [GetHashKey('swift2')] = 250,
    [GetHashKey('swift')] = 250,
}
local VehiclesTrunks = {}

function GetItemWeight(item)
  return ESX.Items[item].weight
end

function RegisterTrunk(plate)
  VehiclesTrunks[plate] = {
    ["items"] = {},
    ["weapons"] = {},
    ["black_money"] = 0
  }
end

function GetTotalInventoryWeight(plate)
  local total = 0
  if VehiclesTrunks[plate] then
    if VehiclesTrunks[plate]["items"] then
        for k, v in pairs(VehiclesTrunks[plate]["items"]) do
          total = total + v
        end
    end
  end
  return total
end

ESX.RegisterServerCallback('truck:GetPlate',function(source,cb,plate, vehicle)
  if not VehiclesTrunks[plate] then
    RegisterTrunk(plate)
  end
     local blackMoney = VehiclesTrunks[plate]["black_money"]
     local items      = VehiclesTrunks[plate]["items"]
     local weapons    = VehiclesTrunks[plate]["weapons"]
     local VehicleCapacity = VehiclesCapacities[vehicle] or 200

    local weight = GetTotalInventoryWeight(plate)
    cb({
    blackMoney = blackMoney,
    items      = items,
    weapons    = weapons,
    weight     = weight,
    max        = VehicleCapacity
    })
end)

ESX.RegisterServerCallback('truck:GetItem',function(source,cb,plate, itemtype, item, count)
  if not VehiclesTrunks[plate] then
    RegisterTrunk(plate)
  end
  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
  local VehicleTrunk = VehiclesTrunks[plate]

  if xPlayer then
    if itemtype == "item_standard" then
      if VehicleTrunk["items"][item] and count > 0 and VehicleTrunk["items"][item] >= count then 
        if not xPlayer.canCarryItem(item, count) then 
          cb(false)
          TriggerClientEvent('esx:showNotification', _source, 'Votre inventaire est plein')
          return
        end
        if VehicleTrunk["items"][item] - count > 0 then
          VehicleTrunk["items"][item] = VehicleTrunk["items"][item] - count
        else
          VehicleTrunk["items"][item] = nil
        end
        xPlayer.addInventoryItem(item, count)
        cb(true)
      else
        cb(false)
        TriggerClientEvent('esx:showNotification', _source, '~r~Quantité invalide~s~')
      end
    elseif itemtype == "item_account" then
      if VehicleTrunk["black_money"] and count > 0 and VehicleTrunk["black_money"] >= count then 
        VehicleTrunk["black_money"] = VehicleTrunk["black_money"] - count
        xPlayer.addAccountMoney(item, count)
        cb(true)
      else
        cb(false)
        TriggerClientEvent('esx:showNotification', _source, '~r~Montant invalide~s~')
      end
    elseif itemtype == "item_weapon" then
      if VehicleTrunk["weapons"][item] and not xPlayer.hasWeapon(item) then
        VehicleTrunk["weapons"][item] = nil
        xPlayer.addWeapon(item, VehicleTrunk["weapons"][item])
        cb(true)
      else
        cb(false)
      end
    end
  end

end)

ESX.RegisterServerCallback('truck:PutItem', function(source, cb, plate, itemtype, item, count, vehicle)
  if not VehiclesTrunks[plate] then
    RegisterTrunk(plate)
  end
  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
  local VehicleTrunk = VehiclesTrunks[plate]
  local VehicleCapacity = VehiclesCapacities[vehicle] or 200

  if xPlayer then
    if itemtype == "item_standard" then
      if count > 0 then 
        if not xPlayer.getInventoryItem(item) or xPlayer.getInventoryItem(item).count < count or (GetTotalInventoryWeight(plate) + (count * GetItemWeight(item))) > VehicleCapacity then 
          cb(false)
          TriggerClientEvent('esx:showNotification', _source, '~r~Quantité invalide~s~')
          return
        end
        xPlayer.removeInventoryItem(item, count)
        if not VehicleTrunk["items"][item] then
            VehicleTrunk["items"][item] = count
        else
            VehicleTrunk["items"][item] = VehicleTrunk["items"][item] + count
        end
        cb(true)
      else
        cb(false)
        TriggerClientEvent('esx:showNotification', _source, '~r~Quantité invalide~s~')
      end
    elseif itemtype == "item_account" then
      if count > 0 then 
        if xPlayer.getAccount(item).money < count then 
          cb(false)
          TriggerClientEvent('esx:showNotification', _source, '~r~Montant invalide~s~')
          return
        end
        xPlayer.removeAccountMoney(item, count)
        VehicleTrunk["black_money"] = VehicleTrunk["black_money"] + count
        cb(true)
      else
        cb(false)
        TriggerClientEvent('esx:showNotification', _source, '~r~Montant invalide~s~')
      end
    elseif itemtype == "item_weapon" then
      if xPlayer.hasWeapon(item) and not VehicleTrunk["weapons"][item] then
        local loadoutNum, weapon = xPlayer.getWeapon(item)
        if weapon then
          VehicleTrunk["weapons"][item] = weapon.ammo
          xPlayer.removeWeapon(item)
          cb(true)
        else
          cb(false)
        end
      else
        cb(false)
      end
    end
  end
end)
