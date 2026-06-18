ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 20)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_cs_burger_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'vous avez mangé 1x pain', "info")
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 20)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_ld_flow_bottle', "info")
	TriggerClientEvent('esx:showNotification', source, 'vous avez bu 1x Eau', "info")
end)

ESX.RegisterUsableItem('sandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sandwich', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 50)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_cs_hotdog_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Sandwish Jambon-Beurre', "info")
end)

ESX.RegisterUsableItem('parapluie', function(source)
print("parapluie utilisé")
end)

ESX.RegisterUsableItem('chocolate', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('chocolate', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 15)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_cs_burger_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Chocolat', "info")
end)

ESX.RegisterUsableItem('orange', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('orange', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 10)
	xPlayer.setDrink(xPlayer.getStatus().drink + 15)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_cs_burger_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Orange', "info")
end)

ESX.RegisterUsableItem('orange_juice', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('orange_juice', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 10)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_cs_burger_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez Bus 1x jus d\'Orange', "info")
end)

ESX.RegisterUsableItem('pomme', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pomme', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 10)
	xPlayer.setDrink(xPlayer.getStatus().drink + 5)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_cs_burger_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Pomme', "info")
end)

ESX.RegisterUsableItem('tarte_pomme', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tarte_pomme', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_cs_burger_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Tarte au pomme', "info")
end)

ESX.RegisterUsableItem('eaugazifie', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('eaugazifie', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_ld_flow_bottle', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé x1 bouteille d\'eau gazifié', "info")
end)

ESX.RegisterUsableItem('pepsi', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pepsi', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 40)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_ecola_can', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Pepsi', "info")
end)

ESX.RegisterUsableItem('7up', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('7up', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 30)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_ld_can_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x 7up', "info")
end)

ESX.RegisterUsableItem('coca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coca', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 50)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_ecola_can', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Coca', "info")
end)

ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fanta', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 50)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_orang_can_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Fanta', "info")
end)

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sprite', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 50)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_ld_can_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Sprite', "info")
end)

ESX.RegisterUsableItem('orangina', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('orangina', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_orang_can_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Orangina', "info")
end)

ESX.RegisterUsableItem('cocktail', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cocktail', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 50)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrink', source, 'prop_cocktail', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Cocktail sans al', "info")
end)

ESX.RegisterUsableItem('bonbons', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bonbons', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 5)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Bonbons', "info")
end)

ESX.RegisterUsableItem('burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('burger', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 50)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_cs_burger_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Hamburger', "info")
end)

ESX.RegisterUsableItem('bigmac', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bigmac', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 60)
	TriggerClientEvent('status:onEat', source, 'prop_cs_burger_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x big mac', "info")
end)

ESX.RegisterUsableItem('frites', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('frites', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 40)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Frites', "info")
end)

ESX.RegisterUsableItem('soda', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('soda', 1)

	xPlayer.setDrink(xPlayer.getStatus().drink + 50)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source, 'prop_orang_can_01', "info")
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Soda Orange', "info")
end)

ESX.RegisterUsableItem('viande', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('viande', 1)

	xPlayer.setEat(xPlayer.getStatus().eat + 30)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez mangé 1x Viande', "info")
end)

-- Items Alcohol --
ESX.RegisterUsableItem('beer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('status:add', source, 'drunk', 45)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Bière~s~', "info")
end)

ESX.RegisterUsableItem('vine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vine', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Vin', "info")
end)

ESX.RegisterUsableItem('vine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vine', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu 1x Vin', "info")
end)

ESX.RegisterUsableItem('metreshooter', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('metreshooter', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Shooter~s~', "info")
end)

ESX.RegisterUsableItem('rhumcoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('rhumcoca', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Rhum Coca~s~', "info")
end)

ESX.RegisterUsableItem('rhumfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('rhumfruit', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Rhum Fruit~s~', "info")
end)

ESX.RegisterUsableItem('vodkardb', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vodkardb', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Vodka Energy~s~', "info")
end)

ESX.RegisterUsableItem('whiskycoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('whiskycoca', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Whisky coca~s~', "info")
end)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Whisky~s~', "info")
end)

ESX.RegisterUsableItem('vittvin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vittvin', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Boisson~s~', "info")
end)

ESX.RegisterUsableItem('codeine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('codeine', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Boisson~s~', "info")
end)

ESX.RegisterUsableItem('disolvant', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('disolvant', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Boisson~s~', "info")
end)

ESX.RegisterUsableItem('grand_cru', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('grand_cru', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Grand Cru~s~', "info")
end)

ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Martini~s~', "info")
end)

ESX.RegisterUsableItem('mojito', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mojito', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Mojito~s~', "info")
end)

ESX.RegisterUsableItem('jager', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('jager', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Jager~s~', "info")
end)

ESX.RegisterUsableItem('jagerbomb', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('jagerbomb', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Jager Bomb~s~', "info")
end)

ESX.RegisterUsableItem('jagercerbere', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('jagercerbere', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Jager biere~s~', "info")
end)

ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Rhum~s~', "info")
end)

ESX.RegisterUsableItem('teqpaf', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('teqpaf', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Teqpaf~s~', "info")
end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('status:add', source, 'drunk', 25)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé 1x ~y~Tequila~s~', "info")
end)

-- Items Drug --
ESX.RegisterUsableItem('weed', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('weed', 1)

	TriggerClientEvent('status:add', source, 'drug', 16)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onWeed', source)
end)

ESX.RegisterUsableItem('opium', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('opium', 1)

	TriggerClientEvent('status:add', source, 'drug', 12)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onOpium', source)
end)

ESX.RegisterUsableItem('meth', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth', 1)

	TriggerClientEvent('status:add', source, 'drug', 14)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onMeth', source)
end)

ESX.RegisterUsableItem('coke', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke', 1)

	TriggerClientEvent('status:add', source, 'drug', 23)
	TriggerClientEvent("esx:SyncMyPlayer", xPlayer.source, xPlayer.getStatus(), xPlayer.getTime())
	TriggerClientEvent('status:onCoke', source)
end)
