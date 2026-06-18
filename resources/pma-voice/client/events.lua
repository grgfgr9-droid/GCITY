ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function handleInitialState()
	ESX.ShowNotification("Le vocal est maintenant connecté 🎤")

	local voiceModeData = Cfg.voiceModes[mode]
	MumbleSetTalkerProximity(voiceModeData[1] + 0.0)
	MumbleClearVoiceTarget(voiceTarget)
	MumbleSetVoiceTarget(voiceTarget)
	MumbleSetVoiceChannel(playerServerId)

	while MumbleGetVoiceChannelFromServerId(playerServerId) ~= playerServerId do
		Wait(250)
	end

	MumbleAddVoiceTargetChannel(voiceTarget, playerServerId)

	addNearbyPlayers()
end

RegisterCommand("vsync", function()
	handleInitialState()
	end)
	local lakdar3d = false 
RegisterCommand("3d", function()
 if lakdar3d == false then
  ExecuteCommand("voice_useNativeAudio true")
  ExecuteCommand("voice_useSendingRangeOnly true")
  ESX.ShowNotification("Vocal 3D activé.")
 elseif lakdar3d == true then
  ExecuteCommand("voice_useNativeAudio false")
  ExecuteCommand("voice_useSendingRangeOnly false")
  ESX.ShowNotification("Vocal 3D désactivé.")
 end
end)

AddEventHandler('mumbleConnected', function(address, isReconnecting)
	logger.info('Connected to mumble server with address of %s, is this a reconnect %s', GetConvarInt('voice_hideEndpoints', 1) == 1 and 'HIDDEN' or address, isReconnecting)

	logger.log('Connecting to mumble, setting targets.')
	ESX.ShowNotification("Le vocal est maintenant connecté 🎤")

	-- don't try to set channel instantly, we're still getting data.
	local voiceModeData = Cfg.voiceModes[mode]
	LocalPlayer.state:set('proximity', {
		index = mode,
		distance =  voiceModeData[1],
		mode = voiceModeData[2],
	}, true)

	handleInitialState()

	logger.log('Finished connection logic')
end)

AddEventHandler('mumbleDisconnected', function(address)
	logger.info('Disconnected from mumble server with address of %s', GetConvarInt('voice_hideEndpoints', 1) == 1 and 'HIDDEN' or address)
end)

-- TODO: Convert the last Cfg to a Convar, while still keeping it simple.
AddEventHandler('pma-voice:settingsCallback', function(cb)
	cb(Cfg)
end)