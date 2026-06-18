AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

Citizen.CreateThread(function()
    local r = ZiZouConfig.rgbColor.r
    local g = ZiZouConfig.rgbColor.g
    local b = ZiZouConfig.rgbColor.b
    local a = 255 -- Opacité (alpha), vous pouvez le modifier si nécessaire

    ReplaceHudColourWithRgba(
        116, -- old Color
        r,   -- R
        g,   -- G
        b,   -- B
        a    -- A
    )
end)

