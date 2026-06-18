Config.DefaultWeaponTints = {
	[0] = "skin par défaut",
	[1] = "skin vert",
	[2] = "skin or",
	[3] = "skin rose",
	[4] = "skin arpmée",
	[5] = "skin lspd",
	[6] = "skin orange",
	[7] = "skin platinium"
}

Config.Weapons = {
	{
		name = 'WEAPON_PISTOL',
		label = "pistolet",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_PISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_PISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')}
		}
	},
	{
		name = 'WEAPON_NAVYREVOLVER',
		label = "pistolet navy",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			
		}
	},
	{
		name = 'WEAPON_GADGETPISTOL',
		label = "pistolet cayo perico",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_PISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_PISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_COMBATPISTOL',
		label = "pistolet de combat",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_APPISTOL',
		label = "pistolet automatique",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_PISTOL50',
		label = "pistolet calibre 50",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SNSPISTOL',
		label = "pistolet sns",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_WOLFKNIFE',
		label = 'WOLFKNIFE',
		components = {
		}
	},

	{
		name = 'WEAPON_HKUMP',
		label = 'HK-UMP',
		components = {
		}
	},

	{
		name = 'WEAPON_PPSH41',
		label = 'PPSH41',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_PPSH41_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PPSH41_CLIP_02') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PPSH41_CLIP_03') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PPSH41_CLIP_04') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PPSH41_CLIP_05') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PPSH41_CLIP_03_V2') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PPSH41_CLIP_01_V3') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PPSH41_CLIP_02_V4') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_PPSH41_SUPP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_PPSH41_SUPP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_PPSH41_SUPP_04_V2') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_PPSH41_SUPP_04_V3') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_PPSH41_SUPP_04_V4') },
			{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_PPSH41_STOCK') },
			{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_PPSH41_STOCK2') },
			{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_PPSH41_STOCK3') },
			{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_PPSH41_STOCK4') },
			{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_PPSH41_STOCK5') },
			{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_PPSH41_STOCK6') },
			{ name = 'stock', label = "STOCK 7", hash = GetHashKey('COMPONENT_PPSH41_STOCK7') },
			{ name = 'stock', label = "STOCK 8", hash = GetHashKey('COMPONENT_PPSH41_STOCK8') },
			{ name = 'stock', label = "STOCK 9", hash = GetHashKey('COMPONENT_PPSH41_STOCK9') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_PPSH41_VARMOD_V2') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_PPSH41_VARMOD_V3') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_PPSH41_VARMOD_V4') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_PPSH41_VARMOD_V2_V2') },
			{ name = 'luxary_finish', label = "VARMOD6", hash = GetHashKey('COMPONENT_PPSH41_VARMOD_V3_V3') },
			{ name = 'luxary_finish', label = "VARMOD7", hash = GetHashKey('COMPONENT_PPSH41_VARMOD_V2_V4') },
			{ name = 'scope', label = "SCOPE V3", hash = GetHashKey('COMPONENT_AT_PPSH41_SCOPE_MEDIUMV3') },
			{ name = 'scope', label = "SCOPE V4", hash = GetHashKey('COMPONENT_AT_PPSH41_SCOPE_MEDIUMV4') }
		}
	},

	{
		name = 'WEAPON_HEAVYPISTOL',
		label = "pistolet lourd",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = "pistolet vintage",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = "pistolet mitrailleur",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{name = 'WEAPON_REVOLVER', label = "revolver", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_MARKSMANPISTOL', label = "pistolet marksman", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_DOUBLEACTION', label = "revolver double action", components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')}},

	{
		name = 'WEAPON_SMG',
		label = "smg",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_SMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_SMG_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_SMG_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = "smg d'assaut",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_MICROSMG',
		label = "micro smg",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_MINISMG',
		label = "mini smg",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MINISMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MINISMG_CLIP_02')}
		}
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = "arme de défense personnelle",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')}
		}
	},

	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = "fusil à pompe",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_SR_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = "carabine à canon scié",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = "carabine d\'assaut",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = "carabine bullpup",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = "fusil à pompe lourd",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{name = 'WEAPON_DBSHOTGUN', label = "fusil à pompe double canon", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')}},
	{name = 'WEAPON_AUTOSHOTGUN', label = "fusil à pompe automatique", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')}},
	{name = 'WEAPON_MUSKET', label = "mousquet", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SHOTGUN')}},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = "fusil d'assaut",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = "carabined'assaut",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02')},
			{name = 'clip_box', label = "chargeur très grande capacité", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = "fusil avancé",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = "carabine spéciale",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = "fusil bullpup",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW')}
		}
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = "fusil compact",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03')}
		}
	},

	{
		name = 'WEAPON_MG',
		label = "mitrailleuse",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MG_CLIP_02')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_MG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_COMBATMG',
		label = "mitrailleuse de combat",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = "balayeuse gusenberg",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02')},
		}
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = "fusil de sniper",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label = "lunette", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = "fusil de sniper lourd",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label = "lunette", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')}
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = "fusil marksman",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE')}
		}
	},

	{name = 'WEAPON_MINIGUN', label = "minigun", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_MINIGUN')}},
	{name = 'WEAPON_RAILGUN', label = "canon éléctrique", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RAILGUN')}},
	{name = 'WEAPON_STUNGUN', label = "tazer", tints = Config.DefaultWeaponTints, components = {}},
	{name = 'WEAPON_RPG', label = "lance-rocket", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "roquette(s)", hash = GetHashKey('AMMO_RPG')}},
	{name = 'WEAPON_HOMINGLAUNCHER', label = "lance tête-chercheuse", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "roquette(s)", hash = GetHashKey('AMMO_HOMINGLAUNCHER')}},
	{name = 'WEAPON_GRENADELAUNCHER', label = "lance-grenade", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "grenade(s)", hash = GetHashKey('AMMO_GRENADELAUNCHER')}},
	{name = 'WEAPON_COMPACTLAUNCHER', label = "lanceur compact", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "grenade(s)", hash = GetHashKey('AMMO_GRENADELAUNCHER')}},
	{name = 'WEAPON_FLAREGUN', label = "lance fusée de détresse", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "fusée(s)", hash = GetHashKey('AMMO_FLAREGUN')}},
	{name = 'WEAPON_FIREEXTINGUISHER', label = "extincteur", components = {}, ammo = {label = "charge(s)", hash = GetHashKey('AMMO_FIREEXTINGUISHER')}},
	{name = 'WEAPON_PETROLCAN', label = "jerrican d\'essence", components = {}, ammo = {label = "jerrican d\'essence", hash = GetHashKey('AMMO_PETROLCAN')}},
	{name = 'WEAPON_FIREWORK', label = "feu d\'artifice", components = {}, ammo = {label = "feu(x) d\'artifice", hash = GetHashKey('AMMO_FIREWORK')}},
	{name = 'WEAPON_FLASHLIGHT', label = "lampe torche", components = {}},
	{name = 'GADGET_PARACHUTE', label = "parachute", components = {}},
	{name = 'WEAPON_KNUCKLE', label = "poing américain", components = {}},
	{name = 'WEAPON_HATCHET', label = "hachette", components = {}},
	{name = 'WEAPON_MACHETE', label = "machette", components = {}},
	{name = 'WEAPON_SWITCHBLADE', label = "couteau à cran d\'arrêt", components = {}},
	{name = 'WEAPON_BOTTLE', label = "bouteille", components = {}},
	{name = 'WEAPON_DAGGER', label = "poignard", components = {}},
	{name = 'WEAPON_POOLCUE', label = "queue de billard", components = {}},
	{name = 'WEAPON_WRENCH', label = "clé", components = {}},
	{name = 'WEAPON_BATTLEAXE', label = "hache de combat", components = {}},
	{name = 'WEAPON_KNIFE', label = "couteau", components = {}},
	{name = 'WEAPON_NIGHTSTICK', label = "matraque", components = {}},
	{name = 'WEAPON_HAMMER', label = "marteau", components = {}},
	{name = 'WEAPON_BAT', label = "batte de Baseball", components = {}},
	{name = 'WEAPON_GOLESXLUB', label = "club de golf", components = {}},
	{name = 'WEAPON_CROWBAR', label = "pied de biche", components = {}},
	{name = 'WEAPON_STONE_HATCHET', label = "hachette en pierre", components = {}},
	{name = 'WEAPON_UNARMED', label = 'Unarmed', components = {}},
	

	{name = 'WEAPON_GRENADE', label = "grenade", components = {}, ammo = {label = "grenade(s)", hash = GetHashKey('AMMO_GRENADE')}},
	{name = 'WEAPON_SMOKEGRENADE', label = "grenade fumigène", components = {}, ammo = {label = "bombe(s)", hash = GetHashKey('AMMO_SMOKEGRENADE')}},
	{name = 'WEAPON_STICKYBOMB', label = "bombe collante", components = {}, ammo = {label = "bombe(s)", hash = GetHashKey('AMMO_STICKYBOMB')}},
	{name = 'WEAPON_PIPEBOMB', label = "bombe tuyau", components = {}, ammo = {label = "bombe(s)", hash = GetHashKey('AMMO_PIPEBOMB')}},
	{name = 'WEAPON_BZGAS', label = "grenade à gaz bz", components = {}, ammo = {label = "grenade(s)", hash = GetHashKey('AMMO_BZGAS')}},
	{name = 'WEAPON_MOLOTOV', label = "cocktail molotov", components = {}, ammo = {label = "cocktail(s)", hash = GetHashKey('AMMO_MOLOTOV')}},
	{name = 'WEAPON_PROXMINE', label = "mine de proximité", components = {}, ammo = {label = "mine(s)", hash = GetHashKey('AMMO_PROXMINE')}},
	{name = 'WEAPON_SNOWBALL', label = "boule de neige", components = {}, ammo = {label = "boule(s) de neige", hash = GetHashKey('AMMO_SNOWBALL')}},
	{name = 'WEAPON_BALL', label = "balle", components = {}, ammo = {label = "balle(s)", hash = GetHashKey('AMMO_BALL')}},
	{name = 'WEAPON_FLARE', label = "fusée de détresse", components = {}, ammo = {label = "fusée(s) éclairante(s)", hash = GetHashKey('AMMO_FLARE')}},

	{
		name = 'WEAPON_KATANA',
		label = ('Katana'),
		components = {}
	},
	{
		name = 'WEAPON_KATANA2',
		label = ('Katana2'),
		components = {}
	},
	{
		name = 'WEAPON_SPIKEDCLUB',
		label = ('Spikbatt'),
		components = {}
	},
	{
		name = 'WEAPON_KNIFE2',
		label = ('knife2'),
		components = {}
	},
	--pistolet
	{
		name = 'WEAPON_PISTOLBLACK',
		label = ('PISTOLBLACK'),
		components = {}
	},
	{
		name = 'WEAPON_PISTOLCALIBRE50',
		label = ('Pokemon_Orange'),
		components = {}
	},
	{
		name = 'WEAPON_PISTOLPOKA',
		label = ('Pokemon_Rouge'),
		components = {}
	},
	{
		name = 'WEAPON_PISTOLWHITE',
		label = ('PISTOLWHITE'),
		components = {}
	},
	{
		name = 'WEAPON_KERTUS',
		label = ('Kertus'),
		components = {}
	},
	{
		name = 'WEAPON_SCORPION',
		label = ('SCORPION'),
		components = {}
	},

	--sniper
	{
		name = 'WEAPON_BLACKSNIPER',
		label = ('Blacksniper'),
		components = {}
	},
	{
		name = 'WEAPON_RGXOPERATOR',
		label = ('RGXOPERATOR'),
		components = {}
	},
	{
		name = 'WEAPON_MARKSMANRIFLE2',
		label = ('MARKSMANRIFLE2'),
		components = {}
	},
	-- ak ect 
	{
		name = 'WEAPON_AKMK01',
		label = ('AkBleu'),
		components = {}
	},
	{
		name = 'WEAPON_ANIMEM4',
		label = ('animem4'),
		components = {}
	},
	{
		name = 'WEAPON_CARBINERIFLE2',
		label = ('Glishpop'),
		components = {}
	},
	{
		name = 'WEAPON_CARBINERIFLE3',
		label = ('RedWhite'),
		components = {}
	},
	{
		name = 'WEAPON_CARBINERIFLE4',
		label = ('BleuAR'),
		components = {}
	},
	{
		name = 'WEAPON_CARBINERIFLE5',
		label = ('GoldAR'),
		components = {}
	},
	{
		name = 'WEAPON_CARBINERIFLE6',
		label = ('RedAR15'),
		components = {}
	},
	{
		name = 'WEAPON_CARBINERIFLE7',
		label = ('IceAR'),
		components = {}
	},
	{
		name = 'WEAPON_JOSM4A4CH',
		label = ('ARnoel'),
		components = {}
	},
	{
		name = 'WEAPON_MENACE',
		label = ('Menace'),
		components = {}
	},
	{
		name = 'WEAPON_SPECIALCARBINE2_MK2',
		label = ('VandalAraxys'),
		components = {}
	},
	{
		name = 'WEAPON_SPECIALCARBINE3',
		label = ('Dragon'),
		components = {}
	},
	{
		name = 'WEAPON_VANDALEX',
		label = ('VandalRever'),
		components = {}
	},	
	{
		name = 'WEAPON_MIDASGUN',
		label = 'Midas Gun',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		}
	},
	{
		name = 'WEAPON_REDL',
		label = 'AK-REDL',
		components = {}
	},
	{
		name = 'WEAPON_AKORUS',
		label = 'AKORUS',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_AKORUS_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_AKORUS_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_AKORUS_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AKORUS_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_MILITARM4',
		label = 'MILITARM4',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_03') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_M4LEOSHOP_MEDIUM') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_M4LEOSHOP_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_GOLDM',
		label = 'GOLDM',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GOLDM_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GOLDM_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GOLDM_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GOLDM_SUPP') }
		}
	},
	{
        name = 'WEAPON_PREDATOR',
        label = 'PREDATOR',
        components = {
            { name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_01') },
            { name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_02') },
            { name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_03') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_PREDATOR_MEDIUM') },
            { name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PREDATOR_SUPP_02') },
            { name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_PREDATOR_AFGRIP') }
        }
    },
	{
        name = 'WEAPON_KINETIC',
        label = 'KINETIC',
        components = {
            { name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_KINETIC_CLIP_01') },
            { name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_KINETIC_CLIP_02') },
            { name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_KINETIC_CLIP_03') },
            { name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_KINETIC_MEDIUM') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_KINETIC_FLSH') },
            { name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_KINETIC_SUPP_02') },
            { name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_KINETIC_AFGRIP') }
        }
    },
	{
        name = 'WEAPON_SCARSC',
        label = 'SCARSC',
        components = {
            { name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SCARSC_CLIP_01') },
            { name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SCARSC_CLIP_02') },
            { name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SCARSC_CLIP_03') },
            { name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_SCARSC') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_SCARSC_FLSH') },
            { name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SCARSC_SUPP_02') },
            { name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_SCARSC_AFGRIP') }
        }
    },
	{
		name = 'WEAPON_TEC9M',
		label = "TEC9M",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9M_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9M_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9M_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9M_SUPP') }
		}
	},
	{
		name = 'WEAPON_TEC9MF',
		label = "TEC9MF",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9MF_SUPP') }
		}
	},
	{
		name = 'WEAPON_TEC9MB',
		label = "TEC9MB",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9MB_SUPP') }
		}
	},
	{
		name = 'WEAPON_BLASTAK',
		label = 'BLASTAK',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_BLASTAK_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_BLASTM4',
		label = 'BLASTM4',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLASTM4_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLASTM4_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_BLASTM4_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_BLASTM4_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_SIG550',
		label = 'SIG550',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SG550_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SG550_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SG550_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SG550_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_BLACKSNIPER',
		label = "BLACKSNIPER",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLACKLEOSHOP_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLACKLEOSHOP_CLIP_02') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_BLACKLEOSHOP_MAX') },
			{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_BLACKLEOSHOP_MAX') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_SUPPBLACKLEOSHOP_02') }
		}
	},

	{
		name = 'WEAPON_SOVEREIGN',
		label = "SOVEREIGN",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SOVEREIGN_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SOVEREIGN_CLIP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SOVEREIGN_SUPP') }
		}
	},

	{
		name = 'WEAPON_GLOCK17',
		label = "GLOCK17",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GLOCKLEOSHOP_CLIP_02') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_GLOCKLEOSHOP_FLSH') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GLOCKLEOSHOP_SUPP') }
		}
	},

	{
		name = 'WEAPON_SHOTGUNK',
		label = "SHOTGUNK",
		components = {
			{ name = 'flashlight', label = 'Lumière Flash', hash = GetHashKey('COMPONENT_AT_AR_SHOTGUNKLEOSHOPFLSH') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_SHOTGUNK_SUPP') }
		}
	},
	{
		name = 'WEAPON_VSCO',
		label = "VSCO",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_VSCO_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_VSCO_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_VSCO_CLIP_03') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_VSCO_MAX') },
			{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_VSCO_MAX2') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_VSCO_02') }
		}
	},
	{
		name = 'WEAPON_BLUERIOT',
		label = "BLUERIOT",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLUERIOT_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLUERIOT_CLIP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_BLUERIOT_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_ANCIENT',
		label = 'ANCIENT',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_ANCIENT_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_SNAKE',
		label = 'SNAKE',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SNAKE_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SNAKE_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SNAKE_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SNAKE_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_HELL',
		label = 'HELL',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_HELL_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_HELL_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_HELL_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_HELL_SUPP') }
		}
	},
	{
		name = 'WEAPON_OBLIVION',
		label = 'OBLIVION',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_OBLIVION_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_ALIEN',
		label = 'ALIEN',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ALIEN_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ALIEN_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ALIEN_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_ALIENAR_SUPP') }
		}
	},
	{
        name = 'WEAPON_MIDGARD',
        label = 'MIDGARD',
        components = {
            { name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_01') },
            { name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_02') },
            { name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_03') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_MIDGARDSCOPE_MEDIUM') },
            { name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_MIDGARDAR_SUPP') }
        }
    },
	{
		name = 'WEAPON_CHAINSAW',
		label = 'CHAINSAW',
		components = {}
	},
	{
		name = 'WEAPON_SPECIALHAMMER',
		label = 'SPECIALHAMMER',
		components = {}
	},
	{
		name = 'WEAPON_PENIS',
		label = 'PENIS',
		components = {}
	},
	{
		name = 'WEAPON_MAZE',
		label = 'MAZE',
		components = {}
	},
	{
		name = 'WEAPON_REVOLVERVAMP',
		label = 'REVOLVERVAMP',
		components = {}
	},
	{
		name = 'WEAPON_GUARD',
		label = 'AK_GUARD',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GUARD_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GUARD_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GUARD_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GUARD_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_GRAU',
		label = 'GRAU',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GRAU_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03_V2') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03_V3') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_GRAU_AR_FLSH') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM') },
			{ name = 'scope', label = "SCOPE 2", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM2') },
			{ name = 'scope', label = "SCOPE 3", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM3') },
			{ name = 'scope', label = "SCOPE LONG", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_LONG') },
			{ name = 'scope', label = "SCOPE LONG X", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_LONGX') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR 3", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_04') },
			{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_GRAU_STOCK') },
			{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_GRAU_STOCK2') },
			{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_GRAU_STOCK3') },
			{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_GRAU_STOCK4') },
			{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_GRAU_STOCK1_V2') },
			{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_GRAU_STOCK2_V3') },
			{ name = 'grip', label = "GRIP 1", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP') },
			{ name = 'grip', label = "GRIP 2", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP2') },
			{ name = 'grip', label = "GRIP 3", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP3') },
			{ name = 'grip', label = "GRIP 4", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP4') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V5') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V3') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V4') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V2F') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V3F') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V2') }
		}
	},
	{
		name = 'WEAPON_UZILS',
		label = 'UZI',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_UZILS_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_04') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_01v4') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02v18') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02v13') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03v3') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03v16') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_UZILS_SUPP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_UZILS_SUPP_02v3') },
			{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_UZILS_STOCK') },
			{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_UZILS_STOCK2') },
			{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_UZILS_STOCK3') },
			{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_UZILS_STOCK4') },
			{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_UZILS_STOCK3v3') },
			{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_UZILS_STOCKv13') },
			{ name = 'stock', label = "STOCK 7", hash = GetHashKey('COMPONENT_UZILS_STOCKv18') },
			{ name = 'stock', label = "BARREL 1", hash = GetHashKey('COMPONENT_UZILS_BARREL') },
			{ name = 'stock', label = "BARREL 2", hash = GetHashKey('COMPONENT_UZILS_BARREL2') },
			{ name = 'stock', label = "BARREL 3", hash = GetHashKey('COMPONENT_UZILS_BARREL3') },
			{ name = 'stock', label = "BARREL 4", hash = GetHashKey('COMPONENT_UZILS_BARREL4') },
			{ name = 'stock', label = "BARREL 1 SKIN5", hash = GetHashKey('COMPONENT_UZILS_BARRELv18') },
			{ name = 'stock', label = "BARREL 1 SKIN3", hash = GetHashKey('COMPONENT_UZILS_BARREL4v13') },
			{ name = 'luxary_finish', label = "SKIN 1", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V3') },
			{ name = 'luxary_finish', label = "SKIN 2", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V4') },
			{ name = 'luxary_finish', label = "SKIN 3", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V13') },
			{ name = 'luxary_finish', label = "SKIN 4", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V16') },
			{ name = 'luxary_finish', label = "SKIN 5", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V18') }
		}
	},
	{
		name = 'WEAPON_M19',
		label = "M19",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M19_CLIP_01') },
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M19_CLIP_01V2') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M19_CLIP_02') },
			{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_M19_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_PI_M19_SUPP2') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_M19_VARMOD_V2') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_M19_VARMOD_V3') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_M19_VARMOD_V4') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_M19_VARMOD_V5') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PI_M19_SUPP') }
		}
	},
	{
		name = 'WEAPON_SPIDERAK',
		label = 'SPIDERAK',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SPIDERAK_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_PUMPKIN',
		label = 'PUMPKIN',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PUMPKIN_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_BONEPER',
		label = "BONEPER",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BONEPER_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BONEPER_CLIP_02') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
			{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_BONEPER_AR_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_DESERTPURPLE',
		label = "DESERTPURPLE",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_DESERT_CLIP_01') },
			{ name = 'clip_extended', label = 'Extension Chargeur', hash = GetHashKey('COMPONENT_DESERT_CLIP_02') },
			{ name = 'flashlight', label = 'Lumière Flash', hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_DESERT_SUPP') }
		}
	},
	{
		name = 'WEAPON_DESERTNIKE',
		label = "DESERT NIKE",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_DESERTNIKE_CLIP_01') },
			{ name = 'clip_extended', label = 'Extension Chargeur', hash = GetHashKey('COMPONENT_DESERTNIKE_CLIP_02') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_DESERTNIKE_PI_SUPP') }
		}
	},
	{
		name = 'WEAPON_GLOCDKM',
		label = "GLOCDKM",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_GLOCKDM_CLIP_01') },
			{ name = 'clip_extended', label = 'Extension Chargeur', hash = GetHashKey('COMPONENT_GLOCKDM_CLIP_02') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDM_SUPP') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDMR_SUPP') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDMG_SUPP') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDMN_SUPP') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDMB_SUPP') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD2') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD3') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD4') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD5') }
		}
	},
	{
		name = 'WEAPON_M4GOLDBEAST',
		label = 'M4GOLDBEAST',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_M4GOLDBEAST_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_HELLSNIPER',
		label = 'HELLSNIPER',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_HELLSNIPER_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_HELLSNIPER_CLIP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_HELLSNIPER_SUPP') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_HELLSNIPER_SCOPE_MAX') }
		}
	},
	{
		name = 'WEAPON_357',
		label = ".357",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_357_CLIP_01') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD4') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD6') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD17') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD22') },
			{ name = 'luxary_finish', label = "VARMOD6", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD23') }
		}
	},
	{
		name = 'WEAPON_REVOLVERULTRA',
		label = "REVOLVERULTRA",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_REVOLVERULTRA_CLIP_01') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_REVOLVERLEOSHOP_SUPP') }
		}
	},
{
		name = 'WEAPON_MIDASGUN',
		label = 'Midas Gun',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		}
	},
	{
		name = 'WEAPON_REDL',
		label = 'AK-REDL',
		components = {}
	},
	{
		name = 'WEAPON_AKORUS',
		label = 'AKORUS',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_AKORUS_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_AKORUS_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_AKORUS_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AKORUS_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_MILITARM4',
		label = 'MILITARM4',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_03') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_M4LEOSHOP_MEDIUM') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_M4LEOSHOP_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_GOLDM',
		label = 'GOLDM',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GOLDM_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GOLDM_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GOLDM_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GOLDM_SUPP') }
		}
	},
	{
        name = 'WEAPON_PREDATOR',
        label = 'PREDATOR',
        components = {
            { name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_01') },
            { name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_02') },
            { name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_03') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_PREDATOR_MEDIUM') },
            { name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PREDATOR_SUPP_02') },
            { name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_PREDATOR_AFGRIP') }
        }
    },
	{
        name = 'WEAPON_KINETIC',
        label = 'KINETIC',
        components = {
            { name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_KINETIC_CLIP_01') },
            { name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_KINETIC_CLIP_02') },
            { name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_KINETIC_CLIP_03') },
            { name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_KINETIC_MEDIUM') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_KINETIC_FLSH') },
            { name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_KINETIC_SUPP_02') },
            { name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_KINETIC_AFGRIP') }
        }
    },
	{
        name = 'WEAPON_SCARSC',
        label = 'SCARSC',
        components = {
            { name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SCARSC_CLIP_01') },
            { name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SCARSC_CLIP_02') },
            { name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SCARSC_CLIP_03') },
            { name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_SCARSC') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_SCARSC_FLSH') },
            { name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SCARSC_SUPP_02') },
            { name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_SCARSC_AFGRIP') }
        }
    },
	{
		name = 'WEAPON_TEC9M',
		label = "TEC9M",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9M_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9M_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9M_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9M_SUPP') }
		}
	},
	{
		name = 'WEAPON_TEC9MF',
		label = "TEC9MF",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9MF_SUPP') }
		}
	},
	{
		name = 'WEAPON_TEC9MB',
		label = "TEC9MB",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9MB_SUPP') }
		}
	},
	{
		name = 'WEAPON_BLASTAK',
		label = 'BLASTAK',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_BLASTAK_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_SIG550',
		label = 'SIG550',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SG550_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SG550_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SG550_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SG550_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_BLACKSNIPER',
		label = "BLACKSNIPER",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLACKLEOSHOP_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLACKLEOSHOP_CLIP_02') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_BLACKLEOSHOP_MAX') },
			{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_BLACKLEOSHOP_MAX') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_SUPPBLACKLEOSHOP_02') }
		}
	},

	{
		name = 'WEAPON_SOVEREIGN',
		label = "SOVEREIGN",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SOVEREIGN_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SOVEREIGN_CLIP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SOVEREIGN_SUPP') }
		}
	},

	{
		name = 'WEAPON_GLOCK17',
		label = "GLOCK17",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GLOCKLEOSHOP_CLIP_02') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_GLOCKLEOSHOP_FLSH') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GLOCKLEOSHOP_SUPP') }
		}
	},

	{
		name = 'WEAPON_SHOTGUNK',
		label = "SHOTGUNK",
		components = {
			{ name = 'flashlight', label = 'Lumière Flash', hash = GetHashKey('COMPONENT_AT_AR_SHOTGUNKLEOSHOPFLSH') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_SHOTGUNK_SUPP') }
		}
	},
	{
		name = 'WEAPON_VSCO',
		label = "VSCO",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_VSCO_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_VSCO_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_VSCO_CLIP_03') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_VSCO_MAX') },
			{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_VSCO_MAX2') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_VSCO_02') }
		}
	},
	{
		name = 'WEAPON_BLUERIOT',
		label = "BLUERIOT",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLUERIOT_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLUERIOT_CLIP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_BLUERIOT_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_ANCIENT',
		label = 'ANCIENT',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_ANCIENT_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_SNAKE',
		label = 'SNAKE',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SNAKE_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SNAKE_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SNAKE_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SNAKE_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_HELL',
		label = 'HELL',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_HELL_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_HELL_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_HELL_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_HELL_SUPP') }
		}
	},
	{
		name = 'WEAPON_OBLIVION',
		label = 'OBLIVION',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_OBLIVION_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_ALIEN',
		label = 'ALIEN',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ALIEN_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ALIEN_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ALIEN_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_ALIENAR_SUPP') }
		}
	},
	{
        name = 'WEAPON_MIDGARD',
        label = 'MIDGARD',
        components = {
            { name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_01') },
            { name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_02') },
            { name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_03') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_MIDGARDSCOPE_MEDIUM') },
            { name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_MIDGARDAR_SUPP') }
        }
    },
	{
		name = 'WEAPON_CHAINSAW',
		label = 'CHAINSAW',
		components = {}
	},
	{
		name = 'WEAPON_SPECIALHAMMER',
		label = 'SPECIALHAMMER',
		components = {}
	},
	{
		name = 'WEAPON_PENIS',
		label = 'PENIS',
		components = {}
	},
	{
		name = 'WEAPON_MAZE',
		label = 'MAZE',
		components = {}
	},
	{
		name = 'WEAPON_REVOLVERVAMP',
		label = 'REVOLVERVAMP',
		components = {}
	},
	{
		name = 'WEAPON_GUARD',
		label = 'AK_GUARD',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GUARD_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GUARD_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GUARD_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GUARD_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_GRAU',
		label = 'GRAU',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GRAU_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03_V2') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03_V3') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_GRAU_AR_FLSH') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM') },
			{ name = 'scope', label = "SCOPE 2", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM2') },
			{ name = 'scope', label = "SCOPE 3", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM3') },
			{ name = 'scope', label = "SCOPE LONG", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_LONG') },
			{ name = 'scope', label = "SCOPE LONG X", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_LONGX') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR 3", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_04') },
			{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_GRAU_STOCK') },
			{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_GRAU_STOCK2') },
			{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_GRAU_STOCK3') },
			{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_GRAU_STOCK4') },
			{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_GRAU_STOCK1_V2') },
			{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_GRAU_STOCK2_V3') },
			{ name = 'grip', label = "GRIP 1", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP') },
			{ name = 'grip', label = "GRIP 2", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP2') },
			{ name = 'grip', label = "GRIP 3", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP3') },
			{ name = 'grip', label = "GRIP 4", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP4') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V5') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V3') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V4') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V2F') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V3F') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V2') }
		}
	},
	{
		name = 'WEAPON_SCAR17',
		label = 'SCAR17',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SCAR17_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SCAR17_CLIP_02') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SCAR17_V2_CLIP_02') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SCAR17_V3_CLIP_02') },
			{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_SCAR17_CLIP_03') },
			{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_SCAR17_V2_CLIP_03') },
			{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_SCAR17_V3_CLIP_03') },
			{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_SCAR17_V4_CLIP_03') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_SCAR17_FLSH') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCAR17_MEDIUM') },
			{ name = 'scope', label = "SCOPE 2", hash = GetHashKey('COMPONENT_AT_SCAR17_V3_MEDIUM') },
			{ name = 'scope', label = "SCOPE 3", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM3') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_SCAR17_SUPP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_AR_SCAR17_SUPP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR 3", hash = GetHashKey('COMPONENT_AT_AR_SCAR17_SUPP_04') },
			{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_SCAR17_STOCK') },
			{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_SCAR17_STOCK2') },
			{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_SCAR17_STOCK3') },
			{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_SCAR17_STOCK4') },
			{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_SCAR17_STOCK5') },
			{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_SCAR17_V2_STOCK3') },
			{ name = 'stock', label = "STOCK 7", hash = GetHashKey('COMPONENT_SCAR17_V3_STOCK') },
			{ name = 'stock', label = "STOCK 8", hash = GetHashKey('COMPONENT_SCAR17_V4_STOCK5') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_SCAR17_VARMOD_V2') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_SCAR17_VARMOD_V3') },
			{ name = 'luxary_finish', label = "VARMOD SMALL", hash = GetHashKey('COMPONENT_SCAR17_VARMOD_SMALL') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_SCAR17_VARMOD_V4') }
		}
	},
	{
		name = 'WEAPON_UZILS',
		label = 'UZI',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_UZILS_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_04') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_01v4') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02v18') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02v13') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03v3') },
			{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03v16') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_UZILS_SUPP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_UZILS_SUPP_02v3') },
			{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_UZILS_STOCK') },
			{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_UZILS_STOCK2') },
			{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_UZILS_STOCK3') },
			{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_UZILS_STOCK4') },
			{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_UZILS_STOCK3v3') },
			{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_UZILS_STOCKv13') },
			{ name = 'stock', label = "STOCK 7", hash = GetHashKey('COMPONENT_UZILS_STOCKv18') },
			{ name = 'stock', label = "BARREL 1", hash = GetHashKey('COMPONENT_UZILS_BARREL') },
			{ name = 'stock', label = "BARREL 2", hash = GetHashKey('COMPONENT_UZILS_BARREL2') },
			{ name = 'stock', label = "BARREL 3", hash = GetHashKey('COMPONENT_UZILS_BARREL3') },
			{ name = 'stock', label = "BARREL 4", hash = GetHashKey('COMPONENT_UZILS_BARREL4') },
			{ name = 'stock', label = "BARREL 1 SKIN5", hash = GetHashKey('COMPONENT_UZILS_BARRELv18') },
			{ name = 'stock', label = "BARREL 1 SKIN3", hash = GetHashKey('COMPONENT_UZILS_BARREL4v13') },
			{ name = 'luxary_finish', label = "SKIN 1", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V3') },
			{ name = 'luxary_finish', label = "SKIN 2", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V4') },
			{ name = 'luxary_finish', label = "SKIN 3", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V13') },
			{ name = 'luxary_finish', label = "SKIN 4", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V16') },
			{ name = 'luxary_finish', label = "SKIN 5", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V18') }
		}
	},
	{
		name = 'WEAPON_M19',
		label = "M19",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M19_CLIP_01') },
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M19_CLIP_01V2') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M19_CLIP_02') },
			{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_M19_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_PI_M19_SUPP2') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_M19_VARMOD_V2') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_M19_VARMOD_V3') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_M19_VARMOD_V4') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_M19_VARMOD_V5') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PI_M19_SUPP') }
		}
	},
	{
		name = 'WEAPON_SPIDERAK',
		label = 'SPIDERAK',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SPIDERAK_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_PUMPKIN',
		label = 'PUMPKIN',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PUMPKIN_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_BONEPER',
		label = "BONEPER",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BONEPER_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BONEPER_CLIP_02') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
			{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_BONEPER_AR_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_DESERTPURPLE',
		label = "DESERTPURPLE",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_DESERT_CLIP_01') },
			{ name = 'clip_extended', label = 'Extension Chargeur', hash = GetHashKey('COMPONENT_DESERT_CLIP_02') },
			{ name = 'flashlight', label = 'Lumière Flash', hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_DESERT_SUPP') }
		}
	},
	{
		name = 'WEAPON_DESERTNIKE',
		label = "DESERT NIKE",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_DESERTNIKE_CLIP_01') },
			{ name = 'clip_extended', label = 'Extension Chargeur', hash = GetHashKey('COMPONENT_DESERTNIKE_CLIP_02') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_DESERTNIKE_PI_SUPP') }
		}
	},
	{
		name = 'WEAPON_GLOCDKM',
		label = "GLOCDKM",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_GLOCKDM_CLIP_01') },
			{ name = 'clip_extended', label = 'Extension Chargeur', hash = GetHashKey('COMPONENT_GLOCKDM_CLIP_02') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDM_SUPP') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDMR_SUPP') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDMG_SUPP') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDMN_SUPP') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_GLOCKDMB_SUPP') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD2') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD3') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD4') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD5') }
		}
	},
	{
		name = 'WEAPON_M4GOLDBEAST',
		label = 'M4GOLDBEAST',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_M4GOLDBEAST_SUPP_02') }
		}
	},
	{
		name = 'WEAPON_HELLSNIPER',
		label = 'HELLSNIPER',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_HELLSNIPER_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_HELLSNIPER_CLIP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_HELLSNIPER_SUPP') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_HELLSNIPER_SCOPE_MAX') }
		}
	},
	{
		name = 'WEAPON_357',
		label = ".357",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_357_CLIP_01') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD4') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD6') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD17') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD22') },
			{ name = 'luxary_finish', label = "VARMOD6", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD23') }
		}
	},
	{
		name = 'WEAPON_REVOLVERULTRA',
		label = "REVOLVERULTRA",
		components = {
			{ name = 'clip_default', label = 'Chargeur', hash = GetHashKey('COMPONENT_REVOLVERULTRA_CLIP_01') },
			{ name = 'suppressor', label = 'Silencieux', hash = GetHashKey('COMPONENT_AT_REVOLVERLEOSHOP_SUPP') }
		}
	},
	{
		name = 'WEAPON_MCX',
		label = 'MCX MODULAR',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_MCX_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_MCX_CLIP_02') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_MCX_CLIP_04') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_MCX_CLIP_05') },
			{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_MCX_CLIP_03') },
			{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_MCX_FLSH_01') },
			{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_MCX_SCOPE_01') },
			{ name = 'scope', label = "SCOPE 2", hash = GetHashKey('COMPONENT_MCX_SCOPE_02') },
			{ name = 'scope', label = "SCOPE 3", hash = GetHashKey('COMPONENT_MCX_SCOPE_03') },
			{ name = 'scope', label = "SCOPE 4", hash = GetHashKey('COMPONENT_MCX_SCOPE_04') },
			{ name = 'scope', label = "SCOPE 5", hash = GetHashKey('COMPONENT_MCX_SCOPE_05') },
			{ name = 'scope', label = "SCOPE 6", hash = GetHashKey('COMPONENT_MCX_SCOPE_06') },
			{ name = 'scope', label = "SCOPE 7", hash = GetHashKey('COMPONENT_MCX_SCOPE_07') },
			{ name = 'scope', label = "SCOPE 8", hash = GetHashKey('COMPONENT_MCX_SCOPE_08') },
			{ name = 'scope', label = "SCOPE 9", hash = GetHashKey('COMPONENT_MCX_SCOPE_09') },
			{ name = 'scope', label = "SCOPE 10", hash = GetHashKey('COMPONENT_MCX_SCOPE_10') },
			{ name = 'scope', label = "SCOPE 11", hash = GetHashKey('COMPONENT_MCX_SCOPE_11') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_SCAR17_SUPP_02') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_AR_SCAR17_SUPP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR 3", hash = GetHashKey('COMPONENT_AT_AR_SCAR17_SUPP_04') },
			{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_MCX_STOCK1') },
			{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_MCX_STOCK1V2') },
			{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_MCX_STOCK1V3') },
			{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_MCX_STOCK2') },
			{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_MCX_STOCK3') },
			{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_MCX_STOCK4') },
			{ name = 'stock', label = "STOCK 7", hash = GetHashKey('COMPONENT_MCX_STOCK5') },
			{ name = 'stock', label = "STOCK 8", hash = GetHashKey('COMPONENT_MCX_STOCK6') },
			{ name = 'stock', label = "STOCK 7", hash = GetHashKey('COMPONENT_MCX_STOCK7') },
			{ name = 'stock', label = "STOCK 8", hash = GetHashKey('COMPONENT_MCX_STOCK8') },
			{ name = 'stock', label = "STOCK 7", hash = GetHashKey('COMPONENT_MCX_STOCK9') },
			{ name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_MCX_AFGRIP2') },
			{ name = 'grip', label = "GRIP 2", hash = GetHashKey('COMPONENT_AT_MCX_AFGRIP3') },
			{ name = 'grip', label = "GRIP 3", hash = GetHashKey('COMPONENT_AT_MCX_AFGRIP4') },
			{ name = 'grip', label = "GRIP 4", hash = GetHashKey('COMPONENT_AT_MCX_AFGRIP5') },
			{ name = 'grip', label = "GRIP 5", hash = GetHashKey('COMPONENT_AT_MCX_AFGRIP6') },
			{ name = 'grip', label = "GRIP 6", hash = GetHashKey('COMPONENT_AT_MCX_AFGRIP7') },
			{ name = 'luxary_finish', label = "VARMOD1", hash = GetHashKey('COMPONENT_MCX_FRAME_01') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_MCX_FRAME_02') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_MCX_FRAME_03') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_MCX_FRAME_04') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_MCX_FRAME_05') }
		}
	},
	{
		name = 'WEAPON_SCOM',
		label = "SCOM",
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SCOM_CLIP_01') },
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SCOM4_CLIP_01') },
			{ name = 'clip_default', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SCOM6_CLIP_01') },
			{ name = 'clip_default', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_SCOM7_CLIP_01') },
			{ name = 'clip_default', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_SCOM7_CLIP_01') },
			{ name = 'clip_default', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_SCOM_CLIP_02') },
			{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_SCOM_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR 1", hash = GetHashKey('COMPONENT_AT_SCOM_SUPP') },
			{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_SCOM2_SUPP') },
			{ name = 'suppressor', label = "SUPPRESSOR 3", hash = GetHashKey('COMPONENT_AT_SCOM3_SUPP') },
			{ name = 'suppressor', label = "SUPPRESSOR 4", hash = GetHashKey('COMPONENT_AT_SCOM4_SUPP') },
			{ name = 'suppressor', label = "SUPPRESSOR 5", hash = GetHashKey('COMPONENT_AT_SCOM5_SUPP') },
			{ name = 'suppressor', label = "SUPPRESSOR 6", hash = GetHashKey('COMPONENT_AT_SCOM6_SUPP') },
			{ name = 'suppressor', label = "SUPPRESSOR 7", hash = GetHashKey('COMPONENT_AT_SCOM7_SUPP') },
			{ name = 'flashlight', label = 'Lumière Flash', hash = GetHashKey('COMPONENT_AT_SCOM_FLSH') },
			{ name = 'flashlight', label = 'Lumière Flash', hash = GetHashKey('COMPONENT_AT_SCOM4_FLSH') },
			{ name = 'flashlight', label = 'Lumière Flash', hash = GetHashKey('COMPONENT_AT_SCOM6_FLSH') },
			{ name = 'flashlight', label = 'Lumière Flash', hash = GetHashKey('COMPONENT_AT_SCOM7_FLSH') },
			{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_SCOM_VARMOD2') },
			{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_SCOM_VARMOD3') },
			{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_SCOM_VARMOD4') },
			{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_SCOM_VARMOD5') },
			{ name = 'luxary_finish', label = "VARMOD6", hash = GetHashKey('COMPONENT_SCOM_VARMOD6') },
			{ name = 'luxary_finish', label = "VARMOD7", hash = GetHashKey('COMPONENT_SCOM_VARMOD7') }
		}
	},
	{
		name = 'WEAPON_BONEAK',
		label = 'BONEAK',
		components = {
			{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_AKBONE_CLIP_01') },
			{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_AKBONE_CLIP_02') },
			{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_AKBONE_CLIP_03') },
			{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AKBONE_SUPP_02') }
		}
	},
	{name = 'WEAPON_GLOCK', label = 'Glock', components = {}, ammo = {label = 'Munitions 9mm', hash = `AMMO_GLOCK`}},
    {name = 'WEAPON_GLOCK20', label = 'Glock 20', components = {}, ammo = {label = 'Munitions 10mm', hash = `AMMO_GLOCK`}},
    {name = 'WEAPON_M9', label = 'M9', components = {}, ammo = {label = 'Munitions 9mm', hash = `AMMO_M9`}},

	
{
	name = 'WEAPON_MIDASGUN',
	label = 'Midas Gun',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03') },
		{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
		{ name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
	}
},
{
	name = 'WEAPON_REDL',
	label = 'AK-REDL',
	components = {}
},
{
	name = 'WEAPON_AKORUS',
	label = 'AKORUS',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_AKORUS_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_AKORUS_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_AKORUS_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AKORUS_SUPP_02') }
	}
},
{
	name = 'WEAPON_MILITARM4',
	label = 'MILITARM4',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_M4LEOSHOP_CLIP_03') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_M4LEOSHOP_MEDIUM') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_M4LEOSHOP_SUPP_02') }
	}
},
{
	name = 'WEAPON_GOLDM',
	label = 'GOLDM',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GOLDM_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GOLDM_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GOLDM_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GOLDM_SUPP') }
	}
},
{
	name = 'WEAPON_PREDATOR',
	label = 'PREDATOR',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_02') },
		{ name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_PREDATOR_CLIP_03') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_PREDATOR_MEDIUM') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PREDATOR_SUPP_02') },
		{ name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_PREDATOR_AFGRIP') }
	}
},
{
	name = 'WEAPON_KINETIC',
	label = 'KINETIC',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_KINETIC_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_KINETIC_CLIP_02') },
		{ name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_KINETIC_CLIP_03') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_KINETIC_MEDIUM') },
		{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_KINETIC_FLSH') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_KINETIC_SUPP_02') },
		{ name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_KINETIC_AFGRIP') }
	}
},
{
	name = 'WEAPON_SCARSC',
	label = 'SCARSC',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SCARSC_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SCARSC_CLIP_02') },
		{ name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SCARSC_CLIP_03') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_SCARSC') },
		{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_SCARSC_FLSH') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SCARSC_SUPP_02') },
		{ name = 'grip', label = "GRIP", hash = GetHashKey('COMPONENT_AT_SCARSC_AFGRIP') }
	}
},
{
	name = 'WEAPON_TEC9M',
	label = "TEC9M",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9M_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9M_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9M_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9M_SUPP') }
	}
},
{
	name = 'WEAPON_TEC9MF',
	label = "TEC9MF",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9MF_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9MF_SUPP') }
	}
},
{
	name = 'WEAPON_TEC9MB',
	label = "TEC9MB",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_TEC9MB_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_TEC9MB_SUPP') }
	}
},
{
	name = 'WEAPON_BLASTAK',
	label = 'BLASTAK',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_BLASTAK_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_BLASTAK_SUPP_02') }
	}
},
{
	name = 'WEAPON_SIG550',
	label = 'SIG550',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SG550_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SG550_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SG550_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SG550_SUPP_02') }
	}
},
{
	name = 'WEAPON_BLACKSNIPER',
	label = "BLACKSNIPER",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLACKLEOSHOP_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLACKLEOSHOP_CLIP_02') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_BLACKLEOSHOP_MAX') },
		{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_BLACKLEOSHOP_MAX') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_SUPPBLACKLEOSHOP_02') }
	}
},

{
	name = 'WEAPON_SOVEREIGN',
	label = "SOVEREIGN",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SOVEREIGN_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SOVEREIGN_CLIP_02') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SOVEREIGN_SUPP') }
	}
},

{
	name = 'WEAPON_GLOCK17',
	label = "GLOCK17",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GLOCKLEOSHOP_CLIP_02') },
		{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_GLOCKLEOSHOP_FLSH') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GLOCKLEOSHOP_SUPP') }
	}
},

{
	name = 'WEAPON_COACHGUN',
	label = "COACHGUN",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_COACHGUN_CLIP_01') }
	}
},
{
	name = 'WEAPON_SHOTGUNK',
	label = "SHOTGUNK",
	components = {
		{ name = 'flashlight', label = ('FLASHLIGHT'), hash = GetHashKey('COMPONENT_AT_AR_SHOTGUNKLEOSHOPFLSH') },
		{ name = 'suppressor', label = ('SUPPRESSOR'), hash = GetHashKey('COMPONENT_AT_SHOTGUNK_SUPP') }
	}
},
{
	name = 'WEAPON_VSCO',
	label = "VSCO",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_VSCO_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_VSCO_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_VSCO_CLIP_03') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_VSCO_MAX') },
		{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_VSCO_MAX2') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_VSCO_02') }
	}
},
{
	name = 'WEAPON_BLUERIOT',
	label = "BLUERIOT",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BLUERIOT_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BLUERIOT_CLIP_02') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_BLUERIOT_SUPP_02') }
	}
},
{
	name = 'WEAPON_ANCIENT',
	label = 'ANCIENT',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ANCIENT_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_ANCIENT_SUPP_02') }
	}
},
{
	name = 'WEAPON_SNAKE',
	label = 'SNAKE',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SNAKE_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SNAKE_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SNAKE_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SNAKE_SUPP_02') }
	}
},
{
	name = 'WEAPON_HELL',
	label = 'HELL',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_HELL_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_HELL_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_HELL_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_HELL_SUPP') }
	}
},
{
	name = 'WEAPON_OBLIVION',
	label = 'OBLIVION',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_OBLIVION_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_OBLIVION_SUPP_02') }
	}
},
{
	name = 'WEAPON_ALIEN',
	label = 'ALIEN',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_ALIEN_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_ALIEN_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_ALIEN_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_ALIENAR_SUPP') }
	}
},
{
	name = 'WEAPON_MIDGARD',
	label = 'MIDGARD',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_02') },
		{ name = 'clip_box', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_MIDGARD_CLIP_03') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_MIDGARDSCOPE_MEDIUM') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_MIDGARDAR_SUPP') }
	}
},
{
	name = 'WEAPON_CHAINSAW',
	label = 'CHAINSAW',
	components = {}
},
{
	name = 'WEAPON_SPECIALHAMMER',
	label = 'SPECIALHAMMER',
	components = {}
},
{
	name = 'WEAPON_PENIS',
	label = 'PENIS',
	components = {}
},
{
	name = 'WEAPON_MAZE',
	label = 'MAZE',
	components = {}
},
{
	name = 'WEAPON_REVOLVERVAMP',
	label = 'REVOLVERVAMP',
	components = {}
},
{
	name = 'WEAPON_GUARD',
	label = 'AK_GUARD',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GUARD_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GUARD_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GUARD_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_GUARD_SUPP_02') }
	}
},
{
	name = 'WEAPON_GRAU',
	label = 'GRAU',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_GRAU_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03_V2') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_GRAU_CLIP_03_V3') },
		{ name = 'flashlight', label = "FLASHLIGHT", hash = GetHashKey('COMPONENT_AT_GRAU_AR_FLSH') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM') },
		{ name = 'scope', label = "SCOPE 2", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM2') },
		{ name = 'scope', label = "SCOPE 3", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_MEDIUM3') },
		{ name = 'scope', label = "SCOPE LONG", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_LONG') },
		{ name = 'scope', label = "SCOPE LONG X", hash = GetHashKey('COMPONENT_AT_GRAU_SCOPE_LONGX') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_02') },
		{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR 3", hash = GetHashKey('COMPONENT_AT_AR_GRAU_SUPP_04') },
		{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_GRAU_STOCK') },
		{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_GRAU_STOCK2') },
		{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_GRAU_STOCK3') },
		{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_GRAU_STOCK4') },
		{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_GRAU_STOCK1_V2') },
		{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_GRAU_STOCK2_V3') },
		{ name = 'grip', label = "GRIP 1", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP') },
		{ name = 'grip', label = "GRIP 2", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP2') },
		{ name = 'grip', label = "GRIP 3", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP3') },
		{ name = 'grip', label = "GRIP 4", hash = GetHashKey('COMPONENT_AT_GRAU_AR_AFGRIP4') },
		{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V5') },
		{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V3') },
		{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V4') },
		{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V2F') },
		{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V3F') },
		{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_GRAU_VARMOD_V2') }
	}
},
{
	name = 'WEAPON_UZILS',
	label = 'UZI',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_UZILS_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_04') },
		{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_01v4') },
		{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02v18') },
		{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_02v13') },
		{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03v3') },
		{ name = 'clip_extended', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_UZILS_CLIP_03v16') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_UZILS_SUPP_02') },
		{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_UZILS_SUPP_02v3') },
		{ name = 'stock', label = "STOCK 1", hash = GetHashKey('COMPONENT_UZILS_STOCK') },
		{ name = 'stock', label = "STOCK 2", hash = GetHashKey('COMPONENT_UZILS_STOCK2') },
		{ name = 'stock', label = "STOCK 3", hash = GetHashKey('COMPONENT_UZILS_STOCK3') },
		{ name = 'stock', label = "STOCK 4", hash = GetHashKey('COMPONENT_UZILS_STOCK4') },
		{ name = 'stock', label = "STOCK 5", hash = GetHashKey('COMPONENT_UZILS_STOCK3v3') },
		{ name = 'stock', label = "STOCK 6", hash = GetHashKey('COMPONENT_UZILS_STOCKv13') },
		{ name = 'stock', label = "STOCK 7", hash = GetHashKey('COMPONENT_UZILS_STOCKv18') },
		{ name = 'stock', label = "BARREL 1", hash = GetHashKey('COMPONENT_UZILS_BARREL') },
		{ name = 'stock', label = "BARREL 2", hash = GetHashKey('COMPONENT_UZILS_BARREL2') },
		{ name = 'stock', label = "BARREL 3", hash = GetHashKey('COMPONENT_UZILS_BARREL3') },
		{ name = 'stock', label = "BARREL 4", hash = GetHashKey('COMPONENT_UZILS_BARREL4') },
		{ name = 'stock', label = "BARREL 1 SKIN5", hash = GetHashKey('COMPONENT_UZILS_BARRELv18') },
		{ name = 'stock', label = "BARREL 1 SKIN3", hash = GetHashKey('COMPONENT_UZILS_BARREL4v13') },
		{ name = 'luxary_finish', label = "SKIN 1", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V3') },
		{ name = 'luxary_finish', label = "SKIN 2", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V4') },
		{ name = 'luxary_finish', label = "SKIN 3", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V13') },
		{ name = 'luxary_finish', label = "SKIN 4", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V16') },
		{ name = 'luxary_finish', label = "SKIN 5", hash = GetHashKey('COMPONENT_UZILS_VARMOD_V18') }
	}
},
{
	name = 'WEAPON_M19',
	label = "M19",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M19_CLIP_01') },
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M19_CLIP_01V2') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M19_CLIP_02') },
		{ name = 'clip_drum', label = "EXTENDED 2 CLIP", hash = GetHashKey('COMPONENT_M19_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR 2", hash = GetHashKey('COMPONENT_AT_PI_M19_SUPP2') },
		{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_M19_VARMOD_V2') },
		{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_M19_VARMOD_V3') },
		{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_M19_VARMOD_V4') },
		{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_M19_VARMOD_V5') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PI_M19_SUPP') }
	}
},
{
	name = 'WEAPON_SPIDERAK',
	label = 'SPIDERAK',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_SPIDERAK_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_SPIDERAK_SUPP_02') }
	}
},
{
	name = 'WEAPON_PUMPKIN',
	label = 'PUMPKIN',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_PUMPKIN_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_PUMPKIN_SUPP_02') }
	}
},
{
	name = 'WEAPON_BONEPER',
	label = "BONEPER",
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_BONEPER_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_BONEPER_CLIP_02') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
		{ name = 'scope_advanced', label = "SCOPE", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_BONEPER_AR_SUPP_02') }
	}
},
{
	name = 'WEAPON_DESERTPURPLE',
	label = "DESERTPURPLE",
	components = {
		{ name = 'clip_default', label = ('chargeur'), hash = GetHashKey('COMPONENT_DESERT_CLIP_01') },
		{ name = 'clip_extended', label = ('clip_default'), hash = GetHashKey('COMPONENT_DESERT_CLIP_02') },
		{ name = 'flashlight', label = ('FLASHLIGHT'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
		{ name = 'suppressor', label = ('SUPPRESSOR'), hash = GetHashKey('COMPONENT_AT_DESERT_SUPP') }
	}
},
{
	name = 'WEAPON_DESERTNIKE',
	label = "DESERT NIKE",
	components = {
		{ name = 'clip_default', label = ('clip_default'), hash = GetHashKey('COMPONENT_DESERTNIKE_CLIP_01') },
		{ name = 'clip_extended', label = ('clip_extended'), hash = GetHashKey('COMPONENT_DESERTNIKE_CLIP_02') },
		{ name = 'suppressor', label = ('SUPPRESSOR'), hash = GetHashKey('COMPONENT_DESERTNIKE_PI_SUPP') }
	}
},
{
	name = 'WEAPON_GLOCDKM',
	label = "GLOCDKM",
	components = {
		{ name = 'clip_default', label = ('clip_default'), hash = GetHashKey('COMPONENT_GLOCKDM_CLIP_01') },
		{ name = 'clip_extended', label = ('component_clip_extended'), hash = GetHashKey('COMPONENT_GLOCKDM_CLIP_02') },
		{ name = 'suppressor', label = ('component_suppressor'), hash = GetHashKey('COMPONENT_AT_GLOCKDM_SUPP') },
		{ name = 'suppressor', label = ('component_suppressor'), hash = GetHashKey('COMPONENT_AT_GLOCKDMR_SUPP') },
		{ name = 'suppressor', label = ('component_suppressor'), hash = GetHashKey('COMPONENT_AT_GLOCKDMG_SUPP') },
		{ name = 'suppressor', label = ('component_suppressor'), hash = GetHashKey('COMPONENT_AT_GLOCKDMN_SUPP') },
		{ name = 'suppressor', label = ('component_suppressor'), hash = GetHashKey('COMPONENT_AT_GLOCKDMB_SUPP') },
		{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD2') },
		{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD3') },
		{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD4') },
		{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_GLOCKDM_VARMOD5') }
	}
},
{
	name = 'WEAPON_M4BEAST',
	label = 'M4BEAST',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M4BEAST_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M4BEAST_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_M4BEAST_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_M4BEAST_SUPP_02') }
	}
},
{
	name = 'WEAPON_M4GOLDBEAST',
	label = 'M4GOLDBEAST',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_02') },
		{ name = 'clip_drum', label = "DRUM CLIP", hash = GetHashKey('COMPONENT_M4GOLDBEAST_CLIP_03') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_M4GOLDBEAST_SUPP_02') }
	}
},
{
	name = 'WEAPON_HELLSNIPER',
	label = 'HELLSNIPER',
	components = {
		{ name = 'clip_default', label = "CLIP DEFAULT", hash = GetHashKey('COMPONENT_HELLSNIPER_CLIP_01') },
		{ name = 'clip_extended', label = "EXTENDED CLIP", hash = GetHashKey('COMPONENT_HELLSNIPER_CLIP_02') },
		{ name = 'suppressor', label = "SUPPRESSOR", hash = GetHashKey('COMPONENT_AT_HELLSNIPER_SUPP') },
		{ name = 'scope', label = "SCOPE", hash = GetHashKey('COMPONENT_HELLSNIPER_SCOPE_MAX') }
	}
},
{
	name = 'WEAPON_357',
	label = ".357",
	components = {
		{ name = 'clip_default', label = ('component_clip_default'), hash = GetHashKey('COMPONENT_357_CLIP_01') },
		{ name = 'luxary_finish', label = "VARMOD2", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD4') },
		{ name = 'luxary_finish', label = "VARMOD3", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD6') },
		{ name = 'luxary_finish', label = "VARMOD4", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD17') },
		{ name = 'luxary_finish', label = "VARMOD5", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD22') },
		{ name = 'luxary_finish', label = "VARMOD6", hash = GetHashKey('COMPONENT_REVOLVER_VARMOD23') }
	}
},
{
	name = 'WEAPON_REVOLVERULTRA',
	label = "REVOLVERULTRA",
	components = {
		{ name = 'clip_default', label = ('component_clip_default'), hash = GetHashKey('COMPONENT_REVOLVERULTRA_CLIP_01') },
		{ name = 'suppressor', label = ('component_suppressor'), hash = GetHashKey('COMPONENT_AT_REVOLVERLEOSHOP_SUPP') }
	}
},

}
