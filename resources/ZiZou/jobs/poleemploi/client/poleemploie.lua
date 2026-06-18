emploieState = false

local MarkerSettings = {
    type = 1,  -- Type du marker
    pos =  vector3(-266.52, -959.45, 30.22), -- Position du marker
    scale = {x = 4.0, y = 4.0, z = 1.0}, -- Taille du marker
    color = {r = 0, g = 0, b = 0, a = 150}, -- Couleur du marker
    bounce = false, -- Effet de saut
    rotate = false -- Rotation
}

local menu = {
    Base = { Title = "Liste des emploies", HeaderColor = {255, 255, 255} },
    Data = { currentMenu = "Emplois disponibles" },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
            if btn.action == "jardinier" then
                TriggerServerEvent('zizou:setjobjardinier')
                SetNewWaypoint(-1356.846, 130.2325, 56.2388)
            elseif btn.action == "chantier" then
             --   TriggerServerEvent('zizou:setjobchantier')
              --  SetNewWaypoint(0.0, 0.0, 0.0)
            elseif btn.action == "mineur" then
             ---   TriggerServerEvent('zizou:setjomineur')
              ---  SetNewWaypoint(0.0, 0.0, 0.0)
            elseif btn.action == "stopjob" then
                TriggerServerEvent('zizou:stopjob')
            end
        end
    },
    Menu = {
        ["Emplois disponibles"] = {
            b = {
                { name = "Jardinier", action = "jardinier", ask = "→", askX = true },
                { name = "Chantier (SOON)", action = "chantier", ask = "→", askX = true },
                { name = "Mineur (SOON)", action = "mineur", ask = "→", askX = true },
                { name = "Arrêter de travailler", action = "stopjob", ask = "→", askX = true }
            }
        }
    }
}

function PoleEmploie()
    CreateMenu(menu)
end

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - vector3(MarkerSettings.pos.x, MarkerSettings.pos.y, MarkerSettings.pos.z))
        local waitTime = 500

        if distance <= 5.0 then
            waitTime = 0   
            DrawMarker(
                MarkerSettings.type, MarkerSettings.pos.x, MarkerSettings.pos.y, MarkerSettings.pos.z,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                MarkerSettings.scale.x, MarkerSettings.scale.y, MarkerSettings.scale.z,
                MarkerSettings.color.r, MarkerSettings.color.g, MarkerSettings.color.b, MarkerSettings.color.a,
                MarkerSettings.bounce, true, 2, MarkerSettings.rotate, nil, nil, false
            )

            ESX.ShowHelpNotification("Appuyez sur [E] pour accéder au Pôle Emploi")

            if IsControlJustPressed(0, 38) then -- 0 = clavier, 38 = touche E
                PoleEmploie()
            end
        end 

        Wait(waitTime)
    end
end)
