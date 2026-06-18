local requestedIpl = {"h4_islandairstrip", "h4_islandairstrip_props", "h4_islandx_mansion", "h4_islandx_mansion_props", "h4_islandx_props", "h4_islandxdock", "h4_islandxdock_props", "h4_islandxdock_props_2", "h4_islandxtower", "h4_islandx_maindock", "h4_islandx_maindock_props", "h4_islandx_maindock_props_2", "h4_IslandX_Mansion_Vault", "h4_islandairstrip_propsb", "h4_beach", "h4_beach_props", "h4_beach_bar_props", "h4_islandx_barrack_props", "h4_islandx_checkpoint", "h4_islandx_checkpoint_props", "h4_islandx_Mansion_Office", "h4_islandx_Mansion_LockUp_01", "h4_islandx_Mansion_LockUp_02", "h4_islandx_Mansion_LockUp_03", "h4_islandairstrip_hangar_props", "h4_IslandX_Mansion_B", "h4_islandairstrip_doorsclosed", "h4_Underwater_Gate_Closed", "h4_mansion_gate_closed", "h4_aa_guns", "h4_IslandX_Mansion_GuardFence", "h4_IslandX_Mansion_Entrance_Fence", "h4_IslandX_Mansion_B_Side_Fence", "h4_IslandX_Mansion_Lights", "h4_islandxcanal_props", "h4_beach_props_party", "h4_islandX_Terrain_props_06_a", "h4_islandX_Terrain_props_06_b", "h4_islandX_Terrain_props_06_c", "h4_islandX_Terrain_props_05_a", "h4_islandX_Terrain_props_05_b", "h4_islandX_Terrain_props_05_c", "h4_islandX_Terrain_props_05_d", "h4_islandX_Terrain_props_05_e", "h4_islandX_Terrain_props_05_f", "H4_islandx_terrain_01", "H4_islandx_terrain_02", "H4_islandx_terrain_03", "H4_islandx_terrain_04", "H4_islandx_terrain_05", "H4_islandx_terrain_06", "h4_ne_ipl_00", "h4_ne_ipl_01", "h4_ne_ipl_02", "h4_ne_ipl_03", "h4_ne_ipl_04", "h4_ne_ipl_05", "h4_ne_ipl_06", "h4_ne_ipl_07", "h4_ne_ipl_08", "h4_ne_ipl_09", "h4_nw_ipl_00", "h4_nw_ipl_01", "h4_nw_ipl_02", "h4_nw_ipl_03", "h4_nw_ipl_04", "h4_nw_ipl_05", "h4_nw_ipl_06", "h4_nw_ipl_07", "h4_nw_ipl_08", "h4_nw_ipl_09", "h4_se_ipl_00", "h4_se_ipl_01", "h4_se_ipl_02", "h4_se_ipl_03", "h4_se_ipl_04", "h4_se_ipl_05", "h4_se_ipl_06", "h4_se_ipl_07", "h4_se_ipl_08", "h4_se_ipl_09", "h4_sw_ipl_00", "h4_sw_ipl_01", "h4_sw_ipl_02", "h4_sw_ipl_03", "h4_sw_ipl_04", "h4_sw_ipl_05", "h4_sw_ipl_06", "h4_sw_ipl_07", "h4_sw_ipl_08", "h4_sw_ipl_09", "h4_islandx_mansion", "h4_islandxtower_veg", "h4_islandx_sea_mines", "h4_islandx", "h4_islandx_barrack_hatch", "h4_islandxdock_water_hatch", "h4_beach_party"}

CreateThread(function()
	for i = #requestedIpl, 1, -1 do
		RequestIpl(requestedIpl[i])
		requestedIpl[i] = nil
	end
	requestedIpl = nil
end)



CreateThread(function()
	Wait(2500)
	local islandLoaded = false
	local islandCoords = vector3(4840.571, -5174.425, 2.0)
	SetDeepOceanScaler(0.0)
	while true do
		local pCoords = ESX.PlayerData.cache.coords
		if #(pCoords - islandCoords) < 2000.0 then
			if not islandLoaded then
				islandLoaded = true
				Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 1)
			end
		else
			if islandLoaded then
				islandLoaded = false
				Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 0)
			end
		end
		Wait(5000)
	end
end)

---------------------------------------------------------------------------------------
--			Arena Resource by Titch2000 You may edit but please keep credit.
---------------------------------------------------------------------------------------
-- config
local map = 1
local scene = "dystopian"


-- 		NO TOUCHING BELOW THIS POINT, NO HELP WILL BE OFFERED IF YOU DO.
---------------------------------------------------------------------------------------
local maps = {
	["dystopian"] = {
		"Set_Dystopian_01",
		"Set_Dystopian_02",
		"Set_Dystopian_03",
		"Set_Dystopian_04",
		"Set_Dystopian_05",
		"Set_Dystopian_06",
		"Set_Dystopian_07",
		"Set_Dystopian_08",
		"Set_Dystopian_09",
		"Set_Dystopian_10",
		"Set_Dystopian_11",
		"Set_Dystopian_12",
		"Set_Dystopian_13",
		"Set_Dystopian_14",
		"Set_Dystopian_15",
		"Set_Dystopian_16",
		"Set_Dystopian_17"
	},

	["scifi"] = {
		"Set_Scifi_01",
		"Set_Scifi_02",
		"Set_Scifi_03",
		"Set_Scifi_04",
		"Set_Scifi_05",
		"Set_Scifi_06",
		"Set_Scifi_07",
		"Set_Scifi_08",
		"Set_Scifi_09",
		"Set_Scifi_10"
	},

	["wasteland"] = {
		"Set_Wasteland_01",
		"Set_Wasteland_02",
		"Set_Wasteland_03",
		"Set_Wasteland_04",
		"Set_Wasteland_05",
		"Set_Wasteland_06",
		"Set_Wasteland_07",
		"Set_Wasteland_08",
		"Set_Wasteland_09",
		"Set_Wasteland_10"
	}
}


Citizen.CreateThread(function()
	-- New Arena : 2800.00, -3800.00, 100.00
	RequestIpl("xs_arena_interior")

	-- The below are additional interiors / maps relating to this DLC play around with them at your own risk and want.
	--RequestIpl("xs_arena_interior_mod")
	--RequestIpl("xs_arena_interior_mod_2")
	--RequestIpl("xs_arena_interior_vip") -- This is the interior bar for VIP's
	--RequestIpl("xs_int_placement_xs")
	--RequestIpl("xs_arena_banners_ipl")
	--RequestIpl("xs_mpchristmasbanners")
	--RequestIpl("xs_mpchristmasbanners_strm_0")

	-- Lets get and save our interior ID for use later
	local interiorID = GetInteriorAtCoords(2800.000, -3800.000, 100.000)

	-- now lets check the interior is ready if not lets just wait a moment
	if (not IsInteriorReady(interiorID)) then
		Wait(1)
	end
	-- We need to add the crowds as who does stuff on their own for nobody?
	EnableInteriorProp(interiorID, "Set_Crowd_A")
	EnableInteriorProp(interiorID, "Set_Crowd_B")
	EnableInteriorProp(interiorID, "Set_Crowd_C")
	EnableInteriorProp(interiorID, "Set_Crowd_D")

	-- now lets set our map type and scene.
	if (scene == "dystopian") then
		EnableInteriorProp(interiorID, "Set_Dystopian_Scene")
		EnableInteriorProp(interiorID, maps[scene][map])
	end
	if (scene == "scifi") then
		EnableInteriorProp(interiorID, "Set_Scifi_Scene")
		EnableInteriorProp(interiorID, maps[scene][map])
	end
	if (scene == "wasteland") then
		EnableInteriorProp(interiorID, "Set_Wasteland_Scene")
		EnableInteriorProp(interiorID, maps[scene][map])
	end
end)