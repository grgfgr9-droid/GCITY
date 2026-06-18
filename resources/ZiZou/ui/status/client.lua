Citizen.CreateThread(function()
  while true do
    Citizen.Wait(30)
    if IsPauseMenuActive() and not IsPaused then
	  IsPaused = true
    SendNUIMessage({action = "toggle", show = false})
    elseif not IsPauseMenuActive() and IsPaused then
    IsPaused = false
    SendNUIMessage({action = "toggle", show = true})
    end
  end
end)

AddEventHandler('esx_status:onTick', function(status)
  SendNUIMessage({action = "updateStatus", status = status})
end)



