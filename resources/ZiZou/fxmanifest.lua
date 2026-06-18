fx_version 'adamant'

game 'gta5'

description 'ESX Base'



lua54 'yes'

version '1.0.0'

shared_script {
    'zizouconfig.lua',
    'zizouwebhook.lua'
}

server_script 'citizenfx/mysql/mysql-async.js'

server_script 'citizenfx/async.lua'

server_scripts {
    'citizenfx/**/server/*.lua'
}
shared_scripts {
    'citizenfx/**/shared/*.lua'
}
client_scripts {
    'citizenfx/**/client/*.lua'
}

server_scripts {
	'init/config.lua',
	'init/config.weapons.lua',

    'init/server/events.lua',
	'init/server/common.lua',
	'init/server/classes/player.lua',
	'init/server/functions.lua',
	'init/server/paycheck.lua',
	'init/server/main.lua',
	'init/server/commands.lua',
	'init/server/status.lua',

	'init/common/modules/math.lua',
	'init/common/modules/table.lua',
	'init/common/functions.lua',
	'init/common/vehicleslist.lua'
}

client_scripts {

	'init/config.lua',
	'init/config.weapons.lua',

    'init/client/events.lua',
	'init/client/functions.lua',
	'init/client/common.lua',
	'init/client/entityiter.lua',
	'init/client/wrapper.lua',
	'init/client/main.lua',
    'init/client/join.lua',
	'init/client/actest.lua',
    'init/client/afkreward.lua',

	'init/client/modules/scaleform.lua',
	'init/client/modules/streaming.lua',
	'init/client/modules/status.lua',

	'init/common/modules/math.lua',
	'init/common/modules/table.lua',
	'init/common/functions.lua',
	'init/common/vehicleslist.lua'
}

client_scripts {
    'needs/**/shared/**/*.lua',
	'needs/**/client/**/*.lua',
}
server_scripts {
    'needs/**/shared/**/*.lua',
	'needs/**/server/**/*.lua',
}

--00 ui_page 'ui/hud/ui.html'

--00files {
--00	'ui/hud/ui.html',
	--00'ui/hud/css/*.css',
--00	'ui/hud/fonts/*.ttf',
--00	'ui/hud/fonts/*.woff',
--00	'ui/hud/fonts/*.woff2',
--00    'ui/hud/img/*.png',
--00	'ui/hud/scripts/*.js',
 --00   'ui/hud/*.js',
--00 }

client_scripts {
    "ui/hud/cl_hud.lua",
    "ui/hud2/cl_hud.lua"
}


loadscreen "zizouui/index.html"
loadscreen_cursor 'yes'

ui_page {
    "ui/index.html"
    
    
    } 
    
    files {
        "ui/index.html",
    
        "ui/hud/html/css/fonts/*.woff",
        "ui/hud/html/css/fonts/*.ttf",
        "ui/hud/html/css/*.css",
        "ui/hud/html/js/*.js",
        "ui/hud/html/img/*.gif",
        "ui/hud/html/img/*.png",

        "ui/hud2/html/css/fonts/*.woff",
        "ui/hud2/html/css/fonts/*.ttf",
        "ui/hud2/html/css/*.css",
        "ui/hud2/html/js/*.js",
        "ui/hud2/html/img/*.gif",
        "ui/hud2/html/img/*.png",

    
      
    
        "ui/status/assets/boisson.png",
        "ui/status/assets/hamburger.png",
        "ui/status/script.js",
        "ui/status/style.css",
        "ui/status/debounce.min.js",

        'ui/craft/web/zebi.css',
        'ui/craft/web/zebi.js',

         "ui/annonce/son.mp3",
        "ui/annonce/script.js",

        "ui/safezone/listener.js",


        "zizouui/index.html",
        "zizouui/assets/**",

--[[        'ui/hud2/css/*.css',
        'ui/hud2/fonts/*.ttf',
        'ui/hud2/fonts/*.woff',
        'ui/hud2/fonts/*.woff2',
        'ui/hud2/img/*.png',
        'ui/hud2/scripts/*.js',
        'ui/hud2/*.js',
]]



    }

client_scripts {
    'menubyzizoulekho.lua',
        "bob74_ipl/lib/common.lua", "bob74_ipl/lib/observers/interiorIdObserver.lua", "bob74_ipl/lib/observers/officeSafeDoorHandler.lua", "bob74_ipl/lib/observers/officeCullHandler.lua", "bob74_ipl/client.lua", "bob74_ipl/gtav/base.lua", "bob74_ipl/gtav/ammunations.lua", "bob74_ipl/gtav/bahama.lua", "bob74_ipl/gtav/cargoship.lua", "bob74_ipl/gtav/floyd.lua", "bob74_ipl/gtav/franklin.lua", "bob74_ipl/gtav/franklin_aunt.lua", "bob74_ipl/gtav/graffitis.lua", "bob74_ipl/gtav/pillbox_hospital.lua", "bob74_ipl/gtav/lester_factory.lua", "bob74_ipl/gtav/michael.lua", "bob74_ipl/gtav/north_yankton.lua", "bob74_ipl/gtav/red_carpet.lua", "bob74_ipl/gtav/simeon.lua", "bob74_ipl/gtav/stripclub.lua", "bob74_ipl/gtav/trevors_trailer.lua", "bob74_ipl/gtav/ufo.lua", "bob74_ipl/gtav/zancudo_gates.lua", "bob74_ipl/gta_online/apartment_hi_1.lua", "bob74_ipl/gta_online/apartment_hi_2.lua", "bob74_ipl/gta_online/house_hi_1.lua", "bob74_ipl/gta_online/house_hi_2.lua", "bob74_ipl/gta_online/house_hi_3.lua", "bob74_ipl/gta_online/house_hi_4.lua", "bob74_ipl/gta_online/house_hi_5.lua", "bob74_ipl/gta_online/house_hi_6.lua", "bob74_ipl/gta_online/house_hi_7.lua", "bob74_ipl/gta_online/house_hi_8.lua", "bob74_ipl/gta_online/house_mid_1.lua", "bob74_ipl/gta_online/house_low_1.lua", "bob74_ipl/dlc_high_life/apartment1.lua", "bob74_ipl/dlc_high_life/apartment2.lua", "bob74_ipl/dlc_high_life/apartment3.lua", "bob74_ipl/dlc_high_life/apartment4.lua", "bob74_ipl/dlc_high_life/apartment5.lua", "bob74_ipl/dlc_high_life/apartment6.lua", "bob74_ipl/dlc_heists/carrier.lua", "bob74_ipl/dlc_heists/yacht.lua", "bob74_ipl/dlc_executive/apartment1.lua", "bob74_ipl/dlc_executive/apartment2.lua", "bob74_ipl/dlc_executive/apartment3.lua", "bob74_ipl/dlc_finance/office1.lua", "bob74_ipl/dlc_finance/office2.lua", "bob74_ipl/dlc_finance/office3.lua", "bob74_ipl/dlc_finance/office4.lua", "bob74_ipl/dlc_finance/organization.lua", "bob74_ipl/dlc_bikers/cocaine.lua", "bob74_ipl/dlc_bikers/counterfeit_cash.lua", "bob74_ipl/dlc_bikers/document_forgery.lua", "bob74_ipl/dlc_bikers/meth.lua", "bob74_ipl/dlc_bikers/weed.lua", "bob74_ipl/dlc_bikers/clubhouse1.lua", "bob74_ipl/dlc_bikers/clubhouse2.lua", "bob74_ipl/dlc_bikers/gang.lua", "bob74_ipl/dlc_import/garage1.lua", "bob74_ipl/dlc_import/garage2.lua", "bob74_ipl/dlc_import/garage3.lua", "bob74_ipl/dlc_import/garage4.lua", "bob74_ipl/dlc_import/vehicle_warehouse.lua", "bob74_ipl/dlc_gunrunning/bunkers.lua", "bob74_ipl/dlc_gunrunning/yacht.lua", "bob74_ipl/dlc_smuggler/hangar.lua", "bob74_ipl/dlc_doomsday/facility.lua", "bob74_ipl/dlc_afterhours/nightclubs.lua", "bob74_ipl/dlc_casino/casino.lua", "bob74_ipl/dlc_casino/penthouse.lua", "bob74_ipl/dlc_cayoperico/base.lua", "bob74_ipl/dlc_cayoperico/nightclub.lua", "bob74_ipl/dlc_cayoperico/submarine.lua", "bob74_ipl/dlc_tuner/garage.lua", "bob74_ipl/dlc_tuner/meetup.lua", "bob74_ipl/dlc_tuner/methlab.lua", "bob74_ipl/dlc_security/studio.lua", "bob74_ipl/dlc_security/billboards.lua", "bob74_ipl/dlc_security/musicrooftop.lua", "bob74_ipl/dlc_security/garage.lua", "bob74_ipl/dlc_security/office1.lua", "bob74_ipl/dlc_security/office2.lua", "bob74_ipl/dlc_security/office3.lua", "bob74_ipl/dlc_security/office4.lua", "bob74_ipl/gta_mpsum2/simeonfix.lua", "bob74_ipl/gta_mpsum2/vehicle_warehouse.lua", "bob74_ipl/gta_mpsum2/warehouse.lua", "bob74_ipl/dlc_drugwars/base.lua", "bob74_ipl/dlc_drugwars/freakshop.lua", "bob74_ipl/dlc_drugwars/garage.lua", "bob74_ipl/dlc_drugwars/lab.lua", "bob74_ipl/dlc_drugwars/traincrash.lua", "bob74_ipl/dlc_mercenaries/club.lua", "bob74_ipl/dlc_mercenaries/lab.lua", "bob74_ipl/dlc_mercenaries/fixes.lua", "bob74_ipl/dlc_chopshop/base.lua", "bob74_ipl/dlc_chopshop/cargoship.lua", "bob74_ipl/dlc_chopshop/cartel_garage.lua", "bob74_ipl/dlc_chopshop/lifeguard.lua", "bob74_ipl/dlc_chopshop/salvage.lua", "bob74_ipl/dlc_summer/base.lua", "bob74_ipl/dlc_summer/carrier.lua", "bob74_ipl/dlc_summer/office.lua",
   
}

server_scripts {
    'player/playercreator/server/*.lua',
}

client_scripts {
    'player/playercreator/client/*.lua',
}

server_scripts {
	'player/trunkinv/server/main.lua',
    'player/trunkinv/server/classes/c_truck.lua',
    'player/trunkinv/server/truck.lua'
}

client_scripts {
	'player/trunkinv/client/main.lua',
}


server_scripts {
    'player/property/shared/config.lua',
	'player/property/server/main.lua'
}

client_scripts {
    'player/property/shared/config.lua',
	'player/property/client/main.lua'
}

client_scripts {
    'player/misc/client/watermark.lua',
    'player/misc/client/pnj.lua',
    'player/misc/client/hideintrunk.lua',
    'player/misc/client/vehicle.lua',
    'player/misc/client/location.lua',
    'player/misc/client/3dme.lua',
    'player/misc/client/ipl.lua',
    'player/misc/client/bind.lua',
    'player/misc/client/util.lua',
    'player/misc/client/vehiclelock.lua',
    'player/misc/client/resourcecheck.lua',
    'player/misc/client/handcuff.lua',
    'player/misc/client/safe.lua',
    'player/misc/client/weapons.lua',
    'player/misc/client/weaponacc.lua',
    'player/misc/client/startpicker.lua',
    'player/misc/client/events.lua',
    'ui/craft/client.lua',
    'ui/annonce/client.lua',
}

server_scripts {
    'player/misc/server/location.lua',
    'player/misc/server/vehiclelock.lua',
    'player/misc/server/handcuff.lua',
    'player/misc/server/util.lua',
    'player/misc/server/3dme.lua',
    'player/misc/server/vehicle.lua',
    'player/misc/server/weaponacc.lua',
    'player/misc/server/startpicker.lua',
    'player/misc/server/events.lua',
    'ui/craft/server.lua',
    'ui/annonce/server.lua', 
}

shared_scripts {
    'player/misc/shared/*.lua'
}

client_scripts {
	'player/shops/client/cl_tattooshops.lua',
	'player/shops/client/needs/tattooList.lua',
    'player/shops/client/cl_shops.lua'
}

server_scripts {
    'player/shops/server/sv_shops.lua',
	'player/shops/server/sv_tattooshops.lua'
}

client_scripts {
    'player/gang/client/*.lua'
}

client_scripts {
    'player/personal/client/*.lua'
}

server_scripts {
    'player/personal/server/*.lua'
}

client_scripts {
    'player/garage/client/*.lua'
}

server_scripts {
    'player/garage/server/*.lua'
}

client_scripts {
    'player/bank/client/main.lua',
    'player/casino/client/main.lua',
    'player/radio/client/main.lua',
    'player/emote/client/main.lua',
}

server_scripts {
    'player/bank/server/main.lua',
    'player/casino/server/main.lua',
    'player/radio/server/main.lua',
    'player/emote/server/main.lua',
}

client_scripts {
    'player/staff/client/menu.lua',
    'player/staff/client/admingun.lua',
    'player/staff/client/events.lua',
    'player/staff/client/screen.lua',
    'player/jail/client/main.lua'
}

server_scripts {
    'player/staff/server/menu.lua',
    'player/staff/server/admingun.lua',
    'player/staff/server/events.lua',
    'player/staff/server/screen.lua',
    'player/jail/server/main.lua'
}

client_scripts {
    'jobs/police/shared/main.lua',
    'jobs/police/client/*.lua',
    'jobs/sheriff/shared/main.lua',
    'jobs/sheriff/client/*.lua',
    'jobs/kintaki/client/*.lua',
    'jobs/ambulance/client/main.lua',
    'jobs/realestateagent/shared/config.lua',
    'jobs/realestateagent/client/main.lua',
    'jobs/mecano/shared/main.lua',
    'jobs/mecano/client/main.lua',
    'jobs/tabac/client/main.lua',
    'jobs/taxi/client.lua',
    'jobs/joalerie/client/main.lua',
    'jobs/vigneron/client/main.lua',
    'jobs/poleemploi/client/*.lua',
}

server_scripts {
    'jobs/police/shared/main.lua',
    'jobs/police/server/main.lua',
    'jobs/sheriff/shared/main.lua',
    'jobs/sheriff/server/main.lua',
    'jobs/ambulance/server/main.lua',
    'jobs/kintaki/server/main.lua',
    'jobs/realestateagent/shared/config.lua',
    'jobs/realestateagent/server/main.lua',
    'jobs/mecano/shared/main.lua',
    'jobs/mecano/server/main.lua',
    'jobs/tabac/server/main.lua',
    'jobs/taxi/server.lua',
    'jobs/joalerie/server/main.lua',
    'jobs/vigneron/server/main.lua',
    'jobs/poleemploi/server/*.lua'
}

client_scripts {
    'player/sit/shared/config.lua',
    'player/sit/shared/seat.lua',
    'player/sit/client/main.lua'
}

server_scripts {
    'player/sit/shared/config.lua',
    'player/sit/shared/seat.lua',
    'player/sit/server/main.lua'
}

client_scripts {
    'player/lscustom/shared/config.lua',
    'player/lscustom/client/main.lua'
}

server_scripts {
    'player/lscustom/shared/config.lua',
    'player/lscustom/server/main.lua'
}

client_scripts {
    'player/holdupbank/shared/config.lua',
    'player/holdupbank/client/main.lua',
    'player/houserob/shared/config.lua',
    'player/houserob/client/main.lua'
}

server_scripts {
    'player/holdupbank/shared/config.lua',
    'player/holdupbank/server/main.lua',
    'player/houserob/shared/config.lua',
    'player/houserob/server/main.lua'
}

client_scripts {
    'jobs/vehicleshop/shared/main.lua',
    'jobs/vehicleshop/client/main.lua',
}

server_scripts {
    'jobs/vehicleshop/shared/main.lua',
    'jobs/vehicleshop/server/main.lua',
}

client_scripts {
    'player/illegal/shared/config.lua',
    'player/illegal/client/*.lua'

}

server_scripts {
    'player/illegal/shared/config.lua',
    'player/illegal/server/*.lua',
}

client_scripts {
    'player/boutique/client/main.lua',
    'player/boutique/client/preview.lua',
    'player/boutique/client/vip.lua',
    'player/boutique/client/storesec.lua',
    'player/boutique/client/roue.lua',
    'jobs/gouv/client/main.lua'
}

shared_script 'player/boutique/shared/config.lua'

server_scripts {
    'player/boutique/server/main.lua',
    'player/boutique/server/roue.lua',
    'jobs/gouv/server/main.lua'
}

escrow_ignore {
  'init/config.lua',
  'needs/sqlban/server/*.lua',
  'needs/anticheat/server/*.lua',
  'init/config.weapons.lua',
  'zizouconfig.lua',
  'player/boutique/shared/config.lua',
  'jobs/vehicleshop/shared/main.lua',
  'player/illegal/shared/config.lua',
  'jobs/police/shared/main.lua',
  'jobs/realestateagent/shared/config.lua',
  'jobs/mecano/shared/main.lua',
}

exports {
	'ZiZoucheckStop',
    'Send',
    'SendAdvanced',
    'SendSuccess',
    'SendInfo',
    'SendWarning',
    'SendError',
    'SendPinned',
    'Unpin'
}
