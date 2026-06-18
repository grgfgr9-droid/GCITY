local eventActive = false
local npcs = {}
local Config = {
    Positions = {
        {x = -500.0, y = -200.0, z = 35.0, h = 180.0},
        {x = -520.0, y = -180.0, z = 35.0, h = 90.0}
    },
    NPCModel = "s_m_y_blackops_01"
}

RegisterCommand("startevent", function(source, args, rawCommand)
    if eventActive then
        print("Événement déjà en cours!")
        return
    end
    
    eventActive = true
    npcs = {}
    
    for i, pos in ipairs(Config.Positions) do
        TriggerClientEvent("assassinEvent:spawnPedStealth", -1, i, pos, Config.NPCModel)
    end
    
    SetTimeout(120000, function()
        if eventActive then
            print("Temps écoulé, fin de l'événement!")
            eventActive = false
            TriggerClientEvent("assassinEvent:endEvent", -1)
        end
    end)
end, true)

RegisterNetEvent("assassinEvent:pedKilled")
AddEventHandler("assassinEvent:pedKilled", function(id)
    npcs[id] = true
    
    local allDead = true
    for i, _ in ipairs(Config.Positions) do
        if not npcs[i] then
            allDead = false
            break
        end
    end
    
    if allDead then
        print("Tous les PNJ sont morts, fin de l'événement!")
        eventActive = false
        TriggerClientEvent("assassinEvent:endEvent", -1)
    end
end)
