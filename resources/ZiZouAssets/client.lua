local isUiOpen = false 
local isTalking = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
	while true do
	 Citizen.Wait(500)
	 if isTalking == false then
	   if NetworkIsPlayerTalking(PlayerId()) then
		 isTalking = true
		 SendNUIMessage({
		   displayWindow = "true"
		 })
		 isUiOpen = true
	   end
	 else
	   if NetworkIsPlayerTalking(PlayerId()) == false then
		 isTalking = false
		 SendNUIMessage({
		   displayWindow = "false"
		 })
		 isUiOpen = true
	   end
	 end
	end
   end)



   ---vocal 


   --local voice = {default = 5.0, shout = 10.0, whisper = 2.0, current = 0}
local voice = {default = 2.0, shout = 5.0, whisper = 1.0, current = 0}

local phoneTargets = {}
local radioTargets = {}
local registeredPlayers = {}

local CurrentGrid = 0
local CurrentRadio = 0

local isUiOpen = false 
local isTalking = false





function initializeMumbleConfig(forced)
  --NetworkSetTalkerProximity(voice.default)
  MumbleSetVoiceTarget(0)
  MumbleClearVoiceTarget(1)
  MumbleSetVoiceTarget(1)

  currentGrid = 0
  intervalGrid()



  ESX.ShowNotification("Le vocal est maintenant connecté 🎤")
end

function initializeMumble()
  initializeMumbleConfig(false)
  CreateThread(function()
   while true do
    Citizen.Wait(1000)
    intervalGrid()
   end
  end)
end

function getGridZoneVoice()
	local pos = GetEntityCoords(PlayerPedId(), false)
	local zoneRadius = 128
	return 100 + math.ceil((pos.x + pos.y) / (zoneRadius))
end

function intervalGrid()
  local newGrid = getGridZoneVoice()
  if newGrid ~= currentGrid then
    currentGrid = newGrid
		MumbleClearVoiceTargetChannels(1)
		NetworkSetVoiceChannel(currentGrid)
		MumbleAddVoiceTargetChannel(1, currentGrid)
  end
end

function addPlayerToVoiceTarget(serverId)
  serverId = tonumber(serverId)
  if not serverId or serverId == -1 then return end

  if not registeredPlayers[serverId] then
    registeredPlayers[serverId] = true
    MumbleAddVoiceTargetPlayerByServerId(1, serverId)
  end
end

function setVoiceTargets()
  registeredPlayers = {}

  MumbleClearVoiceTarget(1)
  MumbleAddVoiceTargetChannel(1, currentGrid)

  for serverId, _ in pairs(phoneTargets) do
    addPlayerToVoiceTarget(serverId)
  end

  for serverId,_ in pairs(radioTargets) do
    addPlayerToVoiceTarget(serverId)
  end
end

function togglePhoneTarget(playerServerId, enabled)
  playerServerId = tonumber(playerServerId)
  print(playerServerId)
  if playerServerId == nil then return end
  if enabled then
      MumbleSetVolumeOverrideByServerId(playerServerId, 0.5)
      addPlayerToVoiceTarget(playerServerId)
      phoneTargets[playerServerId] = true
  else
      MumbleSetVolumeOverrideByServerId(playerServerId, -1.0)
      phoneTargets[playerServerId] = nil
      setVoiceTargets()
  end
end

function switchVoiceMode()
  voice.current = (voice.current + 1) % 3
  if voice.current == 0 then
	Citizen.CreateThread(function()
		local i = 0
		while i < 15 do
			Citizen.Wait(0)
			i = i + 1
			DrawMarker(1, GetEntityCoords(PlayerPedId()) - vector3(0, 0, 0.9), 0, 0, 0, 0, 0, 0, 2.0 * 2.0, 2.0 * 2.0, 0.8001, 0, 75, 255, 80, 0,0, 0,0)
		end
	end)
    --NetworkSetTalkerProximity(voice.default)
    MumbleSetAudioInputDistance(voice.default)
    ESX.ShowNotification("L'intensité de votre voix est maintenant sur ~g~normal~s~.")
  elseif voice.current == 1 then
	Citizen.CreateThread(function()
		local i = 0
		while i < 15 do
			Citizen.Wait(0)
			i = i + 1
			DrawMarker(1, GetEntityCoords(PlayerPedId()) - vector3(0, 0, 0.9), 0, 0, 0, 0, 0, 0, 5.0 * 2.0, 5.0 * 2.0, 0.8001, 0, 75, 255, 80, 0,0, 0,0)
		end
	end)
    --NetworkSetTalkerProximity(voice.shout)
    MumbleSetAudioInputDistance(voice.shout)
    ESX.ShowNotification("L'intensité de votre voix est maintenant sur ~r~crier~s~.")
  elseif voice.current == 2 then
	Citizen.CreateThread(function()
		local i = 0
		while i < 15 do
			Citizen.Wait(0)
			i = i + 1
			DrawMarker(1, GetEntityCoords(PlayerPedId()) - vector3(0, 0, 0.9), 0, 0, 0, 0, 0, 0, 1.0 * 2.0, 1.0 * 2.0, 0.8001, 0, 75, 255, 80, 0,0, 0,0)
		end
	end)
    --NetworkSetTalkerProximity(voice.whisper)
    MumbleSetAudioInputDistance(voice.whisper)
    ESX.ShowNotification("L'intensité de votre voix est maintenant sur ~b~chuchoter~s~.")
  end
end



function MutePlayerAdmin(value)
  if value == true then
    MumbleSetServerAddress("127.0.0.1", 64738)
  elseif value == false then
    local Port = string.sub(GetCurrentServerEndpoint(), -4)
    local IP = string.sub(GetCurrentServerEndpoint(), 1)
    local IPFinal = IP:gsub(":"..Port, "")
    MumbleSetServerAddress("217.144.154.13", 22021)
  end
end


CreateThread(function()
 while ESX == nil do
  Citizen.Wait(500)
 end

 while not ESX.IsPlayerLoaded() do
  Citizen.Wait(500)
 end

 MumbleSetAudioInputDistance(2.0)
 MumbleSetAudioOutputDistance(5.0)

 MumbleSetServerAddress("217.144.154.13", 22021)

 while not MumbleIsConnected() do
  Citizen.Wait(250)
 end

 Citizen.Wait(5000)
 initializeMumble()
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

RegisterCommand("vsync", function()
initializeMumbleConfig(true)
end)

RegisterCommand("switchVoiceModeGM", function()
 switchVoiceMode() 
end, false)

RegisterKeyMapping("switchVoiceModeGM", "Changer l'intensité de votre voix", "keyboard", "f9")