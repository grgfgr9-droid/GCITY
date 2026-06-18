

-- Generated with AltTool

fx_version 'bodacious'
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

game { 'gta5' }
this_is_a_map 'yes'


server_script {
	'maintenance.lua'
  }

files {


'peds.meta',

  'data/**/*.meta',

  'data/*.dat',
  'data/*.meta',

	'ocean_h_timecycle.xml',
--- 1 ---
  'mp_m_freemode_01_mp_m_clth1.meta',
  'mp_f_freemode_01_mp_f_clth1.meta',
  'stream/vetements/1/pedalternatevariations.meta',
--- 2 ---

  'mp_m_freemode_01_mp_m_clth2.meta',
  'mp_f_freemode_01_mp_f_clth2.meta',
  'stream/vetements/2/pedalternatevariations.meta',

  --- 3 ---
  'mp_m_freemode_01_mp_m_clth3.meta',
  'mp_f_freemode_01_mp_f_clth3.meta',
  'stream/vetements/3/pedalternatevariations.meta',

  --- 4 --- 

  'mp_f_freemode_01_mp_f_clth4.meta',
  'stream/vetements/4/pedalternatevariations.meta',
}

data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

data_file 'DLC_ITYP_REQUEST' 'stream/mapping//lspd vespucci/vesp_props.ytyp'
-- 1

data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_m_freemode_01_mp_m_clth1.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_f_freemode_01_mp_f_clth1.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'stream/vetements/1/pedalternatevariations.meta'
-- 2
data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_m_freemode_01_mp_m_clth2.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_f_freemode_01_mp_f_clth2.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'stream/vetements/2/pedalternatevariations.meta'
-- 3
data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_m_freemode_01_mp_m_clth3.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_f_freemode_01_mp_f_clth3.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'stream/vetements/3/pedalternatevariations.meta'
-- 4
data_file 'SHOP_PED_APPAREL_META_FILE' 'mp_f_freemode_01_mp_f_clth4.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'stream/vetements/4/pedalternatevariations.meta'


files({
	'data/**/carcols.meta',
	'data/**/carvariations.meta',
	'data/**/contentunlocks.meta',
	'data/**/handling.meta',
	'data/**/vehiclelayouts.meta',
	'data/**/vehicles.meta',

  'audioconfig/ferrarif140fe_game.dat151.rel',
  'audioconfig/ferrarif140fe_sounds.dat54.rel',

  'audioconfig/b58b30_game.dat151.rel',
  'audioconfig/b58b30_sounds.dat54.rel',
  'sfx/dlc_b58b30/b58b30.awc',
  'sfx/dlc_b58b30/b58b30_npc.awc',

  'audioconfig/ea825_game.dat151.rel',
  'audioconfig/ea825_sounds.dat54.rel',
  'sfx/dlc_ea825/ea825.awc',
  'sfx/dlc_ea825/ea825_npc.awc',

  'audioconfig/bmws702_game.dat151.rel',
  'audioconfig/bmws702_sounds.dat54.rel',
  'sfx/dlc_bmws702/bmws702.awc',
  'sfx/dlc_bmws702/bmws702_npc.awc',

  'audioconfig/brabus850_game.dat151.rel',
  'audioconfig/brabus850_sounds.dat54.rel',
  'sfx/dlc_brabus850/brabus850.awc',
  'sfx/dlc_brabus850/brabus850_npc.awc',

  'audioconfig/lg67koagerars_game.dat151.rel',
  'audioconfig/lg67koagerars_sounds.dat54.rel',

  'sfx/dlc_aston59v12/aston59v12.awc',
  'sfx/dlc_aston59v12/aston59v12_npc.awc',

  'audioconfig/srtvipeng_amp.dat10.rel',
  'audioconfig/srtvipeng_game.dat151.rel',
  'audioconfig/srtvipeng_sounds.dat54.rel',

  "audioconfig/*.dat151.rel",
	"audioconfig/*.dat54.rel",
	"audioconfig/*.dat10.rel",
	"sfx/**/*.awc",

  'audio/dlc_argento/*.awc',
	'audio/dlc_gresleyh/*.awc',
	'audio/dlc_scharmann/*.awc',
	'audio/dlc_scharmannv8/*.awc',
	'audio/dlc_scharmannv8/*.awc',
	'audio/dlc_nspeedo/*.awc',

	'audio/nspeedo_game.dat151',
	'audio/nspeedo_game.dat151.nametable',
	'audio/nspeedo_game.dat151.rel',
	'audio/nspeedo_sounds.dat54',
	'audio/nspeedo_sounds.dat54.nametable',
	'audio/nspeedo_sounds.dat54.rel',

	'audio/scharmann_amp.dat10.rel',
	'audio/scharmann_game.dat151.rel',
	'audio/scharmann_sounds.dat54.rel',
	'audio/scharmannv8_game.dat151.rel',
	'audio/scharmannv8_sounds.dat54.rel',

	'audio/gresleyh_amp.dat10',
	'audio/gresleyh_amp.dat10.nametable',
	'audio/gresleyh_amp.dat10.rel',
	'audio/gresleyh_game.dat151',
	'audio/gresleyh_game.dat151.nametable',
	'audio/gresleyh_game.dat151.rel',
	'audio/gresleyh_sounds.dat54',
	'audio/gresleyh_sounds.dat54.nametable',
	'audio/gresleyh_sounds.dat54.rel',

	'audio/buffaloh_game.dat151',
	'audio/buffaloh_game.dat151.nametable',
	'audio/buffaloh_game.dat151.rel',
	'audio/buffaloh_sounds.dat54',
	'audio/buffaloh_sounds.dat54.nametable',
	'audio/buffaloh_sounds.dat54.rel',
	'audio/argento_game.dat151.rel',
	'audio/argento_sounds.dat54.rel',

	'data/*.meta',
	'data/*.dat',
	'meta/**/*.meta',

})

data_file('CONTENT_UNLOCKING_META_FILE')('data/**/contentunlocks.meta')
data_file('HANDLING_FILE')('data/**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
data_file('CARCOLS_FILE')('data/**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('data/**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('data/**/vehiclelayouts.meta')


data_file('HANDLING_FILE')('data/**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
data_file('CARCOLS_FILE')('data/**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('data/**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('data/**/vehiclelayouts.meta')
data_file('CONTENT_UNLOCKING_META_FILE')('data/**/contentunlocks.meta')
data_file 'AUDIO_GAMEDATA' 'audioconfig/ea825_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ea825_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ea825'
data_file 'AUDIO_GAMEDATA' 'audioconfig/b58b30_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/b58b30_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_b58b30'
data_file "AUDIO_SYNTHDATA" "audioconfig/dghmieng_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/dghmieng_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/dghmieng_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_dghmieng"
data_file 'AUDIO_GAMEDATA' 'audioconfig/ferrarif140fe_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ferrarif140fe_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ferrarif140fe'
data_file 'AUDIO_GAMEDATA' 'audioconfig/bmws702_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/bmws702_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_bmws702'
data_file "AUDIO_SYNTHDATA" "audioconfig/lg67koagerars_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lg67koagerars_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg67koagerars_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg67koagerars"
data_file 'AUDIO_GAMEDATA' 'audioconfig/brabus850_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/brabus850_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_brabus850'
data_file "AUDIO_SYNTHDATA" "audioconfig/srtvipeng_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/srtvipeng_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/srtvipeng_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_srtvipeng"
data_file "AUDIO_SYNTHDATA" "audioconfig/lg125mnsrybently_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lg125mnsrybently_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg125mnsrybently_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg125mnsrybently"
data_file 'AUDIO_GAMEDATA' 'audioconfig/aston59v12_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/aston59v12_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_aston59v12'
data_file 'AUDIO_GAMEDATA' 'audioconfig/m297zonda_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/m297zonda_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_m297zonda'
data_file 'AUDIO_GAMEDATA' 'audioconfig/alfa690t_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/alfa690t_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_alfa690t'
data_file 'AUDIO_GAMEDATA' 'audioconfig/lg115classicf1v10_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/lg115classicf1v10_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_lg115classicf1v10'


data_file 'WEAPONCOMPONENTSINFO_FILE' 'data/weaponcomponents*.meta'
data_file 'WEAPON_METADATA_FILE' 'data/weaponarchetypes*.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/weaponanimations*.meta'
data_file 'WEAPONINFO_FILE' 'data/weapon_*.meta'
data_file 'WEAPONINFO_FILE' 'data/weapons_*.meta'
data_file 'PED_PERSONALITY_FILE' 'data/pedpersonality*.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/patch_*.meta'

data_file 'EXPLOSION_INFO_FILE' 'explosion.meta'
data_file 'EXPLOSIONFX_FILE' 'data/explosionfx.dat'

data_file 'LOADOUTS_FILE' 'data/loadouts*.meta'
data_file 'DLC_WEAPON_PICKUPS' 'data/pickups*.meta'
data_file 'PTFXASSETINFO_FILE' 'data/ptfxassetinfo*.meta'


---

data_file 'WEAPONCOMPONENTSINFO_FILE' 'data/**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'data/**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'data/**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'data/**/weapons.meta'

client_script 'client/cl_weaponNames.lua'



data_file 'HANDLING_FILE' '**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' '**/vehicles.meta'
data_file 'CARCOLS_FILE' '**/carcol*.meta'
data_file 'VEHICLE_VARIATION_FILE' '**/carvariation*.meta'
data_file 'VEHICLE_LAYOUTS_FILE' '**/*layout*.meta'

data_file 'EXPLOSIONFX_FILE' 'data/explosionfx.dat'
data_file 'EXPLOSION_INFO_FILE' 'data/explosion.meta'
data_file 'PTFXASSETINFO_FILE' 'data/ptfxassetinfo.meta'
data_file 'SCRIPTFX_FILE' 'data/scriptfx.dat'
data_file 'VEHICLE_METADATA_FILE' 'data/weaponarchetypes.meta'
data_file 'WEAPONINFO_FILE' 'data/weapons.meta'

data_file 'AUDIO_GAMEDATA' 'audio/scharmann_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/scharmannv8_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/scharmann_sounds.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/scharmannv8_sounds.dat'

data_file 'AUDIO_GAMEDATA' 'audio/nspeedo_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/nspeedo_sounds.dat'

data_file 'AUDIO_GAMEDATA' 'audio/gresleyh_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/gresleyh_sounds.dat'
data_file 'AUDIO_SYNTHDATA' 'audio/gresleyh_amp.dat'

data_file 'AUDIO_GAMEDATA' 'audio/argento_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/argento_sounds.dat'

data_file 'AUDIO_GAMEDATA' 'audio/buffaloh_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/buffaloh_sounds.dat'

data_file 'AUDIO_WAVEPACK' 'audio/dlc_argento'
data_file 'AUDIO_WAVEPACK' 'audio/dlc_gresleyh'
data_file 'AUDIO_WAVEPACK' 'audio/dlc_nspeedo'
data_file 'AUDIO_WAVEPACK' 'audio/dlc_scharmann'
data_file 'AUDIO_WAVEPACK' 'audio/dlc_scharmannv8'