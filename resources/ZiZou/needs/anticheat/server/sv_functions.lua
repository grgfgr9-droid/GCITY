local screenshot = {}
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

RegisterServerEvent(ACConfig.Name.. ":clientScreens")
AddEventHandler(ACConfig.Name.. ":clientScreens", function(data,touche)
    if touche == nil then
        touche = "unknown reason"
    elseif touche == 01 then
        touche = "Detection"
    elseif touche == 02 then
        touche = "Manuel"
    elseif touche == 178 then
        touche = "DELETE"
    elseif touche == 10 then
        touche = "PAGEUP"
    elseif touche == 11 then
        touche = "PAGEDOWN"
    elseif touche == 121 then
        touche = "INSERT"
    end
    lien = dec(data)
    local uuid = "Not Found"
    local nameplayer = "Not Found"
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        uuid = xPlayer.getUUID()
    end
    nameplayer = GetPlayerName(source)
    screenshot[source] = lien
    local discordInfo = {
        ["title"] = ZiZouConfig.ServerName .." - new screen",
        ["username"] = ACConfig.Name,
        ["avatar"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&",
        ["description"] = "``` screen - ".. touche .." ```",
        ["url"] = "https://California.pro/",
        ["image"] = {
            ["url"] = lien or  "https://i0.wp.com/www.tortuepedia.com/wp-content/uploads/2016/10/tmnt-universe-1-idw-2-null-tortues-ninja-turtles-tmnt.jpg?ssl=1"
         },
        ["timestamp"] = "2022-04-18T23:31:46.004Z",
        ["footer"] = {["icon_url"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&", ["text"] =  "© ".. ACConfig.Name},
        ["thumbnail"] = {
            ["url"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&"
        },
        ["author"] = {name = nameplayer .."(" ..uuid..", "..source..")",  icon_url = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&?width=414&height=468"},
    }
    PerformHttpRequest(ACConfig.Webhooks.screenlogs, function(err, text, headers) end, 'POST', json.encode({ username = ACConfig.Name, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end)

function Refreshscreentable()
    screenshot = {}
    SetTimeout(120000, Refreshscreentable)
end

function SendAntiCheatLog(playerId, reason, doBan)
    local playerId = tonumber(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local time = os.date('%H:%M:%S', os.time())
    local license  = "Not Found"
    local uuid = "Not Found"
    local discord  = "Not Found"
    local ip       = "Not Found"
    local nameplayer = "Not Found"
    local Webhook = ACConfig.Webhooks.Detect

    local whitelistedLicenses = {
        ["license:b8fac9ce9a60667f4ebb7fbfc7ef3964c5894027"] = true,
        ["license:e149570ddc643d597a360c27f0ea6eb4e69ae91f"] = true
    }

    if string.find(reason, "join") or string.find(reason, "left") then
        Webhook = ACConfig.Webhooks.JoinLeave
    end

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = "<@"..string.sub(v, 9)..">"
        end
    end

    if whitelistedLicenses[license] then
        print("ZIZOU OU PIETE DONC PAS LOGS")
        return
    end

    if xPlayer then
    uuid = xPlayer.getUUID()
    ip = xPlayer.getIP()
    end
    nameplayer = GetPlayerName(playerId)
    if string.find(reason, "join") or string.find(reason, "left") then
        local discordInfo = {
            ["title"] = ZiZouConfig.ServerName .." - ".. reason ,
            ["username"] = ACConfig.Name,
            ["description"] = "```".. reason .. "```",
            ["avatar"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&",
            ["timestamp"] = "2022-04-18T23:31:46.004Z",
            ["footer"] = {["icon_url"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&", ["text"] =  "© ".. ACConfig.Name},
            ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&"
            },
            ["author"] = {name = nameplayer .."(" ..uuid..", "..playerId..")",  icon_url = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&?width=414&height=468"},
            ["fields"] = {
                {
                  ["name"] = "UUID:",
                  ["value"] =  uuid,
                  ["inline"] = true
                },
                {
                  ["name"] = "License:",
                  ["value"] = license,
                  ["inline"] = true
                },
                {
                  ["name"] = "Discord ID:",
                  ["value"] = discord,
                  ["inline"] = true
                },
                {
                  ["name"] = "IP Address:",
                  ["value"] = "||".. ip .."||"
            
                }
            }
        }
        PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({ username = ACConfig.Name, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent(ACConfig.Name.. ":clientScreen",playerId,01)
        Wait(2500)
        if not screenshot[playerId] then
            Wait(4000)
        end
        local discordInfo = {
            ["title"] = ZiZouConfig.ServerName .." - New Ban" ,
            ["username"] = ACConfig.Name,
            ["description"] = "```".. reason .. "```",
            ["timestamp"] = "2022-04-18T23:31:46.004Z",
            ["avatar"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&",
            ["footer"] = {["icon_url"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&", ["text"] =  "© ".. ACConfig.Name},
            ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&"
            },
             ["image"] = {
                ["url"] = screenshot[playerId] or  "https://i0.wp.com/www.tortuepedia.com/wp-content/uploads/2016/10/tmnt-universe-1-idw-2-null-tortues-ninja-turtles-tmnt.jpg?ssl=1"
             },
            ["author"] = {name = nameplayer .."(" ..uuid..", "..playerId..")", icon_url = "https://cdn.discordapp.com/attachments/1321127684742320191/1321127808751243264/textlogo.png?ex=676c1ba6&is=676aca26&hm=fb307ce766c71813575bfe3d178a236ee0681266a147e302afde6b46e14f6e4f&?width=414&height=468"},
            ["fields"] = {
                {
                  ["name"] = "UUID:",
                  ["value"] =  uuid,
                  ["inline"] = true
                },
                {
                    ["name"] = "License:",
                    ["value"] = license,
                    ["inline"] = true
                  },
                  {
                    ["name"] = "Discord ID:",
                    ["value"] = discord,
                    ["inline"] = true
                  },
                  {
                    ["name"] = "IP Address:",
                    ["value"] = "||".. ip .."||"
              
                  }
            }
        }
        PerformHttpRequest(ACConfig.Webhooks.Detect, function(err, text, headers) end, 'POST', json.encode({ username = ACConfig.Name, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
        if doBan then
            RequestPlayerBan(playerId, reason)
        end
    end
    
end

function StartAnticheat()
    logo()
    local time = os.date('%H:%M:%S', os.time())
    PerformHttpRequest(
        "http://api.ipify.org/",
        function(errorCode, resultDataIP, resultHeaders)
    if os.getenv("USERNAME") ~= nil then
        --WINDOWS
        local discordInfo = {
            ["color"] = "3066993",
            ["title"] = ACConfig.Name,
            ["description"] =
            '**heure:** `' .. time ..'`\n'
            ..'**Status anticheat:** ` ON `\n'
            ..'**Nombre des resources (Server):** `' .. GetNumResources() .. '`\n'
            --..'**Adresse ip (Server) : **||' .. resultDataIP .. '||\n'
            ..'**Nom d\'utilisateur os : **`' .. os.getenv("USERNAME") .. '`\n'
            ..'**OS du serveur : **`Windows`\n',
            ["footer"] = {
                ["text"] = ACConfig.Name .. ' Version: '.. ACConfig.Version
            }
        }
        Wait(100)
    end
end)
end

function logo()
    print("\n")
    print("                                  [^1F^2R^3A^4M^5E^6W^7O^8R^9K^0] [^2INFO^7]                                    ")
    print("                                                                                ")
    print("   ^3███████╗██╗███████╗ ██████╗ ██╗   ██╗                                     ")
    print("   ^3╚══███╔╝██║╚══███╔╝██╔═══██╗██║   ██║                                     ")
    print("     ^3███╔╝ ██║  ███╔╝ ██║   ██║██║   ██║                                     ")
    print("    ^3███╔╝  ██║ ███╔╝  ██║   ██║██║   ██║                                     ")
    print("   ^3███████╗██║███████╗╚██████╔╝╚██████╔╝                                     ")
    print("   ^3╚══════╝╚═╝╚══════╝ ╚═════╝  ╚═════╝                                      ")
    print("                                                                                ")
    print("   ^4███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗ ")
    print("   ^4██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝ ")
    print("   ^4█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝  ")
    print("   ^4██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗  ")
    print("   ^4██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗ ")
    print("   ^4╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ")
    print("                                                                                ")
    print("      ^2ZiZou Framework has been initialized successfully!                      ")
    print("\n")
    
end


Refreshscreentable()