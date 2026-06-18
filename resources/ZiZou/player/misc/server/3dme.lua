RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	if rawCommand:sub(4) then
		if rawCommand:sub(4) == "<img src='img://OOF/UwU' heigh='1' width='1'/>" then return end
	TriggerClientEvent('3dme:trigger', -1, source, ('* %s *'):format(rawCommand:sub(4)))
	end
end, false)