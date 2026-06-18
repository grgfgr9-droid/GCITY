Mechanics = {
    ["bennys"] = {
        type = "cosmetics",
        label = "Benny's Customs",
        zones = {
            ["actions"] = vector3(-206.7, -1341.7, 33.8),
            ["lscustom"] = vector3(-211.03, -1324.10, 29.88)
        }
    },
    ["mechanic"] = {
        type = "upgrades",
        label = "Mechanic",
        zones = {
            ["actions"] = vector3(-346.8, -133.4, 38.0),
            ["lscustom"] = vector3(-339.4, -137.1, 38.0)
        }
    }
} 

function CheckIsMechanic(job)
    if Mechanics[job] then
        return true
    else
        return false
    end
end

