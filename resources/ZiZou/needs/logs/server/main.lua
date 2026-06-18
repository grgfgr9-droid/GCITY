LogsConfig = {}

local AleardyJoinedPlayer = {}

LogsConfig.username = "ZiZou Logs"
LogsConfig.avatar = "https://cdn.discordapp.com/attachments/1314229874613031065/1335077270246658078/6f3d1d7878a49e9ac045a4fb30a02cdb-removebg-preview.png?ex=67a4c9d9&is=67a37859&hm=2c2b528695b877ee792cf2d1434c5424f61ac2bc758daf97729928dca2e35715&"
LogsConfig.webhooks = {
    ["joins"] = "https://discord.com/api/webhooks/1359911845825220759/xdOBolSTinCzeXwXzFO_fb4TITw1UFxR4vHvlpvXFiuBuCp8CCDy4PGyIbFMPOW-vPzb",
    ["leave"] = "https://discord.com/api/webhooks/1359911845825220759/xdOBolSTinCzeXwXzFO_fb4TITw1UFxR4vHvlpvXFiuBuCp8CCDy4PGyIbFMPOW-vPzb",
    ["deaths"] = "https://discord.com/api/webhooks/1359912353721880707/VpR-lb2HkgXsMPojgS858ypP-u95UHfuRUG317Se97tAdb51fX1libvXvhqmUcnLjRKB",
    ["money"] = "https://discord.com/api/webhooks/1359912518901960975/F_D0_R6E91YPhEdCA0NaOM_jqn_W0xJ1JButBqEBBcoN4ZKDXjNY0ibVDU2THQJqPxHE",
    ["billing"] = "https://discord.com/api/webhooks/1360599256314023946/Y9IrX7ViSp_bOVA_sdun4n6FXaYWlZgi915Atp3XeWii6lw59wQl_HwZkOBDdt-Srrov",
    ["weapons"] = "https://discord.com/api/webhooks/1360599368805253231/g1-oClfnBB8eDh0rzsPWHFra6IL_SdfIEnlCUjiUww-U6tMsDOIiWY8XDoq81wOG57o1",
    ["staff"] = "https://discord.com/api/webhooks/1360599590658773052/s9LySmymBPmERFr4rPmOXWx9NJOS_032A1DnH_7MQ5duoF12zJqKfyDgG-TaBXE6Jyjd",
    ["kick"] = "https://discord.com/api/webhooks/1359912730881949878/P07J9PtVkSTjrz7pn56olQX14MdSCJGkW9NmkcO4gBGA2i2-vUjuTXyFVkmW7RHxL_WI",

    ["jail"] = "https://discord.com/api/webhooks/1359912887979606107/BM3gwoULl59AfSm5qQxKYHnqZBmqZk8dAqt-gm5i0CVRadWWRYgDfByCfd7cg7CtCV2n",
    ["setgroup"] = "https://discord.com/api/webhooks/1359913004174672045/GJWCmHetEYE9YlLBW390gHtxh0uZZsPbmHBUVEVCq2STImPngO8UUVmrHKiobFCGPxZP",

    ["setjob"] = "https://discord.com/api/webhooks/1360600011255316671/b10EcEONjpZfwvqKT0iCIGQtzQx9hdvwtFVonPl8T87Hp-I0n2Ope3pSAEbEH--85zIC",
    ["givepermweapon"] = "https://discord.com/api/webhooks/1353804830652633191/tpTD0L4UJ3a3IddGalsEnsC4OGvdo2hLe0549WyYjoGZ-Y26VVdPOBWbB0-5FFYzI1hW",

    ["giveweapon"] = "https://discord.com/api/webhooks/1360600086924497088/KLOZP2AB6eBTESosi5_ib53zbZjyT5T5iHmPgnwIpQLrr_lgwyBRUFXEPI7gM_SEnjch",
    ["giveitem"] = "https://discord.com/api/webhooks/1360600451564961873/RTJlYFsO58Gl7_CUGuwWB0n5yI_p-wA5C7eQ1DojghUL9CNGFjZJehExJlleNcn9FtFt",




    ["wipeitem"] = "https://discord.com/api/webhooks/1360600578765357106/S4GctG3GfRhbF5C-iCAmQqUzTZ9AkRpOKMxQ06jScgCvS_X6rJGl2PFe1q3AfGyEf7-o",
    ["wipeweapon"] = "https://discord.com/api/webhooks/1360600578765357106/S4GctG3GfRhbF5C-iCAmQqUzTZ9AkRpOKMxQ06jScgCvS_X6rJGl2PFe1q3AfGyEf7-o",
    ["wipepermweapon"] = "https://discord.com/api/webhooks/1360600578765357106/S4GctG3GfRhbF5C-iCAmQqUzTZ9AkRpOKMxQ06jScgCvS_X6rJGl2PFe1q3AfGyEf7-o",

    ["spawnvehicle"] = "https://discord.com/api/webhooks/1360600711045447781/JKY0bSwiQsIPTRbKi2kR6jhgqbyb7Z2XeCyABtPu_tKEqr3ryenrPOytU7_C2ZaSwd3v",
    ["gofast_delivery"] = "https://discord.com/api/webhooks/1360600801076052251/-ffbs31s2Xdaa8FzAyLhKT8ABpUSNXEjuuaE1DlA14mDeKZsXb18J6LjADRyjv4oemT_",

    ["coffre"] = "https://discord.com/api/webhooks/1360600911533048048/iYSC3Vx04uJB6JiYH1eUo03YpH-VWrYPo0PcRhH7SXlIum7lQs7xYOBFBmITxujtpyo-",

    ["fouille"] = "https://discord.com/api/webhooks/1360600990482567208/MP5OV0AbyuOIVSVuBh7w-VGXkqhqTjbz09tF8VzlhPoAOORJn9fg3Ufgd-ekmSM73OYc",
    ["caisse"] = "https://discord.com/api/webhooks/1360601146128863382/tPysPi6kIzvv65s-kIVQ7_BT97inejX5CkQaYIEDxGCMYloDnIFEGtRfeXL8IFvM97Rw",

    ["holdup"] = "https://discord.com/api/webhooks/1360601417043279988/tKOkM7XHMC29Ccn2ysoKfFzqFvqse5zm4SFE_t_SAPuN2KKHXkROTXMBy9pvrpqJoBHb",
    ["store"] = "https://discord.com/api/webhooks/1360601591178334461/uP2d2DKvxlUrVLTi_JDK2EoPJGOTHY3lbVc4OxnzfTGbODeA46EXOHQKpgkElCGTWFmx",
    ["anticheat"] = "https://discord.com/api/webhooks/1360601665484492967/9UNwzEEzcYAwVc6H81lww53Aw9W_x0WNYLFh8sCcDP5MK_ugn6Vp3XjCcuKUva4T1Gr1"
}


function discordLog(channel, message)
      PerformHttpRequest(LogsConfig.webhooks[channel], function(err, text, headers) end, 'POST', json.encode({username = LogsConfig.username, content = "```".. message .. "```", avatar_url = LogsConfig.avatar}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('esx:sendLog')
AddEventHandler('esx:sendLog', function(channel, message)
    discordLog(channel, message)
end)

local deadPlayers = {}

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = data
end)

RegisterNetEvent('esx:playerDroppedData')
AddEventHandler('esx:playerDroppedData', function(source, reason, xPlayer)
	local playerPed = ESX.PlayerData.cache.playerped

	if xPlayer.IsDead then
		if reason == 'Disconnected.' or reason == 'Exiting' then
			discordLog('leave', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a quitté en étant mort.')
		else
			discordLog('leave', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a crash en étant mort.')
		end
	else 
		if reason == 'Disconnected.' or reason == 'Exiting' then
			discordLog('leave', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a quitté le serveur.')
		else
		    discordLog('leave', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a crash.')
		end
	end 
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(id,player,killer,DeathReason, Weapon)
	local xPlayer = ESX.GetPlayerFromId(player)
	local xKiller = ESX.GetPlayerFromId(killer)
	
	if id == 1 then  -- Suicide/died
        discordLog('deaths', GetPlayerName(player) .. " ( "  .. player .. ' - ' .. xPlayer.getUUID() .. " )".. ' s\'est suicidé.')
	elseif id == 2 then -- Killed by other player
	    discordLog('deaths', GetPlayerName(player) .. " ( "  .. player .. ' - ' .. xPlayer.getUUID() .. " )".. ' s\'est fait tuer par ' .. GetPlayerName(killer) .. " ( "  .. killer .. ' - ' .. xKiller.getUUID() .. " )")
	else -- When gets killed by something else
		discordLog('deaths', GetPlayerName(player) .. " ( "  .. player .. ' - ' .. xPlayer.getUUID() .. " )".. ' est mort.')
	end
end)