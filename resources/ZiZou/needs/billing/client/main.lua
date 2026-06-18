local lockAskingFine = false

RegisterNetEvent("billing:receiveBill")
AddEventHandler("billing:receiveBill", function(id, label, amount, account, sender)
	Citizen.CreateThread(function()
		if (lockAskingFine ~= true) then

			lockAskingFine = true
			local notifReceivedAt = GetGameTimer()

			ESX.ShowNotification(label .. "<br><br>Appuyez sur Y pour accepter la facture de "..amount.."$,<br>Appuyez sur K pour la refuser.")

			while true do
				Wait(5)

				if (GetTimeDifference(GetGameTimer(), notifReceivedAt) > 10000) then
					TriggerServerEvent("billing:expireBill", id, sender)
					ESX.ShowNotification("~y~La facture a expiré.")
					lockAskingFine = false
					break
				end

				if IsControlPressed(1, 246) and GetLastInputMethod(2) then	
					local confirm = KeyboardInput("BILLING_CONFIRM", "Payer la facture ? Ecrivez oui pour confirmer.", "", 6)
					if confirm ~= nil and confirm == "oui" then
					TriggerServerEvent("billing:payBill", id)					
					lockAskingFine = false
					break
					end			
				end

				if IsControlPressed(1, 311) and GetLastInputMethod(2) then
					TriggerServerEvent("billing:refuseBill", id)
					ESX.ShowNotification("~r~Vous avez refusé de payer la facture.")
					lockAskingFine = false
					break
				end

			end

		else
			TriggerServerEvent("Billing:Expire", id, sender)
		end

	end)
end)