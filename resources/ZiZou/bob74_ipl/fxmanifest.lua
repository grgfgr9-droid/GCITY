fx_version 'cerulean'
game 'gta5'

author 'Bob_74'
description 'Load and customize your map'
version '2.3.3'

lua54 "yes"

client_scripts {
    "bob74_ipl/lib/common.lua"
    , "bob74_ipl/lib/observers/interiorIdObserver.lua"
    , "bob74_ipl/lib/observers/officeSafeDoorHandler.lua"
    , "bob74_ipl/lib/observers/officeCullHandler.lua"
    , "bob74_ipl/client.lua"

    -- GTA V
    , "bob74_ipl/gtav/base.lua"   -- Base IPLs to fix holes
    , "bob74_ipl/gtav/ammunations.lua"
    , "bob74_ipl/gtav/bahama.lua"
    , "bob74_ipl/gtav/cargoship.lua"
    , "bob74_ipl/gtav/floyd.lua"
    , "bob74_ipl/gtav/franklin.lua"
    , "bob74_ipl/gtav/franklin_aunt.lua"
    , "bob74_ipl/gtav/graffitis.lua"
    , "bob74_ipl/gtav/pillbox_hospital.lua"
    , "bob74_ipl/gtav/lester_factory.lua"
    , "bob74_ipl/gtav/michael.lua"
    , "bob74_ipl/gtav/north_yankton.lua"
    , "bob74_ipl/gtav/red_carpet.lua"
    , "bob74_ipl/gtav/simeon.lua"
    , "bob74_ipl/gtav/stripclub.lua"
    , "bob74_ipl/gtav/trevors_trailer.lua"
    , "bob74_ipl/gtav/ufo.lua"
    , "bob74_ipl/gtav/zancudo_gates.lua"

    -- GTA Online
    , "bob74_ipl/gta_online/apartment_hi_1.lua"
    , "bob74_ipl/gta_online/apartment_hi_2.lua"
    , "bob74_ipl/gta_online/house_hi_1.lua"
    , "bob74_ipl/gta_online/house_hi_2.lua"
    , "bob74_ipl/gta_online/house_hi_3.lua"
    , "bob74_ipl/gta_online/house_hi_4.lua"
    , "bob74_ipl/gta_online/house_hi_5.lua"
    , "bob74_ipl/gta_online/house_hi_6.lua"
    , "bob74_ipl/gta_online/house_hi_7.lua"
    , "bob74_ipl/gta_online/house_hi_8.lua"
    , "bob74_ipl/gta_online/house_mid_1.lua"
    , "bob74_ipl/gta_online/house_low_1.lua"

    -- DLC High Life
    , "bob74_ipl/dlc_high_life/apartment1.lua"
    , "bob74_ipl/dlc_high_life/apartment2.lua"
    , "bob74_ipl/dlc_high_life/apartment3.lua"
    , "bob74_ipl/dlc_high_life/apartment4.lua"
    , "bob74_ipl/dlc_high_life/apartment5.lua"
    , "bob74_ipl/dlc_high_life/apartment6.lua"

    -- DLC Heists
    , "bob74_ipl/dlc_heists/carrier.lua"
    , "bob74_ipl/dlc_heists/yacht.lua"

    -- DLC Executives & Other Criminals
    , "bob74_ipl/dlc_executive/apartment1.lua"
    , "bob74_ipl/dlc_executive/apartment2.lua"
    , "bob74_ipl/dlc_executive/apartment3.lua"

    -- DLC Finance & Felony
    , "bob74_ipl/dlc_finance/office1.lua"
    , "bob74_ipl/dlc_finance/office2.lua"
    , "bob74_ipl/dlc_finance/office3.lua"
    , "bob74_ipl/dlc_finance/office4.lua"
    , "bob74_ipl/dlc_finance/organization.lua"

    -- DLC Bikers
    , "bob74_ipl/dlc_bikers/cocaine.lua"
    , "bob74_ipl/dlc_bikers/counterfeit_cash.lua"
    , "bob74_ipl/dlc_bikers/document_forgery.lua"
    , "bob74_ipl/dlc_bikers/meth.lua"
    , "bob74_ipl/dlc_bikers/weed.lua"
    , "bob74_ipl/dlc_bikers/clubhouse1.lua"
    , "bob74_ipl/dlc_bikers/clubhouse2.lua"
    , "bob74_ipl/dlc_bikers/gang.lua"

    -- DLC Import/Export
    , "bob74_ipl/dlc_import/garage1.lua"
    , "bob74_ipl/dlc_import/garage2.lua"
    , "bob74_ipl/dlc_import/garage3.lua"
    , "bob74_ipl/dlc_import/garage4.lua"
    , "bob74_ipl/dlc_import/vehicle_warehouse.lua"

    -- DLC Gunrunning
    , "bob74_ipl/dlc_gunrunning/bunkers.lua"
    , "bob74_ipl/dlc_gunrunning/yacht.lua"

    -- DLC Smuggler's Run
    , "bob74_ipl/dlc_smuggler/hangar.lua"

    -- DLC Doomsday Heist
    , "bob74_ipl/dlc_doomsday/facility.lua"

    -- DLC After Hours
    , "bob74_ipl/dlc_afterhours/nightclubs.lua"

    -- DLC Diamond Casino (Requires forced build 2060 or higher)
    , "bob74_ipl/dlc_casino/casino.lua"
    , "bob74_ipl/dlc_casino/penthouse.lua"

    -- DLC Cayo Perico Heist (Requires forced build 2189 or higher)
    , "bob74_ipl/dlc_cayoperico/base.lua"
    , "bob74_ipl/dlc_cayoperico/nightclub.lua"
    , "bob74_ipl/dlc_cayoperico/submarine.lua"

    -- DLC Tuners (Requires forced build 2372 or higher)
    , "bob74_ipl/dlc_tuner/garage.lua"
    , "bob74_ipl/dlc_tuner/meetup.lua"
    , "bob74_ipl/dlc_tuner/methlab.lua"

    -- DLC The Contract (Requires forced build 2545 or higher)
    , "bob74_ipl/dlc_security/studio.lua"
    , "bob74_ipl/dlc_security/billboards.lua"
    , "bob74_ipl/dlc_security/musicrooftop.lua"
    , "bob74_ipl/dlc_security/garage.lua"
    , "bob74_ipl/dlc_security/office1.lua"
    , "bob74_ipl/dlc_security/office2.lua"
    , "bob74_ipl/dlc_security/office3.lua"
    , "bob74_ipl/dlc_security/office4.lua"

    -- DLC The Criminal Enterprises (Requires forced build 2699 or higher)
    , "bob74_ipl/gta_mpsum2/simeonfix.lua"
    , "bob74_ipl/gta_mpsum2/vehicle_warehouse.lua"
    , "bob74_ipl/gta_mpsum2/warehouse.lua"

    -- DLC Los Santos Drug Wars (Requires forced build 2802 or higher)
    , "bob74_ipl/dlc_drugwars/base.lua"
    , "bob74_ipl/dlc_drugwars/freakshop.lua"
    , "bob74_ipl/dlc_drugwars/garage.lua"
    , "bob74_ipl/dlc_drugwars/lab.lua"
    , "bob74_ipl/dlc_drugwars/traincrash.lua"

    -- DLC San Andreas Mercenaries (Requires forced build 2944 or higher)
    , "bob74_ipl/dlc_mercenaries/club.lua"
    , "bob74_ipl/dlc_mercenaries/lab.lua"
    , "bob74_ipl/dlc_mercenaries/fixes.lua"

    -- DLC The Chop Shop (Requires forced build 3095 or higher)
    , "bob74_ipl/dlc_chopshop/base.lua"
    , "bob74_ipl/dlc_chopshop/cargoship.lua"
    , "bob74_ipl/dlc_chopshop/cartel_garage.lua"
    , "bob74_ipl/dlc_chopshop/lifeguard.lua"
    , "bob74_ipl/dlc_chopshop/salvage.lua"

    -- DLC Bottom Dollar Bounties (Requires forced build 3258 or higher)
    , "bob74_ipl/dlc_summer/base.lua"
    , "bob74_ipl/dlc_summer/carrier.lua"
    , "bob74_ipl/dlc_summer/office.lua"
}
