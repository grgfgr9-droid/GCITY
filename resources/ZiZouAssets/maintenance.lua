TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Licensestaff = {
    Staff = {
        [""] = true, --- MSK
        [""] = true, --- BLXZEK
        [""] = true, --- SILENCE
        [""] = true, --- SILENCE
        [""] = true, --- THX
        [""] = true, --- ZEYRIX
    },
}

local maintenance = false -- Maintenance désactivée par défaut

local function getLicense(src)
    for _, v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return nil
end

local function isStaff(src)
    local lic = getLicense(src)
    return lic ~= nil and Licensestaff.Staff[lic] == true
end

local function devStart(state)
    maintenance = state

    if not state then
        print("Maintenance ^1désactivée^0.")
        return
    end

    print("Maintenance ^2activée^0.")
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local src = xPlayers[i]
        if not isStaff(src) then
            print("Le joueur ^4" .. GetPlayerName(src) .. "^0 connexion ^1refusée^0 (^5Dev^0)")
            DropPlayer(src, "\nInformation\nLe serveur est actuellement en Maintenance !")
        else
            print("Le joueur ^4" .. GetPlayerName(src) .. "^0 connexion ^2acceptée^0 (^5Dev^0)")
        end
    end
end

AddEventHandler('playerConnecting', function(name, setReason, deferrals)
    if not maintenance then return end

    deferrals.defer()

    Citizen.Wait(0)

    local src = source
    deferrals.update("Vérification de votre accès...")

    Citizen.Wait(500)

    if not isStaff(src) then
        print("Le joueur ^4" .. name .. "^0 connexion ^1refusée^0 (^5Maintenance DU SERVEUR^0)")
        deferrals.done("\n\nServeur en Maintenance, plus d'informations sur discord.gg/antalyaoff !\n\n")
        return
    end

    deferrals.done()
end)

Citizen.CreateThread(function()
    while true do
        Wait(60 * 1000 * 4)
        if maintenance then
            print("Maintenance ^2détectée^0 !")
            local xPlayers = ESX.GetPlayers()
            for i = 1, #xPlayers do
                local src = xPlayers[i]
                if not isStaff(src) then
                    print("Le joueur ^4" .. GetPlayerName(src) .. "^0 est ^1refusé^0 dans la Maintenance et je le kick.")
                    DropPlayer(src, "\nInformation\nLe serveur est actuellement en Maintenance !")
                else
                    print("Le joueur ^4" .. GetPlayerName(src) .. "^0 est ^2accepté^0 dans la Maintenance.")
                end
            end
        else
            print("Maintenance ^1non détectée^0 !")
        end
    end
end)

RegisterCommand("maintenance", function(source)
    if source ~= 0 then return end -- console uniquement
    devStart(not maintenance)
end, true)