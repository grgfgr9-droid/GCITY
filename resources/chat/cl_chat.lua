_print = print
_TriggerServerEvent = TriggerServerEvent
_NetworkExplodeVehicle = NetworkExplodeVehicle
_AddExplosion = AddExplosion

local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

RegisterNetEvent('__cfx_internal:serverPrint')
AddEventHandler('__cfx_internal:serverPrint', function(msg)
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = {
			templateId = 'print',
			multiline = true,
			args = { msg }
		}
	})
end)

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(author, color, text)
	local args = { text }

	if author ~= "" then
		table.insert(args, 1, author)
	end

	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = {
			color = color,
			multiline = true,
			args = args
		}
	})
end)

RegisterNetEvent('chat:addMessage')
AddEventHandler('chat:addMessage', function(message)
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = message
	})
end)

RegisterNetEvent('chat:addSuggestions')
AddEventHandler('chat:addSuggestions', function(suggestions)
	for i = 1, #suggestions, 1 do
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = suggestions[i]
		})
	end
end)

RegisterNetEvent('chat:addSuggestion')
AddEventHandler('chat:addSuggestion', function(name, help, params)
	SendNUIMessage({
		type = 'ON_SUGGESTION_ADD',
		suggestion = {
			name = name,
			help = help,
			params = params or nil
		}
	})
end)

RegisterNetEvent('chat:removeSuggestion')
AddEventHandler('chat:removeSuggestion', function(name)
	SendNUIMessage({
		type = 'ON_SUGGESTION_REMOVE',
		name = name
	})
end)

RegisterNetEvent('chat:addTemplate')
AddEventHandler('chat:addTemplate', function(id, html)
	SendNUIMessage({
		type = 'ON_TEMPLATE_ADD',
		template = {
			id = id,
			html = html
		}
	})
end)

RegisterNetEvent('chat:clear')
AddEventHandler('chat:clear', function(name)
	SendNUIMessage({
		type = 'ON_CLEAR'
	})
end)

AddEventHandler('onClientResourceStart', function(resName)
	Citizen.Wait(500)
	refreshCommands()
	refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
	Citizen.Wait(500)
	refreshCommands()
	refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
	refreshCommands()
	refreshThemes()

	chatLoaded = true
	cb('ok')
end)

RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	SetNuiFocus(false)

	if not data.canceled then
		local id = PlayerId()
		local r, g, b = 0, 0, 255

		if data.message:sub(1, 1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			_TriggerServerEvent('::{korioz#0110}::_chat:messageEntered', GetPlayerName(id), {r, g, b}, data.message)
		end
	end

	cb('ok')
end)

function refreshCommands()
	local registeredCommands = GetRegisteredCommands()
	local suggestions = {}

	for i = 1, #registeredCommands, 1 do
		if IsAceAllowed(('command.%s'):format(registeredCommands[i].name)) then
			table.insert(suggestions, {
				name = '/' .. registeredCommands[i].name,
				help = ''
			})
		end
	end

	TriggerEvent('chat:addSuggestions', suggestions)
end

function refreshThemes()
	local themes = {}

	for resIdx = 0, GetNumResources() - 1 do
		local resource = GetResourceByFindIndex(resIdx)

		if GetResourceState(resource) == 'started' then
			local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

			if numThemes > 0 then
				local themeName = GetResourceMetadata(resource, 'chat_theme')
				local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

				if themeName and themeData then
					themeData.baseUrl = 'nui://' .. resource .. '/'
					themes[themeName] = themeData
				end
			end
		end
	end

	SendNUIMessage({
		type = 'ON_UPDATE_THEMES',
		themes = themes
	})
end

Citizen.CreateThread(function()
    SetTextChatEnabled(false)
    SetNuiFocus(false)

    local lastControlCheck, lastScreenCheck = 0, 0
    local controlCheckInterval, screenCheckInterval = 100, 500

    while true do
        Citizen.Wait(50) -- Réduction de la charge CPU avec un intervalle plus long
        local currentTime = GetGameTimer()

        -- Activation du chat
        if not chatInputActive and (currentTime - lastControlCheck) > controlCheckInterval then
            if IsControlPressed(0, 245) then
                chatInputActive = true
                chatInputActivating = true
                SendNUIMessage({ type = 'ON_OPEN' })
            end
            lastControlCheck = currentTime
        end

        -- Fermeture du chat avec contrôle
        if chatInputActivating and (currentTime - lastControlCheck) > controlCheckInterval then
            if not IsControlPressed(0, 245) then
                SetNuiFocus(true)
                chatInputActivating = false
            end
            lastControlCheck = currentTime
        end

        -- Vérification de la visibilité du chat
        if chatLoaded and (currentTime - lastScreenCheck) > screenCheckInterval then
            local shouldBeHidden = IsScreenFadedOut() or IsPauseMenuActive()
            if chatHidden ~= shouldBeHidden then
                chatHidden = shouldBeHidden
                SendNUIMessage({
                    type = 'ON_SCREEN_STATE_CHANGE',
                    shouldHide = shouldBeHidden
                })
            end
            lastScreenCheck = currentTime
        end
    end
end)

