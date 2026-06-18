local _RegisterServerEvent, _AddEventHandler = RegisterServerEvent, AddEventHandler

ProtectedEvents = {}

local LettersNumbers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}

function GenerateRandomEvent() 
    local eventName = ""
    local eventLenght = 40
    while eventLenght >= 20 do
        eventName = eventName .. LettersNumbers[math.random(1, #LettersNumbers)]
        eventLenght = eventLenght - 1
    end
    eventName = eventName .. ":"
    while eventLenght > 0 do
        eventName = eventName .. LettersNumbers[math.random(1, #LettersNumbers)]
        eventLenght = eventLenght - 1
    end
    if not ProtectedEvents[eventName] then
        return eventName
    else
        return GenerateRandomEvent()
    end
end

RegisterServerEvent = function(event)
    if event ~= "esx:triggerServerCallback" then
        if not ProtectedEvents[event] then
        ProtectedEvents[event] = {token = math.random(100000, 999999), name = GenerateRandomEvent()}
        if ProtectedEvents[event] then
            return _RegisterServerEvent(ProtectedEvents[event].name)
        else
            return _RegisterServerEvent(event)
        end
        end
    else
        _RegisterServerEvent("esx:triggerServerCallback")
    end
end

AddEventHandler = function(event, func)
    if ProtectedEvents[event] then
        return _AddEventHandler(ProtectedEvents[event].name, function(token, ...)
            local _source = source
            if tonumber(token) == tonumber(ProtectedEvents[event].token) then
                if ESX.Trigger(_source, ProtectedEvents[event].name) then
                func(...)
                end
            else
                SendAntiCheatLog(_source, "Attempt to Trigger Server Event without authorisation [" .. event .. "]", true)
                CancelEvent()
            end
        end)
    else
        _AddEventHandler(event, func)
    end
end

