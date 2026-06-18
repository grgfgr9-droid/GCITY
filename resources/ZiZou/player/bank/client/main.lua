local HasAlreadyEnteredMarker = false

local banks = {
    {x=150.266, y=-1040.203, z=29.374},
    {x=-1212.980, y=-330.841, z=37.787},
    {x=-2962.582, y=482.627, z=15.703},
    {x=-112.202, y=6469.295, z=31.626},
    {x=314.187, y=-278.621, z=54.170},
    {x=-351.534, y=-49.529, z=49.042},
    {x=241.727, y=220.706, z=106.286},
    {x=4476.75, y=-4464.48, z=4.25}, --cayo
    {x=1175.064, y=2706.643, z=38.094}
  }
  
local BankOpen = false
societymoney = 0
local aleardyAskedForSociety = false

RegisterNetEvent('addonaccount:setMoney')
AddEventHandler('addonaccount:setMoney', function(name, balance)
  RefreshSocietyMoney()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  RefreshSocietyMoney()
end)

Citizen.CreateThread(function()
  while not ESX.PlayerData.PassJoin do
    Wait(5)
  end
  RefreshSocietyMoney()
end)

RegisterNetEvent('bank:refreshSocietyMoney')
AddEventHandler('bank:refreshSocietyMoney', function(money)
  societymoney = ESX.Math.GroupDigits(money)
end)

function RefreshSocietyMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
      TriggerServerEvent('bank:refreshSocietyMoney')
    end
end
  
function OpenBankMenu()
  BankOpen = true
  BankMenu = {}
  BankMenu = {
      Base = { Title = "banque", HeaderColor = {8, 245, 0} },
      Data = { currentMenu = "menu principal" },
  
      Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
        if btn.action == "deposit" then
          local amount = KeyboardInput("BANK_DEPOSIT", "Combien deposer ?", "", 6)
          if tonumber(amount) ~= nil then
            TriggerServerEvent("bank:deposit", tonumber(amount), "player")
            CloseMenu()
            OpenBankMenu()
          end
  
        elseif btn.action == "withdraw" then
          local amount = KeyboardInput("BANK_WITHDRAW", "Combien retirer ?", "", 6)
          if tonumber(amount) ~= nil then
            TriggerServerEvent("bank:withdraw", tonumber(amount), "player")
            CloseMenu()
            OpenBankMenu()
          end
        elseif btn.action == "depositsociety" then
          local amount = KeyboardInput("BANK_DEPOSIT", "Combien deposer ?", "", 6)
          if tonumber(amount) ~= nil then
            TriggerServerEvent("bank:deposit", tonumber(amount), "society")
            CloseMenu()
            OpenBankMenu()
          end
  
        elseif btn.action == "withdrawsociety" then
          local amount = KeyboardInput("BANK_WITHDRAW", "Combien retirer ?", "", 6)
          if tonumber(amount) ~= nil then
            TriggerServerEvent("bank:withdraw", tonumber(amount), "society")
            CloseMenu()
            OpenBankMenu()
          end
        elseif btn.action == "bank" then
          BankMenu.Menu["compte courant "].b = {}
          for k, v in pairs(ESX.PlayerData.accounts) do 
            if v.name == "bank" then
                table.insert(BankMenu.Menu["compte courant "].b, {name = "Compte Bancaire : ~g~" .. v.money .. "$", action = "null"})
                break
            end
          end
          table.insert(BankMenu.Menu["compte courant "].b, {name = "Déposer de l'argent", action = "deposit", type = "bank", ask = "→", askX = true})
          table.insert(BankMenu.Menu["compte courant "].b, {name = "Retirer de l'argent", action = "withdraw", type = "bank", ask = "→", askX = true})
          OpenMenu('compte courant ')
        elseif btn.action == "society" then
          BankMenu.Menu["compte société"].b = {}
          if ESX.PlayerData.job.grade_name == 'boss' then
            table.insert(BankMenu.Menu["compte société"].b, {name = "Compte Entreprise : ~g~" .. societymoney .. "$", action = "null"})
            table.insert(BankMenu.Menu["compte société"].b, {name = "Déposer de l'argent", action = "depositsociety", type = "society", ask = "→", askX = true})
            table.insert(BankMenu.Menu["compte société"].b, {name = "Retirer de l'argent", action = "withdrawsociety", type = "society", ask = "→", askX = true})
            end
          OpenMenu('compte société')
        end
      end
    },
  
    Menu = {
      ["menu principal"] = {
        b = {}
      },
      ["compte courant "] = {
        b = {}
      },
      ["compte société"] = {
        b = {}
      }
    }
  }
  if ESX.PlayerData.job.grade_name == 'boss' then
  table.insert(BankMenu.Menu["menu principal"].b, {name = "Compte Entreprise", action = "society", ask = "→", askX = true})
  end
  table.insert(BankMenu.Menu["menu principal"].b, {name = "Compte Courant", action = "bank", ask = "→", askX = true})
  
  
  CreateMenu(BankMenu)
  
  end
  Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        local pedCoords = GetEntityCoords(PlayerPedId()) -- Récupère les coordonnées du joueur
        local isInMarker = false
        local letSleep = true

        for k, v in pairs(banks) do
            local distance = GetDistanceBetweenCoords(pedCoords, v.x, v.y, v.z, true)

            if distance < 10 then
                letSleep = false

           
               

                if distance < 2.5 then
                  DrawMarker(ZiZouConfig.Marker.Markers.Marker.type, v.x, v.y, v.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ZiZouConfig.Marker.Markers.Marker.x, ZiZouConfig.Marker.Markers.Marker.y, ZiZouConfig.Marker.Markers.Marker.z, ZiZouConfig.Marker.Markers.Marker.r, ZiZouConfig.Marker.Markers.Marker.g, ZiZouConfig.Marker.Markers.Marker.b, ZiZouConfig.Marker.Markers.Marker.a, ZiZouConfig.Marker.Markers.Marker.rotate, false, 2, false, nil, nil, false)

              --    DrawMarker(1, v.x, v.y, v.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 0.5, 0, 255, 0, 100, false, false, 2, false, nil, nil, false)
                    isInMarker = true
                    HasAlreadyEnteredMarker = true

                    if not MenuOpen then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour accéder à votre compte bancaire.")
                    end

                    if IsControlJustPressed(1, 38) then
                        MenuOpen = true
                        OpenBankMenu()
                    end
                end
            end
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            MenuOpen = false
            CloseMenu()
        end

        if letSleep then
            Citizen.Wait(5000)
        end
    end
end)

