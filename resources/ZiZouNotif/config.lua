Config = {}

Config.Timeout          = 9500          -- Overridden by the `timeout` param
Config.Position         = GetResourceKvpString("notif_position") or "bottomleft"
Config.Progress         = true          -- Overridden by the `progress` param
Config.Theme            = "default"     -- Overridden by the `theme` param
Config.Queue            = 5             -- No. of notifications to show before queueing
Config.Stacking         = true
Config.ShowStackedCount = true
Config.AnimationIn      = "fadeIn";     -- Enter animation - 'fadeOut', 'fadeOutLeft', 'flipOutX', 'flipOutY', 'bounceOutLeft', 'backOutLeft', 'slideOutLeft', 'zoomOut', 'zoomOutLeft'
Config.AnimationOut     = "fadeOut";    -- Exit animation - 'fadeOut', 'fadeOutLeft', 'flipOutX', 'flipOutY', 'bounceOutLeft', 'backOutLeft', 'slideOutLeft', 'zoomOut', 'zoomOutLeft'
Config.AnimationTime    = 350           -- Entry / exit animation interval
Config.SoundFile        = false         -- Sound file stored in ui/audio used for notification sound. Leave as false to disable.
Config.SoundVolume      = 0.4           -- 0.0 - 1.0


Config.Icons = {
    info = "info.png",
    error = "error.png",
    check = "check.png",
    message = "message.png",
}

Config.Pictures = {
    CHAR_ANO  = "CHAR_ANO.png",
    CHAR_TWITTER = "CHAR_TWITTER.png",
    CHAR_BAHAMAS = "CHAR_BAHAMA.png",
    CHAR_CONCESSIONNAIRE = "CHAR_CONCESSIONNAIRE.png",
    CHAR_EMS = "CHAR_EMS.png",
    CHAR_GALAXY = "CHAR_GALAXY.png",
    CHAR_IMMO = "CHAR_IMMO.png",
    CHAR_LSCUSTOM = "CHAR_LSCUSTOM.png",
    CHAR_VICECITY = "CHAR_VICECITY.png",
    CHAR_MECANO = "CHAR_MECANO.png",
    CHAR_TABAC = "CHAR_TABAC.png",
    CHAR_TAXI = "CHAR_TAXI.png",
    CHAR_TEQUILALA = "CHAR_TEQUILALA.png",
    CHAR_UNICORN = "CHAR_UNICORN.png",
    CHAR_VIGNERONS = "CHAR_VIGNERONS.png",
}