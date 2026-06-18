    -- ====================================================================
    -- =------------------- [LIB] ---------------------=
    -- ====================================================================
    -- Global variables
    Global = {
        currentInteriorId = 0,
    
        -- The current interior is set to True by 'interiorIdObserver'
        Online = {
            isInsideApartmentHi1 = false,
            isInsideApartmentHi2 = false,
            isInsideHouseHi1 = false,
            isInsideHouseHi2 = false,
            isInsideHouseHi3 = false,
            isInsideHouseHi4 = false,
            isInsideHouseHi5 = false,
            isInsideHouseHi6 = false,
            isInsideHouseHi7 = false,
            isInsideHouseHi8 = false,
            isInsideHouseLow1 = false,
            isInsideHouseMid1 = false
        },
        Biker = {
            isInsideClubhouse1 = false,
            isInsideClubhouse2 = false
        },
        FinanceOffices = {
            isInsideOffice1 = false,
            isInsideOffice2 = false,
            isInsideOffice3 = false,
            isInsideOffice4 = false
        },
        HighLife = {
            isInsideApartment1 = false,
            isInsideApartment2 = false,
            isInsideApartment3 = false,
            isInsideApartment4 = false,
            isInsideApartment5 = false,
            isInsideApartment6 = false
            
        },
    
    
        -- Set all interiors variables to false
        -- The loop inside 'interiorIdObserver' will set them to true
        ResetInteriorVariables = function()
            for _, parentKey in pairs{"Biker", "FinanceOffices", "HighLife"} do
                local t = Global[parentKey]
                for key in pairs(t) do
                    t[key] = false
                end
            end
        end
    }
    
    
    
    
    exports('GVariables', function()
        return Global
    end)
    
    exports('EnableIpl', function(ipl, activate)
        return EnableIpl(ipl, activate)
    end)
    
    exports('GetPedheadshotTexture', function(ped)
        return GetPedheadshotTexture(ped)
    end)
    
    -- Load or remove IPL(s)
    function EnableIpl(ipl, activate)
        if IsTable(ipl) then
            for key, value in pairs(ipl) do
                EnableIpl(value, activate)
            end
        else
            if activate then
                if not IsIplActive(ipl) then RequestIpl(ipl) end
            else
                if IsIplActive(ipl) then RemoveIpl(ipl) end
            end
        end
    end
    
    -- Enable or disable the specified props in an interior
    function SetIplPropState(interiorId, props, state, refresh)
        if refresh == nil then refresh = false end
        if IsTable(interiorId) then
            for key, value in pairs(interiorId) do
                SetIplPropState(value, props, state, refresh)
            end
        else
            if IsTable(props) then
                for key, value in pairs(props) do
                    SetIplPropState(interiorId, value, state, refresh)
                end
            else
                if state then
                    if not IsInteriorPropEnabled(interiorId, props) then EnableInteriorProp(interiorId, props) end
                else
                    if IsInteriorPropEnabled(interiorId, props) then DisableInteriorProp(interiorId, props) end
                end
            end
            if refresh == true then RefreshInterior(interiorId) end
        end
    end
    
    function CreateNamedRenderTargetForModel(name, model)
        local handle = 0
        if not IsNamedRendertargetRegistered(name) then
            RegisterNamedRendertarget(name, false)
        end
        if not IsNamedRendertargetLinked(model) then
            LinkNamedRendertarget(model)
        end
        if IsNamedRendertargetRegistered(name) then
            handle = GetNamedRendertargetRenderId(name)
        end
    
        return handle
    end
    
    function DrawEmptyRect(name, model)
        local step = 250
        local timeout = 5 * 1000
        local currentTime = 0
        local renderId = CreateNamedRenderTargetForModel(name, model)
    
        while (not IsNamedRendertargetRegistered(name)) do
            Citizen.Wait(step)
            currentTime = currentTime + step
            if (currentTime >= timeout) then return false end
        end
        if (IsNamedRendertargetRegistered(name)) then
            SetTextRenderId(renderId)
            SetUiLayer(4)
            DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 0)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    
            ReleaseNamedRendertarget(0, name)
        end
    
        return true
    end
    
    function SetupScaleform(movieId, scaleformFunction, parameters)
        BeginScaleformMovieMethod(movieId, scaleformFunction)
        N_0x77fe3402004cd1b0(name)
        if (IsTable(parameters)) then
            for i = 0, Tablelength(parameters) - 1 do
                local p = parameters["p" .. tostring(i)]
                if (p.type == "bool") then
                    PushScaleformMovieMethodParameterBool(p.value)
                elseif (p.type == "int") then
                    PushScaleformMovieMethodParameterInt(p.value)
                elseif (p.type == "float") then
                    PushScaleformMovieMethodParameterFloat(p.value)
                elseif (p.type == "string") then
                    PushScaleformMovieMethodParameterString(p.value)
                elseif (p.type == "buttonName") then
                    PushScaleformMovieMethodParameterButtonName(p.value)
                end
            end
        end
        EndScaleformMovieMethod()
        N_0x32f34ff7f617643b(movieId, 1)
    end
    
    function LoadStreamedTextureDict(texturesDict)
        local step = 1000
        local timeout = 5 * 1000
        local currentTime = 0
    
        RequestStreamedTextureDict(texturesDict, 0)
        while not HasStreamedTextureDictLoaded(texturesDict) do
            Citizen.Wait(step)
            currentTime = currentTime + step
            if (currentTime >= timeout) then return false end
        end
        return true
    end
    
    function LoadScaleform(scaleform)
        local step = 1000
        local timeout = 5 * 1000
        local currentTime = 0
        local handle = RequestScaleformMovie(scaleform)
    
        while (not HasScaleformMovieLoaded(handle)) do
            Citizen.Wait(step)
            currentTime = currentTime + step
            if (currentTime >= timeout) then return -1 end
        end
    
        return handle
    end
    
    function GetPedheadshot(ped)
        local step = 1000
        local timeout = 5 * 1000
        local currentTime = 0
        local pedheadshot = RegisterPedheadshot(ped)
    
        while not IsPedheadshotReady(pedheadshot) do
            Citizen.Wait(step)
            currentTime = currentTime + step
            if (currentTime >= timeout) then return -1 end
        end
    
        return pedheadshot
    end
    
    function GetPedheadshotTexture(ped)
        local textureDict = nil
        local pedheadshot = GetPedheadshot(ped)
    
        if (pedheadshot ~= -1) then
            textureDict = GetPedheadshotTxdString(pedheadshot)
            local IsTextureDictLoaded = LoadStreamedTextureDict(textureDict)
            if (not IsTextureDictLoaded) then
                Citizen.Trace("ERROR: BikerClubhouseDrawMembers - Textures dictionnary \"" .. tostring(textureDict) .. "\" cannot be loaded.")
            end
        else
            Citizen.Trace("ERROR: BikerClubhouseDrawMembers - PedHeadShot not ready.")
        end
    
        return textureDict
    end
    
    -- Check if a variable is a table
    function IsTable(T)
        return type(T) == 'table'
    end
    -- Return the number of elements of the table
    function Tablelength(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
    end
    
    
    local _scanDelay = 500
    
    Citizen.CreateThread(function()
        while true do
            -- /!\ To do: Find a more reliable way to get the current interior ID
            Global.currentInteriorId = GetInteriorAtCoords(GetEntityCoords(GetPlayerPed(-1)))
    
            if (Global.currentInteriorId == 0) then
                Global.ResetInteriorVariables()
            else
                -- Setting variables
    
                -- GTA Online
                Global.Online.isInsideApartmentHi1 = (Global.currentInteriorId == GTAOApartmentHi1.interiorId)
                Global.Online.isInsideApartmentHi2 = (Global.currentInteriorId == GTAOApartmentHi2.interiorId)
                Global.Online.isInsideHouseHi1 = (Global.currentInteriorId == GTAOHouseHi1.interiorId)
                Global.Online.isInsideHouseHi2 = (Global.currentInteriorId == GTAOHouseHi2.interiorId)
                Global.Online.isInsideHouseHi3 = (Global.currentInteriorId == GTAOHouseHi3.interiorId)
                Global.Online.isInsideHouseHi4 = (Global.currentInteriorId == GTAOHouseHi4.interiorId)
                Global.Online.isInsideHouseHi5 = (Global.currentInteriorId == GTAOHouseHi5.interiorId)
                Global.Online.isInsideHouseHi6 = (Global.currentInteriorId == GTAOHouseHi6.interiorId)
                Global.Online.isInsideHouseHi7 = (Global.currentInteriorId == GTAOHouseHi7.interiorId)
                Global.Online.isInsideHouseHi8 = (Global.currentInteriorId == GTAOHouseHi8.interiorId)
                Global.Online.isInsideHouseLow1 = (Global.currentInteriorId == GTAOHouseLow1.interiorId)
                Global.Online.isInsideHouseMid1 = (Global.currentInteriorId == GTAOHouseMid1.interiorId)
    
                -- DLC: High life
                Global.HighLife.isInsideApartment1 = (Global.currentInteriorId == HLApartment1.interiorId)
                Global.HighLife.isInsideApartment2 = (Global.currentInteriorId == HLApartment2.interiorId)
                Global.HighLife.isInsideApartment3 = (Global.currentInteriorId == HLApartment3.interiorId)
                Global.HighLife.isInsideApartment4 = (Global.currentInteriorId == HLApartment4.interiorId)
                Global.HighLife.isInsideApartment5 = (Global.currentInteriorId == HLApartment5.interiorId)
                Global.HighLife.isInsideApartment6 = (Global.currentInteriorId == HLApartment6.interiorId)
    
                -- DLC: Bikers - Clubhouses
                Global.Biker.isInsideClubhouse1 = (Global.currentInteriorId == BikerClubhouse1.interiorId)
                Global.Biker.isInsideClubhouse2 = (Global.currentInteriorId == BikerClubhouse2.interiorId)
    
                -- DLC: Finance & Felony - Offices
                Global.FinanceOffices.isInsideOffice1 = (Global.currentInteriorId == FinanceOffice1.currentInteriorId)
                Global.FinanceOffices.isInsideOffice2 = (Global.currentInteriorId == FinanceOffice2.currentInteriorId)
                Global.FinanceOffices.isInsideOffice3 = (Global.currentInteriorId == FinanceOffice3.currentInteriorId)
                Global.FinanceOffices.isInsideOffice4 = (Global.currentInteriorId == FinanceOffice4.currentInteriorId)
            end
    
            Wait(_scanDelay)
    
        end
    end)
    
    
    -- Delay between each attempt to open/close the doors corresponding to their state
    local _scanDelay = 500
    
    Citizen.CreateThread(function()
        while true do
            local office = 0
            
            -- Search for the current office to open/close the safes doors
            if (Global.FinanceOffices.isInsideOffice1) then office = FinanceOffice1
                elseif (Global.FinanceOffices.isInsideOffice2) then office = FinanceOffice2
                elseif (Global.FinanceOffices.isInsideOffice3) then office = FinanceOffice3
                elseif (Global.FinanceOffices.isInsideOffice4) then office = FinanceOffice4
            end
    
            if (office ~= 0) then
                -- Office found, let's check the doors
                -- Check left door
                doorHandle = office.Safe.GetDoorHandle(office.currentSafeDoors.hashL)
                if (doorHandle ~= 0) then
                    if (office.Safe.isLeftDoorOpen) then office.Safe.SetDoorState("left", true)
                    else office.Safe.SetDoorState("left", false) end
                end
    
                -- Check right door
                doorHandle = office.Safe.GetDoorHandle(office.currentSafeDoors.hashR)
                if (doorHandle ~= 0) then
                    if (office.Safe.isRightDoorOpen) then office.Safe.SetDoorState("right", true)
                    else office.Safe.SetDoorState("right", false) end
                end
            end
    
            Wait(_scanDelay)
        end
    end)

Citizen.CreateThread(function()
    -- ====================================================================
    -- =--------------------- [GTA V: Single player] ---------------------=
    -- ====================================================================

    -- Michael: -802.311, 175.056, 72.8446
    Michael.LoadDefault()

    -- Simeon: -47.16170 -1115.3327 26.5
    Simeon.LoadDefault()

    -- Franklin's aunt: -9.96562, -1438.54, 31.1015
    FranklinAunt.LoadDefault()

    -- Franklin
    Franklin.LoadDefault()

    -- Floyd: -1150.703, -1520.713, 10.633
    Floyd.LoadDefault()

    -- Trevor: 1985.48132, 3828.76757, 32.5
    TrevorsTrailer.LoadDefault()

    -- Bahama Mamas: -1388.0013, -618.41967, 30.819599
    BahamaMamas.Enable(true)

    -- Pillbox hospital: 307.1680, -590.807, 43.280
    PillboxHospital.Enable(true)

    -- Zancudo Gates (GTAO like): -1600.30100000, 2806.73100000, 18.79683000
    ZancudoGates.LoadDefault()

    -- Other
    Ammunations.LoadDefault()
    LesterFactory.LoadDefault()
    StripClub.LoadDefault()

    Graffitis.Enable(true)

    -- UFO
    UFO.Hippie.Enable(false)    -- 2490.47729, 3774.84351, 2414.035
    UFO.Chiliad.Enable(false)   -- 501.52880000, 5593.86500000, 796.23250000
    UFO.Zancudo.Enable(false)   -- -2051.99463, 3237.05835, 1456.97021
    
    -- Red Carpet: 300.5927, 199.7589, 104.3776
    RedCarpet.Enable(false)
    
    -- North Yankton: 3217.697, -4834.826, 111.8152
    NorthYankton.Enable(false)

    -- ====================================================================
    -- =-------------------------- [GTA Online] --------------------------=
    -- ====================================================================
    GTAOApartmentHi1.LoadDefault()      -- -35.31277 -580.4199 88.71221 (4 Integrity Way, Apt 30)
    GTAOApartmentHi2.LoadDefault()      -- -1477.14 -538.7499 55.5264 (Dell Perro Heights, Apt 7)
    GTAOHouseHi1.LoadDefault()          -- -169.286 486.4938 137.4436 (3655 Wild Oats Drive)
    GTAOHouseHi2.LoadDefault()          -- 340.9412 437.1798 149.3925 (2044 North Conker Avenue)
    GTAOHouseHi3.LoadDefault()          -- 373.023 416.105 145.7006 (2045 North Conker Avenue)
    GTAOHouseHi4.LoadDefault()          -- -676.127 588.612 145.1698 (2862 Hillcrest Avenue)
    GTAOHouseHi5.LoadDefault()          -- -763.107 615.906 144.1401 (2868 Hillcrest Avenue)
    GTAOHouseHi6.LoadDefault()          -- -857.798 682.563 152.6529 (2874 Hillcrest Avenue)
    GTAOHouseHi7.LoadDefault()          -- 120.5 549.952 184.097 (2677 Whispymound Drive)
    GTAOHouseHi8.LoadDefault()          -- -1288 440.748 97.69459 (2133 Mad Wayne Thunder)
    GTAOHouseMid1.LoadDefault()         -- 347.2686 -999.2955 -99.19622
    GTAOHouseLow1.LoadDefault()         -- 261.4586 -998.8196 -99.00863

    -- ====================================================================
    -- =------------------------ [DLC: High life] ------------------------=
    -- ====================================================================
    HLApartment1.LoadDefault()          -- -1468.14 -541.815 73.4442 (Dell Perro Heights, Apt 4)
    HLApartment2.LoadDefault()          -- -915.811 -379.432 113.6748 (Richard Majestic, Apt 2)
    HLApartment3.LoadDefault()          -- -614.86 40.6783 97.60007 (Tinsel Towers, Apt 42)
    HLApartment4.LoadDefault()          -- -773.407 341.766 211.397 (EclipseTowers, Apt 3)
    HLApartment5.LoadDefault()          -- -18.07856 -583.6725 79.46569 (4 Integrity Way, Apt 28)
    HLApartment6.LoadDefault()          -- -609.56690000 51.28212000 -183.98080

    -- ====================================================================
    -- =-------------------------- [DLC: Heists] -------------------------=
    -- ====================================================================
    HeistCarrier.Enable(true)       -- 3082.3117, -4717.1191, 15.2622
    HeistYacht.LoadDefault()        -- -2043.974,-1031.582, 11.981

    -- ====================================================================
    -- =--------------- [DLC: Executives & Other Criminals] --------------=
    -- ====================================================================
    ExecApartment1.LoadDefault()    -- -787.7805 334.9232 215.8384 (EclipseTowers, Penthouse Suite 1)
    ExecApartment2.LoadDefault()    -- -773.2258 322.8252 194.8862 (EclipseTowers, Penthouse Suite 2)
    ExecApartment3.LoadDefault()    -- -787.7805 334.9232 186.1134 (EclipseTowers, Penthouse Suite 3)
    
    -- ====================================================================
    -- =-------------------- [DLC: Finance  & Felony] --------------------=
    -- ====================================================================
    FinanceOffice1.LoadDefault()    -- -141.1987, -620.913, 168.8205 (Arcadius Business Centre)
    FinanceOffice2.LoadDefault()    -- -75.8466, -826.9893, 243.3859 (Maze Bank Building)
    FinanceOffice3.LoadDefault()    -- -1579.756, -565.0661, 108.523 (Lom Bank)
    FinanceOffice4.LoadDefault()    -- -1392.667, -480.4736, 72.04217 (Maze Bank West)

    -- ====================================================================
    -- =-------------------------- [DLC: Bikers] -------------------------=
    -- ====================================================================
    BikerCocaine.LoadDefault()	        -- Cocaine lockup: 1093.6, -3196.6, -38.99841
    BikerCounterfeit.LoadDefault()      -- Counterfeit cash factory: 1121.897, -3195.338, -40.4025
    BikerDocumentForgery.LoadDefault()  -- Document forgery: 1165, -3196.6, -39.01306
    BikerMethLab.LoadDefault()          -- Meth lab: 1009.5, -3196.6, -38.99682
    BikerWeedFarm.LoadDefault()         -- Weed farm: 1051.491, -3196.536, -39.14842
    BikerClubhouse1.LoadDefault()       -- 1107.04, -3157.399, -37.51859
    BikerClubhouse2.LoadDefault()       -- 998.4809, -3164.711, -38.90733

    -- ====================================================================
    -- =---------------------- [DLC: Import/Export] ----------------------=
    -- ====================================================================
    ImportCEOGarage1.LoadDefault()             -- Arcadius Business Centre
    ImportCEOGarage2.LoadDefault()             -- Maze Bank Building               /!\ Do not load parts Garage1, Garage2 and Garage3 at the same time (overlaping issues)
    ImportCEOGarage3.LoadDefault()             -- Lom Bank                         /!\ Do not load parts Garage1, Garage2 and Garage3 at the same time (overlaping issues)
    ImportCEOGarage4.LoadDefault()             -- Maze Bank West                   /!\ Do not load parts Garage1, Garage2 and Garage3 at the same time (overlaping issues)
    ImportVehicleWarehouse.LoadDefault()       -- Vehicle warehouse: 994.5925, -3002.594, -39.64699

    -- ====================================================================
    -- =------------------------ [DLC: Gunrunning] -----------------------=
    -- ====================================================================
    GunrunningBunker.LoadDefault()  -- 892.6384, -3245.8664, -98.2645
    GunrunningYacht.LoadDefault()   -- -1363.724, 6734.108, 2.44598
    
    -- ====================================================================
    -- =---------------------- [DLC: Smuggler's Run] ---------------------=
    -- ====================================================================
    SmugglerHangar.LoadDefault()    -- -1267.0 -3013.135 -49.5

    -- ====================================================================
    -- =-------------------- [DLC: The Doomsday Heist] -------------------=
    -- ====================================================================
    DoomsdayFacility.LoadDefault()

    -- ====================================================================
    -- =----------------------- [DLC: After Hours] -----------------------=
    -- ====================================================================
    AfterHoursNightclubs.LoadDefault()          -- -1604.664, -3012.583, -78.000

    -- ====================================================================
    -- =------------------- [DLC: Diamond Casino Resort] -----------------=
    -- ====================================================================
    if GetGameBuildNumber() >= 2060 then
        DiamondCasino.LoadDefault()                -- 1100.000, 220.000, -50.000
        DiamondPenthouse.LoadDefault()             -- 976.636, 70.295, 115.164
    end

    -- ====================================================================
    -- =------------------- [DLC: Los Santos Tuners] ---------------------=
    -- ====================================================================
    if GetGameBuildNumber() >= 2372 then
        TunerGarage.LoadDefault()   -- -1350.0, 160.0, -100.0
        TunerMethLab.LoadDefault()  -- 981.9999, -143.0, -50.0
        TunerMeetup.LoadDefault()   -- -2000.0, 1113.211, -25.36243
    end

    -- ====================================================================
    -- =------------------- [DLC: Los Santos The Contract] ---------------------=
    -- ====================================================================
    if GetGameBuildNumber() >= 2545 then
        MpSecurityGarage.LoadDefault()   -- -1071.4387, -77.033875, -93.525505
        MpSecurityMusicRoofTop.LoadDefault()   -- -592.6896, 273.1052, 116.302444
        MpSecurityStudio.LoadDefault()   -- -1000.7252, -70.559875, -98.10669
        MpSecurityBillboards.LoadDefault()   -- -592.6896, 273.1052, 116.302444
        MpSecurityOffice1.LoadDefault()   -- -1021.86084, -427.74564, 68.95764
        MpSecurityOffice2.LoadDefault()   -- 383.4156, -59.878227, 108.4595
        MpSecurityOffice3.LoadDefault()   -- -1004.23035, -761.2084, 66.99069
        MpSecurityOffice4.LoadDefault()   -- -587.87213, -716.84937, 118.10156
    end
end)

    -- ====================================================================
    -- =------------------- [GTAV] ---------------------=
    -- ====================================================================
    
exports('GetAmmunationsObject', function()
    return Ammunations
end)

Ammunations = {
    ammunationsId = {
        140289,			-- 249.8, -47.1, 70.0
        153857,			-- 844.0, -1031.5, 28.2
        168193, 		-- -664.0, -939.2, 21.8
        164609,			-- -1308.7, -391.5, 36.7
        176385,			-- -3170.0, 1085.0, 20.8
        175617,			-- -1116.0, 2694.1, 18.6
        200961,			-- 1695.2, 3756.0, 34.7
        180481,			-- -328.7, 6079.0, 31.5
        178689			-- 2569.8, 297.8, 108.7
    },
    gunclubsId = {
        137729,			-- 19.1, -1110.0, 29.8
        248065			-- 811.0, -2152.0, 29.6
    },
    Details = {
        hooks = "GunStoreHooks",				-- Hooks for gun displaying
        hooksClub = "GunClubWallHooks",			-- Hooks for gun displaying
        Enable = function (details, state, refresh)
            if (details == Ammunations.Details.hooks) then
                SetIplPropState(Ammunations.ammunationsId, details, state, refresh)
            elseif (details == Ammunations.Details.hooksClub) then
                SetIplPropState(Ammunations.gunclubsId, details, state, refresh)
            end

        end
    },

    LoadDefault = function()
        Ammunations.Details.Enable(Ammunations.Details.hooks, true, true)
        Ammunations.Details.Enable(Ammunations.Details.hooksClub, true, true)
    end
}

-- Bahama Mamas: -1388.0013, -618.41967, 30.819599

exports('GetBahamaMamasObject', function()
    return BahamaMamas
end)

BahamaMamas = {
    ipl = "hei_sm_16_interior_v_bahama_milo_",

    Enable = function(state)
        EnableIpl(BahamaMamas.ipl, state)
    end
}


Citizen.CreateThread(function()

    -- Heist Jewel: -637.20159 -239.16250 38.1
    RequestIpl("post_hiest_unload")
    
    -- Max Renda: -585.8247, -282.72, 35.45475
    RequestIpl("refit_unload")

    -- Heist Union Depository: 2.69689322, -667.0166, 16.1306286
    RequestIpl("FINBANK")

    -- Morgue: 239.75195, -1360.64965, 39.53437
    RequestIpl("Coroner_Int_on")
    RequestIpl("coronertrash")
    
    -- Cluckin Bell: -146.3837, 6161.5, 30.2062
    RequestIpl("CS1_02_cf_onmission1")
    RequestIpl("CS1_02_cf_onmission2")
    RequestIpl("CS1_02_cf_onmission3")
    RequestIpl("CS1_02_cf_onmission4")
    
    -- Grapeseed's farm: 2447.9, 4973.4, 47.7
    RequestIpl("farm")
    RequestIpl("farmint")
    RequestIpl("farm_lod")
    RequestIpl("farm_props")
    RequestIpl("des_farmhouse")
    
    -- FIB lobby: 105.4557, -745.4835, 44.7548
    RequestIpl("FIBlobby")

    -- FIB Roof: 134.33, -745.95, 266.98
    RequestIpl("atriumglmission")

    -- FIB Fountain 174.184, -667.902, 43.140
    RemoveIpl('dt1_05_hc_end')
    RemoveIpl('dt1_05_hc_req')
    RequestIpl('dt1_05_hc_remove')
        
    -- Billboard: iFruit
    RequestIpl("FruitBB")
    RequestIpl("sc1_01_newbill")
    RequestIpl("hw1_02_newbill")
    RequestIpl("hw1_emissive_newbill")
    RequestIpl("sc1_14_newbill")
    RequestIpl("dt1_17_newbill")

    -- Lester's factory: 716.84, -962.05, 31.59
    RequestIpl("id2_14_during_door")
    RequestIpl("id2_14_during1")
    
    -- Life Invader lobby: -1047.9, -233.0, 39.0
    RequestIpl("facelobby")
    
    -- Tunnels
    RequestIpl("v_tunnel_hole")

    -- Carwash: 55.7, -1391.3, 30.5
    RequestIpl("Carwash_with_spinners")
    
    -- Stadium "Fame or Shame": -248.49159240722656, -2010.509033203125, 34.57429885864258
    RequestIpl("sp1_10_real_interior")
    RequestIpl("sp1_10_real_interior_lod")
    
    -- House in Banham Canyon: -3086.428, 339.2523, 6.3717
    RequestIpl("ch1_02_open")
        
    -- Garage in La Mesa (autoshop): 970.27453, -1826.56982, 31.11477
    RequestIpl("bkr_bi_id1_23_door")
        
    -- Hill Valley church - Grave: -282.46380000, 2835.84500000, 55.91446000
    RequestIpl("lr_cs6_08_grave_closed")
    
    -- Lost's trailer park: 49.49379000, 3744.47200000, 46.38629000
    RequestIpl("methtrailer_grp1")
        
    -- Lost safehouse: 984.1552, -95.3662, 74.50
    RequestIpl("bkr_bi_hw1_13_int")
            
    -- Raton Canyon river: -1652.83, 4445.28, 2.52
    RequestIpl("CanyonRvrShallow")
        
    -- Josh's house: -1117.1632080078, 303.090698, 66.52217
    RequestIpl("bh1_47_joshhse_unburnt")
    RequestIpl("bh1_47_joshhse_unburnt_lod")
        
    -- Bahama Mamas: -1388.0013, -618.41967, 30.819599
    RequestIpl("hei_sm_16_interior_v_bahama_milo_")
        
    -- Zancudo River (need streamed content): 86.815, 3191.649, 30.463
    RequestIpl("cs3_05_water_grp1")
    RequestIpl("cs3_05_water_grp1_lod")
    RequestIpl("trv1_trail_start")
    
    -- Cassidy Creek (need streamed content): -425.677, 4433.404, 27.3253
    RequestIpl("canyonriver01")
    RequestIpl("canyonriver01_lod")

    -- Ferris wheel
    RequestIpl("ferris_finale_anim")
end)


exports('GetFloydObject', function()
    return Floyd
end)

Floyd = {
    interiorId = 171777,
    Style = {
        normal = {"swap_clean_apt", "layer_debra_pic", "layer_whiskey", "swap_sofa_A"},
        messedUp = {"layer_mess_A", "layer_mess_B", "layer_mess_C", "layer_sextoys_a", "swap_sofa_B", "swap_wade_sofa_A", "layer_wade_shit", "layer_torture"},
        Set = function(style, refresh)
            Floyd.Style.Clear(false)
            SetIplPropState(Floyd.interiorId, style, true, refresh)
        end,
        Clear = function(refresh) SetIplPropState(Floyd.interiorId, {Floyd.Style.normal, Floyd.Style.messedUp}, false, refresh) end
    },
    MrJam = {
        normal = "swap_mrJam_A", jammed = "swap_mrJam_B", jammedOnTable = "swap_mrJam_C",
        Set = function(mrJam, refresh)
            Floyd.MrJam.Clear(false)
            SetIplPropState(Floyd.interiorId, mrJam, true, refresh)
        end,
        Clear = function(refresh) SetIplPropState(Floyd.interiorId, {Floyd.MrJam.normal, Floyd.MrJam.jammed, Floyd.MrJam.jammedOnTable}, false, refresh) end
    },

    LoadDefault = function()
        Floyd.Style.Set(Floyd.Style.normal)
        Floyd.MrJam.Set(Floyd.MrJam.normal)
        RefreshInterior(Floyd.interiorId)
    end
}


exports('GetFranklinObject', function()
    return Franklin
end)

Franklin = {
    interiorId = 206849,
    Style = {
        empty = "", unpacking = "franklin_unpacking", settled = {"franklin_unpacking", "franklin_settled"}, cardboxes = "showhome_only",
        Set = function(style, refresh)
            Franklin.Style.Clear(false)
            if style ~= "" then
                SetIplPropState(Franklin.interiorId, style, true, refresh)
            else
                if (refresh) then RefreshInterior(Franklin.interiorId) end
            end
        end,
        Clear = function(refresh) SetIplPropState(Franklin.interiorId, {Franklin.Style.settled, Franklin.Style.unpacking, Franklin.Style.cardboxes}, false, refresh) end
    },
    GlassDoor = {
        opened = "unlocked", closed = "locked",
        Set = function(door, refresh)
            Franklin.GlassDoor.Clear(false)
            SetIplPropState(Franklin.interiorId, door, true, refresh)
        end,
        Clear = function(refresh) SetIplPropState(Franklin.interiorId, {Franklin.GlassDoor.opened, Franklin.GlassDoor.closed}, false, refresh) end
    },
    Details = {
        flyer = "progress_flyer",					-- Mountain flyer on the kitchen counter
        tux = "progress_tux",						-- Tuxedo suit in the wardrobe
        tshirt = "progress_tshirt",					-- "I <3 LS" tshirt on the bed
        bong = "bong_and_wine",						-- Bong on the table
        Enable = function (details, state, refresh) SetIplPropState(Franklin.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        Franklin.Style.Set(Franklin.Style.empty)
        Franklin.GlassDoor.Set(Franklin.GlassDoor.opened)
        Franklin.Details.Enable(Franklin.Details.flyer, false)
        Franklin.Details.Enable(Franklin.Details.tux, false)
        Franklin.Details.Enable(Franklin.Details.tshirt, false)
        Franklin.Details.Enable(Franklin.Details.bong, false)
        RefreshInterior(Franklin.interiorId)
    end
}


exports('GetFranklinAuntObject', function()
    return FranklinAunt
end)

FranklinAunt = {
    interiorId = 197889,
    Style = {
        empty = "", franklinStuff = "V_57_FranklinStuff", franklinLeft = "V_57_Franklin_LEFT",
        Set = function(style, refresh)
            FranklinAunt.Style.Clear(false)
            if style ~= "" then
                SetIplPropState(FranklinAunt.interiorId, style, true, refresh)
            else
                if (refresh) then RefreshInterior(FranklinAunt.interiorId) end
            end
        end,
        Clear = function(refresh) SetIplPropState(FranklinAunt.interiorId, {FranklinAunt.Style.franklinStuff, FranklinAunt.Style.franklinLeft}, false, refresh) end
    },
    Details = {
        bandana = "V_57_GangBandana",				-- Bandana on the bed
        bag = "V_57_Safari",						-- Bag in the closet
        Enable = function (details, state, refresh) SetIplPropState(FranklinAunt.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        FranklinAunt.Style.Set(FranklinAunt.Style.empty)
        FranklinAunt.Details.Enable(FranklinAunt.Details.bandana, false)
        FranklinAunt.Details.Enable(FranklinAunt.Details.bag, false)
        RefreshInterior(FranklinAunt.interiorId)
    end
}


exports('GetGraffitisObject', function()
    return Graffitis
end)

Graffitis = {
    ipl = {
        "ch3_rd2_bishopschickengraffiti",	-- 1861.28, 2402.11, 58.53
        "cs5_04_mazebillboardgraffiti",		-- 2697.32, 3162.18, 58.1
        "cs5_roads_ronoilgraffiti"			-- 2119.12, 3058.21, 53.25
    },
    Enable = function(state) EnableIpl(Graffitis.ipl, state) end
}


exports('GetLesterFactoryObject', function()
    return LesterFactory
end)

LesterFactory = {
    interiorId = 92674,
    Details = {
        bluePrint = "V_53_Agency_Blueprint",		-- Blueprint on the office desk
        bag = "V_35_KitBag",						-- Bag under the office desk
        fireMan = "V_35_Fireman",					-- Firemans helmets in the office
        armour = "V_35_Body_Armour",				-- Body armor in storage
        gasMask = "Jewel_Gasmasks",					-- Gas mask and suit in storage
        janitorStuff = "v_53_agency _overalls",		-- Janitor stuff in the storage (yes, there is a whitespace)
        Enable = function (details, state, refresh) SetIplPropState(LesterFactory.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        LesterFactory.Details.Enable(LesterFactory.Details.bluePrint, false)
        LesterFactory.Details.Enable(LesterFactory.Details.bag, false)
        LesterFactory.Details.Enable(LesterFactory.Details.fireMan, false)
        LesterFactory.Details.Enable(LesterFactory.Details.armour, false)
        LesterFactory.Details.Enable(LesterFactory.Details.gasMask, false)
        LesterFactory.Details.Enable(LesterFactory.Details.janitorStuff, false)
        RefreshInterior(LesterFactory.interiorId)
    end
}


exports('GetMichaelObject', function()
    return Michael
end)

Michael = {
    interiorId = 166657,
    garageId = 166401,
    Style = {
        normal = {"V_Michael_bed_tidy", "V_Michael_M_items", "V_Michael_D_items", "V_Michael_S_items", "V_Michael_L_Items"},
        moved = {"V_Michael_bed_Messy", "V_Michael_M_moved", "V_Michael_D_Moved", "V_Michael_L_Moved", "V_Michael_S_items_swap", "V_Michael_M_items_swap"},
        Set = function(style, refresh)
            Michael.Style.Clear(false)
            SetIplPropState(Michael.interiorId, style, true, refresh)
        end,
        Clear = function(refresh) SetIplPropState(Michael.interiorId, {Michael.Style.normal, Michael.Style.moved}, false, refresh) end
    },
    Bed = {
        tidy = "V_Michael_bed_tidy", messy = "V_Michael_bed_Messy",
        Set = function(bed, refresh)
            Michael.Bed.Clear(false)
            SetIplPropState(Michael.interiorId, bed, true, refresh)
        end,
        Clear = function(refresh) SetIplPropState(Michael.interiorId, {Michael.Bed.tidy, Michael.Bed.messy}, false, refresh) end
    },
    Garage = {
        scuba = "V_Michael_Scuba",					-- Scuba diver gear
        Enable = function (scuba, state, refresh) SetIplPropState(Michael.garageId, scuba, state, refresh) end
    },
    Details = {
        moviePoster = "Michael_premier",			-- Meltdown movie poster
        fameShamePoste = "V_Michael_FameShame",		-- Next to Tracey's bed
        planeTicket = "V_Michael_plane_ticket",		-- Plane ticket
        spyGlasses = "V_Michael_JewelHeist",		-- On the shelf inside Michael's bedroom
        bugershot = "burgershot_yoga",				-- Bag and cup in the kitchen, next to the sink

        Enable = function (details, state, refresh) SetIplPropState(Michael.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        Michael.Garage.Enable(Michael.Garage.scuba, false, true)
        Michael.Style.Set(Michael.Style.normal)
        Michael.Bed.Set(Michael.Bed.tidy)
        Michael.Details.Enable(Michael.Details.moviePoster, false)
        Michael.Details.Enable(Michael.Details.fameShamePoste, false)
        Michael.Details.Enable(Michael.Details.spyGlasses, false)
        Michael.Details.Enable(Michael.Details.planeTicket, false)
        Michael.Details.Enable(Michael.Details.bugershot, false)
        RefreshInterior(Michael.interiorId)
    end
}


exports('GetNorthYanktonObject', function()
	return NorthYankton
end)

NorthYankton = {
	ipl = {
		"prologue01",
		"prologue01c",
		"prologue01d",
		"prologue01e",
		"prologue01f",
		"prologue01g",
		"prologue01h",
		"prologue01i",
		"prologue01j",
		"prologue01k",
		"prologue01z",
		"prologue02",
		"prologue03",
		"prologue03b",
		"prologue04",
		"prologue04b",
		"prologue05",
		"prologue05b",
		"prologue06",
		"prologue06b",
		"prologue06_int",
		"prologuerd",
		"prologuerdb",
		"prologue_DistantLights",
		"prologue_LODLights",
		"prologue_m2_door"
	},
	Enable = function(state) EnableIpl(NorthYankton.ipl, state) end
}

-- Pillbox hospital: 307.1680, -590.807, 43.280

exports('GetPillboxHospitalObject', function()
    return PillboxHospital
end)

PillboxHospital = {
    ipl = "rc12b_default",
    Enable = function(state) EnableIpl(PillboxHospital.ipl, state) end
}


exports('GetRedCarpetObject', function()
	return RedCarpet
end)

RedCarpet = {
	ipl = "redCarpet",
	Enable = function(state) EnableIpl(RedCarpet.ipl, state) end
}


exports('GetSimeonObject', function()
    return Simeon
end)

Simeon = {
    interiorId = 7170,
    Ipl = {
        Interior = {
            ipl = {"shr_int"},
            Load = function() EnableIpl(Simeon.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(Simeon.Ipl.Interior.ipl, false) end
        },
    },
    Style = {
        normal = "csr_beforeMission", noGlass = "csr_inMission", destroyed = "csr_afterMissionA", fixed = "csr_afterMissionB",
        Set = function(style, refresh)
            Simeon.Style.Clear(false)
            SetIplPropState(Simeon.interiorId, style, true, refresh)
        end,
        Clear = function(refresh) SetIplPropState(Simeon.interiorId, {Simeon.Style.normal, Simeon.Style.noGlass, Simeon.Style.destroyed, Simeon.Style.fixed}, false, refresh) end
    },
    Shutter = {
        none = "", opened = "shutter_open", closed = "shutter_closed",
        Set = function(shutter, refresh)
            Simeon.Shutter.Clear(false)
            if (shutter ~= "") then
                SetIplPropState(Simeon.interiorId, shutter, true, refresh)
            else
                if (refresh) then RefreshInterior(Simeon.interiorId) end
            end
        end,
        Clear = function(refresh) SetIplPropState(Simeon.interiorId, {Simeon.Shutter.opened, Simeon.Shutter.closed}, false, refresh) end
    },

    LoadDefault = function()
        Simeon.Ipl.Interior.Load()
        Simeon.Style.Set(Simeon.Style.normal)
        Simeon.Shutter.Set(Simeon.Shutter.opened)
        RefreshInterior(Simeon.interiorId)
    end
}


exports('GetStripClubObject', function()
    return StripClub
end)

StripClub = {
    interiorId = 197121,
    Mess = {
        mess = "V_19_Trevor_Mess",					-- A bit of mess in the office
        Enable = function (state) SetIplPropState(StripClub.interiorId, StripClub.Mess.mess, state, true) end
    },

    LoadDefault = function()
        StripClub.Mess.Enable(false)
    end
}


exports('GetTrevorsTrailerObject', function()
    return TrevorsTrailer
end)

TrevorsTrailer = {
    interiorId = 2562,
    Interior = {
        tidy = "trevorstrailertidy", trash = "TrevorsTrailerTrash",
        Set = function(interior)
            TrevorsTrailer.Interior.Clear()
            EnableIpl(interior, true)
        end,
        Clear = function() EnableIpl({TrevorsTrailer.Interior.tidy, TrevorsTrailer.Interior.trash}, false) end
    },
    Details = {
        copHelmet = "V_26_Trevor_Helmet3",			-- Cop helmet in the closet
        briefcase = "V_24_Trevor_Briefcase3",		-- Briefcase in the main room
        michaelStuff = "V_26_Michael_Stay3",		-- Michael's suit hanging on the window
        Enable = function (details, state, refresh) SetIplPropState(TrevorsTrailer.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        TrevorsTrailer.Interior.Set(TrevorsTrailer.Interior.trash)
        TrevorsTrailer.Details.Enable(TrevorsTrailer.Details.copHelmet, false, false)
        TrevorsTrailer.Details.Enable(TrevorsTrailer.Details.briefcase, false, false)
        TrevorsTrailer.Details.Enable(TrevorsTrailer.Details.michaelStuff, false, false)
        RefreshInterior(TrevorsTrailer.interiorId)
    end
}


exports('GetUFOObject', function()
    return UFO
end)

UFO = {
    Hippie = {
        ipl = "ufo",		-- Hippie base: 2490.47729, 3774.84351, 2414.035
        Enable = function(state)
            EnableIpl(UFO.Hippie.ipl, state)
        end
    },
    Chiliad = {
        ipl = "ufo_eye",	-- Chiliad: 501.5288, 5593.865, 796.2325
        Enable = function(state)
            EnableIpl(UFO.Chiliad.ipl, state)
        end
    },
    Zancudo = {
        ipl = "ufo_lod",	-- Zancudo: -2051.99463, 3237.05835, 1456.97021
        Enable = function(state)
            EnableIpl(UFO.Zancudo.ipl, state)
        end
    }
}


-- Zancudo Gates (GTAO like): -1600.30100000 2806.73100000 18.79683000

exports('GetZancudoGatesObject', function()
    return ZancudoGates
end)

ZancudoGates = {
    Gates = {
        Open = function()
            EnableIpl("CS3_07_MPGates", false)
        end,
        Close = function()
            EnableIpl("CS3_07_MPGates", true)
        end,
    },

    LoadDefault = function()
        ZancudoGates.Gates.Open()
    end
}

    -- ====================================================================
    -- =------------------- [GTA_ONLINE] ---------------------=
    -- ====================================================================

    
-- 4 Integrity Way, Apt 30
-- High end apartment 1: -35.31277 -580.4199 88.71221

exports('GetGTAOApartmentHi1Object', function()
    return GTAOApartmentHi1
end)

GTAOApartmentHi1 = {
    interiorId = 141313,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi1.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi1.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi1.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOApartmentHi1.Strip.Enable({GTAOApartmentHi1.Strip.A, GTAOApartmentHi1.Strip.B, GTAOApartmentHi1.Strip.C}, false)
        GTAOApartmentHi1.Booze.Enable({GTAOApartmentHi1.Booze.A, GTAOApartmentHi1.Booze.B, GTAOApartmentHi1.Booze.C}, false)
        GTAOApartmentHi1.Smoke.Enable({GTAOApartmentHi1.Smoke.A, GTAOApartmentHi1.Smoke.B, GTAOApartmentHi1.Smoke.C}, false)
        RefreshInterior(GTAOApartmentHi1.interiorId)
    end
}


-- Dell Perro Heights, Apt 7
-- High end apartment 2: -1477.14 -538.7499 55.5264

exports('GetGTAOApartmentHi2Object', function()
    return GTAOApartmentHi2
end)

GTAOApartmentHi2 = {
    interiorId = 145665,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi2.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi2.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi2.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOApartmentHi2.Strip.Enable({GTAOApartmentHi2.Strip.A, GTAOApartmentHi2.Strip.B, GTAOApartmentHi2.Strip.C}, false)
        GTAOApartmentHi2.Booze.Enable({GTAOApartmentHi2.Booze.A, GTAOApartmentHi2.Booze.B, GTAOApartmentHi2.Booze.C}, false)
        GTAOApartmentHi2.Smoke.Enable({GTAOApartmentHi2.Smoke.A, GTAOApartmentHi2.Smoke.B, GTAOApartmentHi2.Smoke.C}, false)
        RefreshInterior(GTAOApartmentHi2.interiorId)
    end
}


-- 3655 Wild Oats Drive 
-- High end house 1: -169.286 486.4938 137.4436

exports('GetGTAOHouseHi1Object', function()
    return GTAOHouseHi1
end)

GTAOHouseHi1 = {
    interiorId = 207105,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi1.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi1.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi1.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi1.Strip.Enable({GTAOHouseHi1.Strip.A, GTAOHouseHi1.Strip.B, GTAOHouseHi1.Strip.C}, false)
        GTAOHouseHi1.Booze.Enable({GTAOHouseHi1.Booze.A, GTAOHouseHi1.Booze.B, GTAOHouseHi1.Booze.C}, false)
        GTAOHouseHi1.Smoke.Enable({GTAOHouseHi1.Smoke.A, GTAOHouseHi1.Smoke.B, GTAOHouseHi1.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi1.interiorId)
    end
}


-- 2044 North Conker Avenue
-- High end house 2: 340.9412 437.1798 149.3925

exports('GetGTAOHouseHi2Object', function()
    return GTAOHouseHi2
end)

GTAOHouseHi2 = {
    interiorId = 206081,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi2.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi2.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi2.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi2.Strip.Enable({GTAOHouseHi2.Strip.A, GTAOHouseHi2.Strip.B, GTAOHouseHi2.Strip.C}, false)
        GTAOHouseHi2.Booze.Enable({GTAOHouseHi2.Booze.A, GTAOHouseHi2.Booze.B, GTAOHouseHi2.Booze.C}, false)
        GTAOHouseHi2.Smoke.Enable({GTAOHouseHi2.Smoke.A, GTAOHouseHi2.Smoke.B, GTAOHouseHi2.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi2.interiorId)
    end
}


-- 2045 North Conker Avenue
-- High end house 3: 373.023 416.105 145.7006

exports('GetGTAOHouseHi3Object', function()
    return GTAOHouseHi3
end)

GTAOHouseHi3 = {
    interiorId = 206337,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi3.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi3.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi3.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi3.Strip.Enable({GTAOHouseHi3.Strip.A, GTAOHouseHi3.Strip.B, GTAOHouseHi3.Strip.C}, false)
        GTAOHouseHi3.Booze.Enable({GTAOHouseHi3.Booze.A, GTAOHouseHi3.Booze.B, GTAOHouseHi3.Booze.C}, false)
        GTAOHouseHi3.Smoke.Enable({GTAOHouseHi3.Smoke.A, GTAOHouseHi3.Smoke.B, GTAOHouseHi3.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi3.interiorId)
    end
}


-- 2862 Hillcrest Avenue 
-- High end house 4: -676.127 588.612 145.1698

exports('GetGTAOHouseHi4Object', function()
    return GTAOHouseHi4
end)

GTAOHouseHi4 = {
    interiorId = 208129,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi4.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi4.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi4.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi4.Strip.Enable({GTAOHouseHi4.Strip.A, GTAOHouseHi4.Strip.B, GTAOHouseHi4.Strip.C}, false)
        GTAOHouseHi4.Booze.Enable({GTAOHouseHi4.Booze.A, GTAOHouseHi4.Booze.B, GTAOHouseHi4.Booze.C}, false)
        GTAOHouseHi4.Smoke.Enable({GTAOHouseHi4.Smoke.A, GTAOHouseHi4.Smoke.B, GTAOHouseHi4.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi4.interiorId)
    end
}


-- 2868 Hillcrest Avenue 
-- High end house 5: -763.107 615.906 144.1401

exports('GetGTAOHouseHi5Object', function()
    return GTAOHouseHi5
end)

GTAOHouseHi5 = {
    interiorId = 207617,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi5.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi5.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi5.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi5.Strip.Enable({GTAOHouseHi5.Strip.A, GTAOHouseHi5.Strip.B, GTAOHouseHi5.Strip.C}, false)
        GTAOHouseHi5.Booze.Enable({GTAOHouseHi5.Booze.A, GTAOHouseHi5.Booze.B, GTAOHouseHi5.Booze.C}, false)
        GTAOHouseHi5.Smoke.Enable({GTAOHouseHi5.Smoke.A, GTAOHouseHi5.Smoke.B, GTAOHouseHi5.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi5.interiorId)
    end
}


-- 2874 Hillcrest Avenue
-- High end house 6: -857.798 682.563 152.6529

exports('GetGTAOHouseHi6Object', function()
    return GTAOHouseHi6
end)

GTAOHouseHi6 = {
    interiorId = 207361,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi6.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi6.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi6.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi6.Strip.Enable({GTAOHouseHi6.Strip.A, GTAOHouseHi6.Strip.B, GTAOHouseHi6.Strip.C}, false)
        GTAOHouseHi6.Booze.Enable({GTAOHouseHi6.Booze.A, GTAOHouseHi6.Booze.B, GTAOHouseHi6.Booze.C}, false)
        GTAOHouseHi6.Smoke.Enable({GTAOHouseHi6.Smoke.A, GTAOHouseHi6.Smoke.B, GTAOHouseHi6.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi6.interiorId)
    end
}


-- 2677 Whispymound Drive
-- High end house 7: 120.5 549.952 184.097

exports('GetGTAOHouseHi7Object', function()
    return GTAOHouseHi7
end)

GTAOHouseHi7 = {
    interiorId = 206593,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi7.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi7.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi7.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi7.Strip.Enable({GTAOHouseHi7.Strip.A, GTAOHouseHi7.Strip.B, GTAOHouseHi7.Strip.C}, false)
        GTAOHouseHi7.Booze.Enable({GTAOHouseHi7.Booze.A, GTAOHouseHi7.Booze.B, GTAOHouseHi7.Booze.C}, false)
        GTAOHouseHi7.Smoke.Enable({GTAOHouseHi7.Smoke.A, GTAOHouseHi7.Smoke.B, GTAOHouseHi7.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi7.interiorId)
    end
}


-- 2133 Mad Wayne Thunder 
-- High end house 8: -1288 440.748 97.69459

exports('GetGTAOHouseHi8Object', function()
    return GTAOHouseHi8
end)

GTAOHouseHi8 = {
    interiorId = 208385,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi8.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi8.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi8.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi8.Strip.Enable({GTAOHouseHi8.Strip.A, GTAOHouseHi8.Strip.B, GTAOHouseHi8.Strip.C}, false)
        GTAOHouseHi8.Booze.Enable({GTAOHouseHi8.Booze.A, GTAOHouseHi8.Booze.B, GTAOHouseHi8.Booze.C}, false)
        GTAOHouseHi8.Smoke.Enable({GTAOHouseHi8.Smoke.A, GTAOHouseHi8.Smoke.B, GTAOHouseHi8.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi8.interiorId)
    end
}


-- Low end house 1: 261.4586 -998.8196 -99.00863

exports('GetGTAOHouseLow1Object', function()
    return GTAOHouseLow1
end)

GTAOHouseLow1 = {
    interiorId = 149761,
    Strip = {
        A = "Studio_Lo_Strip_A", B = "Studio_Lo_Strip_B", C = "Studio_Lo_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseLow1.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Studio_Lo_Booze_A", B = "Studio_Lo_Booze_B", C = "Studio_Lo_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseLow1.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        none = "", stage1 = "Studio_Lo_Smoke_A", stage2 = "Studio_Lo_Smoke_B", stage3 = "Studio_Lo_Smoke_C",
        Set = function(smoke, refresh)
            GTAOHouseLow1.Smoke.Clear(false)
            if (smoke ~= nil) then
                SetIplPropState(GTAOHouseLow1.interiorId, smoke, true, refresh)
            else
                if (refresh) then RefreshInterior(GTAOHouseLow1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(GTAOHouseLow1.interiorId, {GTAOHouseLow1.Smoke.stage1, GTAOHouseLow1.Smoke.stage2, GTAOHouseLow1.Smoke.stage3}, false, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseLow1.Strip.Enable({GTAOHouseLow1.Strip.A, GTAOHouseLow1.Strip.B, GTAOHouseLow1.Strip.C}, false)
        GTAOHouseLow1.Booze.Enable({GTAOHouseLow1.Booze.A, GTAOHouseLow1.Booze.B, GTAOHouseLow1.Booze.C}, false)
        GTAOHouseLow1.Smoke.Set(GTAOHouseLow1.Smoke.none)
        RefreshInterior(GTAOHouseLow1.interiorId)
    end
}


-- Middle end house 1: 347.2686 -999.2955 -99.19622

exports('GetGTAOHouseMid1Object', function()
    return GTAOHouseMid1
end)

GTAOHouseMid1 = {
    interiorId = 148225,
    Strip = {
        A = "Apart_Mid_Strip_A", B = "Apart_Mid_Strip_B", C = "Apart_Mid_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseMid1.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Mid_Booze_A", B = "Apart_Mid_Booze_B", C = "Apart_Mid_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseMid1.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        none = "", stage1 = "Apart_Mid_Smoke_A", stage2 = "Apart_Mid_Smoke_B", stage3 = "Apart_Mid_Smoke_C",
        Set = function(smoke, refresh)
            GTAOHouseMid1.Smoke.Clear(false)
            if (smoke ~= nil) then
                SetIplPropState(GTAOHouseMid1.interiorId, smoke, true, refresh)
            else
                if (refresh) then RefreshInterior(GTAOHouseMid1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(GTAOHouseMid1.interiorId, {GTAOHouseMid1.Smoke.stage1, GTAOHouseMid1.Smoke.stage2, GTAOHouseMid1.Smoke.stage3}, false, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseMid1.Strip.Enable({GTAOHouseMid1.Strip.A, GTAOHouseMid1.Strip.B, GTAOHouseMid1.Strip.C}, false)
        GTAOHouseMid1.Booze.Enable({GTAOHouseMid1.Booze.A, GTAOHouseMid1.Booze.B, GTAOHouseMid1.Booze.C}, false)
        GTAOHouseMid1.Smoke.Set(GTAOHouseMid1.Smoke.none)
        RefreshInterior(GTAOHouseMid1.interiorId)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_tuner_Roberto] ---------------------=
    -- ====================================================================

    exports('GetTunerGarageObject', function()
        return TunerGarage
    end)
    
    TunerGarage = {
        InteriorId = 285953,
        Ipl = {
            Interior = {
                ipl = {
                    'tr_tuner_shop_burton',
                    'tr_tuner_shop_mesa',
                    'tr_tuner_shop_mission',
                    'tr_tuner_shop_rancho',
                    'tr_tuner_shop_strawberry',
                }
            },
            Load = function ()
                EnableIpl(TunerGarage.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(TunerGarage.Ipl.Interior.ipl, false)
            end,
        },
        Entities = {
            entity_set_bedroom = true,
            entity_set_bedroom_empty = false,
            entity_set_bombs = true,
            entity_set_box_clutter = false,
            entity_set_cabinets = false,
            entity_set_car_lift_cutscene = true,
            entity_set_car_lift_default = true,
            entity_set_car_lift_purchase = true,
            entity_set_chalkboard = false,
            entity_set_container = false,
            entity_set_cut_seats = false,
            entity_set_def_table = false,
            entity_set_drive = true,
            entity_set_ecu = true,
            entity_set_IAA = true,
            entity_set_jammers = true,
            entity_set_laptop = true,
            entity_set_lightbox = true,
            entity_set_methLab = false,
            entity_set_plate = true,
            entity_set_scope = true,
            entity_set_style_1 = false,
            entity_set_style_2 = false,
            entity_set_style_3 = false,
            entity_set_style_4 = false,
            entity_set_style_5 = false,
            entity_set_style_6 = false,
            entity_set_style_7 = false,
            entity_set_style_8 = false,
            entity_set_style_9 = true,
            entity_set_table = false,
            entity_set_thermal = true,
            entity_set_tints = true,
            entity_set_train = true,
            entity_set_virus = true,
            Set = function (name, state)
                for entity, _ in pairs(TunerGarage.Entities) do
                    if entity == name then
                        TunerGarage.Entities[entity] = state
                        TunerGarage.Entities.Clear()
                        TunerGarage.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(TunerGarage.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(TunerGarage.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(TunerGarage.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(TunerGarage.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            TunerGarage.Ipl.Load()
            TunerGarage.Entities.Load()
            RefreshInterior(TunerGarage.interiorId)
        end
    }

    exports('GetTunerMeetupObject', function()
        return TunerMeetup
    end)
    
    TunerMeetup = {
        InteriorId = 285697,
        Ipl = {
            Interior = {
                ipl = {
                    'tr_tuner_meetup',
                    'tr_tuner_race_line',
                }
            },
            Load = function ()
                EnableIpl(TunerMeetup.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(TunerMeetup.Ipl.Interior.ipl, false)
            end,
        },
        Entities = {
            entity_set_meet_crew = true,
            entity_set_meet_lights = true,
            entity_set_meet_lights_cheap = true,
            entity_set_player = true,
            entity_set_test_crew = false,
            entity_set_test_lights = true,
            entity_set_test_lights_cheap = true,
            entity_set_time_trial = true,
            Set = function (name, state)
                for entity, _ in pairs(TunerMeetup.Entities) do
                    if entity == name then
                        TunerMeetup.Entities[entity] = state
                        TunerMeetup.Entities.Clear()
                        TunerMeetup.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(TunerMeetup.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(TunerMeetup.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(TunerMeetup.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(TunerMeetup.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            TunerMeetup.Ipl.Load()
            TunerMeetup.Entities.Load()
            RefreshInterior(TunerMeetup.interiorId)
        end
    }

    exports('GetTunerMethLabObject', function()
        return TunerMethLab
    end)
    
    TunerMethLab = {
        InteriorId = 284673,
        Entities = {
            tintable_walls = true,
            Set = function (name, state)
                for entity, _ in pairs(TunerMethLab.Entities) do
                    if entity == name then
                        TunerMethLab.Entities[entity] = state
                        TunerMethLab.Entities.Clear()
                        TunerMethLab.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(TunerMethLab.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(TunerMethLab.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(TunerMethLab.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(TunerMethLab.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            TunerMethLab.Entities.Load()
            SetInteriorEntitySetColor(TunerMethLab.interiorId, TunerMethLab.Entities.tintable_walls, 3)
            RefreshInterior(TunerMethLab.interiorId)
        end
    }
    
    -- ====================================================================
    -- =------------------- [dlc_smuggler_roberto] ---------------------=
    -- ====================================================================
    
-- SmugglerHangar: -1267.0 -3013.135 -49.5

exports('GetSmugglerHangarObject', function()
    return SmugglerHangar
end)

SmugglerHangar = {
    interiorId = 260353,
    Ipl = {
        Interior = {
            ipl = "sm_smugdlc_interior_placement_interior_0_smugdlc_int_01_milo_",
            Load = function() EnableIpl(SmugglerHangar.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(SmugglerHangar.Ipl.Interior.ipl, false) end
        },
    },
    Colors = {
        colorSet1 = 1, -- sable, red, gray
        colorSet2 = 2, -- white, blue, gray
        colorSet3 = 3, -- gray, orange, blue
        colorSet4 = 4, -- gray, blue, orange
        colorSet5 = 5, -- gray, light gray, red
        colorSet6 = 6, -- yellow, gray, light gray
        colorSet7 = 7, -- light Black and white
        colorSet8 = 8, -- dark Black and white
        colorSet9 = 9  -- sable and gray
    },
    Walls = {
        default = "set_tint_shell",
        SetColor = function(color, refresh)
            SetIplPropState(SmugglerHangar.interiorId, SmugglerHangar.Walls.default, true, refresh)
            SetInteriorPropColor(SmugglerHangar.interiorId, SmugglerHangar.Walls.default, color)
        end,
    },
    Floor = {
        Style = {
            raw = "set_floor_1", plain = "set_floor_2",
            Set = function(floor, refresh)
                SmugglerHangar.Floor.Style.Clear(false)
                SetIplPropState(SmugglerHangar.interiorId, floor, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(SmugglerHangar.interiorId, {SmugglerHangar.Floor.Style.raw, SmugglerHangar.Floor.Style.plain}, false, refresh)
            end
        },
        Decals = {
            decal1 = "set_floor_decal_1", decal2 = "set_floor_decal_2", decal4 = "set_floor_decal_3", decal3 = "set_floor_decal_4",
            decal5 = "set_floor_decal_5", decal6 = "set_floor_decal_6", decal7 = "set_floor_decal_7", decal8 = "set_floor_decal_8",
            decal9 = "set_floor_decal_9",
            Set = function(decal, color, refresh)
                if color == nil then color = 1 end
                SmugglerHangar.Floor.Decals.Clear(false)
                SetIplPropState(SmugglerHangar.interiorId, decal, true, refresh)
                SetInteriorPropColor(SmugglerHangar.interiorId, decal, color)
            end,
            Clear = function(refresh)
                SetIplPropState(SmugglerHangar.interiorId, {SmugglerHangar.Floor.Decals.decal1, SmugglerHangar.Floor.Decals.decal2, SmugglerHangar.Floor.Decals.decal3,
                SmugglerHangar.Floor.Decals.decal4, SmugglerHangar.Floor.Decals.decal5, SmugglerHangar.Floor.Decals.decal6, SmugglerHangar.Floor.Decals.decal7,
                SmugglerHangar.Floor.Decals.decal8, SmugglerHangar.Floor.Decals.decal9}, false, refresh)
            end
        }
    },
    Cranes = {
        on = "set_crane_tint", off = "",
        Set = function(crane, color, refresh)
            SmugglerHangar.Cranes.Clear()
            if crane ~= "" then
                SetIplPropState(SmugglerHangar.interiorId, crane, true, refresh)
                SetInteriorPropColor(SmugglerHangar.interiorId, crane, color)
            else
                if (refresh) then RefreshInterior(SmugglerHangar.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(SmugglerHangar.interiorId, SmugglerHangar.Cranes.default, false, refresh)
        end
    },
    ModArea = {
        on = "set_modarea", off = "",
        Set = function(mod, color, refresh)
            if color == nil then color = 1 end
            SmugglerHangar.ModArea.Clear(false)
            if mod ~= "" then 
                SetIplPropState(SmugglerHangar.interiorId, mod, true, refresh)
                SetInteriorPropColor(SmugglerHangar.interiorId, mod, color)
            else
                if (refresh) then RefreshInterior(SmugglerHangar.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(SmugglerHangar.interiorId, SmugglerHangar.ModArea.mod, false, refresh)
        end	
    },
    Office = {
        basic = "set_office_basic", modern = "set_office_modern", traditional = "set_office_traditional",
        Set = function(office, refresh)
            SmugglerHangar.Office.Clear(false)
            SetIplPropState(SmugglerHangar.interiorId, office, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(SmugglerHangar.interiorId, {SmugglerHangar.Office.basic, SmugglerHangar.Office.modern, SmugglerHangar.Office.traditional}, false, refresh)
        end	
    },
    Bedroom = {
        Style = {
            none = "", modern = {"set_bedroom_modern", "set_bedroom_tint"}, traditional = {"set_bedroom_traditional", "set_bedroom_tint"},
            Set = function(bed, color, refresh)
                if color == nil then color = 1 end
                SmugglerHangar.Bedroom.Style.Clear(false)
                if bed ~= "" then
                    SetIplPropState(SmugglerHangar.interiorId, bed, true, refresh)
                    SetInteriorPropColor(SmugglerHangar.interiorId, "set_bedroom_tint", color)
                else
                    if (refresh) then RefreshInterior(SmugglerHangar.interiorId) end
                end
            end,
            Clear = function(refresh)
                SetIplPropState(SmugglerHangar.interiorId, {SmugglerHangar.Bedroom.Style.modern, SmugglerHangar.Bedroom.Style.traditional}, false, refresh)
            end	
        },
        Blinds = {
            none = "", opened = "set_bedroom_blinds_open", closed = "set_bedroom_blinds_closed",
            Set = function(blinds, refresh)
                SmugglerHangar.Bedroom.Blinds.Clear(false)
                if blinds ~= "" then
                    SetIplPropState(SmugglerHangar.interiorId, blinds, true, refresh)
                else
                    if (refresh) then RefreshInterior(SmugglerHangar.interiorId) end
                end
            end,
            Clear = function(refresh)
                SetIplPropState(SmugglerHangar.interiorId, {SmugglerHangar.Bedroom.Blinds.opened, SmugglerHangar.Bedroom.Blinds.closed}, false, refresh)
            end	
        }
    },
    Lighting = {
        FakeLights = {
            none = "", yellow = 2, blue = 1, white = 0,
            Set = function(light, refresh)
                SmugglerHangar.Lighting.FakeLights.Clear(false)
                if light ~= "" then
                    SetIplPropState(SmugglerHangar.interiorId, "set_lighting_tint_props", true, refresh)
                    SetInteriorPropColor(SmugglerHangar.interiorId, "set_lighting_tint_props", light)
                else
                    if (refresh) then RefreshInterior(SmugglerHangar.interiorId) end
                end
            end,
            Clear = function(refresh)
                SetIplPropState(SmugglerHangar.interiorId, "set_lighting_tint_props", false, refresh)
            end	
        },
        Ceiling = {
            none = "", yellow = "set_lighting_hangar_a", blue = "set_lighting_hangar_b", white = "set_lighting_hangar_c",
            Set = function(light, refresh)
                SmugglerHangar.Lighting.Ceiling.Clear(false)
                if light ~= "" then
                    SetIplPropState(SmugglerHangar.interiorId, light, true, refresh)
                else
                    if (refresh) then RefreshInterior(SmugglerHangar.interiorId) end
                end
            end,
            Clear = function(refresh)
                SetIplPropState(SmugglerHangar.interiorId, {SmugglerHangar.Lighting.Ceiling.yellow, SmugglerHangar.Lighting.Ceiling.blue, SmugglerHangar.Lighting.Ceiling.white}, false, refresh)
            end	
        },
        Walls = {
            none = "", neutral = "set_lighting_wall_neutral", blue = "set_lighting_wall_tint01", orange = "set_lighting_wall_tint02",
            lightYellow = "set_lighting_wall_tint03", lightYellow2 = "set_lighting_wall_tint04", dimmed = "set_lighting_wall_tint05",
            strongYellow = "set_lighting_wall_tint06", white = "set_lighting_wall_tint07", lightGreen = "set_lighting_wall_tint08",
            yellow = "set_lighting_wall_tint09",
            Set = function(light, refresh)
                SmugglerHangar.Lighting.Walls.Clear(false)
                if light ~= "" then
                    SetIplPropState(SmugglerHangar.interiorId, light, true, refresh)
                else
                    if (refresh) then RefreshInterior(SmugglerHangar.interiorId) end
                end
            end,
            Clear = function(refresh)
                SetIplPropState(SmugglerHangar.interiorId, {SmugglerHangar.Lighting.Walls.neutral, SmugglerHangar.Lighting.Walls.blue, SmugglerHangar.Lighting.Walls.orange,
                    SmugglerHangar.Lighting.Walls.lightYellow, SmugglerHangar.Lighting.Walls.lightYellow2, SmugglerHangar.Lighting.Walls.dimmed,
                    SmugglerHangar.Lighting.Walls.strongYellow, SmugglerHangar.Lighting.Walls.white, SmugglerHangar.Lighting.Walls.lightGreen,
                    SmugglerHangar.Lighting.Walls.yellow}, false, refresh)
            end	
        }
    },
    Details = {
        bedroomClutter = "set_bedroom_clutter",
        Enable = function (details, state, refresh)
            SetIplPropState(SmugglerHangar.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        SmugglerHangar.Ipl.Interior.Load()
        
        SmugglerHangar.Walls.SetColor(SmugglerHangar.Colors.colorSet1)
        SmugglerHangar.Cranes.Set(SmugglerHangar.Cranes.on, SmugglerHangar.Colors.colorSet1)
        SmugglerHangar.Floor.Style.Set(SmugglerHangar.Floor.Style.plain)
        SmugglerHangar.Floor.Decals.Set(SmugglerHangar.Floor.Decals.decal1, SmugglerHangar.Colors.colorSet1)

        SmugglerHangar.Lighting.Ceiling.Set(SmugglerHangar.Lighting.Ceiling.yellow)
        SmugglerHangar.Lighting.Walls.Set(SmugglerHangar.Lighting.Walls.neutral)
        SmugglerHangar.Lighting.FakeLights.Set(SmugglerHangar.Lighting.FakeLights.yellow)

        SmugglerHangar.ModArea.Set(SmugglerHangar.ModArea.on, SmugglerHangar.Colors.colorSet1)

        SmugglerHangar.Office.Set(SmugglerHangar.Office.basic)

        SmugglerHangar.Bedroom.Style.Set(SmugglerHangar.Bedroom.Style.modern, SmugglerHangar.Colors.colorSet1)
        SmugglerHangar.Bedroom.Blinds.Set(SmugglerHangar.Bedroom.Blinds.opened)

        SmugglerHangar.Details.Enable(SmugglerHangar.Details.bedroomClutter, false)

        RefreshInterior(SmugglerHangar.interiorId)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_security_roberto] ---------------------=
    -- ====================================================================
    exports('GetMpSecurityBillboardsObject', function()
        return MpSecurityBillboards
    end)
    
    MpSecurityBillboards = {
        Ipl = {
            Interior = {
                ipl = {
                    'sf_billboards',
                }
            },
            Load = function ()
                EnableIpl(MpSecurityBillboards.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(MpSecurityBillboards.Ipl.Interior.ipl, false)
            end,
        },
        LoadDefault = function()
            MpSecurityBillboards.Ipl.Load()
        end
    }

    exports('GetMpSecurityGarageObject', function()
        return MpSecurityGarage
    end)
    
    MpSecurityGarage = {
        InteriorId = 286721,
        Ipl = {
            Interior = {
                ipl = {
                    'sf_int_placement_sec_interior_2_dlc_garage_sec_milo_',
                }
            },
            Load = function ()
                EnableIpl(MpSecurityGarage.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(MpSecurityGarage.Ipl.Interior.ipl, false)
            end,
        },
        Entities = {
            Entity_Set_Workshop_Wall = false,
            Entity_Set_Wallpaper_01 = false,
            Entity_Set_Wallpaper_02  = false,
            Entity_Set_Wallpaper_03 = false,
            Entity_Set_Wallpaper_04 = false,
            Entity_Set_Wallpaper_05 = false,
            Entity_Set_Wallpaper_06 = false,
            Entity_Set_Wallpaper_07 = true,
            Entity_Set_Wallpaper_08 = false,
            Entity_Set_Wallpaper_09 = false,
            Entity_Set_Art_1 = false,
            Entity_Set_Art_2 = false,
            Entity_Set_Art_3 = false,
            Entity_Set_Art_1_NoMod = false,
            Entity_Set_Art_2_NoMod = false,
            Entity_Set_Art_3_NoMod = false,
            entity_set_tints = true,
            Entity_Set_Workshop_Lights = true,
            
            Set = function (name, state)
                for entity, _ in pairs(MpSecurityGarage.Entities) do
                    if entity == name then
                        MpSecurityGarage.Entities[entity] = state
                        MpSecurityGarage.Entities.Clear()
                        MpSecurityGarage.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(MpSecurityGarage.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(MpSecurityGarage.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(MpSecurityGarage.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(MpSecurityGarage.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            MpSecurityGarage.Ipl.Load()
            MpSecurityGarage.Entities.Load()
            RefreshInterior(MpSecurityGarage.interiorId)
        end
    }

    exports('GetMpSecurityMusicRoofTopObject', function()
        return MpSecurityMusicRoofTop
    end)
    
    MpSecurityMusicRoofTop = {
        Ipl = {
            Interior = {
                ipl = {
                    'sf_musicrooftop',
                }
            },
            Load = function ()
                EnableIpl(MpSecurityMusicRoofTop.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(MpSecurityMusicRoofTop.Ipl.Interior.ipl, false)
            end,
        },
        LoadDefault = function()
            MpSecurityMusicRoofTop.Ipl.Load()
        end
    }

    exports('GetMpSecurityOffice1Object', function()
        return MpSecurityOffice1
    end)
    
    MpSecurityOffice1 = {
        InteriorId = 287489,
        Ipl = {
            Interior = {
                ipl = {
                    'sf_fixeroffice_bh1_05',
                }
            },
            Load = function ()
                EnableIpl(MpSecurityOffice1.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(MpSecurityOffice1.Ipl.Interior.ipl, false)
            end,
        },
        Entities = {
            Entity_Set_Armoury = false,
            Entity_Set_Standard_Office = true,
            Entity_Set_Blocker = false,
            Entity_Set_Wpaper_1 = false,
            Entity_Set_Wpaper_3 = false,
            Entity_Set_Wpaper_2 = false,
            Entity_Set_Wpaper_4 = false,
            Entity_Set_Wpaper_5 = false,
            Entity_Set_Wpaper_6 = false,
            Entity_Set_Wpaper_7 = false,
            Entity_Set_Wpaper_8 = true,
            Entity_Set_Wpaper_9 = false,
            Entity_Set_Moving = true,
            Entity_Set_Tint_AG = true,
            Entity_Set_Spare_Seats = true,
            Entity_Set_Player_Seats = true,
            Entity_Set_Player_Desk = true,
            Entity_Set_M_Golf_Intro = true,
            Entity_Set_M_Setup = true,
            Entity_Set_M_Nightclub = true,
            Entity_Set_M_Yacht = true,
            Entity_Set_M_Promoter = true,
            Entity_Set_M_Limo_Photo = true,
            Entity_Set_M_Limo_Wallet = true,
            Entity_Set_M_The_Way = true,
            Entity_Set_M_Billionaire = true,
            Entity_Set_M_Families = true,
            Entity_Set_M_Ballas = true,
            Entity_Set_M_Hood = true,
            Entity_Set_M_Fire_Booth = true,
            Entity_Set_M_50 = true,
            Entity_Set_M_Taxi = true,
            Entity_Set_M_Gone_Golfing = true,
            Entity_Set_M_Motel = true,
            Entity_Set_M_Construction = true,
            Entity_Set_M_Hit_List = true,
            Entity_Set_M_Tuner = true,
            Entity_Set_M_Attack = true,
            Entity_Set_M_Vehicles = true,
            Entity_Set_M_Trip_01 = true,
            Entity_Set_M_Trip_02 = true,
            Entity_Set_M_Trip_03 = true,
            Entity_set_disc_01 = true,
            Entity_set_disc_02 = false,
            Entity_set_disc_03 = false,
            Entity_set_disc_04 = false,
            Entity_set_disc_05 = false,
            Entity_set_disc_06 = false,
            Entity_Set_Art_1 = true,
            Entity_Set_Art_2 = false,
            Entity_Set_Art_3 = false,
            
            Set = function (name, state)
                for entity, _ in pairs(MpSecurityOffice1.Entities) do
                    if entity == name then
                        MpSecurityOffice1.Entities[entity] = state
                        MpSecurityOffice1.Entities.Clear()
                        MpSecurityOffice1.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(MpSecurityOffice1.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(MpSecurityOffice1.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(MpSecurityOffice1.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(MpSecurityOffice1.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            MpSecurityOffice1.Ipl.Load()
            MpSecurityOffice1.Entities.Load()
            RefreshInterior(MpSecurityOffice1.interiorId)
        end
    }

    exports('GetMpSecurityOffice2Object', function()
        return MpSecurityOffice2
    end)
    
    MpSecurityOffice2 = {
        InteriorId = 288257,
        Ipl = {
            Interior = {
                ipl = {
                    'sf_fixeroffice_hw1_08',
                }
            },
            Load = function ()
                EnableIpl(MpSecurityOffice2.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(MpSecurityOffice2.Ipl.Interior.ipl, false)
            end,
        },
        Entities = {
            Entity_Set_Armoury = true,
            Entity_Set_Standard_Office = false,
            Entity_Set_Blocker = false,
            Entity_Set_Wpaper_1 = false,
            Entity_Set_Wpaper_3 = false,
            Entity_Set_Wpaper_2 = false,
            Entity_Set_Wpaper_4 = false,
            Entity_Set_Wpaper_5 = false,
            Entity_Set_Wpaper_6 = false,
            Entity_Set_Wpaper_7 = false,
            Entity_Set_Wpaper_8 = false,
            Entity_Set_Wpaper_9 = true,
            Entity_Set_Moving = true,
            Entity_Set_Tint_AG = true,
            Entity_Set_Spare_Seats = true,
            Entity_Set_Player_Seats = true,
            Entity_Set_Player_Desk = true,
            Entity_Set_M_Golf_Intro = true,
            Entity_Set_M_Setup = true,
            Entity_Set_M_Nightclub = true,
            Entity_Set_M_Yacht = true,
            Entity_Set_M_Promoter = true,
            Entity_Set_M_Limo_Photo = true,
            Entity_Set_M_Limo_Wallet = true,
            Entity_Set_M_The_Way = true,
            Entity_Set_M_Billionaire = true,
            Entity_Set_M_Families = true,
            Entity_Set_M_Ballas = true,
            Entity_Set_M_Hood = true,
            Entity_Set_M_Fire_Booth = true,
            Entity_Set_M_50 = true,
            Entity_Set_M_Taxi = true,
            Entity_Set_M_Gone_Golfing = true,
            Entity_Set_M_Motel = true,
            Entity_Set_M_Construction = true,
            Entity_Set_M_Hit_List = true,
            Entity_Set_M_Tuner = true,
            Entity_Set_M_Attack = true,
            Entity_Set_M_Vehicles = true,
            Entity_Set_M_Trip_01 = true,
            Entity_Set_M_Trip_02 = true,
            Entity_Set_M_Trip_03 = true,
            Entity_set_disc_01 = false,
            Entity_set_disc_02 = true,
            Entity_set_disc_03 = false,
            Entity_set_disc_04 = false,
            Entity_set_disc_05 = false,
            Entity_set_disc_06 = false,
            Entity_Set_Art_1 = false,
            Entity_Set_Art_2 = true,
            Entity_Set_Art_3 = false,
            
            Set = function (name, state)
                for entity, _ in pairs(MpSecurityOffice2.Entities) do
                    if entity == name then
                        MpSecurityOffice2.Entities[entity] = state
                        MpSecurityOffice2.Entities.Clear()
                        MpSecurityOffice2.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(MpSecurityOffice2.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(MpSecurityOffice2.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(MpSecurityOffice2.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(MpSecurityOffice2.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            MpSecurityOffice2.Ipl.Load()
            MpSecurityOffice2.Entities.Load()
            RefreshInterior(MpSecurityOffice2.interiorId)
        end
    }

    exports('GetMpSecurityOffice3Object', function()
        return MpSecurityOffice3
    end)
    
    MpSecurityOffice3 = {
        InteriorId = 288001,
        Ipl = {
            Interior = {
                ipl = {
                    'sf_fixeroffice_kt1_05',
                }
            },
            Load = function ()
                EnableIpl(MpSecurityOffice3.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(MpSecurityOffice3.Ipl.Interior.ipl, false)
            end,
        },
        Entities = {
            Entity_Set_Armoury = false,
            Entity_Set_Standard_Office = true,
            Entity_Set_Blocker = false,
            Entity_Set_Wpaper_1 = false,
            Entity_Set_Wpaper_3 = false,
            Entity_Set_Wpaper_2 = true,
            Entity_Set_Wpaper_4 = false,
            Entity_Set_Wpaper_5 = false,
            Entity_Set_Wpaper_6 = false,
            Entity_Set_Wpaper_7 = false,
            Entity_Set_Wpaper_8 = false,
            Entity_Set_Wpaper_9 = false,
            Entity_Set_Moving = true,
            Entity_Set_Tint_AG = true,
            Entity_Set_Spare_Seats = true,
            Entity_Set_Player_Seats = true,
            Entity_Set_Player_Desk = true,
            Entity_Set_M_Golf_Intro = true,
            Entity_Set_M_Setup = true,
            Entity_Set_M_Nightclub = true,
            Entity_Set_M_Yacht = true,
            Entity_Set_M_Promoter = true,
            Entity_Set_M_Limo_Photo = true,
            Entity_Set_M_Limo_Wallet = true,
            Entity_Set_M_The_Way = true,
            Entity_Set_M_Billionaire = true,
            Entity_Set_M_Families = true,
            Entity_Set_M_Ballas = true,
            Entity_Set_M_Hood = true,
            Entity_Set_M_Fire_Booth = true,
            Entity_Set_M_50 = true,
            Entity_Set_M_Taxi = true,
            Entity_Set_M_Gone_Golfing = true,
            Entity_Set_M_Motel = true,
            Entity_Set_M_Construction = true,
            Entity_Set_M_Hit_List = true,
            Entity_Set_M_Tuner = true,
            Entity_Set_M_Attack = true,
            Entity_Set_M_Vehicles = true,
            Entity_Set_M_Trip_01 = true,
            Entity_Set_M_Trip_02 = true,
            Entity_Set_M_Trip_03 = true,
            Entity_set_disc_01 = false,
            Entity_set_disc_02 = true,
            Entity_set_disc_03 = false,
            Entity_set_disc_04 = false,
            Entity_set_disc_05 = false,
            Entity_set_disc_06 = false,
            Entity_Set_Art_1 = false,
            Entity_Set_Art_2 = false,
            Entity_Set_Art_3 = true,
            
            Set = function (name, state)
                for entity, _ in pairs(MpSecurityOffice3.Entities) do
                    if entity == name then
                        MpSecurityOffice3.Entities[entity] = state
                        MpSecurityOffice3.Entities.Clear()
                        MpSecurityOffice3.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(MpSecurityOffice3.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(MpSecurityOffice3.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(MpSecurityOffice3.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(MpSecurityOffice3.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            MpSecurityOffice3.Ipl.Load()
            MpSecurityOffice3.Entities.Load()
            RefreshInterior(MpSecurityOffice3.interiorId)
        end
    }

    exports('GetMpSecurityOffice4Object', function()
        return MpSecurityOffice4
    end)
    
    MpSecurityOffice4 = {
        InteriorId = 287745,
        Ipl = {
            Interior = {
                ipl = {
                    'sf_fixeroffice_kt1_08',
                }
            },
            Load = function ()
                EnableIpl(MpSecurityOffice4.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(MpSecurityOffice4.Ipl.Interior.ipl, false)
            end,
        },
        Entities = {
            Entity_Set_Armoury = true,
            Entity_Set_Standard_Office = false,
            Entity_Set_Blocker = false,
            Entity_Set_Wpaper_1 = false,
            Entity_Set_Wpaper_3 = true,
            Entity_Set_Wpaper_2 = false,
            Entity_Set_Wpaper_4 = false,
            Entity_Set_Wpaper_5 = false,
            Entity_Set_Wpaper_6 = false,
            Entity_Set_Wpaper_7 = false,
            Entity_Set_Wpaper_8 = false,
            Entity_Set_Wpaper_9 = false,
            Entity_Set_Moving = true,
            Entity_Set_Tint_AG = true,
            Entity_Set_Spare_Seats = true,
            Entity_Set_Player_Seats = true,
            Entity_Set_Player_Desk = true,
            Entity_Set_M_Golf_Intro = true,
            Entity_Set_M_Setup = true,
            Entity_Set_M_Nightclub = true,
            Entity_Set_M_Yacht = true,
            Entity_Set_M_Promoter = true,
            Entity_Set_M_Limo_Photo = true,
            Entity_Set_M_Limo_Wallet = true,
            Entity_Set_M_The_Way = true,
            Entity_Set_M_Billionaire = true,
            Entity_Set_M_Families = true,
            Entity_Set_M_Ballas = true,
            Entity_Set_M_Hood = true,
            Entity_Set_M_Fire_Booth = true,
            Entity_Set_M_50 = true,
            Entity_Set_M_Taxi = true,
            Entity_Set_M_Gone_Golfing = true,
            Entity_Set_M_Motel = true,
            Entity_Set_M_Construction = true,
            Entity_Set_M_Hit_List = true,
            Entity_Set_M_Tuner = true,
            Entity_Set_M_Attack = true,
            Entity_Set_M_Vehicles = true,
            Entity_Set_M_Trip_01 = true,
            Entity_Set_M_Trip_02 = true,
            Entity_Set_M_Trip_03 = true,
            Entity_set_disc_01 = false,
            Entity_set_disc_02 = false,
            Entity_set_disc_03 = false,
            Entity_set_disc_04 = false,
            Entity_set_disc_05 = true,
            Entity_set_disc_06 = false,
            Entity_Set_Art_1 = true,
            Entity_Set_Art_2 = false,
            Entity_Set_Art_3 = false,
            
            Set = function (name, state)
                for entity, _ in pairs(MpSecurityOffice4.Entities) do
                    if entity == name then
                        MpSecurityOffice4.Entities[entity] = state
                        MpSecurityOffice4.Entities.Clear()
                        MpSecurityOffice4.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(MpSecurityOffice4.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(MpSecurityOffice4.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(MpSecurityOffice4.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(MpSecurityOffice4.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            MpSecurityOffice4.Ipl.Load()
            MpSecurityOffice4.Entities.Load()
            RefreshInterior(MpSecurityOffice4.interiorId)
        end
    }

    exports('GetMpSecurityStudioObject', function()
        return MpSecurityStudio
    end)
    
    MpSecurityStudio = {
        InteriorId = 286977,
        Ipl = {
            Interior = {
                ipl = {
                    'sf_int_placement_sec_interior_1_dlc_studio_sec_milo_ ',
                }
            },
            Load = function ()
                EnableIpl(MpSecurityStudio.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(MpSecurityStudio.Ipl.Interior.ipl, false)
            end,
        },
        Entities = {
            Entity_Set_FIX_STU_EXT_P3A1 = false,
            Entity_Set_FIX_TRIP1_INT_P2 = false,
            Entity_Set_FIX_STU_EXT_P1 = false,
            Entity_Set_Fire = true,
            entity_set_default = true,
            
            Set = function (name, state)
                for entity, _ in pairs(MpSecurityStudio.Entities) do
                    if entity == name then
                        MpSecurityStudio.Entities[entity] = state
                        MpSecurityStudio.Entities.Clear()
                        MpSecurityStudio.Entities.Load()
                    end
                end
            end,
            Load = function ()
                for entity, state in pairs(MpSecurityStudio.Entities) do
                    if type(entity) == 'string' and state then
                        ActivateInteriorEntitySet(MpSecurityStudio.InteriorId, entity)
                    end
                end
            end,
            Clear = function ()
                for entity, _ in pairs(MpSecurityStudio.Entities) do
                    if type(entity) == 'string' then
                        DeactivateInteriorEntitySet(MpSecurityStudio.InteriorId, entity)
                    end
                end
            end,
        },
        LoadDefault = function()
            MpSecurityStudio.Ipl.Load()
            MpSecurityStudio.Entities.Load()
            RefreshInterior(MpSecurityStudio.interiorId)
        end
    }
    
    -- ====================================================================
    -- =------------------- [dlc_import_Roberto] ---------------------=
    -- ====================================================================

    
-- Garage 1: Arcadius Business Centre

exports('GetImportCEOGarage1Object', function()
	return ImportCEOGarage1
end)

ImportCEOGarage1 = {
    Part = {
        Garage1 = {interiorId = 253441, ipl = "imp_dt1_02_cargarage_a"},  -- -191.0133, -579.1428, 135.0000
        Garage2 = {interiorId = 253697, ipl = "imp_dt1_02_cargarage_b"},  -- -117.4989, -568.1132, 135.0000
        Garage3 = {interiorId = 253953, ipl = "imp_dt1_02_cargarage_c"},  -- -136.0780, -630.1852, 135.0000
        ModShop = {interiorId = 254209, ipl = "imp_dt1_02_modgarage"},    -- -146.6166, -596.6301, 166.0000

        Load = function(part) EnableIpl(part.ipl, true) end,
        Remove = function(part) EnableIpl(part.ipl, false) end,
        Clear = function() EnableIpl({ImportCEOGarage1.Part.Garage1.ipl, ImportCEOGarage1.Part.Garage2.ipl, ImportCEOGarage1.Part.Garage3.ipl}, false) end,
    },
    Style = {
        concrete = "garage_decor_01", plain = "garage_decor_02", marble = "garage_decor_03", wooden = "garage_decor_04",
        Set = function(part, style, refresh)
            ImportCEOGarage1.Style.Clear(part)
            SetIplPropState(part.interiorId, style, true, refresh)
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {ImportCEOGarage1.Style.concrete, ImportCEOGarage1.Style.plain, ImportCEOGarage1.Style.marble, ImportCEOGarage1.Style.wooden}, false, true)
        end
    },
    Numbering = {
        none = "",
        Level1 = {
            style1 = "numbering_style01_n1", style2 = "numbering_style02_n1", style3 = "numbering_style03_n1",
            style4 = "numbering_style04_n1", style5 = "numbering_style05_n1", style6 = "numbering_style06_n1",
            style7 = "numbering_style07_n1", style8 = "numbering_style08_n1", style9 = "numbering_style09_n1",
        },
        Level2 = {
            style1 = "numbering_style01_n2", style2 = "numbering_style02_n2", style3 = "numbering_style03_n2",
            style4 = "numbering_style04_n2", style5 = "numbering_style05_n2", style6 = "numbering_style06_n2",
            style7 = "numbering_style07_n2", style8 = "numbering_style08_n2", style9 = "numbering_style09_n2",
        },
        Level3 = {
            style1 = "numbering_style01_n3", style2 = "numbering_style02_n3", style3 = "numbering_style03_n3",
            style4 = "numbering_style04_n3", style5 = "numbering_style05_n3", style6 = "numbering_style06_n3",
            style7 = "numbering_style07_n3", style8 = "numbering_style08_n3", style9 = "numbering_style09_n3",
        },
        Set = function(part, num, refresh)
            ImportCEOGarage1.Numbering.Clear(part)
            if (num ~= nil) then
                SetIplPropState(part.interiorId, num, true, refresh)
            else
                if (refresh) then RefreshInterior(part.interiorId) end
            end
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {ImportCEOGarage1.Numbering.Level1, ImportCEOGarage1.Numbering.Level2, ImportCEOGarage1.Numbering.Level3}, false, true)
        end
    },
    Lighting = {
        none = "",
        style1 = "lighting_option01", style2 = "lighting_option02", style3 = "lighting_option03",
        style4 = "lighting_option04", style5 = "lighting_option05", style6 = "lighting_option06",
        style7 = "lighting_option07", style8 = "lighting_option08", style9 = "lighting_option09",

        Set = function(part, light, refresh)
            ImportCEOGarage1.Lighting.Clear(part)
            if (light ~= nil) then
                SetIplPropState(part.interiorId, light, true, refresh)
            else
                if (refresh) then RefreshInterior(part.interiorId) end
            end
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {
                ImportCEOGarage1.Lighting.style1, ImportCEOGarage1.Lighting.style2, ImportCEOGarage1.Lighting.style3,
                ImportCEOGarage1.Lighting.style4, ImportCEOGarage1.Lighting.style5, ImportCEOGarage1.Lighting.style6,
                ImportCEOGarage1.Lighting.style7, ImportCEOGarage1.Lighting.style8, ImportCEOGarage1.Lighting.style9
            }, false, true)
        end
    },
    ModShop = {
        Floor = {
            default = "",
            city = "floor_vinyl_01", seabed = "floor_vinyl_02", aliens = "floor_vinyl_03",
            clouds = "floor_vinyl_04", money = "floor_vinyl_05", zebra = "floor_vinyl_06",
            blackWhite = "floor_vinyl_07", barcode = "floor_vinyl_08", paintbrushBW = "floor_vinyl_09",
            grid = "floor_vinyl_10", splashes = "floor_vinyl_11", squares = "floor_vinyl_12",
            mosaic = "floor_vinyl_13", paintbrushColor = "floor_vinyl_14", curvesColor = "floor_vinyl_15",
            marbleBrown = "floor_vinyl_16", marbleBlue = "floor_vinyl_17", marbleBW = "floor_vinyl_18",
            maze = "floor_vinyl_19",

            Set = function(floor, refresh)
                ImportCEOGarage1.ModShop.Floor.Clear()
                if (floor ~= nil) then
                    SetIplPropState(ImportCEOGarage1.Part.ModShop.interiorId, floor, true, refresh)
                else
                    if (refresh) then RefreshInterior(ImportCEOGarage1.Part.ModShop.interiorId) end
                end
            end,
            Clear = function()
                SetIplPropState(ImportCEOGarage1.Part.ModShop.interiorId, {
                    ImportCEOGarage1.ModShop.Floor.city, ImportCEOGarage1.ModShop.Floor.seabed, ImportCEOGarage1.ModShop.Floor.aliens,
                    ImportCEOGarage1.ModShop.Floor.clouds, ImportCEOGarage1.ModShop.Floor.money, ImportCEOGarage1.ModShop.Floor.zebra,
                    ImportCEOGarage1.ModShop.Floor.blackWhite, ImportCEOGarage1.ModShop.Floor.barcode, ImportCEOGarage1.ModShop.Floor.paintbrushBW,
                    ImportCEOGarage1.ModShop.Floor.grid, ImportCEOGarage1.ModShop.Floor.splashes, ImportCEOGarage1.ModShop.Floor.squares,
                    ImportCEOGarage1.ModShop.Floor.mosaic, ImportCEOGarage1.ModShop.Floor.paintbrushColor, ImportCEOGarage1.ModShop.Floor.curvesColor,
                    ImportCEOGarage1.ModShop.Floor.marbleBrown, ImportCEOGarage1.ModShop.Floor.marbleBlue, ImportCEOGarage1.ModShop.Floor.marbleBW,
                    ImportCEOGarage1.ModShop.Floor.maze
                }, false, true)
            end
        }
    },

    LoadDefault = function()
        ImportCEOGarage1.Part.Load(ImportCEOGarage1.Part.Garage1)
        ImportCEOGarage1.Style.Set(ImportCEOGarage1.Part.Garage1, ImportCEOGarage1.Style.concrete)
        ImportCEOGarage1.Numbering.Set(ImportCEOGarage1.Part.Garage1, ImportCEOGarage1.Numbering.Level1.style1)
        ImportCEOGarage1.Lighting.Set(ImportCEOGarage1.Part.Garage1, ImportCEOGarage1.Lighting.style1, true)
        
        ImportCEOGarage1.Part.Load(ImportCEOGarage1.Part.ModShop)
        ImportCEOGarage1.ModShop.Floor.Set(ImportCEOGarage1.ModShop.Floor.default, true)
    end
}


-- Garage 2: Maze Bank Building

exports('GetImportCEOGarage2Object', function()
	return ImportCEOGarage2
end)

ImportCEOGarage2 = {
    Part = {
        Garage1 = {interiorId = 254465, ipl = "imp_dt1_11_cargarage_a"},  -- -84.2193, -823.0851, 221.0000
        Garage2 = {interiorId = 254721, ipl = "imp_dt1_11_cargarage_b"},  -- -69.8627, -824.7498, 221.0000
        Garage3 = {interiorId = 254977, ipl = "imp_dt1_11_cargarage_c"},  -- -80.4318, -813.2536, 221.0000
        ModShop = {interiorId = 255233, ipl = "imp_dt1_11_modgarage"},    -- -73.9039, -821.6204, 284.0000

        Load = function(part) EnableIpl(part.ipl, true) end,
        Remove = function(part) EnableIpl(part.ipl, false) end,
        Clear = function() EnableIpl({ImportCEOGarage2.Part.Garage1.ipl, ImportCEOGarage2.Part.Garage2.ipl, ImportCEOGarage2.Part.Garage3.ipl}, false) end,
    },
    Style = {
        concrete = "garage_decor_01", plain = "garage_decor_02", marble = "garage_decor_03", wooden = "garage_decor_04",
        Set = function(part, style, refresh)
            ImportCEOGarage2.Style.Clear(part)
            SetIplPropState(part.interiorId, style, true, refresh)
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {ImportCEOGarage2.Style.concrete, ImportCEOGarage2.Style.plain, ImportCEOGarage2.Style.marble, ImportCEOGarage2.Style.wooden}, false, true)
        end
    },
    Numbering = {
        none = "",
        Level1 = {
            style1 = "numbering_style01_n1", style2 = "numbering_style02_n1", style3 = "numbering_style03_n1",
            style4 = "numbering_style04_n1", style5 = "numbering_style05_n1", style6 = "numbering_style06_n1",
            style7 = "numbering_style07_n1", style8 = "numbering_style08_n1", style9 = "numbering_style09_n1",
        },
        Level2 = {
            style1 = "numbering_style01_n2", style2 = "numbering_style02_n2", style3 = "numbering_style03_n2",
            style4 = "numbering_style04_n2", style5 = "numbering_style05_n2", style6 = "numbering_style06_n2",
            style7 = "numbering_style07_n2", style8 = "numbering_style08_n2", style9 = "numbering_style09_n2",
        },
        Level3 = {
            style1 = "numbering_style01_n3", style2 = "numbering_style02_n3", style3 = "numbering_style03_n3",
            style4 = "numbering_style04_n3", style5 = "numbering_style05_n3", style6 = "numbering_style06_n3",
            style7 = "numbering_style07_n3", style8 = "numbering_style08_n3", style9 = "numbering_style09_n3",
        },
        Set = function(part, num, refresh)
            ImportCEOGarage2.Numbering.Clear(part)
            if (num ~= nil) then
                SetIplPropState(part.interiorId, num, true, refresh)
            else
                if (refresh) then RefreshInterior(part.interiorId) end
            end
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {ImportCEOGarage2.Numbering.Level1, ImportCEOGarage2.Numbering.Level2, ImportCEOGarage2.Numbering.Level3}, false, true)
        end
    },
    Lighting = {
        none = "",
        style1 = "lighting_option01", style2 = "lighting_option02", style3 = "lighting_option03",
        style4 = "lighting_option04", style5 = "lighting_option05", style6 = "lighting_option06",
        style7 = "lighting_option07", style8 = "lighting_option08", style9 = "lighting_option09",

        Set = function(part, light, refresh)
            ImportCEOGarage2.Lighting.Clear(part)
            if (light ~= nil) then
                SetIplPropState(part.interiorId, light, true, refresh)
            else
                if (refresh) then RefreshInterior(part.interiorId) end
            end
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {
                ImportCEOGarage2.Lighting.style1, ImportCEOGarage2.Lighting.style2, ImportCEOGarage2.Lighting.style3,
                ImportCEOGarage2.Lighting.style4, ImportCEOGarage2.Lighting.style5, ImportCEOGarage2.Lighting.style6,
                ImportCEOGarage2.Lighting.style7, ImportCEOGarage2.Lighting.style8, ImportCEOGarage2.Lighting.style9
            }, false, true)
        end
    },
    ModShop = {
        Floor = {
            default = "",
            city = "floor_vinyl_01", seabed = "floor_vinyl_02", aliens = "floor_vinyl_03",
            clouds = "floor_vinyl_04", money = "floor_vinyl_05", zebra = "floor_vinyl_06",
            blackWhite = "floor_vinyl_07", barcode = "floor_vinyl_08", paintbrushBW = "floor_vinyl_09",
            grid = "floor_vinyl_10", splashes = "floor_vinyl_11", squares = "floor_vinyl_12",
            mosaic = "floor_vinyl_13", paintbrushColor = "floor_vinyl_14", curvesColor = "floor_vinyl_15",
            marbleBrown = "floor_vinyl_16", marbleBlue = "floor_vinyl_17", marbleBW = "floor_vinyl_18",
            maze = "floor_vinyl_19",

            Set = function(floor, refresh)
                ImportCEOGarage2.ModShop.Floor.Clear()
                if (floor ~= nil) then
                    SetIplPropState(ImportCEOGarage2.Part.ModShop.interiorId, floor, true, refresh)
                else
                    if (refresh) then RefreshInterior(ImportCEOGarage2.Part.ModShop.interiorId) end
                end
            end,
            Clear = function()
                SetIplPropState(ImportCEOGarage2.Part.ModShop.interiorId, {
                    ImportCEOGarage2.ModShop.Floor.city, ImportCEOGarage2.ModShop.Floor.seabed, ImportCEOGarage2.ModShop.Floor.aliens,
                    ImportCEOGarage2.ModShop.Floor.clouds, ImportCEOGarage2.ModShop.Floor.money, ImportCEOGarage2.ModShop.Floor.zebra,
                    ImportCEOGarage2.ModShop.Floor.blackWhite, ImportCEOGarage2.ModShop.Floor.barcode, ImportCEOGarage2.ModShop.Floor.paintbrushBW,
                    ImportCEOGarage2.ModShop.Floor.grid, ImportCEOGarage2.ModShop.Floor.splashes, ImportCEOGarage2.ModShop.Floor.squares,
                    ImportCEOGarage2.ModShop.Floor.mosaic, ImportCEOGarage2.ModShop.Floor.paintbrushColor, ImportCEOGarage2.ModShop.Floor.curvesColor,
                    ImportCEOGarage2.ModShop.Floor.marbleBrown, ImportCEOGarage2.ModShop.Floor.marbleBlue, ImportCEOGarage2.ModShop.Floor.marbleBW,
                    ImportCEOGarage2.ModShop.Floor.maze
                }, false, true)
            end
        }
    },

    LoadDefault = function()
        ImportCEOGarage2.Part.Load(ImportCEOGarage2.Part.Garage1)
        ImportCEOGarage2.Style.Set(ImportCEOGarage2.Part.Garage1, ImportCEOGarage2.Style.concrete, false)
        ImportCEOGarage2.Numbering.Set(ImportCEOGarage2.Part.Garage1, ImportCEOGarage2.Numbering.Level1.style1, false)
        ImportCEOGarage2.Lighting.Set(ImportCEOGarage2.Part.Garage1, ImportCEOGarage2.Lighting.style1, true)
        
        ImportCEOGarage2.Part.Load(ImportCEOGarage2.Part.ModShop)
        ImportCEOGarage2.ModShop.Floor.Set(ImportCEOGarage2.ModShop.Floor.default, true)
    end
}


-- Garage 3: Lom Bank

exports('GetImportCEOGarage3Object', function()
	return ImportCEOGarage3
end)

ImportCEOGarage3 = {
    Part = {
        Garage1 = {interiorId = 255489, ipl = "imp_sm_13_cargarage_a"},  -- -1581.1120, -567.2450, 85.5000
        Garage2 = {interiorId = 255745, ipl = "imp_sm_13_cargarage_b"},  -- -1568.7390, -562.0455, 85.5000
        Garage3 = {interiorId = 256001, ipl = "imp_sm_13_cargarage_c"},  -- -1563.5570, -574.4314, 85.5000
        ModShop = {interiorId = 256257, ipl = "imp_sm_13_modgarage"},    -- -1578.0230, -576.4251, 104.2000

        Load = function(part) EnableIpl(part.ipl, true) end,
        Remove = function(part) EnableIpl(part.ipl, false) end,
        Clear = function() EnableIpl({ImportCEOGarage3.Part.Garage1.ipl, ImportCEOGarage3.Part.Garage2.ipl, ImportCEOGarage3.Part.Garage3.ipl}, false) end,
    },
    Style = {
        concrete = "garage_decor_01", plain = "garage_decor_02", marble = "garage_decor_03", wooden = "garage_decor_04",
        Set = function(part, style, refresh)
            ImportCEOGarage3.Style.Clear(part)
            SetIplPropState(part.interiorId, style, true, refresh)
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {ImportCEOGarage3.Style.concrete, ImportCEOGarage3.Style.plain, ImportCEOGarage3.Style.marble, ImportCEOGarage3.Style.wooden}, false, true)
        end
    },
    Numbering = {
        none = "",
        Level1 = {
            style1 = "numbering_style01_n1", style2 = "numbering_style02_n1", style3 = "numbering_style03_n1",
            style4 = "numbering_style04_n1", style5 = "numbering_style05_n1", style6 = "numbering_style06_n1",
            style7 = "numbering_style07_n1", style8 = "numbering_style08_n1", style9 = "numbering_style09_n1",
        },
        Level2 = {
            style1 = "numbering_style01_n2", style2 = "numbering_style02_n2", style3 = "numbering_style03_n2",
            style4 = "numbering_style04_n2", style5 = "numbering_style05_n2", style6 = "numbering_style06_n2",
            style7 = "numbering_style07_n2", style8 = "numbering_style08_n2", style9 = "numbering_style09_n2",
        },
        Level3 = {
            style1 = "numbering_style01_n3", style2 = "numbering_style02_n3", style3 = "numbering_style03_n3",
            style4 = "numbering_style04_n3", style5 = "numbering_style05_n3", style6 = "numbering_style06_n3",
            style7 = "numbering_style07_n3", style8 = "numbering_style08_n3", style9 = "numbering_style09_n3",
        },
        Set = function(part, num, refresh)
            ImportCEOGarage3.Numbering.Clear(part)
            if (num ~= nil) then
                SetIplPropState(part.interiorId, num, true, refresh)
            else
                if (refresh) then RefreshInterior(part.interiorId) end
            end
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {ImportCEOGarage3.Numbering.Level1, ImportCEOGarage3.Numbering.Level2, ImportCEOGarage3.Numbering.Level3}, false, true)
        end
    },
    Lighting = {
        none = "",
        style1 = "lighting_option01", style2 = "lighting_option02", style3 = "lighting_option03",
        style4 = "lighting_option04", style5 = "lighting_option05", style6 = "lighting_option06",
        style7 = "lighting_option07", style8 = "lighting_option08", style9 = "lighting_option09",

        Set = function(part, light, refresh)
            ImportCEOGarage3.Lighting.Clear(part)
            if (light ~= nil) then
                SetIplPropState(part.interiorId, light, true, refresh)
            else
                if (refresh) then RefreshInterior(part.interiorId) end
            end
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {
                ImportCEOGarage3.Lighting.style1, ImportCEOGarage3.Lighting.style2, ImportCEOGarage3.Lighting.style3,
                ImportCEOGarage3.Lighting.style4, ImportCEOGarage3.Lighting.style5, ImportCEOGarage3.Lighting.style6,
                ImportCEOGarage3.Lighting.style7, ImportCEOGarage3.Lighting.style8, ImportCEOGarage3.Lighting.style9
            }, false, true)
        end
    },
    ModShop = {
        Floor = {
            default = "",
            city = "floor_vinyl_01", seabed = "floor_vinyl_02", aliens = "floor_vinyl_03",
            clouds = "floor_vinyl_04", money = "floor_vinyl_05", zebra = "floor_vinyl_06",
            blackWhite = "floor_vinyl_07", barcode = "floor_vinyl_08", paintbrushBW = "floor_vinyl_09",
            grid = "floor_vinyl_10", splashes = "floor_vinyl_11", squares = "floor_vinyl_12",
            mosaic = "floor_vinyl_13", paintbrushColor = "floor_vinyl_14", curvesColor = "floor_vinyl_15",
            marbleBrown = "floor_vinyl_16", marbleBlue = "floor_vinyl_17", marbleBW = "floor_vinyl_18",
            maze = "floor_vinyl_19",

            Set = function(floor, refresh)
                ImportCEOGarage3.ModShop.Floor.Clear()
                if (floor ~= nil) then
                    SetIplPropState(ImportCEOGarage3.Part.ModShop.interiorId, floor, true, refresh)
                else
                    if (refresh) then RefreshInterior(ImportCEOGarage3.Part.ModShop.interiorId) end
                end
            end,
            Clear = function()
                SetIplPropState(ImportCEOGarage3.Part.ModShop.interiorId, {
                    ImportCEOGarage3.ModShop.Floor.city, ImportCEOGarage3.ModShop.Floor.seabed, ImportCEOGarage3.ModShop.Floor.aliens,
                    ImportCEOGarage3.ModShop.Floor.clouds, ImportCEOGarage3.ModShop.Floor.money, ImportCEOGarage3.ModShop.Floor.zebra,
                    ImportCEOGarage3.ModShop.Floor.blackWhite, ImportCEOGarage3.ModShop.Floor.barcode, ImportCEOGarage3.ModShop.Floor.paintbrushBW,
                    ImportCEOGarage3.ModShop.Floor.grid, ImportCEOGarage3.ModShop.Floor.splashes, ImportCEOGarage3.ModShop.Floor.squares,
                    ImportCEOGarage3.ModShop.Floor.mosaic, ImportCEOGarage3.ModShop.Floor.paintbrushColor, ImportCEOGarage3.ModShop.Floor.curvesColor,
                    ImportCEOGarage3.ModShop.Floor.marbleBrown, ImportCEOGarage3.ModShop.Floor.marbleBlue, ImportCEOGarage3.ModShop.Floor.marbleBW,
                    ImportCEOGarage3.ModShop.Floor.maze
                }, false, true)
            end
        }
    },

    LoadDefault = function()
        ImportCEOGarage3.Part.Load(ImportCEOGarage3.Part.Garage1)
        ImportCEOGarage3.Style.Set(ImportCEOGarage3.Part.Garage1, ImportCEOGarage3.Style.concrete, false)
        ImportCEOGarage3.Numbering.Set(ImportCEOGarage3.Part.Garage1, ImportCEOGarage3.Numbering.Level1.style1, false)
        ImportCEOGarage3.Lighting.Set(ImportCEOGarage3.Part.Garage1, ImportCEOGarage3.Lighting.style1, true)
        
        -- No mod shop since it overlapses CEO office
        ImportCEOGarage3.Part.Remove(ImportCEOGarage3.Part.ModShop)
    end
}


-- Garage 4: Maze Bank West
-- Be careful, ImportCEOGarage4.Part.Garage1 and ImportCEOGarage4.Part.Garage3 overlaps with FinanceOffice4

exports('GetImportCEOGarage4Object', function()
	return ImportCEOGarage4
end)

ImportCEOGarage4 = {
    Part = {
        Garage1 = {interiorId = 256513, ipl = "imp_sm_15_cargarage_a"},  -- -1388.8400, -478.7402, 56.1000
        Garage2 = {interiorId = 256769, ipl = "imp_sm_15_cargarage_b"},  -- -1388.8600, -478.7574, 48.1000
        Garage3 = {interiorId = 257025, ipl = "imp_sm_15_cargarage_c"},  -- -1374.6820, -474.3586, 56.1000
        ModShop = {interiorId = 257281, ipl = "imp_sm_15_modgarage"},    -- -1391.2450, -473.9638, 77.2000

        Load = function(part) EnableIpl(part.ipl, true) end,
        Remove = function(part) EnableIpl(part.ipl, false) end,
        Clear = function() EnableIpl({ImportCEOGarage4.Part.Garage1.ipl, ImportCEOGarage4.Part.Garage2.ipl, ImportCEOGarage4.Part.Garage3.ipl}, false) end,
    },
    Style = {
        concrete = "garage_decor_01", plain = "garage_decor_02", marble = "garage_decor_03", wooden = "garage_decor_04",
        Set = function(part, style, refresh)
            ImportCEOGarage4.Style.Clear(part)
            SetIplPropState(part.interiorId, style, true, refresh)
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {ImportCEOGarage4.Style.concrete, ImportCEOGarage4.Style.plain, ImportCEOGarage4.Style.marble, ImportCEOGarage4.Style.wooden}, false, true)
        end
    },
    Numbering = {
        none = "",
        Level1 = {
            style1 = "numbering_style01_n1", style2 = "numbering_style02_n1", style3 = "numbering_style03_n1",
            style4 = "numbering_style04_n1", style5 = "numbering_style05_n1", style6 = "numbering_style06_n1",
            style7 = "numbering_style07_n1", style8 = "numbering_style08_n1", style9 = "numbering_style09_n1",
        },
        Level2 = {
            style1 = "numbering_style01_n2", style2 = "numbering_style02_n2", style3 = "numbering_style03_n2",
            style4 = "numbering_style04_n2", style5 = "numbering_style05_n2", style6 = "numbering_style06_n2",
            style7 = "numbering_style07_n2", style8 = "numbering_style08_n2", style9 = "numbering_style09_n2",
        },
        Level3 = {
            style1 = "numbering_style01_n3", style2 = "numbering_style02_n3", style3 = "numbering_style03_n3",
            style4 = "numbering_style04_n3", style5 = "numbering_style05_n3", style6 = "numbering_style06_n3",
            style7 = "numbering_style07_n3", style8 = "numbering_style08_n3", style9 = "numbering_style09_n3",
        },
        Set = function(part, num, refresh)
            ImportCEOGarage4.Numbering.Clear(part)
            if (num ~= nil) then
                SetIplPropState(part.interiorId, num, true, refresh)
            else
                if (refresh) then RefreshInterior(part.interiorId) end
            end
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {ImportCEOGarage4.Numbering.Level1, ImportCEOGarage4.Numbering.Level2, ImportCEOGarage4.Numbering.Level3}, false, true)
        end
    },
    Lighting = {
        none = "",
        style1 = "lighting_option01", style2 = "lighting_option02", style3 = "lighting_option03",
        style4 = "lighting_option04", style5 = "lighting_option05", style6 = "lighting_option06",
        style7 = "lighting_option07", style8 = "lighting_option08", style9 = "lighting_option09",

        Set = function(part, light, refresh)
            ImportCEOGarage4.Lighting.Clear(part)
            if (light ~= nil) then
                SetIplPropState(part.interiorId, light, true, refresh)
            else
                if (refresh) then RefreshInterior(part.interiorId) end
            end
        end,
        Clear = function(part)
            SetIplPropState(part.interiorId, {
                ImportCEOGarage4.Lighting.style1, ImportCEOGarage4.Lighting.style2, ImportCEOGarage4.Lighting.style3,
                ImportCEOGarage4.Lighting.style4, ImportCEOGarage4.Lighting.style5, ImportCEOGarage4.Lighting.style6,
                ImportCEOGarage4.Lighting.style7, ImportCEOGarage4.Lighting.style8, ImportCEOGarage4.Lighting.style9
            }, false, true)
        end
    },
    ModShop = {
        Floor = {
            default = "",
            city = "floor_vinyl_01", seabed = "floor_vinyl_02", aliens = "floor_vinyl_03",
            clouds = "floor_vinyl_04", money = "floor_vinyl_05", zebra = "floor_vinyl_06",
            blackWhite = "floor_vinyl_07", barcode = "floor_vinyl_08", paintbrushBW = "floor_vinyl_09",
            grid = "floor_vinyl_10", splashes = "floor_vinyl_11", squares = "floor_vinyl_12",
            mosaic = "floor_vinyl_13", paintbrushColor = "floor_vinyl_14", curvesColor = "floor_vinyl_15",
            marbleBrown = "floor_vinyl_16", marbleBlue = "floor_vinyl_17", marbleBW = "floor_vinyl_18",
            maze = "floor_vinyl_19",

            Set = function(floor, refresh)
                ImportCEOGarage4.ModShop.Floor.Clear()
                if (floor ~= nil) then
                    SetIplPropState(ImportCEOGarage4.Part.ModShop.interiorId, floor, true, refresh)
                else
                    if (refresh) then RefreshInterior(ImportCEOGarage4.Part.ModShop.interiorId) end
                end
            end,
            Clear = function()
                SetIplPropState(ImportCEOGarage4.Part.ModShop.interiorId, {
                    ImportCEOGarage4.ModShop.Floor.city, ImportCEOGarage4.ModShop.Floor.seabed, ImportCEOGarage4.ModShop.Floor.aliens,
                    ImportCEOGarage4.ModShop.Floor.clouds, ImportCEOGarage4.ModShop.Floor.money, ImportCEOGarage4.ModShop.Floor.zebra,
                    ImportCEOGarage4.ModShop.Floor.blackWhite, ImportCEOGarage4.ModShop.Floor.barcode, ImportCEOGarage4.ModShop.Floor.paintbrushBW,
                    ImportCEOGarage4.ModShop.Floor.grid, ImportCEOGarage4.ModShop.Floor.splashes, ImportCEOGarage4.ModShop.Floor.squares,
                    ImportCEOGarage4.ModShop.Floor.mosaic, ImportCEOGarage4.ModShop.Floor.paintbrushColor, ImportCEOGarage4.ModShop.Floor.curvesColor,
                    ImportCEOGarage4.ModShop.Floor.marbleBrown, ImportCEOGarage4.ModShop.Floor.marbleBlue, ImportCEOGarage4.ModShop.Floor.marbleBW,
                    ImportCEOGarage4.ModShop.Floor.maze
                }, false, true)
            end
        }
    },

    LoadDefault = function()
        ImportCEOGarage4.Part.Load(ImportCEOGarage4.Part.Garage2)

        ImportCEOGarage4.Style.Set(ImportCEOGarage4.Part.Garage2, ImportCEOGarage4.Style.concrete, false)
        ImportCEOGarage4.Numbering.Set(ImportCEOGarage4.Part.Garage2, ImportCEOGarage4.Numbering.Level1.style1, false)
        ImportCEOGarage4.Lighting.Set(ImportCEOGarage4.Part.Garage2, ImportCEOGarage4.Lighting.style1, true)
        
        ImportCEOGarage4.Part.Load(ImportCEOGarage4.Part.ModShop)
        ImportCEOGarage4.ModShop.Floor.Set(ImportCEOGarage4.ModShop.Floor.default, true)
    end
}


-- Vehicle warehouse
-- Upper: 994.5925, -3002.594, -39.64699
-- Lower: 969.5376, -3000.411, -48.64689

exports('GetImportVehicleWarehouseObject', function()
    return ImportVehicleWarehouse
end)

ImportVehicleWarehouse = {
    Upper = {
        interiorId = 252673,
        Ipl = {
            Interior = {
                ipl = "imp_impexp_interior_placement_interior_1_impexp_intwaremed_milo_",
                Load = function() EnableIpl(ImportVehicleWarehouse.Upper.Ipl.Interior.ipl, true) end,
                Remove = function() EnableIpl(ImportVehicleWarehouse.Upper.Ipl.Interior.ipl, false) end
            },
        },
        Style = {
            basic = "basic_style_set", branded = "branded_style_set", urban = "urban_style_set",
            Set = function(style, refresh)
                ImportVehicleWarehouse.Upper.Style.Clear(false)
                SetIplPropState(ImportVehicleWarehouse.Upper.interiorId, style, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(ImportVehicleWarehouse.Upper.interiorId, {ImportVehicleWarehouse.Upper.Style.basic, ImportVehicleWarehouse.Upper.Style.branded, ImportVehicleWarehouse.Upper.Style.urban}, false, refresh)
            end
        },
        Details = {
            floorHatch = "car_floor_hatch",
            doorBlocker = "door_blocker",       -- Invisible wall
            Enable = function (details, state, refresh)
                SetIplPropState(ImportVehicleWarehouse.Upper.interiorId, details, state, refresh)
            end
        },
    },
    Lower = {
        interiorId = 253185,
        Ipl = {
            Interior = {
                ipl = "imp_impexp_interior_placement_interior_3_impexp_int_02_milo_",
                Load = function() EnableIpl(ImportVehicleWarehouse.Lower.Ipl.Interior.ipl, true) end,
                Remove = function() EnableIpl(ImportVehicleWarehouse.Lower.Ipl.Interior.ipl, false) end
            },
        },
        Details = {
            Pumps = {
                pump1 = "pump_01", pump2 = "pump_02", pump3 = "pump_03", pump4 = "pump_04", pump5 = "pump_05", pump6 = "pump_06", pump7 = "pump_07", pump8 = "pump_08",
            },
            Enable = function (details, state, refresh)
                SetIplPropState(ImportVehicleWarehouse.Lower.interiorId, details, state, refresh)
            end
        },
    },

    LoadDefault = function()
        ImportVehicleWarehouse.Upper.Ipl.Interior.Load()
        ImportVehicleWarehouse.Upper.Style.Set(ImportVehicleWarehouse.Upper.Style.branded)
        ImportVehicleWarehouse.Upper.Details.Enable(ImportVehicleWarehouse.Upper.Details.floorHatch, true)
        ImportVehicleWarehouse.Upper.Details.Enable(ImportVehicleWarehouse.Upper.Details.doorBlocker, false)
        RefreshInterior(ImportVehicleWarehouse.Upper.interiorId)

        ImportVehicleWarehouse.Lower.Ipl.Interior.Load()
        ImportVehicleWarehouse.Lower.Details.Enable(ImportVehicleWarehouse.Lower.Details.Pumps, true)
        RefreshInterior(ImportVehicleWarehouse.Lower.interiorId)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_high_life_Roberto] ---------------------=
    -- ====================================================================

    
-- Apartment 1: -1462.28100000, -539.62760000, 72.44434000

exports('GetHLApartment1Object', function()
    return HLApartment1
end)

HLApartment1 = {
    interiorId = 145921,
    Ipl = {
        Interior = {
            ipl = "mpbusiness_int_placement_interior_v_mp_apt_h_01_milo_",
            Load = function() EnableIpl(HLApartment1.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(HLApartment1.Ipl.Interior.ipl, false) end
        },
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment1.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment1.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment1.interiorId, details, state, refresh)
        end
    }, 
    LoadDefault = function()
        HLApartment1.Ipl.Interior.Load()
        HLApartment1.Strip.Enable({HLApartment1.Strip.A, HLApartment1.Strip.B, HLApartment1.Strip.C}, false)
        HLApartment1.Booze.Enable({HLApartment1.Booze.A, HLApartment1.Booze.B, HLApartment1.Booze.C}, false)
        HLApartment1.Smoke.Enable({HLApartment1.Smoke.A, HLApartment1.Smoke.B, HLApartment1.Smoke.C}, false)
        RefreshInterior(HLApartment1.interiorId)
    end
}


-- Apartment 2: -914.90260000, -374.87310000, 112.6748

exports('GetHLApartment2Object', function()
	return HLApartment2
end)

HLApartment2 = {
    interiorId = 146177,
    Ipl = {
        Interior = {
            ipl = "mpbusiness_int_placement_interior_v_mp_apt_h_01_milo__1",
            Load = function() EnableIpl(HLApartment2.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(HLApartment2.Ipl.Interior.ipl, false) end
        },
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment2.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment2.interiorId, details, state, refresh)
        end
    },  
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment2.interiorId, details, state, refresh)
        end
    }, 
    LoadDefault = function()
        HLApartment2.Ipl.Interior.Load()
        HLApartment2.Strip.Enable({HLApartment2.Strip.A, HLApartment2.Strip.B, HLApartment2.Strip.C}, false)
        HLApartment2.Booze.Enable({HLApartment2.Booze.A, HLApartment2.Booze.B, HLApartment2.Booze.C}, false)
        HLApartment2.Smoke.Enable({HLApartment2.Smoke.A, HLApartment2.Smoke.B, HLApartment2.Smoke.C}, false)
        RefreshInterior(HLApartment2.interiorId)
    end
}


-- Apartment 3: -609.56690000, 51.28212000, 96.60023000

exports('GetHLApartment3Object', function()
	return HLApartment3
end)

HLApartment3 = {
    interiorId = 146689,
    Ipl = {
        Interior = {
            ipl = "mpbusiness_int_placement_interior_v_mp_apt_h_01_milo__2",
            Load = function() EnableIpl(HLApartment3.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(HLApartment3.Ipl.Interior.ipl, false) end
        },
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment3.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment3.interiorId, details, state, refresh)
        end
    },  
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment3.interiorId, details, state, refresh)
        end
    }, 
    LoadDefault = function()
        HLApartment3.Ipl.Interior.Load()
        HLApartment3.Strip.Enable({HLApartment3.Strip.A, HLApartment3.Strip.B, HLApartment3.Strip.C}, false)
        HLApartment3.Booze.Enable({HLApartment3.Booze.A, HLApartment3.Booze.B, HLApartment3.Booze.C}, false)
        HLApartment3.Smoke.Enable({HLApartment3.Smoke.A, HLApartment3.Smoke.B, HLApartment3.Smoke.C}, false)
        RefreshInterior(HLApartment3.interiorId)
    end
}


-- Apartment 4: -778.50610000, 331.31600000, 210.39720

exports('GetHLApartment4Object', function()
    return HLApartment4
end)

HLApartment4 = {
    interiorId = 146945,
    Ipl = {
        Interior = {
            ipl = "mpbusiness_int_placement_interior_v_mp_apt_h_01_milo__3",
            Load = function() EnableIpl(HLApartment4.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(HLApartment4.Ipl.Interior.ipl, false) end
        },
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment4.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment4.interiorId, details, state, refresh)
        end
    },  
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment4.interiorId, details, state, refresh)
        end
    }, 
    LoadDefault = function()
        HLApartment4.Ipl.Interior.Load()
        HLApartment4.Strip.Enable({HLApartment4.Strip.A, HLApartment4.Strip.B, HLApartment4.Strip.C}, false)
        HLApartment4.Booze.Enable({HLApartment4.Booze.A, HLApartment4.Booze.B, HLApartment4.Booze.C}, false)
        HLApartment4.Smoke.Enable({HLApartment4.Smoke.A, HLApartment4.Smoke.B, HLApartment4.Smoke.C}, false)
        RefreshInterior(HLApartment4.interiorId)
    end
}


-- Apartment 5: -22.61353000, -590.14320000, 78.430910

exports('GetHLApartment5Object', function()
    return HLApartment5
end)

HLApartment5 = {
    interiorId = 147201,
    Ipl = {
        Interior = {
            ipl = "mpbusiness_int_placement_interior_v_mp_apt_h_01_milo__4",
            Load = function() EnableIpl(HLApartment5.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(HLApartment5.Ipl.Interior.ipl, false) end
        },
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment5.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment5.interiorId, details, state, refresh)
        end
    },  
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment5.interiorId, details, state, refresh)
        end
    }, 
    LoadDefault = function()
        HLApartment5.Ipl.Interior.Load()
        HLApartment5.Strip.Enable({HLApartment5.Strip.A, HLApartment5.Strip.B, HLApartment5.Strip.C}, false)
        HLApartment5.Booze.Enable({HLApartment5.Booze.A, HLApartment5.Booze.B, HLApartment5.Booze.C}, false)
        HLApartment5.Smoke.Enable({HLApartment5.Smoke.A, HLApartment5.Smoke.B, HLApartment5.Smoke.C}, false)
        RefreshInterior(HLApartment5.interiorId)
    end
}


-- Apartment 6: -609.56690000, 51.28212000, -183.98080

exports('GetHLApartment6Object', function()
    return HLApartment6
end)

HLApartment6 = {
    interiorId = 147457,
    Ipl = {
        Interior = {
            ipl = "mpbusiness_int_placement_interior_v_mp_apt_h_01_milo__5",
            Load = function() EnableIpl(HLApartment6.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(HLApartment6.Ipl.Interior.ipl, false) end
        },
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment6.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment6.interiorId, details, state, refresh)
        end
    },  
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment6.interiorId, details, state, refresh)
        end
    }, 
    LoadDefault = function()
        HLApartment6.Ipl.Interior.Load()
        HLApartment6.Strip.Enable({HLApartment6.Strip.A, HLApartment6.Strip.B, HLApartment6.Strip.C}, false)
        HLApartment6.Booze.Enable({HLApartment6.Booze.A, HLApartment6.Booze.B, HLApartment6.Booze.C}, false)
        HLApartment6.Smoke.Enable({HLApartment6.Smoke.A, HLApartment6.Smoke.B, HLApartment6.Smoke.C}, false)
        RefreshInterior(HLApartment6.interiorId)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_heists_roberto] ---------------------=
    -- ====================================================================

    
-- Heist Carrier: 3082.3117 -4717.1191 15.2622

exports('GetHeistCarrierObject', function()
	return HeistCarrier
end)

HeistCarrier = {
	ipl = {
		"hei_carrier",
		"hei_carrier_int1",
		"hei_carrier_int1_lod",
		"hei_carrier_int2",
		"hei_carrier_int2_lod",
		"hei_carrier_int3",
		"hei_carrier_int3_lod",
		"hei_carrier_int4",
		"hei_carrier_int4_lod",
		"hei_carrier_int5",
		"hei_carrier_int5_lod",
		"hei_carrier_int6",
		"hei_carrier_int6_lod",
		"hei_carrier_lod",
		"hei_carrier_slod"
	},
	Enable = function(state) EnableIpl(HeistCarrier.ipl, state) end
}


-- Heist Yatch: -2043.974,-1031.582, 11.981

exports('GetHeistYachtObject', function()
    return HeistYacht
end)

HeistYacht = {
    ipl = {
        "hei_yacht_heist",
        "hei_yacht_heist_bar",
        "hei_yacht_heist_bar_lod",
        "hei_yacht_heist_bedrm",
        "hei_yacht_heist_bedrm_lod",
        "hei_yacht_heist_bridge",
        "hei_yacht_heist_bridge_lod",
        "hei_yacht_heist_enginrm",
        "hei_yacht_heist_enginrm_lod",
        "hei_yacht_heist_lod",
        "hei_yacht_heist_lounge",
        "hei_yacht_heist_lounge_lod",
        "hei_yacht_heist_slod"
    },
    Enable = function(state) EnableIpl(HeistYacht.ipl, state) end,
    Water = {
        modelHash = GetHashKey("apa_mp_apa_yacht_jacuzzi_ripple1"),

        Enable = function(state)
            local handle = GetClosestObjectOfType(-2023.773, -1038.0, 5.40, 5.0, HeistYacht.Water.modelHash, false, false, false)

            if (state) then
                -- Enable
                if (handle == 0) then
                    RequestModel(HeistYacht.Water.modelHash)
                    while not HasModelLoaded(HeistYacht.Water.modelHash) do
                        Wait(0)
                    end
        
                    local water = CreateObjectNoOffset(HeistYacht.Water.modelHash, -2023.773, -1038.0, 5.40, false, false, false)
                    SetEntityAsMissionEntity(water, false, false)
                end
            else
                -- Disable
                if (handle ~= 0) then
                    SetEntityAsMissionEntity(handle, false, false)
                    DeleteEntity(handle)
                end
            end
        end
    },
    LoadDefault = function()
        HeistYacht.Enable(true)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_gunrunning_roberto] ---------------------=
    -- ====================================================================

    
exports('GetGunrunningBunkerObject', function()
    return GunrunningBunker
end)

GunrunningBunker = {
    interiorId = 258561,
    Ipl = {
        Interior = {
            ipl = "gr_grdlc_interior_placement_interior_1_grdlc_int_02_milo_",
            -- Load interiors IPLs.
            Load = function() EnableIpl(GunrunningBunker.Ipl.Interior.ipl, true) end,

            -- Remove interiors IPLs.
            Remove = function() EnableIpl(GunrunningBunker.Ipl.Interior.ipl, false) end
        },
    
        Exterior = {
            ipl = {
                "gr_case0_bunkerclosed",	-- Desert: 848.6175, 2996.567, 45.81612
                "gr_case1_bunkerclosed",	-- SmokeTree: 2126.785, 3335.04, 48.21422
                "gr_case2_bunkerclosed",	-- Scrapyard: 2493.654, 3140.399, 51.28789
                "gr_case3_bunkerclosed",	-- Oilfields: 481.0465, 2995.135, 43.96672
                "gr_case4_bunkerclosed",	-- RatonCanyon: -391.3216, 4363.728, 58.65862
                "gr_case5_bunkerclosed",	-- Grapeseed: 1823.961, 4708.14, 42.4991
                "gr_case6_bunkerclosed",	-- Farmhouse: 1570.372, 2254.549, 78.89397
                "gr_case7_bunkerclosed",	-- Paletto: -783.0755, 5934.686, 24.31475
                "gr_case9_bunkerclosed",	-- Route68: 24.43542, 2959.705, 58.35517
                "gr_case10_bunkerclosed",	-- Zancudo: -3058.714, 3329.19, 12.5844
                "gr_case11_bunkerclosed"	-- Great Ocean Highway: -3180.466, 1374.192, 19.9597
            },
            -- Load exteriors IPLs.
            Load = function() EnableIpl(GunrunningBunker.Ipl.Exterior.ipl, true) end,

            -- Remove exteriors IPLs.
            Remove = function() EnableIpl(GunrunningBunker.Ipl.Exterior.ipl, false) end
        }
    },

    Style = {
        default = "Bunker_Style_A", blue = "Bunker_Style_B", yellow = "Bunker_Style_C",

        -- Set the style (color) of the bunker.
        -- 	style: Wall color (values: GunrunningBunker.Style.default / GunrunningBunker.Style.blue / GunrunningBunker.Style.yellow)
        -- 	refresh: Reload the whole interior (values: true / false)
        Set = function(style, refresh)
            GunrunningBunker.Style.Clear(false)
            SetIplPropState(GunrunningBunker.interiorId, style, true, refresh)
        end,

        -- Removes the style.
        -- 	refresh: Reload the whole interior (values: true / false)
        Clear = function(refresh) SetIplPropState(GunrunningBunker.interiorId, {GunrunningBunker.Style.default, GunrunningBunker.Style.blue, GunrunningBunker.Style.yellow}, false, refresh) end
    },

    Tier = {
        default = "standard_bunker_set", upgrade = "upgrade_bunker_set",

        -- Set the tier (quality) of the bunker.
        -- 	tier: Upgrade state (values: GunrunningBunker.Tier.default / GunrunningBunker.Tier.upgrade)
        -- 	refresh: Reload the whole interior (values: true / false)
        Set = function(tier, refresh)
            GunrunningBunker.Tier.Clear(false)
            SetIplPropState(GunrunningBunker.interiorId, tier, true, refresh)
        end,

        -- Removes the tier.
        -- 	refresh: Reload the whole interior (values: true / false)
        Clear = function(refresh) SetIplPropState(GunrunningBunker.interiorId, {GunrunningBunker.Tier.default, GunrunningBunker.Tier.upgrade}, false, refresh) end
    },

    Security = {
        noEntryGate = "", default = "standard_security_set", upgrade = "security_upgrade",

        -- Set the security stage of the bunker.
        -- 	security: Upgrade state (values: GunrunningBunker.Security.default / GunrunningBunker.Security.upgrade)
        -- 	refresh: Reload the whole interior (values: true / false)
        Set = function(security, refresh)
            GunrunningBunker.Security.Clear(false)
            if (security ~= "") then
                SetIplPropState(GunrunningBunker.interiorId, security, true, refresh)
            else
                if (refresh) then RefreshInterior(GunrunningBunker.interiorId) end
            end
        end,

        -- Removes the security.
        -- 	refresh: Reload the whole interior (values: true / false)
        Clear = function(refresh) SetIplPropState(GunrunningBunker.interiorId, {GunrunningBunker.Security.default, GunrunningBunker.Security.upgrade}, false, refresh) end
    },

    Details = {
        office = "Office_Upgrade_set",				-- Office interior
        officeLocked = "Office_blocker_set",		-- Metal door blocking access to the office
        locker = "gun_locker_upgrade",				-- Locker next to the office door
        rangeLights = "gun_range_lights",			-- Lights next to the shooting range
        rangeWall = "gun_wall_blocker",				-- Wall blocking access to the shooting range
        rangeLocked = "gun_range_blocker_set",		-- Metal door blocking access to the shooting range
        schematics = "Gun_schematic_set",			-- Gun schematic on the table and whiteboard

        -- Enable or disable a detail.
        -- 	details: Prop to enable or disable (values: GunrunningBunker.Details.office / GunrunningBunker.Details.officeLocked / GunrunningBunker.Details.locker...)
        --  state: Enable or Disable (values: true / false)
        -- 	refresh: Reload the whole interior (values: true / false)
        Enable = function (details, state, refresh)
            SetIplPropState(GunrunningBunker.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        GunrunningBunker.Ipl.Interior.Load()
        GunrunningBunker.Ipl.Exterior.Load()

        GunrunningBunker.Style.Set(GunrunningBunker.Style.default)
        GunrunningBunker.Tier.Set(GunrunningBunker.Tier.default)
        GunrunningBunker.Security.Set(GunrunningBunker.Security.default)
    
        GunrunningBunker.Details.Enable(GunrunningBunker.Details.office, true)
        GunrunningBunker.Details.Enable(GunrunningBunker.Details.officeLocked, false)
        GunrunningBunker.Details.Enable(GunrunningBunker.Details.locker, true)
        GunrunningBunker.Details.Enable(GunrunningBunker.Details.rangeLights, true)
        GunrunningBunker.Details.Enable(GunrunningBunker.Details.rangeWall, false)
        GunrunningBunker.Details.Enable(GunrunningBunker.Details.rangeLocked, false)
        GunrunningBunker.Details.Enable(GunrunningBunker.Details.schematics, false)

        -- Must be called in order to spawn or remove the props
        RefreshInterior(GunrunningBunker.interiorId)
    end

}


-- Gunrunning Yacht: -1363.724, 6734.108, 2.44598

exports('GetGunrunningYachtObject', function()
    return GunrunningYacht
end)

GunrunningYacht = {
    ipl = {
        "gr_heist_yacht2",
        "gr_heist_yacht2_bar",
        "gr_heist_yacht2_bar_lod",
        "gr_heist_yacht2_bedrm",
        "gr_heist_yacht2_bedrm_lod",
        "gr_heist_yacht2_bridge",
        "gr_heist_yacht2_bridge_lod",
        "gr_heist_yacht2_enginrm",
        "gr_heist_yacht2_enginrm_lod",
        "gr_heist_yacht2_lod",
        "gr_heist_yacht2_lounge",
        "gr_heist_yacht2_lounge_lod",
        "gr_heist_yacht2_slod",
    },
    Enable = function(state) EnableIpl(GunrunningYacht.ipl, state) end,
    Water = {
        modelHash = GetHashKey("apa_mp_apa_yacht_jacuzzi_ripple1"),

        Enable = function(state)
            local handle = GetClosestObjectOfType(-1369.0, 6736.0, 5.40, 5.0, GunrunningYacht.Water.modelHash, false, false, false)

            if (state) then
                -- Enable
                if (handle == 0) then
                    RequestModel(GunrunningYacht.Water.modelHash)
                    while not HasModelLoaded(GunrunningYacht.Water.modelHash) do
                        Wait(0)
                    end

                    local water = CreateObjectNoOffset(GunrunningYacht.Water.modelHash, -1369.0, 6736.0, 5.40, false, false, false)
                    SetEntityAsMissionEntity(water, false, false)
                end
            else
                -- Disable
                if (handle ~= 0) then
                    SetEntityAsMissionEntity(handle, false, false)
                    DeleteEntity(handle)
                end
            end
        end
    },
    LoadDefault = function()
        GunrunningYacht.Enable(true)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_finance_roberto] ---------------------=
    -- ====================================================================

    
-- Office 1: -141.1987, -620.913, 168.8205 (Arcadius Business Centre)

exports('GetFinanceOffice1Object', function()
    return FinanceOffice1
end)

FinanceOffice1 = {
    currentInteriorId = -1,
    currentSafeDoors = {hashL = "", hashR = ""},
    
    Style = {
        Theme = {
            warm = {interiorId = 236289, ipl = "ex_dt1_02_office_01a", safe = "ex_prop_safedoor_office1a"},
            classical = {interiorId = 236545, ipl = "ex_dt1_02_office_01b", safe = "ex_prop_safedoor_office1b"},
            vintage = {interiorId = 236801, ipl = "ex_dt1_02_office_01c", safe = "ex_prop_safedoor_office1c"},
            contrast = {interiorId = 237057, ipl = "ex_dt1_02_office_02a", safe = "ex_prop_safedoor_office2a"},
            rich = {interiorId = 237313, ipl = "ex_dt1_02_office_02b", safe = "ex_prop_safedoor_office2a"},
            cool = {interiorId = 237569, ipl = "ex_dt1_02_office_02c", safe = "ex_prop_safedoor_office2a"},
            ice = {interiorId = 237825, ipl = "ex_dt1_02_office_03a", safe = "ex_prop_safedoor_office3a"},
            conservative = {interiorId = 238081, ipl = "ex_dt1_02_office_03b", safe = "ex_prop_safedoor_office3a"},
            polished = {interiorId = 238337, ipl = "ex_dt1_02_office_03c", safe = "ex_prop_safedoor_office3c"}
        },
        Set = function(style, refresh)
            if (refresh == nil) then refresh = false end
            if (IsTable(style)) then
                FinanceOffice1.Style.Clear()
                FinanceOffice1.currentInteriorId = style.interiorId
                FinanceOffice1.currentSafeDoors = {hashL = GetHashKey(style.safe .. "_l"), hashR = GetHashKey(style.safe .. "_r")}
                EnableIpl(style.ipl, true)
                if (refresh) then RefreshInterior(style.interiorId) end
            end
        end,
        Clear = function()
            for themeKey, themeValue in pairs(FinanceOffice1.Style.Theme) do
                for swagKey, swagValue in pairs(FinanceOffice1.Swag) do
                    if (IsTable(swagValue)) then
                        SetIplPropState(themeValue.interiorId, {swagValue.A, swagValue.B, swagValue.C}, false)
                    end
                end
                SetIplPropState(themeValue.interiorId, "office_chairs", false, false)
                SetIplPropState(themeValue.interiorId, "office_booze", false, true)
                FinanceOffice1.currentSafeDoors = {hashL = 0, hashR = 0}
                EnableIpl(themeValue.ipl, false)
            end
        end
    },
    Safe = {
        doorHeadingL = 96.0, -- Only need the heading of the Left door to get the Right ones
        Position = {x = -124.25, y = -641.30, z = 168.870}, -- Approximately between the two doors

        -- These values are checked from "doorHandler.lua" and
        isLeftDoorOpen = false, isRightDoorOpen = false,

        -- Safe door API
        Open = function(doorSide)
            if (doorSide:lower() == "left") then FinanceOffice1.Safe.isLeftDoorOpen = true
            elseif (doorSide:lower() == "right") then FinanceOffice1.Safe.isRightDoorOpen = true
            else
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " is not a correct value. Valid values are:")
                Citizen.Trace("left right")
            end
        end,
        Close = function(doorSide)
            if (doorSide:lower() == "left") then FinanceOffice1.Safe.isLeftDoorOpen = false
            elseif (doorSide:lower() == "right") then FinanceOffice1.Safe.isRightDoorOpen = false
            else
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " is not a correct value. Valid values are:")
                Citizen.Trace("left right")
            end
        end,

        -- Internal use only
        SetDoorState = function(doorSide, open)
            local doorHandle = 0
            local heading = FinanceOffice1.Safe.doorHeadingL

            if (doorSide:lower() == "left") then
                doorHandle = FinanceOffice1.Safe.GetDoorHandle(FinanceOffice1.currentSafeDoors.hashL)
                if (open) then heading = heading - 90.0 end
            elseif (doorSide:lower() == "right") then
                doorHandle = FinanceOffice1.Safe.GetDoorHandle(FinanceOffice1.currentSafeDoors.hashR)
                heading = heading - 180
                if (open) then heading = heading + 90.0 end
            end

            if (doorHandle == 0) then
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " safe door handle is 0")
                return
            end

            SetEntityHeading(doorHandle, heading)
        end,

        -- /!\ handle changes whenever the interior is refreshed /!\
        GetDoorHandle = function(doorHash)
            local timeout = 4
            local doorHandle = GetClosestObjectOfType(FinanceOffice1.Safe.Position.x, FinanceOffice1.Safe.Position.y, FinanceOffice1.Safe.Position.z, 5.0, doorHash, false, false, false)

            while (doorHandle == 0) do
                Wait(25)
                doorHandle = GetClosestObjectOfType(FinanceOffice1.Safe.Position.x, FinanceOffice1.Safe.Position.y, FinanceOffice1.Safe.Position.z, 5.0, doorHash, false, false, false)
                timeout = timeout - 1
                if (timeout <= 0) then
                    break
                end
            end
            return doorHandle
        end
    },
    Swag = {
        Cash = {
            A = "cash_set_01", B = "cash_set_02", C = "cash_set_03", D = "cash_set_04", E = "cash_set_05",
            F = "cash_set_06", G = "cash_set_07", H = "cash_set_08", I = "cash_set_09", J = "cash_set_10",
            K = "cash_set_11", L = "cash_set_12", M = "cash_set_13", N = "cash_set_14", O = "cash_set_15",
            P = "cash_set_16", Q = "cash_set_17", R = "cash_set_18", S = "cash_set_19", T = "cash_set_20",
            U = "cash_set_21", V = "cash_set_22", W = "cash_set_23", X = "cash_set_24"
        },
        BoozeCigs = {A = "swag_booze_cigs", B = "swag_booze_cigs2", C = "swag_booze_cigs3"},
        Counterfeit = {A = "swag_counterfeit", B = "swag_counterfeit2", C = "swag_counterfeit3"},
        DrugBags = {A = "swag_drugbags", B = "swag_drugbags2", C = "swag_drugbags3"},
        DrugStatue = {A = "swag_drugstatue", B = "swag_drugstatue2", C = "swag_drugstatue3"},
        Electronic = {A = "swag_electronic", B = "swag_electronic2", C = "swag_electronic3"},
        FurCoats = {A = "swag_furcoats", B = "swag_furcoats2", C = "swag_furcoats3"},
        Gems = {A = "swag_gems", B = "swag_gems2", C = "swag_gems3"},
        Guns = {A = "swag_guns", B = "swag_guns2", C = "swag_guns3"},
        Ivory = {A = "swag_ivory", B = "swag_ivory2", C = "swag_ivory3"},
        Jewel = {A = "swag_jewelwatch", B = "swag_jewelwatch2", C = "swag_jewelwatch3"},
        Med = {A = "swag_med", B = "swag_med2", C = "swag_med3"},
        Painting = {A = "swag_art", B = "swag_art2", C = "swag_art3"},
        Pills = {A = "swag_pills", B = "swag_pills2", C = "swag_pills3"},
        Silver = {A = "swag_silver", B = "swag_silver2", C = "swag_silver3"},
        Enable = function (details, state, refresh)
            SetIplPropState(FinanceOffice1.currentInteriorId, details, state, refresh)
        end
    },
    Chairs = {
        off = "", on = "office_chairs",
        Set = function(chairs, refresh)
            FinanceOffice1.Chairs.Clear(false)
            if (chairs ~= nil) then
                SetIplPropState(FinanceOffice1.currentInteriorId, chairs, true, refresh)
            else
                if (refresh) then RefreshInterior(FinanceOffice1.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(FinanceOffice1.currentInteriorId, FinanceOffice1.Chairs.on, false, refresh)
        end
    },
    Booze = {
        off = "", on = "office_booze",
        Set = function(booze, refresh)
            FinanceOffice1.Booze.Clear(false)
            if (booze ~= nil) then
                SetIplPropState(FinanceOffice1.currentInteriorId, booze, true, refresh)
            else
                if (refresh) then RefreshInterior(FinanceOffice1.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(FinanceOffice1.currentInteriorId, FinanceOffice1.Booze.on, false, refresh)
        end
    },

    LoadDefault = function()
        FinanceOffice1.Style.Set(FinanceOffice1.Style.Theme.polished)
        FinanceOffice1.Chairs.Set(FinanceOffice1.Chairs.on, true)
    end
}


-- Office 2: -75.8466, -826.9893, 243.3859 (Maze Bank Building)

exports('GetFinanceOffice2Object', function()
	return FinanceOffice2
end)

FinanceOffice2 = {
    currentInteriorId = -1,
    currentSafeDoors = {hashL = "", hashR = ""},
    
    Style = {
        Theme = {
            warm = {interiorId = 238593, ipl = "ex_dt1_11_office_01a", safe = "ex_prop_safedoor_office1a"},
            classical = {interiorId = 238849, ipl = "ex_dt1_11_office_01b", safe = "ex_prop_safedoor_office1b"},
            vintage = {interiorId = 239105, ipl = "ex_dt1_11_office_01c", safe = "ex_prop_safedoor_office1c"},
            contrast = {interiorId = 239361, ipl = "ex_dt1_11_office_02a", safe = "ex_prop_safedoor_office2a"},
            rich = {interiorId = 239617, ipl = "ex_dt1_11_office_02b", safe = "ex_prop_safedoor_office2a"},
            cool = {interiorId = 239873, ipl = "ex_dt1_11_office_02c", safe = "ex_prop_safedoor_office2a"},
            ice = {interiorId = 240129, ipl = "ex_dt1_11_office_03a", safe = "ex_prop_safedoor_office3a"},
            conservative = {interiorId = 240385, ipl = "ex_dt1_11_office_03b", safe = "ex_prop_safedoor_office3a"},
            polished = {interiorId = 240641, ipl = "ex_dt1_11_office_03c", safe = "ex_prop_safedoor_office3c"}
        },
        Set = function(style, refresh)
            if (refresh == nil) then refresh = false end
            if (IsTable(style)) then
                FinanceOffice2.Style.Clear()
                FinanceOffice2.currentInteriorId = style.interiorId
                FinanceOffice2.currentSafeDoors = {hashL = GetHashKey(style.safe .. "_l"), hashR = GetHashKey(style.safe .. "_r")}
                EnableIpl(style.ipl, true)
                if (refresh) then RefreshInterior(style.interiorId) end
            end
        end,
        Clear = function()
            for themeKey, themeValue in pairs(FinanceOffice2.Style.Theme) do
                for swagKey, swagValue in pairs(FinanceOffice2.Swag) do
                    if (IsTable(swagValue)) then
                        SetIplPropState(themeValue.interiorId, {swagValue.A, swagValue.B, swagValue.C}, false)
                    end
                end
                SetIplPropState(themeValue.interiorId, "office_chairs", false, false)
                SetIplPropState(themeValue.interiorId, "office_booze", false, true)
                FinanceOffice2.currentSafeDoors = {hashL = 0, hashR = 0}
                EnableIpl(themeValue.ipl, false)
            end
        end
    },
    Safe = {
        doorHeadingL = 250.0, -- Only need the heading of the Left door to get the Right ones
        Position = {x = -82.593, y = -801.0, z = 243.385}, -- Approximately between the two doors

        -- These values are checked from "doorHandler.lua" and
        isLeftDoorOpen = false, isRightDoorOpen = false,

        -- Safe door API
        Open = function(doorSide)
            if (doorSide:lower() == "left") then FinanceOffice2.Safe.isLeftDoorOpen = true
            elseif (doorSide:lower() == "right") then FinanceOffice2.Safe.isRightDoorOpen = true
            else
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " is not a correct value. Valid values are:")
                Citizen.Trace("left right")
            end
        end,
        Close = function(doorSide)
            if (doorSide:lower() == "left") then FinanceOffice2.Safe.isLeftDoorOpen = false
            elseif (doorSide:lower() == "right") then FinanceOffice2.Safe.isRightDoorOpen = false
            else
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " is not a correct value. Valid values are:")
                Citizen.Trace("left right")
            end
        end,

        -- Internal use only
        SetDoorState = function(doorSide, open)
            local doorHandle = 0
            local heading = FinanceOffice2.Safe.doorHeadingL

            if (doorSide:lower() == "left") then
                doorHandle = FinanceOffice2.Safe.GetDoorHandle(FinanceOffice2.currentSafeDoors.hashL)
                if (open) then heading = heading - 90.0 end
            elseif (doorSide:lower() == "right") then
                doorHandle = FinanceOffice2.Safe.GetDoorHandle(FinanceOffice2.currentSafeDoors.hashR)
                heading = heading - 180
                if (open) then heading = heading + 90.0 end
            end

            if (doorHandle == 0) then
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " safe door handle is 0")
                return
            end

            SetEntityHeading(doorHandle, heading)
        end,

        -- /!\ handle changes whenever the interior is refreshed /!\
        GetDoorHandle = function(doorHash)
            local timeout = 4
            local doorHandle = GetClosestObjectOfType(FinanceOffice2.Safe.Position.x, FinanceOffice2.Safe.Position.y, FinanceOffice2.Safe.Position.z, 5.0, doorHash, false, false, false)

            while (doorHandle == 0) do
                Wait(25)
                doorHandle = GetClosestObjectOfType(FinanceOffice2.Safe.Position.x, FinanceOffice2.Safe.Position.y, FinanceOffice2.Safe.Position.z, 5.0, doorHash, false, false, false)
                timeout = timeout - 1
                if (timeout <= 0) then
                    break
                end
            end
            return doorHandle
        end
    },
    Swag = {
        Cash = {
            A = "cash_set_01", B = "cash_set_02", C = "cash_set_03", D = "cash_set_04", E = "cash_set_05",
            F = "cash_set_06", G = "cash_set_07", H = "cash_set_08", I = "cash_set_09", J = "cash_set_10",
            K = "cash_set_11", L = "cash_set_12", M = "cash_set_13", N = "cash_set_14", O = "cash_set_15",
            P = "cash_set_16", Q = "cash_set_17", R = "cash_set_18", S = "cash_set_19", T = "cash_set_20",
            U = "cash_set_21", V = "cash_set_22", W = "cash_set_23", X = "cash_set_24"
        },
        BoozeCigs = {A = "swag_booze_cigs", B = "swag_booze_cigs2", C = "swag_booze_cigs3"},
        Counterfeit = {A = "swag_counterfeit", B = "swag_counterfeit2", C = "swag_counterfeit3"},
        DrugBags = {A = "swag_drugbags", B = "swag_drugbags2", C = "swag_drugbags3"},
        DrugStatue = {A = "swag_drugstatue", B = "swag_drugstatue2", C = "swag_drugstatue3"},
        Electronic = {A = "swag_electronic", B = "swag_electronic2", C = "swag_electronic3"},
        FurCoats = {A = "swag_furcoats", B = "swag_furcoats2", C = "swag_furcoats3"},
        Gems = {A = "swag_gems", B = "swag_gems2", C = "swag_gems3"},
        Guns = {A = "swag_guns", B = "swag_guns2", C = "swag_guns3"},
        Ivory = {A = "swag_ivory", B = "swag_ivory2", C = "swag_ivory3"},
        Jewel = {A = "swag_jewelwatch", B = "swag_jewelwatch2", C = "swag_jewelwatch3"},
        Med = {A = "swag_med", B = "swag_med2", C = "swag_med3"},
        Painting = {A = "swag_art", B = "swag_art2", C = "swag_art3"},
        Pills = {A = "swag_pills", B = "swag_pills2", C = "swag_pills3"},
        Silver = {A = "swag_silver", B = "swag_silver2", C = "swag_silver3"},
        Enable = function (details, state, refresh)
            SetIplPropState(FinanceOffice2.currentInteriorId, details, state, refresh)
        end
    },
    Chairs = {
        off = "", on = "office_chairs",
        Set = function(chairs, refresh)
            FinanceOffice2.Chairs.Clear(false)
            if (chairs ~= nil) then
                SetIplPropState(FinanceOffice2.currentInteriorId, chairs, true, refresh)
            else
                if (refresh) then RefreshInterior(FinanceOffice2.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(FinanceOffice2.currentInteriorId, FinanceOffice2.Chairs.on, false, refresh)
        end
    },
    Booze = {
        off = "", on = "office_booze",
        Set = function(booze, refresh)
            FinanceOffice2.Booze.Clear(false)
            if (booze ~= nil) then
                SetIplPropState(FinanceOffice2.currentInteriorId, booze, true, refresh)
            else
                if (refresh) then RefreshInterior(FinanceOffice2.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(FinanceOffice2.currentInteriorId, FinanceOffice2.Booze.on, false, refresh)
        end
    },

    LoadDefault = function()
        FinanceOffice2.Style.Set(FinanceOffice2.Style.Theme.warm)
        FinanceOffice2.Chairs.Set(FinanceOffice2.Chairs.on, true)
    end
}


-- Office 3: -1579.756, -565.0661, 108.523 (Lom Bank)

exports('GetFinanceOffice3Object', function()
	return FinanceOffice3
end)

FinanceOffice3 = {
    currentInteriorId = -1,
    currentSafeDoors = {hashL = "", hashR = ""},
    
    Style = {
        Theme = {
            warm = {interiorId = 240897, ipl = "ex_sm_13_office_01a", safe = "ex_prop_safedoor_office1a"},
            classical = {interiorId = 241153, ipl = "ex_sm_13_office_01b", safe = "ex_prop_safedoor_office1b"},
            vintage = {interiorId = 241409, ipl = "ex_sm_13_office_01c", safe = "ex_prop_safedoor_office1c"},
            contrast = {interiorId = 241665, ipl = "ex_sm_13_office_02a", safe = "ex_prop_safedoor_office2a"},
            rich = {interiorId = 241921, ipl = "ex_sm_13_office_02b", safe = "ex_prop_safedoor_office2a"},
            cool = {interiorId = 242177, ipl = "ex_sm_13_office_02c", safe = "ex_prop_safedoor_office2a"},
            ice = {interiorId = 242433, ipl = "ex_sm_13_office_03a", safe = "ex_prop_safedoor_office3a"},
            conservative = {interiorId = 242689, ipl = "ex_sm_13_office_03b", safe = "ex_prop_safedoor_office3a"},
            polished = {interiorId = 242945, ipl = "ex_sm_13_office_03c", safe = "ex_prop_safedoor_office3c"}
        },
        Set = function(style, refresh)
            if (refresh == nil) then refresh = false end
            if (IsTable(style)) then
                FinanceOffice3.Style.Clear()
                FinanceOffice3.currentInteriorId = style.interiorId
                FinanceOffice3.currentSafeDoors = {hashL = GetHashKey(style.safe .. "_l"), hashR = GetHashKey(style.safe .. "_r")}
                EnableIpl(style.ipl, true)
                if (refresh) then RefreshInterior(style.interiorId) end
            end
        end,
        Clear = function()
            for themeKey, themeValue in pairs(FinanceOffice3.Style.Theme) do
                for swagKey, swagValue in pairs(FinanceOffice3.Swag) do
                    if (IsTable(swagValue)) then
                        SetIplPropState(themeValue.interiorId, {swagValue.A, swagValue.B, swagValue.C}, false)
                    end
                end
                SetIplPropState(themeValue.interiorId, "office_chairs", false, false)
                SetIplPropState(themeValue.interiorId, "office_booze", false, true)
                FinanceOffice3.currentSafeDoors = {hashL = 0, hashR = 0}
                EnableIpl(themeValue.ipl, false)
            end
        end
    },
    Safe = {
        doorHeadingL = 126.0, -- Only need the heading of the Left door to get the Right ones
        Position = {x = -1554.08, y = -573.7122, z = 108.5272}, -- Approximately between the two doors

        -- These values are checked from "doorHandler.lua" and
        isLeftDoorOpen = false, isRightDoorOpen = false,

        -- Safe door API
        Open = function(doorSide)
            if (doorSide:lower() == "left") then FinanceOffice3.Safe.isLeftDoorOpen = true
            elseif (doorSide:lower() == "right") then FinanceOffice3.Safe.isRightDoorOpen = true
            else
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " is not a correct value. Valid values are:")
                Citizen.Trace("left right")
            end
        end,
        Close = function(doorSide)
            if (doorSide:lower() == "left") then FinanceOffice3.Safe.isLeftDoorOpen = false
            elseif (doorSide:lower() == "right") then FinanceOffice3.Safe.isRightDoorOpen = false
            else
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " is not a correct value. Valid values are:")
                Citizen.Trace("left right")
            end
        end,

        -- Internal use only
        SetDoorState = function(doorSide, open)
            local doorHandle = 0
            local heading = FinanceOffice3.Safe.doorHeadingL

            if (doorSide:lower() == "left") then
                doorHandle = FinanceOffice3.Safe.GetDoorHandle(FinanceOffice3.currentSafeDoors.hashL)
                if (open) then heading = heading - 90.0 end
            elseif (doorSide:lower() == "right") then
                doorHandle = FinanceOffice3.Safe.GetDoorHandle(FinanceOffice3.currentSafeDoors.hashR)
                heading = heading - 180
                if (open) then heading = heading + 90.0 end
            end

            if (doorHandle == 0) then
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " safe door handle is 0")
                return
            end

            SetEntityHeading(doorHandle, heading)
        end,

        -- /!\ handle changes whenever the interior is refreshed /!\
        GetDoorHandle = function(doorHash)
            local timeout = 4
            local doorHandle = GetClosestObjectOfType(FinanceOffice3.Safe.Position.x, FinanceOffice3.Safe.Position.y, FinanceOffice3.Safe.Position.z, 5.0, doorHash, false, false, false)

            while (doorHandle == 0) do
                Wait(25)
                doorHandle = GetClosestObjectOfType(FinanceOffice3.Safe.Position.x, FinanceOffice3.Safe.Position.y, FinanceOffice3.Safe.Position.z, 5.0, doorHash, false, false, false)
                timeout = timeout - 1
                if (timeout <= 0) then
                    break
                end
            end
            return doorHandle
        end
    },
    Swag = {
        Cash = {
            A = "cash_set_01", B = "cash_set_02", C = "cash_set_03", D = "cash_set_04", E = "cash_set_05",
            F = "cash_set_06", G = "cash_set_07", H = "cash_set_08", I = "cash_set_09", J = "cash_set_10",
            K = "cash_set_11", L = "cash_set_12", M = "cash_set_13", N = "cash_set_14", O = "cash_set_15",
            P = "cash_set_16", Q = "cash_set_17", R = "cash_set_18", S = "cash_set_19", T = "cash_set_20",
            U = "cash_set_21", V = "cash_set_22", W = "cash_set_23", X = "cash_set_24"
        },
        BoozeCigs = {A = "swag_booze_cigs", B = "swag_booze_cigs2", C = "swag_booze_cigs3"},
        Counterfeit = {A = "swag_counterfeit", B = "swag_counterfeit2", C = "swag_counterfeit3"},
        DrugBags = {A = "swag_drugbags", B = "swag_drugbags2", C = "swag_drugbags3"},
        DrugStatue = {A = "swag_drugstatue", B = "swag_drugstatue2", C = "swag_drugstatue3"},
        Electronic = {A = "swag_electronic", B = "swag_electronic2", C = "swag_electronic3"},
        FurCoats = {A = "swag_furcoats", B = "swag_furcoats2", C = "swag_furcoats3"},
        Gems = {A = "swag_gems", B = "swag_gems2", C = "swag_gems3"},
        Guns = {A = "swag_guns", B = "swag_guns2", C = "swag_guns3"},
        Ivory = {A = "swag_ivory", B = "swag_ivory2", C = "swag_ivory3"},
        Jewel = {A = "swag_jewelwatch", B = "swag_jewelwatch2", C = "swag_jewelwatch3"},
        Med = {A = "swag_med", B = "swag_med2", C = "swag_med3"},
        Painting = {A = "swag_art", B = "swag_art2", C = "swag_art3"},
        Pills = {A = "swag_pills", B = "swag_pills2", C = "swag_pills3"},
        Silver = {A = "swag_silver", B = "swag_silver2", C = "swag_silver3"},
        Enable = function (details, state, refresh)
            SetIplPropState(FinanceOffice3.currentInteriorId, details, state, refresh)
        end
    },
    Chairs = {
        off = "", on = "office_chairs",
        Set = function(chairs, refresh)
            FinanceOffice3.Chairs.Clear(false)
            if (chairs ~= nil) then
                SetIplPropState(FinanceOffice3.currentInteriorId, chairs, true, refresh)
            else
                if (refresh) then RefreshInterior(FinanceOffice3.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(FinanceOffice3.currentInteriorId, FinanceOffice3.Chairs.on, false, refresh)
        end
    },
    Booze = {
        off = "", on = "office_booze",
        Set = function(booze, refresh)
            FinanceOffice3.Booze.Clear(false)
            if (booze ~= nil) then
                SetIplPropState(FinanceOffice3.currentInteriorId, booze, true, refresh)
            else
                if (refresh) then RefreshInterior(FinanceOffice3.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(FinanceOffice3.currentInteriorId, FinanceOffice3.Booze.on, false, refresh)
        end
    },

    LoadDefault = function()
        FinanceOffice3.Style.Set(FinanceOffice3.Style.Theme.conservative)
        FinanceOffice3.Chairs.Set(FinanceOffice3.Chairs.on, true)
    end
}


-- Office 4: -1392.667, -480.4736, 72.04217 (Maze Bank West)

exports('GetFinanceOffice4Object', function()
	return FinanceOffice4
end)

FinanceOffice4 = {
    currentInteriorId = -1,
    currentSafeDoors = {hashL = "", hashR = ""},
    
    Style = {
        Theme = {
            warm = {interiorId = 243201, ipl = "ex_sm_15_office_01a", safe = "ex_prop_safedoor_office1a"},
            classical = {interiorId = 243457, ipl = "ex_sm_15_office_01b", safe = "ex_prop_safedoor_office1b"},
            vintage = {interiorId = 243713, ipl = "ex_sm_15_office_01c", safe = "ex_prop_safedoor_office1c"},
            contrast = {interiorId = 243969, ipl = "ex_sm_15_office_02a", safe = "ex_prop_safedoor_office2a"},
            rich = {interiorId = 244225, ipl = "ex_sm_15_office_02b", safe = "ex_prop_safedoor_office2a"},
            cool = {interiorId = 244481, ipl = "ex_sm_15_office_02c", safe = "ex_prop_safedoor_office2a"},
            ice = {interiorId = 244737, ipl = "ex_sm_15_office_03a", safe = "ex_prop_safedoor_office3a"},
            conservative = {interiorId = 244993, ipl = "ex_sm_15_office_03b", safe = "ex_prop_safedoor_office3a"},
            polished = {interiorId = 245249, ipl = "ex_sm_15_office_03c", safe = "ex_prop_safedoor_office3c"}
        },
        Set = function(style, refresh)
            if (refresh == nil) then refresh = false end
            if (IsTable(style)) then
                FinanceOffice4.Style.Clear()
                FinanceOffice4.currentInteriorId = style.interiorId
                FinanceOffice4.currentSafeDoors = {hashL = GetHashKey(style.safe .. "_l"), hashR = GetHashKey(style.safe .. "_r")}
                EnableIpl(style.ipl, true)
                if (refresh) then RefreshInterior(style.interiorId) end
            end
        end,
        Clear = function()
            for themeKey, themeValue in pairs(FinanceOffice4.Style.Theme) do
                for swagKey, swagValue in pairs(FinanceOffice4.Swag) do
                    if (IsTable(swagValue)) then
                        SetIplPropState(themeValue.interiorId, {swagValue.A, swagValue.B, swagValue.C}, false)
                    end
                end
                SetIplPropState(themeValue.interiorId, "office_chairs", false, false)
                SetIplPropState(themeValue.interiorId, "office_booze", false, true)
                FinanceOffice4.currentSafeDoors = {hashL = 0, hashR = 0}
                EnableIpl(themeValue.ipl, false)
            end
        end
    },
    Safe = {
        doorHeadingL = 188.0, -- Only need the heading of the Left door to get the Right ones
        Position = {x = -1372.905, y = -462.08, z = 72.05}, -- Approximately between the two doors

        -- These values are checked from "doorHandler.lua" and
        isLeftDoorOpen = false, isRightDoorOpen = false,

        -- Safe door API
        Open = function(doorSide)
            if (doorSide:lower() == "left") then FinanceOffice4.Safe.isLeftDoorOpen = true
            elseif (doorSide:lower() == "right") then FinanceOffice4.Safe.isRightDoorOpen = true
            else
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " is not a correct value. Valid values are:")
                Citizen.Trace("left right")
            end
        end,
        Close = function(doorSide)
            if (doorSide:lower() == "left") then FinanceOffice4.Safe.isLeftDoorOpen = false
            elseif (doorSide:lower() == "right") then FinanceOffice4.Safe.isRightDoorOpen = false
            else
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " is not a correct value. Valid values are:")
                Citizen.Trace("left right")
            end
        end,

        -- Internal use only
        SetDoorState = function(doorSide, open)
            local doorHandle = 0
            local heading = FinanceOffice4.Safe.doorHeadingL

            if (doorSide:lower() == "left") then
                doorHandle = FinanceOffice4.Safe.GetDoorHandle(FinanceOffice4.currentSafeDoors.hashL)
                if (open) then heading = heading - 90.0 end
            elseif (doorSide:lower() == "right") then
                doorHandle = FinanceOffice4.Safe.GetDoorHandle(FinanceOffice4.currentSafeDoors.hashR)
                heading = heading - 180
                if (open) then heading = heading + 90.0 end
            end

            if (doorHandle == 0) then
                Citizen.Trace("[bob74_ipl] Warning: " .. doorSide .. " safe door handle is 0")
                return
            end

            SetEntityHeading(doorHandle, heading)
        end,

        -- /!\ handle changes whenever the interior is refreshed /!\
        GetDoorHandle = function(doorHash)
            local timeout = 4
            local doorHandle = GetClosestObjectOfType(FinanceOffice4.Safe.Position.x, FinanceOffice4.Safe.Position.y, FinanceOffice4.Safe.Position.z, 5.0, doorHash, false, false, false)

            while (doorHandle == 0) do
                Wait(25)
                doorHandle = GetClosestObjectOfType(FinanceOffice4.Safe.Position.x, FinanceOffice4.Safe.Position.y, FinanceOffice4.Safe.Position.z, 5.0, doorHash, false, false, false)
                timeout = timeout - 1
                if (timeout <= 0) then
                    break
                end
            end
            return doorHandle
        end
    },
    Swag = {
        Cash = {
            A = "cash_set_01", B = "cash_set_02", C = "cash_set_03", D = "cash_set_04", E = "cash_set_05",
            F = "cash_set_06", G = "cash_set_07", H = "cash_set_08", I = "cash_set_09", J = "cash_set_10",
            K = "cash_set_11", L = "cash_set_12", M = "cash_set_13", N = "cash_set_14", O = "cash_set_15",
            P = "cash_set_16", Q = "cash_set_17", R = "cash_set_18", S = "cash_set_19", T = "cash_set_20",
            U = "cash_set_21", V = "cash_set_22", W = "cash_set_23", X = "cash_set_24"
        },
        BoozeCigs = {A = "swag_booze_cigs", B = "swag_booze_cigs2", C = "swag_booze_cigs3"},
        Counterfeit = {A = "swag_counterfeit", B = "swag_counterfeit2", C = "swag_counterfeit3"},
        DrugBags = {A = "swag_drugbags", B = "swag_drugbags2", C = "swag_drugbags3"},
        DrugStatue = {A = "swag_drugstatue", B = "swag_drugstatue2", C = "swag_drugstatue3"},
        Electronic = {A = "swag_electronic", B = "swag_electronic2", C = "swag_electronic3"},
        FurCoats = {A = "swag_furcoats", B = "swag_furcoats2", C = "swag_furcoats3"},
        Gems = {A = "swag_gems", B = "swag_gems2", C = "swag_gems3"},
        Guns = {A = "swag_guns", B = "swag_guns2", C = "swag_guns3"},
        Ivory = {A = "swag_ivory", B = "swag_ivory2", C = "swag_ivory3"},
        Jewel = {A = "swag_jewelwatch", B = "swag_jewelwatch2", C = "swag_jewelwatch3"},
        Med = {A = "swag_med", B = "swag_med2", C = "swag_med3"},
        Painting = {A = "swag_art", B = "swag_art2", C = "swag_art3"},
        Pills = {A = "swag_pills", B = "swag_pills2", C = "swag_pills3"},
        Silver = {A = "swag_silver", B = "swag_silver2", C = "swag_silver3"},
        Enable = function (details, state, refresh)
            SetIplPropState(FinanceOffice4.currentInteriorId, details, state, refresh)
        end
    },
    Chairs = {
        off = "", on = "office_chairs",
        Set = function(chairs, refresh)
            FinanceOffice4.Chairs.Clear(false)
            if (chairs ~= nil) then
                SetIplPropState(FinanceOffice4.currentInteriorId, chairs, true, refresh)
            else
                if (refresh) then RefreshInterior(FinanceOffice4.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(FinanceOffice4.currentInteriorId, FinanceOffice4.Chairs.on, false, refresh)
        end
    },
    Booze = {
        off = "", on = "office_booze",
        Set = function(booze, refresh)
            FinanceOffice4.Booze.Clear(false)
            if (booze ~= nil) then
                SetIplPropState(FinanceOffice4.currentInteriorId, booze, true, refresh)
            else
                if (refresh) then RefreshInterior(FinanceOffice4.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(FinanceOffice4.currentInteriorId, FinanceOffice4.Booze.on, false, refresh)
        end
    },

    LoadDefault = function()
        FinanceOffice4.Style.Set(FinanceOffice4.Style.Theme.cool)
        FinanceOffice4.Chairs.Set(FinanceOffice4.Chairs.on, true)
    end
}


exports('GetFinanceOrganizationObject', function()
    return FinanceOrganization
end)

AddEventHandler('onClientResourceStop', function(res)
    if (GetCurrentResourceName() ~= res) then return end
    FinanceOrganization.Office.Clear()
end)

FinanceOrganization = {
    Name = {
        Colors = {black = 0, gray = 1, yellow = 2, blue = 3, orange = 5, red = 6, green = 7},
        Fonts = {font1 = 0, font2 = 1, font3 = 2, font4 = 3, font5 = 4, font6 = 5, font7 = 6,
                 font8 = 7, font9 = 8, font10 = 9, font11 = 10, font12 = 11, font13 = 12},
        Style = {normal = 3, light = 1},
        name = "",
        style = 0,
        color = 0,
        font = 0,
        Set = function(name, style, color, font)
            FinanceOrganization.Name.name = name
            FinanceOrganization.Name.style = style
            FinanceOrganization.Name.color = color
            FinanceOrganization.Name.font = font
            FinanceOrganization.Office.stage = 0
        end
    },
    Office = {
        needToLoad = false,
        loaded = false,
        target = "prop_ex_office_text",
        prop = "ex_prop_ex_office_text",
        renderId = -1,
        movieId = -1,
        stage = 0,

        Init = function()
            DrawEmptyRect(FinanceOrganization.Office.target, FinanceOrganization.Office.prop)
        end,
        Enable = function(state)
            FinanceOrganization.Office.needToLoad = state
        end,
        Clear = function()
            if IsNamedRendertargetRegistered(FinanceOrganization.Office.target) then
                ReleaseNamedRendertarget(GetHashKey(FinanceOrganization.Office.target))
            end
            if (HasNamedScaleformMovieLoaded(FinanceOrganization.Office.movieId)) then
                SetScaleformMovieAsNoLongerNeeded(FinanceOrganization.Office.movieId)
            end
            FinanceOrganization.Office.renderId = -1
            FinanceOrganization.Office.movieId = -1
            FinanceOrganization.Office.stage = 0
        end
    }
}

Citizen.CreateThread(function()
    FinanceOrganization.Office.Init()

    while true do
        if FinanceOrganization.Office.needToLoad then
            -- Need to load
            if (Global.FinanceOffices.isInsideOffice1 or Global.FinanceOffices.isInsideOffice2 or
                Global.FinanceOffices.isInsideOffice3 or Global.FinanceOffices.isInsideOffice4) then
                DrawOrganizationName(FinanceOrganization.Name.name, FinanceOrganization.Name.style, FinanceOrganization.Name.color, FinanceOrganization.Name.font)
                FinanceOrganization.Office.loaded = true
                Wait(0) -- We need to call all this every frame
            else
                Wait(1000) -- We are not inside an office
            end
        elseif FinanceOrganization.Office.loaded then
            -- Loaded and need to unload
            FinanceOrganization.Office.Clear()
            FinanceOrganization.Office.loaded = false
            Wait(1000) -- We can wait longer when we don't need to display text
        else
            -- Not needed to load
            Wait(1000) -- We can wait longer when we don't need to display text
        end
    end
end)

function DrawOrganizationName(name, style, color, font)
    if FinanceOrganization.Office.stage == 0 then
        if (FinanceOrganization.Office.renderId == -1) then
            FinanceOrganization.Office.renderId = CreateNamedRenderTargetForModel(FinanceOrganization.Office.target, FinanceOrganization.Office.prop)
        end
        if (FinanceOrganization.Office.movieId == -1) then
            FinanceOrganization.Office.movieId = RequestScaleformMovie("ORGANISATION_NAME")
        end
        FinanceOrganization.Office.stage = 1
    elseif FinanceOrganization.Office.stage == 1 then
        if (HasScaleformMovieLoaded(FinanceOrganization.Office.movieId)) then
            local parameters = {
                p0 = {type = "string", value = name},
                p1 = {type = "int", value = style},
                p2 = {type = "int", value = color},
                p3 = {type = "int", value = font}
            }
            SetupScaleform(FinanceOrganization.Office.movieId, "SET_ORGANISATION_NAME", parameters)
            FinanceOrganization.Office.stage = 2
        else
            FinanceOrganization.Office.movieId = RequestScaleformMovie("ORGANISATION_NAME")
        end
    elseif FinanceOrganization.Office.stage == 2 then
        SetTextRenderId(FinanceOrganization.Office.renderId)
        SetUiLayer(4)
        N_0xc6372ecd45d73bcd(true)
        ScreenDrawPositionBegin(73, 73)
        DrawScaleformMovie(FinanceOrganization.Office.movieId, 0.196, 0.245, 0.46, 0.66, 255, 255, 255, 255, 0)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        ScreenDrawPositionEnd()
    end
end

    -- ====================================================================
    -- =------------------- [dlc_executive_roberto] ---------------------=
    -- ====================================================================

    
-- Apartment 1: -787.78050000 334.92320000 215.83840000

exports('GetExecApartment1Object', function()
	return ExecApartment1
end)

ExecApartment1 = {
    currentInteriorId = -1,

    Style = {
        Theme = {
            modern = {interiorId = 227329, ipl = "apa_v_mp_h_01_a"},
            moody = {interiorId = 228097, ipl = "apa_v_mp_h_02_a"},
            vibrant = {interiorId = 228865, ipl = "apa_v_mp_h_03_a"},
            sharp = {interiorId = 229633, ipl = "apa_v_mp_h_04_a"},
            monochrome = {interiorId = 230401, ipl = "apa_v_mp_h_05_a"},
            seductive = {interiorId = 231169, ipl = "apa_v_mp_h_06_a"},
            regal = {interiorId = 231937, ipl = "apa_v_mp_h_07_a"},
            aqua = {interiorId = 232705, ipl = "apa_v_mp_h_08_a"}
        },

        Set = function(style, refresh)
            if (IsTable(style)) then
                ExecApartment1.Style.Clear()
                ExecApartment1.currentInteriorId = style.interiorId
                EnableIpl(style.ipl, true)
                if (refresh) then RefreshInterior(style.interiorId) end
            end
        end,
        Clear = function()
            for key, value in pairs(ExecApartment1.Style.Theme) do
                SetIplPropState(value.interiorId, {"Apart_Hi_Strip_A", "Apart_Hi_Strip_B", "Apart_Hi_Strip_C"}, false)
                SetIplPropState(value.interiorId, {"Apart_Hi_Booze_A", "Apart_Hi_Booze_B", "Apart_Hi_Booze_C"}, false)
                SetIplPropState(value.interiorId, {"Apart_Hi_Smokes_A", "Apart_Hi_Smokes_B", "Apart_Hi_Smokes_C"}, false, true)
                EnableIpl(value.ipl, false)
            end
        end
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(ExecApartment1.currentInteriorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(ExecApartment1.currentInteriorId, details, state, refresh)
        end
    },
    Smoke = {
        none = "", stage1 = "Apart_Hi_Smokes_A", stage2 = "Apart_Hi_Smokes_B", stage3 = "Apart_Hi_Smokes_C",
        Set = function(smoke, refresh)
            ExecApartment1.Smoke.Clear(false)
            if (smoke ~= nil) then
                SetIplPropState(ExecApartment1.currentInteriorId, smoke, true, refresh)
            else
                if (refresh) then RefreshInterior(ExecApartment1.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(ExecApartment1.currentInteriorId, {ExecApartment1.Smoke.stage1, ExecApartment1.Smoke.stage2, ExecApartment1.Smoke.stage3}, false, refresh)
        end
    }, 
    LoadDefault = function()
        ExecApartment1.Style.Set(ExecApartment1.Style.Theme.modern, true)
        ExecApartment1.Strip.Enable({ExecApartment1.Strip.A, ExecApartment1.Strip.B, ExecApartment1.Strip.C}, false)
        ExecApartment1.Booze.Enable({ExecApartment1.Booze.A, ExecApartment1.Booze.B, ExecApartment1.Booze.C}, false)
        ExecApartment1.Smoke.Set(ExecApartment1.Smoke.none)
    end
}


-- Apartment 2: -773.22580000 322.82520000 194.88620000

exports('GetExecApartment2Object', function()
	return ExecApartment2
end)

ExecApartment2 = {
    currentInteriorId = -1,

    Style = {
        Theme = {
            modern = {interiorId = 227585, ipl = "apa_v_mp_h_01_b"},
            moody = {interiorId = 228353, ipl = "apa_v_mp_h_02_b"},
            vibrant = {interiorId = 229121, ipl = "apa_v_mp_h_03_b"},
            sharp = {interiorId = 229889, ipl = "apa_v_mp_h_04_b"},
            monochrome = {interiorId = 230657, ipl = "apa_v_mp_h_05_b"},
            seductive = {interiorId = 231425, ipl = "apa_v_mp_h_06_b"},
            regal = {interiorId = 232193, ipl = "apa_v_mp_h_07_b"},
            aqua = {interiorId = 232961, ipl = "apa_v_mp_h_08_b"}
        },

        Set = function(style, refresh)
            if (IsTable(style)) then
                ExecApartment2.Style.Clear()
                ExecApartment2.currentInteriorId = style.interiorId
                EnableIpl(style.ipl, true)
                if (refresh) then RefreshInterior(style.interiorId) end
            end
        end,
        Clear = function()
            for key, value in pairs(ExecApartment2.Style.Theme) do
                SetIplPropState(value.interiorId, {"Apart_Hi_Strip_A", "Apart_Hi_Strip_B", "Apart_Hi_Strip_C"}, false)
                SetIplPropState(value.interiorId, {"Apart_Hi_Booze_A", "Apart_Hi_Booze_B", "Apart_Hi_Booze_C"}, false)
                SetIplPropState(value.interiorId, {"Apart_Hi_Smokes_A", "Apart_Hi_Smokes_B", "Apart_Hi_Smokes_C"}, false, true)
                EnableIpl(value.ipl, false)
            end
        end
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(ExecApartment2.currentInteriorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(ExecApartment2.currentInteriorId, details, state, refresh)
        end
    },
    Smoke = {
        none = "", stage1 = "Apart_Hi_Smokes_A", stage2 = "Apart_Hi_Smokes_B", stage3 = "Apart_Hi_Smokes_C",
        Set = function(smoke, refresh)
            ExecApartment2.Smoke.Clear(false)
            if (smoke ~= nil) then
                SetIplPropState(ExecApartment2.currentInteriorId, smoke, true, refresh)
            else
                if (refresh) then RefreshInterior(ExecApartment2.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(ExecApartment2.currentInteriorId, {ExecApartment2.Smoke.stage1, ExecApartment2.Smoke.stage2, ExecApartment2.Smoke.stage3}, false, refresh)
        end
    }, 
    LoadDefault = function()
        ExecApartment2.Style.Set(ExecApartment2.Style.Theme.seductive, true)
        ExecApartment2.Strip.Enable({ExecApartment2.Strip.A, ExecApartment2.Strip.B, ExecApartment2.Strip.C}, false)
        ExecApartment2.Booze.Enable({ExecApartment2.Booze.A, ExecApartment2.Booze.B, ExecApartment2.Booze.C}, false)
        ExecApartment2.Smoke.Set(ExecApartment2.Smoke.none)
    end
}


-- Apartment 3: -787.78050000 334.92320000 186.11340000

exports('GetExecApartment3Object', function()
	return ExecApartment3
end)

ExecApartment3 = {
    currentInteriorId = -1,

    Style = {
        Theme = {
            modern = {interiorId = 227841, ipl = "apa_v_mp_h_01_c"},
            moody = {interiorId = 228609, ipl = "apa_v_mp_h_02_c"},
            vibrant = {interiorId = 229377, ipl = "apa_v_mp_h_03_c"},
            sharp = {interiorId = 230145, ipl = "apa_v_mp_h_04_c"},
            monochrome = {interiorId = 230913, ipl = "apa_v_mp_h_05_c"},
            seductive = {interiorId = 231681, ipl = "apa_v_mp_h_06_c"},
            regal = {interiorId = 232449, ipl = "apa_v_mp_h_07_c"},
            aqua = {interiorId = 233217, ipl = "apa_v_mp_h_08_c"}
        },

        Set = function(style, refresh)
            if (IsTable(style)) then
                ExecApartment3.Style.Clear()
                ExecApartment3.currentInteriorId = style.interiorId
                EnableIpl(style.ipl, true)
                if (refresh) then RefreshInterior(style.interiorId) end
            end
        end,
        Clear = function()
            for key, value in pairs(ExecApartment3.Style.Theme) do
                SetIplPropState(value.interiorId, {"Apart_Hi_Strip_A", "Apart_Hi_Strip_B", "Apart_Hi_Strip_C"}, false)
                SetIplPropState(value.interiorId, {"Apart_Hi_Booze_A", "Apart_Hi_Booze_B", "Apart_Hi_Booze_C"}, false)
                SetIplPropState(value.interiorId, {"Apart_Hi_Smokes_A", "Apart_Hi_Smokes_B", "Apart_Hi_Smokes_C"}, false, true)
                EnableIpl(value.ipl, false)
            end
        end
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(ExecApartment3.currentInteriorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(ExecApartment3.currentInteriorId, details, state, refresh)
        end
    },
    Smoke = {
        none = "", stage1 = "Apart_Hi_Smokes_A", stage2 = "Apart_Hi_Smokes_B", stage3 = "Apart_Hi_Smokes_C",
        Set = function(smoke, refresh)
            ExecApartment3.Smoke.Clear(false)
            if (smoke ~= nil) then
                SetIplPropState(ExecApartment3.currentInteriorId, smoke, true, refresh)
            else
                if (refresh) then RefreshInterior(ExecApartment3.currentInteriorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(ExecApartment3.currentInteriorId, {ExecApartment3.Smoke.stage1, ExecApartment3.Smoke.stage2, ExecApartment3.Smoke.stage3}, false, refresh)
        end
    }, 
    LoadDefault = function()
        ExecApartment3.Style.Set(ExecApartment3.Style.Theme.sharp, true)
        ExecApartment3.Strip.Enable({ExecApartment3.Strip.A, ExecApartment3.Strip.B, ExecApartment3.Strip.C}, false)
        ExecApartment3.Booze.Enable({ExecApartment3.Booze.A, ExecApartment3.Booze.B, ExecApartment3.Booze.C}, false)
        ExecApartment3.Smoke.Set(ExecApartment3.Smoke.none)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_doomsday] ---------------------=
    -- ====================================================================
    
-- DoomsdayFacility: 345.00000000 4842.00000000 -60.00000000

exports('GetDoomsdayFacilityObject', function()
    return DoomsdayFacility
end)

DoomsdayFacility = {
    interiorId = 269313,
    Ipl = {
        Interior = {
            ipl = "xm_x17dlc_int_placement_interior_33_x17dlc_int_02_milo_",
            Load = function(color)
                EnableIpl(DoomsdayFacility.Ipl.Interior.ipl, true)
                SetIplPropState(DoomsdayFacility.interiorId, "set_int_02_shell", true, true)
            end,
            Remove = function() EnableIpl(DoomsdayFacility.Ipl.Interior.ipl, false) end
        },
        Exterior = {
            ipl = {
                "xm_hatch_01_cutscene",         -- 1286.924 2846.06 49.39426
                "xm_hatch_02_cutscene",         -- 18.633 2610.834 86.0
                "xm_hatch_03_cutscene",         -- 2768.574 3919.924 45.82
                "xm_hatch_04_cutscene",         -- 3406.90 5504.77 26.28
                "xm_hatch_06_cutscene",         -- 1.90 6832.18 15.82
                "xm_hatch_07_cutscene",         -- -2231.53 2418.42 12.18
                "xm_hatch_08_cutscene",         -- -6.92 3327.0 41.63
                "xm_hatch_09_cutscene",         -- 2073.62 1748.77 104.51
                "xm_hatch_10_cutscene",         -- 1874.35 284.34 164.31
                "xm_hatch_closed",              -- Closed hatches (all)
                "xm_siloentranceclosed_x17",    -- Closed silo: 598.4869 5556.846 716.7615
                "xm_bunkerentrance_door",       -- Bunker entrance closed door: 2050.85 2950.0 47.75
                "xm_hatches_terrain",           -- Terrain adjustments for facilities (all) + silo
                "xm_hatches_terrain_lod",
            },
            Load = function()
                EnableIpl(DoomsdayFacility.Ipl.Exterior.ipl, true)
            end,
            Remove = function() EnableIpl(DoomsdayFacility.Ipl.Exterior.ipl, false) end
        }
    },
    Colors = {
        utility = 1, expertise = 2, altitude = 3,
        power = 4, authority = 5, influence = 6,
        order = 7, empire = 8, supremacy = 9
    },
    Walls = {
        SetColor = function(color, refresh)
            SetInteriorPropColor(DoomsdayFacility.interiorId, "set_int_02_shell", color)
            if (refresh) then RefreshInterior(DoomsdayFacility.interiorId) end
        end
    },
    Decals = {
        none = "",
        style01 = "set_int_02_decal_01", style02 = "set_int_02_decal_02", style03 = "set_int_02_decal_03",
        style04 = "set_int_02_decal_04", style05 = "set_int_02_decal_05", style06 = "set_int_02_decal_06",
        style07 = "set_int_02_decal_07", style08 = "set_int_02_decal_08", style09 = "set_int_02_decal_09",
        Set = function(decal, refresh)
            DoomsdayFacility.Decals.Clear(refresh)
            if decal ~= "" then
                SetIplPropState(DoomsdayFacility.interiorId, decal, true, refresh)
            else
                if (refresh) then RefreshInterior(DoomsdayFacility.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(DoomsdayFacility.interiorId, {
                DoomsdayFacility.Decals.style01, DoomsdayFacility.Decals.style02, DoomsdayFacility.Decals.style03,
                DoomsdayFacility.Decals.style04, DoomsdayFacility.Decals.style05, DoomsdayFacility.Decals.style06,
                DoomsdayFacility.Decals.style07, DoomsdayFacility.Decals.style08, DoomsdayFacility.Decals.style09
            }, false, refresh)
        end
    },
    Lounge = {
        utility = "set_int_02_lounge1", prestige = "set_int_02_lounge2", premier = "set_int_02_lounge3",
        Set = function(lounge, color, refresh)
            DoomsdayFacility.Lounge.Clear(false)
            SetIplPropState(DoomsdayFacility.interiorId, lounge, true, refresh)
            SetInteriorPropColor(DoomsdayFacility.interiorId, lounge, color)
        end,
        Clear = function(refresh)
            SetIplPropState(DoomsdayFacility.interiorId, {DoomsdayFacility.Lounge.utility, DoomsdayFacility.Lounge.prestige, DoomsdayFacility.Lounge.premier}, false, refresh)
        end
    },
    Sleeping = {
        none = "set_int_02_no_sleep",
        utility = "set_int_02_sleep", prestige = "set_int_02_sleep2", premier = "set_int_02_sleep3",
        Set = function(sleep, color, refresh)
            DoomsdayFacility.Sleeping.Clear(false)
            SetIplPropState(DoomsdayFacility.interiorId, sleep, true, refresh)
            SetInteriorPropColor(DoomsdayFacility.interiorId, sleep, color)
        end,
        Clear = function(refresh)
            SetIplPropState(DoomsdayFacility.interiorId, {DoomsdayFacility.Sleeping.none, DoomsdayFacility.Sleeping.utility, DoomsdayFacility.Sleeping.prestige, DoomsdayFacility.Sleeping.premier}, false, refresh)
        end
    },
    Security = {
        off = "set_int_02_no_security", on = "set_int_02_security",
        Set = function(security, color, refresh)
            DoomsdayFacility.Security.Clear(false)
            SetIplPropState(DoomsdayFacility.interiorId, security, true, refresh)
            SetInteriorPropColor(DoomsdayFacility.interiorId, security, color)
        end,
        Clear = function(refresh)
            SetIplPropState(DoomsdayFacility.interiorId, {DoomsdayFacility.Security.off, DoomsdayFacility.Security.on}, false, refresh)
        end
    },
    Cannon = {
        off = "set_int_02_no_cannon", on = "set_int_02_cannon",
        Set = function(cannon, color, refresh)
            DoomsdayFacility.Cannon.Clear(false)
            SetIplPropState(DoomsdayFacility.interiorId, cannon, true, refresh)
            SetInteriorPropColor(DoomsdayFacility.interiorId, cannon, color)
        end,
        Clear = function(refresh)
            SetIplPropState(DoomsdayFacility.interiorId, {DoomsdayFacility.Cannon.off, DoomsdayFacility.Cannon.on}, false, refresh)
        end
    },
    PrivacyGlass = {
        controlModelHash = GetHashKey("xm_prop_x17_tem_control_01"),
        Bedroom = {
            Enable = function(state)
                local handle = GetClosestObjectOfType(367.99, 4827.745, -59.0, 1.0, GetHashKey("xm_prop_x17_l_glass_03"), false, false, false)

                if (state) then
                    if (handle == 0) then
                        local model = GetHashKey("xm_prop_x17_l_glass_03")
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            Wait(0)
                        end
                        
                        local privacyGlass = CreateObject(model, 367.99, 4827.745, -59.0, false, false, false)
                        SetEntityAsMissionEntity(privacyGlass, true, 0)
                        SetEntityCollision_2(privacyGlass, false, 0)
                        SetEntityInvincible(privacyGlass, true)
                        SetEntityAlpha(privacyGlass, 254, false)
                    end
                else
                    if (handle ~= 0) then
                        SetEntityAsMissionEntity(handle, false, false)
                        DeleteEntity(handle)
                    end
                end
            end,

            Control = {
                position = {x = 372.115, y = 4827.504, z = -58.47},
                rotation = {x = 0.0, y = 0.0, z = 0.0},
                Enable = function(state)
                    local handle = GetClosestObjectOfType(DoomsdayFacility.PrivacyGlass.Bedroom.Control.position.x, DoomsdayFacility.PrivacyGlass.Bedroom.Control.position.y, DoomsdayFacility.PrivacyGlass.Bedroom.Control.position.z, 1.0, DoomsdayFacility.PrivacyGlass.controlModelHash, false, false, false)

                    if (state) then
                        if (handle == 0) then
                            RequestModel(DoomsdayFacility.PrivacyGlass.controlModelHash)
                            while not HasModelLoaded(DoomsdayFacility.PrivacyGlass.controlModelHash) do
                                Wait(0)
                            end
                
                            local privacyGlass = CreateObjectNoOffset(DoomsdayFacility.PrivacyGlass.controlModelHash, DoomsdayFacility.PrivacyGlass.Bedroom.Control.position.x, DoomsdayFacility.PrivacyGlass.Bedroom.Control.position.y, DoomsdayFacility.PrivacyGlass.Bedroom.Control.position.z, true, true, false)
                            SetEntityRotation(privacyGlass, DoomsdayFacility.PrivacyGlass.Bedroom.Control.rotation.x, DoomsdayFacility.PrivacyGlass.Bedroom.Control.rotation.y, DoomsdayFacility.PrivacyGlass.Bedroom.Control.rotation.z, 2, true)
                            FreezeEntityPosition(privacyGlass, true)
                            SetEntityAsMissionEntity(privacyGlass, false, false)
                        end
                    else
                        if (handle ~= 0) then
                            SetEntityAsMissionEntity(handle, false, false)
                            DeleteEntity(handle)
                        end
                    end
                end,
            }
        },
        Lounge = {
            Glasses = {
                {modelHash = GetHashKey("xm_prop_x17_l_door_glass_01"), entityHash = GetHashKey("xm_prop_x17_l_door_frame_01"), entityPos = {x = 359.22, y = 4846.043, z = -58.85}},
                {modelHash = GetHashKey("xm_prop_x17_l_door_glass_01"), entityHash = GetHashKey("xm_prop_x17_l_door_frame_01"), entityPos = {x = 369.066, y = 4846.273, z = -58.85}},
                {modelHash = GetHashKey("xm_prop_x17_l_glass_01"), entityHash = GetHashKey("xm_prop_x17_l_frame_01"), entityPos = {x = 358.843, y = 4845.103, z = -60.0}},
                {modelHash = GetHashKey("xm_prop_x17_l_glass_02"), entityHash = GetHashKey("xm_prop_x17_l_frame_02"), entityPos = {x = 366.309, y = 4847.281, z = -60.0}},
                {modelHash = GetHashKey("xm_prop_x17_l_glass_03"), entityHash = GetHashKey("xm_prop_x17_l_frame_03"), entityPos = {x = 371.194, y = 4841.27, z = -60.0}}
            },
            Enable = function(state)
                for key, glass in pairs(DoomsdayFacility.PrivacyGlass.Lounge.Glasses) do
                    local handle = GetClosestObjectOfType(glass.entityPos.x, glass.entityPos.y, glass.entityPos.z, 1.0, glass.modelHash, false, false, false)

                    if (state) then
                        if (handle == 0) then
                            local entityToAttach = GetClosestObjectOfType(glass.entityPos.x, glass.entityPos.y, glass.entityPos.z, 1.0, glass.entityHash, false, false, false)

                            if entityToAttach ~= 0 then
                                RequestModel(glass.modelHash)
                                while not HasModelLoaded(glass.modelHash) do
                                    Wait(0)
                                end
                                
                                local privacyGlass = CreateObject(glass.modelHash, glass.entityPos.x, glass.entityPos.y, glass.entityPos.z, false, false, false)
                                SetEntityAsMissionEntity(privacyGlass, true, false)
                                SetEntityCollision_2(privacyGlass, false, 0)
                                SetEntityInvincible(privacyGlass, true)
                                SetEntityAlpha(privacyGlass, 254, false)
                                AttachEntityToEntity(privacyGlass, entityToAttach, -1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
                            end
                        end
                    else
                        if (handle ~= 0) then
                            SetEntityAsMissionEntity(handle, false, false)
                            DeleteEntity(handle)
                        end
                    end
                end
            end,
            
            Control = {
                position = {x = 367.317, y = 4846.729, z = -58.448},
                rotation = {x = 0.0, y = 0.0, z = -16.0},
                Enable = function(state)
                    local handle = GetClosestObjectOfType(DoomsdayFacility.PrivacyGlass.Lounge.Control.position.x, DoomsdayFacility.PrivacyGlass.Lounge.Control.position.y, DoomsdayFacility.PrivacyGlass.Lounge.Control.position.z, 1.0, DoomsdayFacility.PrivacyGlass.controlModelHash, false, false, false)

                    if (state) then
                        if (handle == 0) then
                            RequestModel(DoomsdayFacility.PrivacyGlass.controlModelHash)
                            while not HasModelLoaded(DoomsdayFacility.PrivacyGlass.controlModelHash) do
                                Wait(0)
                            end
                
                            local privacyGlass = CreateObjectNoOffset(DoomsdayFacility.PrivacyGlass.controlModelHash, DoomsdayFacility.PrivacyGlass.Lounge.Control.position.x, DoomsdayFacility.PrivacyGlass.Lounge.Control.position.y, DoomsdayFacility.PrivacyGlass.Lounge.Control.position.z, true, true, false)
                            SetEntityRotation(privacyGlass, DoomsdayFacility.PrivacyGlass.Lounge.Control.rotation.x, DoomsdayFacility.PrivacyGlass.Lounge.Control.rotation.y, DoomsdayFacility.PrivacyGlass.Lounge.Control.rotation.z, 2, true)
                            FreezeEntityPosition(privacyGlass, true)
                            SetEntityAsMissionEntity(privacyGlass, false, false)
                        end
                    else
                        if (handle ~= 0) then
                            SetEntityAsMissionEntity(handle, false, false)
                            DeleteEntity(handle)
                        end
                    end
                end,
            }
        }
    },
    Details = {
        KhanjaliParts = {A = "Set_Int_02_Parts_Panther1", B = "Set_Int_02_Parts_Panther2", C = "Set_Int_02_Parts_Panther3"},
        RiotParts = {A = "Set_Int_02_Parts_Riot1", B = "Set_Int_02_Parts_Riot2", C = "Set_Int_02_Parts_Riot3"},
        ChenoParts = {A = "Set_Int_02_Parts_Cheno1", B = "Set_Int_02_Parts_Cheno2", C = "Set_Int_02_Parts_Cheno3"},
        ThrusterParts = {A = "Set_Int_02_Parts_Thruster1", B = "Set_Int_02_Parts_Thruster2", C = "Set_Int_02_Parts_Thruster3"},
        AvengerParts = {A = "Set_Int_02_Parts_Avenger1", B = "Set_Int_02_Parts_Avenger2", C = "Set_Int_02_Parts_Avenger3"},
        
        Outfits = {
            paramedic = "Set_Int_02_outfit_paramedic", morgue = "Set_Int_02_outfit_morgue", serverFarm = "Set_Int_02_outfit_serverfarm",
            iaa = "Set_Int_02_outfit_iaa", stealAvenger = "Set_Int_02_outfit_steal_avenger", foundry = "Set_Int_02_outfit_foundry",
            riot = "Set_Int_02_outfit_riot_van", stromberg = "Set_Int_02_outfit_stromberg", submarine = "Set_Int_02_outfit_sub_finale",
            predator = "Set_Int_02_outfit_predator", khanjali = "Set_Int_02_outfit_khanjali", volatol = "Set_Int_02_outfit_volatol"
        },

        Trophies = {
            eagle = "set_int_02_trophy1", iaa = "set_int_02_trophy_iaa", submarine = "set_int_02_trophy_sub",
            SetColor = function(color, refresh)
                SetInteriorPropColor(DoomsdayFacility.interiorId, "set_int_02_trophy_sub", color)
                if (refresh) then RefreshInterior(DoomsdayFacility.interiorId) end
            end
        },

        Clutter = {A = "set_int_02_clutter1", B = "set_int_02_clutter2", C = "set_int_02_clutter3", D = "set_int_02_clutter4", E = "set_int_02_clutter5"},

        crewEmblem = "set_int_02_crewemblem",

        Enable = function (details, state, refresh)
            SetIplPropState(DoomsdayFacility.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        DoomsdayFacility.Ipl.Exterior.Load()
        DoomsdayFacility.Ipl.Interior.Load()
        
        DoomsdayFacility.Walls.SetColor(DoomsdayFacility.Colors.utility)
        DoomsdayFacility.Decals.Set(DoomsdayFacility.Decals.style01)
        DoomsdayFacility.Lounge.Set(DoomsdayFacility.Lounge.premier, DoomsdayFacility.Colors.utility)
        DoomsdayFacility.Sleeping.Set(DoomsdayFacility.Sleeping.premier, DoomsdayFacility.Colors.utility)
        DoomsdayFacility.Security.Set(DoomsdayFacility.Security.on, DoomsdayFacility.Colors.utility)
        DoomsdayFacility.Cannon.Set(DoomsdayFacility.Cannon.on, DoomsdayFacility.Colors.utility)

        -- Privacy glass remote
        DoomsdayFacility.PrivacyGlass.Bedroom.Control.Enable(true)
        DoomsdayFacility.PrivacyGlass.Lounge.Control.Enable(true)

        DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.crewEmblem, false)

        DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.AvengerParts, true)

        DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.Outfits, true)
        
        DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.Trophies, true)
        DoomsdayFacility.Details.Trophies.SetColor(DoomsdayFacility.Colors.utility)

        DoomsdayFacility.Details.Enable({DoomsdayFacility.Details.Clutter.A, DoomsdayFacility.Details.Clutter.B}, true)

        RefreshInterior(DoomsdayFacility.interiorId)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_casino] ---------------------=
    -- ====================================================================

    exports('GetDiamondCasinoObject', function()
        return DiamondCasino
    end)
    
    DiamondCasino = {
        Ipl = {
            Building = {
                ipl = {
                    "hei_dlc_windows_casino",
                    "hei_dlc_casino_aircon",
                    "vw_dlc_casino_door",
                    "hei_dlc_casino_door"
                },
                Load = function() EnableIpl(DiamondCasino.Ipl.Building.ipl, true) end,
                Remove = function() EnableIpl(DiamondCasino.Ipl.Building.ipl, false) end
            },
            Main = {
                ipl = "vw_casino_main",
                Load = function() EnableIpl(DiamondCasino.Ipl.Main.ipl, true) end,
                Remove = function() EnableIpl(DiamondCasino.Ipl.Main.ipl, false) end
            },
            Garage = {
                ipl = "vw_casino_garage",
                Load = function() EnableIpl(DiamondCasino.Ipl.Garage.ipl, true) end,
                Remove = function() EnableIpl(DiamondCasino.Ipl.Garage.ipl, false) end
            },
            Carpark = {
                ipl = "vw_casino_carpark",
                Load = function() EnableIpl(DiamondCasino.Ipl.Carpark.ipl, true) end,
                Remove = function() EnableIpl(DiamondCasino.Ipl.Carpark.ipl, false) end
            }
        },
    
        LoadDefault = function()
            DiamondCasino.Ipl.Building.Load()
            DiamondCasino.Ipl.Main.Load()
            DiamondCasino.Ipl.Carpark.Load()
            DiamondCasino.Ipl.Garage.Load()
        end
    }
    exports('GetDiamondPenthouseObject', function()
        return DiamondPenthouse
    end)
    
    DiamondPenthouse = {
        interiorId = 274689,
    
        Ipl = {
            Interior = {
                ipl = "vw_casino_penthouse",
                Load = function()
                    EnableIpl(DiamondPenthouse.Ipl.Interior.ipl, true)
                    SetIplPropState(DiamondPenthouse.interiorId, "Set_Pent_Tint_Shell", true, true)
                end,
                Remove = function() EnableIpl(DiamondPenthouse.Ipl.Interior.ipl, false) end
            }
        },
        Colors = {
            default = 0,
            sharp = 1,
            vibrant = 2,
            timeless = 3
        },
        Interior = {
            Walls = {
                SetColor = function(color, refresh)
                    SetInteriorEntitySetColor(DiamondPenthouse.interiorId, "Set_Pent_Tint_Shell", color)
                    if (refresh) then RefreshInterior(DiamondPenthouse.interiorId) end
                end
            },
            Pattern = {
                pattern01 = "Set_Pent_Pattern_01", pattern02 = "Set_Pent_Pattern_02", pattern03 = "Set_Pent_Pattern_03",
                pattern04 = "Set_Pent_Pattern_04", pattern05 = "Set_Pent_Pattern_05", pattern06 = "Set_Pent_Pattern_06",
                pattern07 = "Set_Pent_Pattern_07", pattern08 = "Set_Pent_Pattern_08", pattern09 = "Set_Pent_Pattern_09",
                Set = function(pattern, refresh)
                    DiamondPenthouse.Interior.Pattern.Clear(false)
                    SetIplPropState(DiamondPenthouse.interiorId, pattern, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(DiamondPenthouse.Interior.Pattern) do
                        if (type(value) == "string") then
                            SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            SpaBar = {
                open = "Set_Pent_Spa_Bar_Open", closed = "Set_Pent_Spa_Bar_Closed",
                Set = function(state, refresh)
                    DiamondPenthouse.Interior.SpaBar.Clear(false)
                    SetIplPropState(DiamondPenthouse.interiorId, state, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(DiamondPenthouse.Interior.SpaBar) do
                        if (type(value) == "string") then
                            SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            MediaBar = {
                open = "Set_Pent_Media_Bar_Open", closed = "Set_Pent_Media_Bar_Closed",
                Set = function(state, refresh)
                    DiamondPenthouse.Interior.MediaBar.Clear(false)
                    SetIplPropState(DiamondPenthouse.interiorId, state, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(DiamondPenthouse.Interior.MediaBar) do
                        if (type(value) == "string") then
                            SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            Dealer = {
                open = "Set_Pent_Dealer", closed = "Set_Pent_NoDealer",
                Set = function(state, refresh)
                    DiamondPenthouse.Interior.Dealer.Clear(false)
                    SetIplPropState(DiamondPenthouse.interiorId, state, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(DiamondPenthouse.Interior.Dealer) do
                        if (type(value) == "string") then
                            SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            Arcade = {
                none = "", retro = "Set_Pent_Arcade_Retro", modern = "Set_Pent_Arcade_Modern",
                Set = function(arcade, refresh)
                    DiamondPenthouse.Interior.Arcade.Clear(false)
                    SetIplPropState(DiamondPenthouse.interiorId, arcade, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(DiamondPenthouse.Interior.Arcade) do
                        if (type(value) == "string") then
                            SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            Clutter = {
                bar = "Set_Pent_Bar_Clutter", clutter01 = "Set_Pent_Clutter_01", clutter02 = "Set_Pent_Clutter_02", clutter03 = "Set_Pent_Clutter_03",
                Set = function(clutter, refresh)
                    DiamondPenthouse.Interior.Clutter.Clear(false)
                    SetIplPropState(DiamondPenthouse.interiorId, clutter, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(DiamondPenthouse.Interior.Clutter) do
                        if (type(value) == "string") then
                            SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            BarLight = {
                none = "", light0 = "set_pent_bar_light_0", light1 = "set_pent_bar_light_01", light2 = "set_pent_bar_light_02",
                Set = function(light, refresh)
                    DiamondPenthouse.Interior.BarLight.Clear(false)
                    SetIplPropState(DiamondPenthouse.interiorId, light, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(DiamondPenthouse.Interior.BarLight) do
                        if (type(value) == "string") then
                            SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            BarParty = {
                none = "", party0 = "set_pent_bar_party_0", party1 = "set_pent_bar_party_1", party2 = "set_pent_bar_party_2", partyafter = "set_pent_bar_party_after",
                Set = function(party, refresh)
                    DiamondPenthouse.Interior.BarParty.Clear(false)
                    SetIplPropState(DiamondPenthouse.interiorId, party, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(DiamondPenthouse.Interior.BarParty) do
                        if (type(value) == "string") then
                            SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            Blockers = {
                Guest = {
                    enabled = "Set_Pent_GUEST_BLOCKER", disabled = "",
                    Set = function(blocker, refresh)
                        DiamondPenthouse.Interior.Blockers.Guest.Clear(false)
                        SetIplPropState(DiamondPenthouse.interiorId, blocker, true, refresh)
                    end,
                    Clear = function(refresh)
                        for key, value in pairs(DiamondPenthouse.Interior.Blockers.Guest) do
                            if (type(value) == "string") then
                                SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                            end
                        end
                    end
                },
                Lounge = {
                    enabled = "Set_Pent_LOUNGE_BLOCKER", disabled = "",
                    Set = function(blocker, refresh)
                        DiamondPenthouse.Interior.Blockers.Lounge.Clear(false)
                        SetIplPropState(DiamondPenthouse.interiorId, blocker, true, refresh)
                    end,
                    Clear = function(refresh)
                        for key, value in pairs(DiamondPenthouse.Interior.Blockers.Lounge) do
                            if (type(value) == "string") then
                                SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                            end
                        end
                    end
                },
                Office = {
                    enabled = "Set_Pent_OFFICE_BLOCKER", disabled = "",
                    Set = function(blocker, refresh)
                        DiamondPenthouse.Interior.Blockers.Office.Clear(false)
                        SetIplPropState(DiamondPenthouse.interiorId, blocker, true, refresh)
                    end,
                    Clear = function(refresh)
                        for key, value in pairs(DiamondPenthouse.Interior.Blockers.Office) do
                            if (type(value) == "string") then
                                SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                            end
                        end
                    end
                },
                Cinema = {
                    enabled = "Set_Pent_CINE_BLOCKER", disabled = "",
                    Set = function(blocker, refresh)
                        DiamondPenthouse.Interior.Blockers.Cinema.Clear(false)
                        SetIplPropState(DiamondPenthouse.interiorId, blocker, true, refresh)
                    end,
                    Clear = function(refresh)
                        for key, value in pairs(DiamondPenthouse.Interior.Blockers.Cinema) do
                            if (type(value) == "string") then
                                SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                            end
                        end
                    end
                },
                Spa = {
                    enabled = "Set_Pent_SPA_BLOCKER", disabled = "",
                    Set = function(blocker, refresh)
                        DiamondPenthouse.Interior.Blockers.Spa.Clear(false)
                        SetIplPropState(DiamondPenthouse.interiorId, blocker, true, refresh)
                    end,
                    Clear = function(refresh)
                        for key, value in pairs(DiamondPenthouse.Interior.Blockers.Spa) do
                            if (type(value) == "string") then
                                SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                            end
                        end
                    end
                },
                Bar = {
                    enabled = "Set_Pent_BAR_BLOCKER", disabled = "",
                    Set = function(blocker, refresh)
                        DiamondPenthouse.Interior.Blockers.Bar.Clear(false)
                        SetIplPropState(DiamondPenthouse.interiorId, blocker, true, refresh)
                    end,
                    Clear = function(refresh)
                        for key, value in pairs(DiamondPenthouse.Interior.Blockers.Bar) do
                            if (type(value) == "string") then
                                SetIplPropState(DiamondPenthouse.interiorId, value, false, refresh)
                            end
                        end
                    end
                },
                EnableAllBlockers = function()
                    DiamondPenthouse.Interior.Blockers.Bar.Set(DiamondPenthouse.Interior.Blockers.Bar.enabled)
                    DiamondPenthouse.Interior.Blockers.Guest.Set(DiamondPenthouse.Interior.Blockers.Guest.enabled)
                    DiamondPenthouse.Interior.Blockers.Spa.Set(DiamondPenthouse.Interior.Blockers.Spa.enabled)
                    DiamondPenthouse.Interior.Blockers.Cinema.Set(DiamondPenthouse.Interior.Blockers.Cinema.enabled)
                    DiamondPenthouse.Interior.Blockers.Lounge.Set(DiamondPenthouse.Interior.Blockers.Lounge.enabled)
                    DiamondPenthouse.Interior.Blockers.Office.Set(DiamondPenthouse.Interior.Blockers.Office.enabled)
                end,
                DisableAllBlockers = function()
                    DiamondPenthouse.Interior.Blockers.Bar.Set(DiamondPenthouse.Interior.Blockers.Bar.disabled)
                    DiamondPenthouse.Interior.Blockers.Guest.Set(DiamondPenthouse.Interior.Blockers.Guest.disabled)
                    DiamondPenthouse.Interior.Blockers.Spa.Set(DiamondPenthouse.Interior.Blockers.Spa.disabled)
                    DiamondPenthouse.Interior.Blockers.Cinema.Set(DiamondPenthouse.Interior.Blockers.Cinema.disabled)
                    DiamondPenthouse.Interior.Blockers.Lounge.Set(DiamondPenthouse.Interior.Blockers.Lounge.disabled)
                    DiamondPenthouse.Interior.Blockers.Office.Set(DiamondPenthouse.Interior.Blockers.Office.disabled)
                end
            }
        },
    
        LoadDefault = function()
            DiamondPenthouse.Ipl.Interior.Load()
    
            DiamondPenthouse.Interior.Walls.SetColor(DiamondPenthouse.Colors.default)
            DiamondPenthouse.Interior.SpaBar.Set(DiamondPenthouse.Interior.SpaBar.open)
            DiamondPenthouse.Interior.MediaBar.Set(DiamondPenthouse.Interior.MediaBar.open)
            DiamondPenthouse.Interior.Dealer.Set(DiamondPenthouse.Interior.Dealer.open)
    
            RefreshInterior(DiamondPenthouse.interiorId)
        end
    }

    -- ====================================================================
    -- =------------------- [dlc_bikers_roberto] ---------------------=
    -- ====================================================================
    
-- Clubhouse1: 1107.04, -3157.399, -37.51859

exports('GetBikerClubhouse1Object', function()
    return BikerClubhouse1
end)

BikerClubhouse1 = {
    interiorId = 246273,
    Ipl = {
        Interior = {
            ipl = "bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo",
            Load = function() EnableIpl(BikerClubhouse1.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(BikerClubhouse1.Ipl.Interior.ipl, false) end
        },
    },
    Walls = {
        brick = "walls_01", plain = "walls_02",
        Color = {
            sable = 0,
            yellowGray = 1,
            red = 2,
            brown = 3,
            yellow = 4,
            lightYellow = 5,
            lightYellowGray = 6,
            lightGray = 7,
            orange = 8,
            gray = 9
        },
        Set = function(walls, color, refresh)
            if color == nil then color = 0 end
            BikerClubhouse1.Walls.Clear(false)
            SetIplPropState(BikerClubhouse1.interiorId, walls, true, refresh)
            SetInteriorPropColor(BikerClubhouse1.interiorId, walls, color)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Walls.brick, BikerClubhouse1.Walls.plain}, false, refresh)
        end
    },
    Furnitures = {
        A = "furnishings_01", B = "furnishings_02",
        Set = function(furn, color, refresh)
            if color == nil then color = 0 end
            BikerClubhouse1.Furnitures.Clear(false)
            SetIplPropState(BikerClubhouse1.interiorId, furn, true, refresh)
            SetInteriorPropColor(BikerClubhouse1.interiorId, furn, color)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Furnitures.A, BikerClubhouse1.Furnitures.B}, false, refresh)
        end
    },
    Decoration = {
        A = "decorative_01", B = "decorative_02",
        Set = function(deco, refresh)
            BikerClubhouse1.Decoration.Clear(false)
            SetIplPropState(BikerClubhouse1.interiorId, deco, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Decoration.A, BikerClubhouse1.Decoration.B}, false, refresh)
        end
    },
    Mural = {
        none = "", rideFree = "mural_01", mods = "mural_02", brave = "mural_03", fist = "mural_04",
        forest = "mural_05", mods2 = "mural_06", rideForever = "mural_07", heart = "mural_08",
        route68 = "mural_09",
        Set = function(mural, refresh)
            BikerClubhouse1.Mural.Clear(false)
            if mural ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, mural, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Mural.rideFree, BikerClubhouse1.Mural.mods, BikerClubhouse1.Mural.brave, BikerClubhouse1.Mural.fist,
            BikerClubhouse1.Mural.forest, BikerClubhouse1.Mural.mods2, BikerClubhouse1.Mural.rideForever, BikerClubhouse1.Mural.heart, BikerClubhouse1.Mural.route68}, false, refresh)
        end
    },
    GunLocker = {
        none = "", on = "gun_locker", off = "no_gun_locker",
        Set = function(locker, refresh)
            BikerClubhouse1.GunLocker.Clear(false)
            if locker ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, locker, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.GunLocker.on, BikerClubhouse1.GunLocker.off}, false, refresh)
        end
    },
    ModBooth = {
        none = "", on = "mod_booth", off = "no_mod_booth",
        Set = function(mod, refresh)
            BikerClubhouse1.ModBooth.Clear(false)
            if mod ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, mod, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.ModBooth.on, BikerClubhouse1.ModBooth.off}, false, refresh)
        end
    },
    Meth = {
        none = "", stage1 = "meth_stash1", stage2 = {"meth_stash1", "meth_stash2"}, stage3 = {"meth_stash1", "meth_stash2", "meth_stash3"},
        Set = function(stage, refresh)
            BikerClubhouse1.Meth.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Meth.stage1, BikerClubhouse1.Meth.stage2, BikerClubhouse1.Meth.stage3}, false, refresh)
        end
    },
    Cash = {
        none = "", stage1 = "cash_stash1", stage2 = {"cash_stash1", "cash_stash2"}, stage3 = {"cash_stash1", "cash_stash2", "cash_stash3"},
        Set = function(stage, refresh)
            BikerClubhouse1.Cash.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Cash.stage1, BikerClubhouse1.Cash.stage2, BikerClubhouse1.Cash.stage3}, false, refresh)
        end
    },
    Weed = {
        none = "", stage1 = "weed_stash1", stage2 = {"weed_stash1", "weed_stash2"}, stage3 = {"weed_stash1", "weed_stash2", "weed_stash3"},
        Set = function(stage, refresh)
            BikerClubhouse1.Weed.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Weed.stage1, BikerClubhouse1.Weed.stage2, BikerClubhouse1.Weed.stage3}, false, refresh)
        end
    },
    Coke = {
        none = "", stage1 = "coke_stash1", stage2 = {"coke_stash1", "coke_stash2"}, stage3 = {"coke_stash1", "coke_stash2", "coke_stash3"},
        Set = function(stage, refresh)
            BikerClubhouse1.Coke.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Coke.stage1, BikerClubhouse1.Coke.stage2, BikerClubhouse1.Coke.stage3}, false, refresh)
        end
    },
    Counterfeit = {
        none = "", stage1 = "counterfeit_stash1", stage2 = {"counterfeit_stash1", "counterfeit_stash2"}, stage3 = {"counterfeit_stash1", "counterfeit_stash2", "counterfeit_stash3"},
        Set = function(stage, refresh)
            BikerClubhouse1.Counterfeit.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Counterfeit.stage1, BikerClubhouse1.Counterfeit.stage2, BikerClubhouse1.Counterfeit.stage3}, false, refresh)
        end
    },
    Documents = {
        none = "", stage1 = "id_stash1", stage2 = {"id_stash1", "id_stash2"}, stage3 = {"id_stash1", "id_stash2", "id_stash3"},
        Set = function(stage, refresh)
            BikerClubhouse1.Documents.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse1.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse1.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse1.interiorId, {BikerClubhouse1.Documents.stage1, BikerClubhouse1.Documents.stage2, BikerClubhouse1.Documents.stage3}, false, refresh)
        end
    },

    LoadDefault = function()
        BikerClubhouse1.Ipl.Interior.Load()
        
        BikerClubhouse1.Walls.Set(BikerClubhouse1.Walls.plain, BikerClubhouse1.Walls.Color.brown)

        BikerClubhouse1.Furnitures.Set(BikerClubhouse1.Furnitures.A, 3)
        BikerClubhouse1.Decoration.Set(BikerClubhouse1.Decoration.A)
        BikerClubhouse1.Mural.Set(BikerClubhouse1.Mural.rideFree)

        BikerClubhouse1.ModBooth.Set(BikerClubhouse1.ModBooth.none)
        BikerClubhouse1.GunLocker.Set(BikerClubhouse1.GunLocker.none)

        BikerClubhouse1.Meth.Set(BikerClubhouse1.Meth.none)
        BikerClubhouse1.Cash.Set(BikerClubhouse1.Cash.none)
        BikerClubhouse1.Coke.Set(BikerClubhouse1.Coke.none)
        BikerClubhouse1.Weed.Set(BikerClubhouse1.Weed.none)
        BikerClubhouse1.Counterfeit.Set(BikerClubhouse1.Counterfeit.none)
        BikerClubhouse1.Documents.Set(BikerClubhouse1.Documents.none)

        RefreshInterior(BikerClubhouse1.interiorId)
    end
}


-- Clubhouse2: 998.4809, -3164.711, -38.90733

exports('GetBikerClubhouse2Object', function()
    return BikerClubhouse2
end)

BikerClubhouse2 = {
    interiorId = 246529,
    Ipl = {
        Interior = {
            ipl = "bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo",
            Load = function() EnableIpl(BikerClubhouse2.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(BikerClubhouse2.Ipl.Interior.ipl, false) end
        },
    },
    Walls = {
        brick = "walls_01", plain = "walls_02",
        Color = {
            greenAndGray = 1,
            multicolor = 2,
            orangeAndGray = 3,
            blue = 4,
            lightBlueAndSable = 5,
            greenAndRed = 6,
            yellowAndGray = 7,
            red = 8,
            fuchsiaAndGray = 9
        },
        Set = function(walls, color, refresh)
            if color == nil then color = 0 end
            BikerClubhouse2.Walls.Clear(false)
            SetIplPropState(BikerClubhouse2.interiorId, walls, true, refresh)
            SetInteriorPropColor(BikerClubhouse2.interiorId, walls, color)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Walls.brick, BikerClubhouse2.Walls.plain}, false, refresh)
        end
    },
    LowerWalls = {
        default = "lower_walls_default",
        SetColor = function(color, refresh)
            SetIplPropState(BikerClubhouse2.interiorId, BikerClubhouse2.LowerWalls.default, true, refresh)
            SetInteriorPropColor(BikerClubhouse2.interiorId, BikerClubhouse2.LowerWalls.default, color)
        end,
    },
    Furnitures = {
        A = "furnishings_01", B = "furnishings_02",
        -- Colors for "furnishings_01" only
        Color = {
            turquoise = 0,
            darkBrown = 1,
            brown = 2,
            -- 3 equal 1
            brown2 = 4,
            gray = 5,
            red = 6,
            darkGray = 7,
            black = 8,
            red2 = 9
        },
        Set = function(furn, color, refresh)
            if color == nil then color = 0 end
            BikerClubhouse2.Furnitures.Clear(false)
            SetIplPropState(BikerClubhouse2.interiorId, furn, true, refresh)
            SetInteriorPropColor(BikerClubhouse2.interiorId, furn, color)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Furnitures.A, BikerClubhouse2.Furnitures.B}, false, refresh)
        end
    },
    Decoration = {
        A = "decorative_01", B = "decorative_02",
        Set = function(deco, refresh)
            BikerClubhouse2.Decoration.Clear(false)
            SetIplPropState(BikerClubhouse2.interiorId, deco, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Decoration.A, BikerClubhouse2.Decoration.B}, false, refresh)
        end
    },
    Mural = {
        none = "", death1 = "mural_01", cityColor1 = "mural_02", death2 = "mural_03", cityColor2 = "mural_04",
        graffitis = "mural_05", cityColor3 = "mural_06", cityColor4 = "mural_07", cityBlack = "mural_08",
        death3 = "mural_09",
        Set = function(mural, refresh)
            BikerClubhouse2.Mural.Clear(false)
            if mural ~= "" then
                SetIplPropState(BikerClubhouse2.interiorId, mural, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse2.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Mural.death1, BikerClubhouse2.Mural.cityColor1, BikerClubhouse2.Mural.death2, BikerClubhouse2.Mural.cityColor2,
            BikerClubhouse2.Mural.graffitis, BikerClubhouse2.Mural.cityColor3, BikerClubhouse2.Mural.cityColor4, BikerClubhouse2.Mural.cityBlack, BikerClubhouse2.Mural.death3}, false, refresh)
        end
    },
    GunLocker = {
        on = "gun_locker", off = "no_gun_locker",
        Set = function(locker, refresh)
            BikerClubhouse2.GunLocker.Clear(false)
            if locker ~= "" then SetIplPropState(BikerClubhouse2.interiorId, locker, true, refresh) end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.GunLocker.on, BikerClubhouse2.GunLocker.off}, false, refresh)
        end
    },
    ModBooth = {
        none = "", on = "mod_booth", off = "no_mod_booth",
        Set = function(mod, refresh)
            BikerClubhouse2.ModBooth.Clear(false)
            if mod ~= "" then
                SetIplPropState(BikerClubhouse2.interiorId, mod, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse2.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.ModBooth.on, BikerClubhouse2.ModBooth.off}, false, refresh)
        end
    },
    Meth = {
        none = "", stage1 = "meth_small", stage2 = {"meth_small", "meth_medium"}, stage3 = {"meth_small", "meth_medium", "meth_large"},
        Set = function(stage, refresh)
            BikerClubhouse2.Meth.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse2.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse2.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Meth.stage1, BikerClubhouse2.Meth.stage2, BikerClubhouse2.Meth.stage3}, false, refresh)
        end
    },
    Cash = {
        none = "", stage1 = "cash_small", stage2 = {"cash_small", "cash_medium"}, stage3 = {"cash_small", "cash_medium", "cash_large"},
        Set = function(stage, refresh)
            BikerClubhouse2.Cash.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse2.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse2.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Cash.stage1, BikerClubhouse2.Cash.stage2, BikerClubhouse2.Cash.stage3}, false, refresh)
        end
    },
    Weed = {
        none = "", stage1 = "weed_small", stage2 = {"weed_small", "weed_medium"}, stage3 = {"weed_small", "weed_medium", "weed_large"},
        Set = function(stage, refresh)
            BikerClubhouse2.Weed.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse2.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse2.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Weed.stage1, BikerClubhouse2.Weed.stage2, BikerClubhouse2.Weed.stage3}, false, refresh)
        end
    },
    Coke = {
        none = "", stage1 = "coke_small", stage2 = {"coke_small", "coke_medium"}, stage3 = {"coke_small", "coke_medium", "coke_large"},
        Set = function(stage, refresh)
            BikerClubhouse2.Coke.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse2.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse2.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Coke.stage1, BikerClubhouse2.Coke.stage2, BikerClubhouse2.Coke.stage3}, false, refresh)
        end
    },
    Counterfeit = {
        none = "", stage1 = "counterfeit_small", stage2 = {"counterfeit_small", "counterfeit_medium"}, stage3 = {"counterfeit_small", "counterfeit_medium", "counterfeit_large"},
        Set = function(stage, refresh)
            BikerClubhouse2.Counterfeit.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse2.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse2.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Counterfeit.stage1, BikerClubhouse2.Counterfeit.stage2, BikerClubhouse2.Counterfeit.stage3}, false, refresh)
        end
    },
    Documents = {
        none = "", stage1 = "id_small", stage2 = {"id_small", "id_medium"}, stage3 = {"id_small", "id_medium", "id_large"},
        Set = function(stage, refresh)
            BikerClubhouse2.Documents.Clear(false)
            if stage ~= "" then
                SetIplPropState(BikerClubhouse2.interiorId, stage, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerClubhouse2.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerClubhouse2.interiorId, {BikerClubhouse2.Documents.stage1, BikerClubhouse2.Documents.stage2, BikerClubhouse2.Documents.stage3}, false, refresh)
        end
    },

    LoadDefault = function()
        BikerClubhouse2.Ipl.Interior.Load()
        
        BikerClubhouse2.Walls.Set(BikerClubhouse2.Walls.brick, BikerClubhouse2.Walls.Color.red)
        BikerClubhouse2.LowerWalls.SetColor(BikerClubhouse2.Walls.Color.red)

        BikerClubhouse2.Furnitures.Set(BikerClubhouse2.Furnitures.B, BikerClubhouse2.Furnitures.Color.black)
        BikerClubhouse2.Decoration.Set(BikerClubhouse2.Decoration.B)
        BikerClubhouse2.Mural.Set(BikerClubhouse2.Mural.death3)

        BikerClubhouse2.ModBooth.Set(BikerClubhouse2.ModBooth.off)
        BikerClubhouse2.GunLocker.Set(BikerClubhouse2.GunLocker.off)

        BikerClubhouse2.Meth.Set(BikerClubhouse2.Meth.none)
        BikerClubhouse2.Cash.Set(BikerClubhouse2.Cash.none)
        BikerClubhouse2.Coke.Set(BikerClubhouse2.Coke.none)
        BikerClubhouse2.Weed.Set(BikerClubhouse2.Weed.none)
        BikerClubhouse2.Counterfeit.Set(BikerClubhouse2.Counterfeit.none)
        BikerClubhouse2.Documents.Set(BikerClubhouse2.Documents.none)
        
        RefreshInterior(BikerClubhouse2.interiorId)
    end
}


-- Cocaine lockup: 1093.6, -3196.6, -38.99841

exports('GetBikerCocaineObject', function()
    return BikerCocaine
end)

BikerCocaine = {
    interiorId = 247553,
    Ipl = {
        Interior = {
            ipl = "bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo",
            Load = function() EnableIpl(BikerCocaine.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(BikerCocaine.Ipl.Interior.ipl, false) end
        },
    },
    Style = {
        none = "",
        basic = {"set_up", "equipment_basic", "coke_press_basic", "production_basic", "table_equipment"},
        upgrade = {"set_up", "equipment_upgrade", "coke_press_upgrade", "production_upgrade", "table_equipment_upgrade"},
        Set = function(style, refresh)
            BikerCocaine.Style.Clear(false)
            if (style ~= "") then
                SetIplPropState(BikerCocaine.interiorId, style, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerCocaine.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerCocaine.interiorId, {BikerCocaine.Style.basic, BikerCocaine.Style.upgrade}, false, refresh)
        end
    },
    Security = {
        none = "", basic = "security_low", upgrade = "security_high",
        Set = function(security, refresh)
            BikerCocaine.Security.Clear(false)
            if (security ~= "") then
                SetIplPropState(BikerCocaine.interiorId, security, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerCocaine.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerCocaine.interiorId, {BikerCocaine.Security.basic, BikerCocaine.Security.upgrade}, false, refresh)
        end
    },
    Details = {
        cokeBasic1 = "coke_cut_01",						-- On the basic tables
        cokeBasic2 = "coke_cut_02",						-- On the basic tables
        cokeBasic3 = "coke_cut_03",						-- On the basic tables
        cokeUpgrade1 = "coke_cut_04",					-- On the upgraded tables
        cokeUpgrade2 = "coke_cut_05",					-- On the upgraded tables
        Enable = function (details, state, refresh)
            SetIplPropState(BikerCocaine.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        BikerCocaine.Ipl.Interior.Load()
        BikerCocaine.Style.Set(BikerCocaine.Style.basic)
        BikerCocaine.Security.Set(BikerCocaine.Security.none)
        RefreshInterior(BikerCocaine.interiorId)
    end
}


-- Counterfeit cash factory: 1121.897, -3195.338, -40.4025

exports('GetBikerCounterfeitObject', function()
    return BikerCounterfeit
end)

BikerCounterfeit = {
    interiorId = 247809,
    Ipl = {
        Interior = {
            ipl = "bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo",
            Load = function() EnableIpl(BikerCounterfeit.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(BikerCounterfeit.Ipl.Interior.ipl, false) end
        },
    },
    Printer = {
        none = "",
        basic = "counterfeit_standard_equip_no_prod", basicProd = "counterfeit_standard_equip",
        upgrade = "counterfeit_upgrade_equip_no_prod", upgradeProd = "counterfeit_upgrade_equip",
        Set = function(printer, refresh)
            BikerCounterfeit.Printer.Clear(false)
            if (printer ~= "") then
                SetIplPropState(BikerCounterfeit.interiorId, printer, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerCounterfeit.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerCounterfeit.interiorId, {BikerCounterfeit.Printer.basic, BikerCounterfeit.Printer.basicProd, BikerCounterfeit.Printer.upgrade, BikerCounterfeit.Printer.upgradeProd}, false, refresh)
        end
    },
    Security = {
        basic = "counterfeit_low_security", upgrade = "counterfeit_security",
        Set = function(security, refresh)
            BikerCounterfeit.Security.Clear(false)
            SetIplPropState(BikerCounterfeit.interiorId, security, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerCounterfeit.interiorId, {BikerCounterfeit.Security.basic, BikerCounterfeit.Security.upgrade}, false, refresh)
        end
    },
    Dryer1 = {
        none = "", on = "dryera_on", off = "dryera_off", open = "dryera_open",
        Set = function(dryer, refresh)
            BikerCounterfeit.Dryer1.Clear(false)
            if (dryer ~= "") then
                SetIplPropState(BikerCounterfeit.interiorId, dryer, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerCounterfeit.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerCounterfeit.interiorId, {BikerCounterfeit.Dryer1.on, BikerCounterfeit.Dryer1.off, BikerCounterfeit.Dryer1.open}, false, refresh)
        end
    },
    Dryer2 = {
        none = "", on = "dryerb_on", off = "dryerb_off", open = "dryerb_open",
        Set = function(dryer, refresh)
            BikerCounterfeit.Dryer2.Clear(false)
            if (dryer ~= "") then
                SetIplPropState(BikerCounterfeit.interiorId, dryer, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerCounterfeit.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerCounterfeit.interiorId, {BikerCounterfeit.Dryer2.on, BikerCounterfeit.Dryer2.off, BikerCounterfeit.Dryer2.open}, false, refresh)
        end
    },
    Dryer3 = {
        none = "", on = "dryerc_on", off = "dryerc_off", open = "dryerc_open",
        Set = function(dryer, refresh)
            BikerCounterfeit.Dryer3.Clear(false)
            if (dryer ~= "") then
                SetIplPropState(BikerCounterfeit.interiorId, dryer, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerCounterfeit.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerCounterfeit.interiorId, {BikerCounterfeit.Dryer3.on, BikerCounterfeit.Dryer3.off, BikerCounterfeit.Dryer3.open}, false, refresh)
        end
    },
    Dryer4 = {
        none = "", on = "dryerd_on", off = "dryerd_off", open = "dryerd_open",
        Set = function(dryer, refresh)
            BikerCounterfeit.Dryer4.Clear(false)
            if (dryer ~= "") then
                SetIplPropState(BikerCounterfeit.interiorId, dryer, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerCounterfeit.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerCounterfeit.interiorId, {BikerCounterfeit.Dryer4.on, BikerCounterfeit.Dryer4.off, BikerCounterfeit.Dryer4.open}, false, refresh)
        end
    },
    Details = {
        Cash10 = {
            A = "counterfeit_cashpile10a", B = "counterfeit_cashpile10b",
            C = "counterfeit_cashpile10c", D = "counterfeit_cashpile10d",
        },
        Cash20 = {
            A = "counterfeit_cashpile20a", B = "counterfeit_cashpile20b",
            C = "counterfeit_cashpile20c", D = "counterfeit_cashpile20d",
        },
        Cash100 = {
            A = "counterfeit_cashpile100a", B = "counterfeit_cashpile100b",
            C = "counterfeit_cashpile100c", D = "counterfeit_cashpile100d",
        },
        chairs = "special_chairs",							-- Brown chairs at the end of the room
        cutter = "money_cutter",							-- Money cutting machine
        furnitures = "counterfeit_setup",				-- Paper, counting machines, cups

        Enable = function (details, state, refresh)
            SetIplPropState(BikerCounterfeit.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        BikerCounterfeit.Ipl.Interior.Load()
        BikerCounterfeit.Printer.Set(BikerCounterfeit.Printer.basicProd)
        BikerCounterfeit.Security.Set(BikerCounterfeit.Security.upgrade)
        BikerCounterfeit.Dryer1.Set(BikerCounterfeit.Dryer1.open)
        BikerCounterfeit.Dryer2.Set(BikerCounterfeit.Dryer2.on)
        BikerCounterfeit.Dryer3.Set(BikerCounterfeit.Dryer3.on)
        BikerCounterfeit.Dryer4.Set(BikerCounterfeit.Dryer4.on)
        BikerCounterfeit.Details.Enable(BikerCounterfeit.Details.cutter, true)
        BikerCounterfeit.Details.Enable(BikerCounterfeit.Details.furnitures, true)

        BikerCounterfeit.Details.Enable(BikerCounterfeit.Details.Cash100, true)


        RefreshInterior(BikerCounterfeit.interiorId)
    end
}


-- Document forgery: 1165, -3196.6, -39.01306

exports('GetBikerDocumentForgeryObject', function()
    return BikerDocumentForgery
end)

BikerDocumentForgery = {
    interiorId = 246785,
    Ipl = {
        Interior = {
            ipl = "bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo",
            Load = function() EnableIpl(BikerDocumentForgery.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(BikerDocumentForgery.Ipl.Interior.ipl, false) end
        },
    },
    Style = {
        basic = "interior_basic", upgrade = "interior_upgrade",
        Set = function(style, refresh)
            BikerDocumentForgery.Style.Clear(false)
            SetIplPropState(BikerDocumentForgery.interiorId, style, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerDocumentForgery.interiorId, {BikerDocumentForgery.Style.basic, BikerDocumentForgery.Style.upgrade}, false, refresh)
        end
    },
    Equipment = {
        none = "", basic = "equipment_basic", upgrade = "equipment_upgrade",
        Set = function(eqpt, refresh)
            BikerDocumentForgery.Equipment.Clear(false)
            if (eqpt ~= "") then
                SetIplPropState(BikerDocumentForgery.interiorId, eqpt, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerDocumentForgery.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerDocumentForgery.interiorId, {BikerDocumentForgery.Equipment.basic, BikerDocumentForgery.Equipment.upgrade}, false, refresh)
        end
    },
    Security = {
        basic = "security_low", upgrade = "security_high",
        Set = function(security, refresh)
            BikerDocumentForgery.Security.Clear(false)
            SetIplPropState(BikerDocumentForgery.interiorId, security, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerDocumentForgery.interiorId, {BikerDocumentForgery.Security.basic, BikerDocumentForgery.Security.upgrade}, false, refresh)
        end
    },
    Details = {
        Chairs = {
            A = "chair01", B = "chair02", C = "chair03", D = "chair04",
            E = "chair05", F = "chair06", G = "chair07",
        },
        production = "production",			-- Papers, pencils
        furnitures = "set_up",				-- Printers, shredders
        clutter = "clutter",				-- Pizza boxes, cups

        Enable = function (details, state, refresh)
            SetIplPropState(BikerDocumentForgery.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        BikerDocumentForgery.Ipl.Interior.Load()
        BikerDocumentForgery.Style.Set(BikerDocumentForgery.Style.basic)
        BikerDocumentForgery.Security.Set(BikerDocumentForgery.Security.basic)
        BikerDocumentForgery.Equipment.Set(BikerDocumentForgery.Equipment.basic)
        BikerDocumentForgery.Details.Enable(BikerDocumentForgery.Details.production, false)
        BikerDocumentForgery.Details.Enable(BikerDocumentForgery.Details.setup, false)
        BikerDocumentForgery.Details.Enable(BikerDocumentForgery.Details.clutter, false)
        BikerDocumentForgery.Details.Enable(BikerDocumentForgery.Details.Chairs, true)
        RefreshInterior(BikerDocumentForgery.interiorId)
    end
}


exports('GetBikerGangObject', function()
    return BikerGang
end)

AddEventHandler('onClientResourceStop', function(res)
    if (GetCurrentResourceName() ~= res) then return end
    BikerGang.Clubhouse.ClearAll()
end)

BikerGang = {
    Name = {
        Colors = {black = 0, gray = 1, white = 2, orange = 3, red = 4, green = 5, yellow = 6, blue = 7},
        Fonts = {font1 = 0, font2 = 1, font3 = 2, font4 = 3, font5 = 4, font6 = 5, font7 = 6,
                 font8 = 7, font9 = 8, font10 = 9, font11 = 10, font12 = 11, font13 = 12},
        name = "",
        color = 0,
        font = 0,
        Set = function(name, color, font)
            BikerGang.Name.name = name
            BikerGang.Name.color = color
            BikerGang.Name.font = font
            BikerGang.Clubhouse.ClubName.stage = 0
        end
    },
    Emblem = {
        Logo = {
            eagle = "MPClubPreset1",
            skull = "MPClubPreset2",
            ace = "MPClubPreset3",
            brassKnuckles = "MPClubPreset4",
            UR = "MPClubPreset5",
            fox = "MPClubPreset6",
            city = "MPClubPreset7",
            dices = "MPClubPreset8",
            target = "MPClubPreset9"
        },

        emblem = "MPClubPreset1",
        rot = 90.0,                 -- Rotation for 0.0 to 360.0
        
        Set = function(logo, rotation)
            BikerGang.Emblem.emblem = logo
            BikerGang.Emblem.rot = rotation
            BikerGang.Clubhouse.Emblem.stage = 0
        end
    },
    Clubhouse = {
        interiorId1 = 246273,
        interiorId2 = 246529,

        Members = {
            President = {
                needToLoad = false,
                loaded = false,
                renderId = -1,
                textureDict = "",
                pedheadshot = -1,
                target = "memorial_wall_president",
                prop = "bkr_prop_rt_memorial_president",
                stage = 0,
                Init = function()
                    DrawEmptyRect(BikerGang.Clubhouse.Members.President.target, BikerGang.Clubhouse.Members.President.prop)
                end,
                Enable = function(state)
                    BikerGang.Clubhouse.Members.President.needToLoad = state
                end,
                Set = function(ped)
                    BikerGang.Clubhouse.Members.Set(BikerGang.Clubhouse.Members.President, ped)
                end,
                Clear = function()
                    BikerGang.Clubhouse.Members.Clear(BikerGang.Clubhouse.Members.President)
                end
            },
            VicePresident = {
                needToLoad = false,
                loaded = false,
                renderId = -1,
                textureDict = "",
                pedheadshot = -1,
                target = "memorial_wall_vice_president",
                prop = "bkr_prop_rt_memorial_vice_pres",
                stage = 0,
                Init = function()
                    DrawEmptyRect(BikerGang.Clubhouse.Members.VicePresident.target, BikerGang.Clubhouse.Members.VicePresident.prop)
                end,
                Enable = function(state)
                    BikerGang.Clubhouse.Members.VicePresident.needToLoad = state
                end,
                Set = function(ped)
                    BikerGang.Clubhouse.Members.Set(BikerGang.Clubhouse.Members.VicePresident, ped)
                end,
                Clear = function()
                    BikerGang.Clubhouse.Members.Clear(BikerGang.Clubhouse.Members.VicePresident)
                end
            },
            RoadCaptain = {
                needToLoad = false,
                loaded = false,
                renderId = -1,
                textureDict = "",
                pedheadshot = -1,
                target = "memorial_wall_active_01",
                prop = "bkr_prop_rt_memorial_active_01",
                stage = 0,
                Init = function()
                    DrawEmptyRect(BikerGang.Clubhouse.Members.RoadCaptain.target, BikerGang.Clubhouse.Members.RoadCaptain.prop)
                end,
                Enable = function(state)
                    BikerGang.Clubhouse.Members.RoadCaptain.needToLoad = state
                end,
                Set = function(ped)
                    BikerGang.Clubhouse.Members.Set(BikerGang.Clubhouse.Members.RoadCaptain, ped)
                end,
                Clear = function()
                    BikerGang.Clubhouse.Members.Clear(BikerGang.Clubhouse.Members.RoadCaptain)
                end
            },
            Enforcer = {
                needToLoad = false,
                loaded = false,
                renderId = -1,
                textureDict = "",
                pedheadshot = -1,
                target = "memorial_wall_active_02",
                prop = "bkr_prop_rt_memorial_active_02",
                stage = 0,
                Init = function()
                    DrawEmptyRect(BikerGang.Clubhouse.Members.Enforcer.target, BikerGang.Clubhouse.Members.Enforcer.prop)
                end,
                Enable = function(state)
                    BikerGang.Clubhouse.Members.Enforcer.needToLoad = state
                end,
                Set = function(ped)
                    BikerGang.Clubhouse.Members.Set(BikerGang.Clubhouse.Members.Enforcer, ped)
                end,
                Clear = function()
                    BikerGang.Clubhouse.Members.Clear(BikerGang.Clubhouse.Members.Enforcer)
                end
            },
            SergeantAtArms = {
                needToLoad = false,
                loaded = false,
                renderId = -1,
                textureDict = "",
                pedheadshot = -1,
                target = "memorial_wall_active_03",
                prop = "bkr_prop_rt_memorial_active_03",
                stage = 0,
                Init = function()
                    DrawEmptyRect(BikerGang.Clubhouse.Members.SergeantAtArms.target, BikerGang.Clubhouse.Members.SergeantAtArms.prop)
                end,
                Enable = function(state)
                    BikerGang.Clubhouse.Members.SergeantAtArms.needToLoad = state
                end,
                Set = function(ped)
                    BikerGang.Clubhouse.Members.Set(BikerGang.Clubhouse.Members.SergeantAtArms, ped)
                end,
                Clear = function()
                    BikerGang.Clubhouse.Members.Clear(BikerGang.Clubhouse.Members.SergeantAtArms)
                end
            },
            Set = function(member, ped)
                member.Clear()
                member.pedheadshot = GetPedheadshot(ped)

                if (member.pedheadshot ~= -1) then
                    member.textureDict = GetPedheadshotTxdString(member.pedheadshot)

                    local IsTextureDictLoaded = LoadStreamedTextureDict(member.textureDict)
                    if (not IsTextureDictLoaded) then
                        Citizen.Trace("ERROR: BikerClubhouseDrawMembers - Textures dictionnary \"" .. tostring(member.textureDict) .. "\" cannot be loaded.")
                    end
                else
                    Citizen.Trace("ERROR: BikerClubhouseDrawMembers - PedHeadShot not ready.")
                end
            end,
            Clear = function(member)
                if IsNamedRendertargetRegistered(member.target) then
                    ReleaseNamedRendertarget(GetHashKey(member.target))
                end
                if (member.pedheadshot ~= -1) then
                    UnregisterPedheadshot(member.pedheadshot)
                end
                if (member.textureDict ~= "") then
                    SetStreamedTextureDictAsNoLongerNeeded(member.textureDict)
                end
                member.renderId = -1
                member.textureDict = ""
                member.pedheadshot = -1
                member.stage = 0
            end
        },

        ClubName = {
            needToLoad = false,
            loaded = false,
            target = "clubname_blackboard_01a",
            prop = "bkr_prop_clubhouse_blackboard_01a",
            renderId = -1,
            movieId = -1,
            stage = 0,

            Init = function()
                DrawEmptyRect(BikerGang.Clubhouse.ClubName.target, BikerGang.Clubhouse.ClubName.prop)
            end,
            Enable = function(state)
                BikerGang.Clubhouse.ClubName.needToLoad = state
            end,
            Clear = function()
                if IsNamedRendertargetRegistered(BikerGang.Clubhouse.ClubName.target) then
                    ReleaseNamedRendertarget(GetHashKey(BikerGang.Clubhouse.ClubName.target))
                end
                if (HasNamedScaleformMovieLoaded(BikerGang.Clubhouse.ClubName.movieId)) then
                    SetScaleformMovieAsNoLongerNeeded(BikerGang.Clubhouse.ClubName.movieId)
                end
                BikerGang.Clubhouse.ClubName.renderId = -1
                BikerGang.Clubhouse.ClubName.movieId = -1
                BikerGang.Clubhouse.ClubName.stage = 0
            end
        },

        Emblem = {
            needToLoad = false,
            loaded = false,
            target = "clubhouse_table",
            prop = "bkr_prop_rt_clubhouse_table",
            renderId = -1,
            movieId = -1,
            stage = 0,

            Enable = function(state)
                BikerGang.Clubhouse.Emblem.needToLoad = state
            end,
            Init = function()
                DrawEmptyRect(BikerGang.Clubhouse.Emblem.target, BikerGang.Clubhouse.Emblem.prop)
            end,
            Clear = function()
                if IsNamedRendertargetRegistered(BikerGang.Clubhouse.Emblem.target) then
                    ReleaseNamedRendertarget(GetHashKey(BikerGang.Clubhouse.Emblem.target))
                end
                BikerGang.Clubhouse.Emblem.renderId = -1
                BikerGang.Clubhouse.Emblem.stage = 0
            end
        },

        MissionsWall = {
            Missions = {
                Titles = {
                    byThePoundUpper = "BDEAL_DEALN",
                    byThePound = "DEAL_DEALN",
                    prisonerOfWarUpper = "BIGM_RESCN",
                    prisonerOfWar = "CELL_BIKER_RESC",
                    gunsForHire = "LR_INTRO_ST",
                    weaponOfChoice = "CELL_BIKER_CK",
                    gunrunningUpper = "GB_BIGUNLOAD_U",
                    gunrunning = "GB_BIGUNLOAD_T",
                    nineTenthsOfTheLawUpper = "SB_INTRO_TITLE",
                    nineTenthsOfTheLaw = "SB_MENU_TITLE",
                    jailbreakUpper = "FP_INTRO_TITLE",
                    jailbreak = "FP_MENU_TITLE",
                    crackedUpper = "SC_INTRO_TITLE",
                    cracked = "SC_MENU_TITLE",
                    fragileGoodsUpper = "DV_SH_BIG",
                    fragileGoods = "DV_SH_TITLE",
                    torchedUpper = "BA_SH_BIG",
                    torched = "BA_SH_TITLE",
                    outriderUpper = "SHU_SH_BIG",
                    outrider = "SHU_SH_TITLE"
                },
                Descriptions = {
                    byThePound = "DEAL_DEALND",
                    prisonerOfWar = "CELL_BIKER_RESD",
                    gunsForHire = "GFH_MENU_DESC",
                    weaponOfChoice = "CELL_BIKER_CKD",
                    gunrunning = "GB_BIGUNLOAD_D",
                    nineTenthsOfTheLaw = "SB_MENU_DESC",
                    jailbreak = "FP_MENU_DESC",
                    cracked = "SC_MENU_DESC",
                    fragileGoods = "DV_MENU_DESC",
                    torched = "BA_MENU_DESC",
                    outrider = "SHU_MENU_DESC"
                },
                Pictures = {
                    byThePound = "CHM_IMG0", -- Pickup car parked
                    prisonerOfWar = "CHM_IMG8", -- Police with man down
                    gunsForHire = "CHM_IMG4", -- Limo
                    weaponOfChoice = "CHM_IMG10", -- Prisoner being beaten
                    gunrunning = "CHM_IMG3", -- Shipment
                    nineTenthsOfTheLaw = "CHM_IMG6", -- Wheeling
                    jailbreak = "CHM_IMG5", -- Prison bus
                    cracked = "CHM_IMG1", -- Safe
                    fragileGoods = "CHM_IMG2", -- Lost Van
                    torched = "CHM_IMG9", -- Explosive crate
                    outrider = "CHM_IMG7" -- Sport ride 
                },
            },
            needToLoad = false,
            loaded = false,
            target = "clubhouse_Plan_01a",
            prop = "bkr_prop_rt_clubhouse_plan_01a",
            renderId = -1,
            movieId = -1,
            stage = 0,
            
            Position = {none = -1, left = 0, middle = 1, right = 2},

            Init = function()
                if not DrawEmptyRect(BikerGang.Clubhouse.MissionsWall.target, BikerGang.Clubhouse.MissionsWall.prop) then
                    Citizen.Trace("ERROR: BikerGang.Clubhouse.MissionsWall.Init() - DrawEmptyRect - Timeout")
                end
            end,
            Enable = function(state)
                BikerGang.Clubhouse.MissionsWall.needToLoad = state
            end,
            SelectMission = function(position)
                if BikerGang.Clubhouse.MissionsWall.movieId ~= -1 then
                    BeginScaleformMovieMethod(BikerGang.Clubhouse.MissionsWall.movieId, "SET_SELECTED_MISSION")
                    PushScaleformMovieMethodParameterInt(position) -- Mission index 0 to 2 (-1 = no mission)
                    EndScaleformMovieMethod()
                end
            end,
            SetMission = function(position, title, desc, textDict, x, y)
                if BikerGang.Clubhouse.MissionsWall.needToLoad then
                    if not HasNamedScaleformMovieLoaded(BikerGang.Clubhouse.MissionsWall.movieId) then
                        BikerGang.Clubhouse.MissionsWall.movieId = LoadScaleform("BIKER_MISSION_WALL")
                    end
                    if BikerGang.Clubhouse.MissionsWall.movieId ~= -1 then
                        if (position > -1) then
                            BeginScaleformMovieMethod(BikerGang.Clubhouse.MissionsWall.movieId, "SET_MISSION")
                            PushScaleformMovieMethodParameterInt(position)          -- Mission index 0 to 2 (-1 = no mission)
                            PushScaleformMovieMethodParameterString(title)
                            PushScaleformMovieMethodParameterString(desc)
                            PushScaleformMovieMethodParameterButtonName(textDict)
                            PushScaleformMovieMethodParameterFloat(x)               -- Mission 0: world coordinates X
                            PushScaleformMovieMethodParameterFloat(y)               -- Mission 0: world coordinates Y
                            EndScaleformMovieMethod()
                        else
                            -- Remove all missions
                            for key, value in pairs(BikerGang.Clubhouse.MissionsWall.Position) do
                                BikerGang.Clubhouse.MissionsWall.RemoveMission(value)
                            end
                            BikerGang.Clubhouse.MissionsWall.SelectMission(BikerGang.Clubhouse.MissionsWall.Position.none)
                        end
                    end
                end
            end,
            RemoveMission = function(position)
                BeginScaleformMovieMethod(BikerGang.Clubhouse.MissionsWall.movieId, "HIDE_MISSION")
                PushScaleformMovieMethodParameterInt(position)
                EndScaleformMovieMethod()
            end,
            Clear = function()
                -- Removing missions
                BikerGang.Clubhouse.MissionsWall.SelectMission(BikerGang.Clubhouse.MissionsWall.Position.none)
                BikerGang.Clubhouse.MissionsWall.SetMission(BikerGang.Clubhouse.MissionsWall.Position.none)

                -- Releasing handles
                if IsNamedRendertargetRegistered(BikerGang.Clubhouse.MissionsWall.prop) then
                    ReleaseNamedRendertarget(GetHashKey(BikerGang.Clubhouse.MissionsWall.prop))
                end
                if HasNamedScaleformMovieLoaded(BikerGang.Clubhouse.MissionsWall.movieId) then
                    SetScaleformMovieAsNoLongerNeeded(BikerGang.Clubhouse.MissionsWall.movieId)
                end
                
                -- Resetting
                BikerGang.Clubhouse.MissionsWall.renderId = -1
                BikerGang.Clubhouse.MissionsWall.movieId = -1
                BikerGang.Clubhouse.MissionsWall.stage = 0
            end
        },
        
        ClearAll = function()
            BikerGang.Clubhouse.ClubName.Clear()
            BikerGang.Clubhouse.ClubName.loaded = false
            
            BikerGang.Clubhouse.Emblem.Clear()
            BikerGang.Clubhouse.Emblem.loaded = false
            
            BikerGang.Clubhouse.MissionsWall.Clear()
            BikerGang.Clubhouse.MissionsWall.loaded = false

            for key, member in pairs(BikerGang.Clubhouse.Members) do
                if IsTable(member) then
                    member.Clear()
                    member.loaded = false
                end
            end
        end
    }
}

Citizen.CreateThread(function()
    -- Removing the black texture
    BikerGang.Clubhouse.Members.President.Init()
    BikerGang.Clubhouse.Members.VicePresident.Init()
    BikerGang.Clubhouse.Members.RoadCaptain.Init()
    BikerGang.Clubhouse.Members.Enforcer.Init()
    BikerGang.Clubhouse.Members.SergeantAtArms.Init()
    
    BikerGang.Clubhouse.ClubName.Init()
    BikerGang.Clubhouse.Emblem.Init()
    BikerGang.Clubhouse.MissionsWall.Init()
    

    while true do
        if (BikerGang.Clubhouse.ClubName.needToLoad or
            BikerGang.Clubhouse.Emblem.needToLoad or
            BikerGang.Clubhouse.MissionsWall.needToLoad or
            BikerGang.Clubhouse.Members.President.needToLoad or
            BikerGang.Clubhouse.Members.VicePresident.needToLoad or
            BikerGang.Clubhouse.Members.RoadCaptain.needToLoad or
            BikerGang.Clubhouse.Members.Enforcer.needToLoad or
            BikerGang.Clubhouse.Members.SergeantAtArms.needToLoad) then

            -- If we are inside a clubhouse, then we load
            if (Global.Biker.isInsideClubhouse1 or Global.Biker.isInsideClubhouse2) then
                -- Club name
                if BikerGang.Clubhouse.ClubName.needToLoad then
                    DrawClubName(BikerGang.Name.name, BikerGang.Name.color, BikerGang.Name.font)
                    BikerGang.Clubhouse.ClubName.loaded = true
                elseif (BikerGang.Clubhouse.ClubName.loaded) then
                    BikerGang.Clubhouse.ClubName.Clear()
                    BikerGang.Clubhouse.ClubName.loaded = false
                end
                -- Emblem
                if BikerGang.Clubhouse.Emblem.needToLoad then
                    DrawEmblem(BikerGang.Emblem.emblem, BikerGang.Emblem.rot)
                    BikerGang.Clubhouse.Emblem.loaded = true
                elseif (BikerGang.Clubhouse.Emblem.loaded) then
                    BikerGang.Clubhouse.Emblem.Clear()
                    BikerGang.Clubhouse.Emblem.loaded = false
                end
                -- Missions wall
                if BikerGang.Clubhouse.MissionsWall.needToLoad then
                    DrawMissions()
                    BikerGang.Clubhouse.MissionsWall.loaded = true
                elseif (BikerGang.Clubhouse.MissionsWall.loaded) then
                    BikerGang.Clubhouse.MissionsWall.Clear()
                    BikerGang.Clubhouse.MissionsWall.loaded = false
                end

                -- Members: President
                for key, member in pairs(BikerGang.Clubhouse.Members) do
                    if IsTable(member) then
                        if member.needToLoad then
                            DrawMember(member)
                            member.loaded = true
                        elseif member.loaded then
                            member.Clear()
                            member.loaded = false
                        end
                    end
                end

                Wait(0) -- We need to call all this every frame
            else
                -- Not in a clubhouse
                Wait(1000)
            end
        else
            -- No load needed
            Wait(1000)
        end
    end

end)





function DrawClubName(name, color, font)
    if BikerGang.Clubhouse.ClubName.stage == 0 then
        if (BikerGang.Clubhouse.ClubName.renderId == -1) then
            BikerGang.Clubhouse.ClubName.renderId = CreateNamedRenderTargetForModel(BikerGang.Clubhouse.ClubName.target, BikerGang.Clubhouse.ClubName.prop)
        end
        if (BikerGang.Clubhouse.ClubName.movieId == -1) then
            BikerGang.Clubhouse.ClubName.movieId = RequestScaleformMovie("CLUBHOUSE_NAME")
        end
        BikerGang.Clubhouse.ClubName.stage = 1
    elseif BikerGang.Clubhouse.ClubName.stage == 1 then
        if (HasScaleformMovieLoaded(BikerGang.Clubhouse.ClubName.movieId)) then
            local parameters = {
                p0 = {type = "string", value = name},
                p1 = {type = "int", value = color},
                p2 = {type = "int", value = font}
            }
            SetupScaleform(BikerGang.Clubhouse.ClubName.movieId, "SET_CLUBHOUSE_NAME", parameters)
            BikerGang.Clubhouse.ClubName.stage = 2
        else
            BikerGang.Clubhouse.ClubName.movieId = RequestScaleformMovie("CLUBHOUSE_NAME")
        end
    elseif BikerGang.Clubhouse.ClubName.stage == 2 then
        SetTextRenderId(BikerGang.Clubhouse.ClubName.renderId)
        SetUiLayer(4)
        N_0xc6372ecd45d73bcd(true)
        ScreenDrawPositionBegin(73, 73)
        DrawScaleformMovie(BikerGang.Clubhouse.ClubName.movieId, 0.0975, 0.105, 0.235, 0.35, 255, 255, 255, 255, 0)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        ScreenDrawPositionEnd()
    end
end

function DrawEmblem(texturesDict, rotation)
    if (BikerGang.Clubhouse.Emblem.stage == 0) then
        if (BikerGang.Clubhouse.Emblem.renderId == -1) then
            BikerGang.Clubhouse.Emblem.renderId = CreateNamedRenderTargetForModel(BikerGang.Clubhouse.Emblem.target, BikerGang.Clubhouse.Emblem.prop)
        end
        local IsTextureDictLoaded = LoadStreamedTextureDict(texturesDict)
        if (not IsTextureDictLoaded) then Citizen.Trace("ERROR: DrawEmblem - Textures dictionnary cannot be loaded.") end
        BikerGang.Clubhouse.Emblem.stage = 1
    elseif (BikerGang.Clubhouse.Emblem.stage == 1) then
        BikerGang.Clubhouse.Emblem.renderId = CreateNamedRenderTargetForModel(BikerGang.Clubhouse.Emblem.target, BikerGang.Clubhouse.Emblem.prop)
        BikerGang.Clubhouse.Emblem.stage = 2
    elseif (BikerGang.Clubhouse.Emblem.stage == 2) then
        SetTextRenderId(BikerGang.Clubhouse.Emblem.renderId)
        ScreenDrawPositionBegin(73, 73)
        SetUiLayer(4)
        N_0xc6372ecd45d73bcd(true)
        N_0x2bc54a8188768488(texturesDict, texturesDict, 0.5, 0.5, 1.0, 1.0, rotation, 255, 255, 255, 255);
        ScreenDrawPositionEnd()
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    end
end

function DrawMissions()
    if BikerGang.Clubhouse.MissionsWall.stage == 0 then
        if (BikerGang.Clubhouse.MissionsWall.renderId == -1) then
            BikerGang.Clubhouse.MissionsWall.renderId = CreateNamedRenderTargetForModel(BikerGang.Clubhouse.MissionsWall.target, BikerGang.Clubhouse.MissionsWall.prop)
        end
        BikerGang.Clubhouse.MissionsWall.stage = 1
    elseif BikerGang.Clubhouse.MissionsWall.stage == 1 then
        if (HasScaleformMovieLoaded(BikerGang.Clubhouse.MissionsWall.movieId)) then
            BikerGang.Clubhouse.MissionsWall.stage = 2
        else
            BikerGang.Clubhouse.MissionsWall.movieId = RequestScaleformMovie("BIKER_MISSION_WALL")
        end
    elseif BikerGang.Clubhouse.MissionsWall.stage == 2 then
        SetTextRenderId(BikerGang.Clubhouse.MissionsWall.renderId)
        SetUiLayer(4)
        N_0xc6372ecd45d73bcd(false)
        DrawScaleformMovie(BikerGang.Clubhouse.MissionsWall.movieId, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255, 0)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        N_0xe6a9f00d4240b519(BikerGang.Clubhouse.MissionsWall.movieId, true)
    end
end

function DrawMember(member)
    if (member.stage == 0) then

        member.stage = 1
    elseif (member.stage == 1) then
        member.renderId = CreateNamedRenderTargetForModel(member.target, member.prop)
        member.stage = 2
    elseif (member.stage == 2) then
        if (HasStreamedTextureDictLoaded(member.textureDict)) then
            SetTextRenderId(member.renderId)
            ScreenDrawPositionBegin(73, 73)
            N_0x2bc54a8188768488(member.textureDict, member.textureDict, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            ScreenDrawPositionEnd()
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        end
    end
end


-- Meth lab: 1009.5, -3196.6, -38.99682

exports('GetBikerMethLabObject', function()
    return BikerMethLab
end)

BikerMethLab = {
    interiorId = 247041,
    Ipl = {
        Interior = {
            ipl = "bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo",
            Load = function() EnableIpl(BikerMethLab.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(BikerMethLab.Ipl.Interior.ipl, false) end
        },
    },
    Style = {
        none = "", empty = "meth_lab_empty", basic = {"meth_lab_basic", "meth_lab_setup"}, upgrade = {"meth_lab_upgrade", "meth_lab_setup"},
        Set = function(style, refresh)
            BikerMethLab.Style.Clear(false)
            if (style ~= "") then
                SetIplPropState(BikerMethLab.interiorId, style, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerMethLab.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerMethLab.interiorId, {BikerMethLab.Style.empty, BikerMethLab.Style.basic, BikerMethLab.Style.upgrade}, false, refresh)
        end
    },
    Security = {
        none = "", upgrade = "meth_lab_security_high",
        Set = function(security, refresh)
            BikerMethLab.Security.Clear(false)
            if (security ~= "") then
                SetIplPropState(BikerMethLab.interiorId, security, true, refresh)
            else
                if (refresh) then RefreshInterior(BikerMethLab.interiorId) end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerMethLab.interiorId, BikerMethLab.Security.upgrade, false, refresh)
        end
    },
    Details = {
        production = "meth_lab_production",			-- Products
        Enable = function (details, state, refresh)
            SetIplPropState(BikerMethLab.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        BikerMethLab.Ipl.Interior.Load()
        BikerMethLab.Style.Set(BikerMethLab.Style.empty)
        BikerMethLab.Security.Set(BikerMethLab.Security.none)
        BikerMethLab.Details.Enable(BikerMethLab.Details.production, false)
        RefreshInterior(BikerMethLab.interiorId)
    end
}


-- Weed farm: 1051.491, -3196.536, -39.14842

exports('GetBikerWeedFarmObject', function()
    return BikerWeedFarm
end)

BikerWeedFarm = {
    interiorId = 247297,
    Ipl = {
        Interior = {
            ipl = "bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo",
            Load = function() EnableIpl(BikerWeedFarm.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(BikerWeedFarm.Ipl.Interior.ipl, false) end
        },
    },
    Style = {
        basic = "weed_standard_equip", upgrade = "weed_upgrade_equip",
        Set = function(style, refresh)
            BikerWeedFarm.Style.Clear(false)
            SetIplPropState(BikerWeedFarm.interiorId, style, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Style.basic, BikerWeedFarm.Style.upgrade}, false, refresh)
        end
    },
    Security = {
        basic = "weed_low_security", upgrade = "weed_security_upgrade",
        Set = function(security, refresh)
            BikerWeedFarm.Security.Clear(false)
            SetIplPropState(BikerWeedFarm.interiorId, security, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Security.basic, BikerWeedFarm.Security.upgrade}, false, refresh)
        end
    },
    Plant1 = {
        Stage = {
            small = "weed_growtha_stage1", medium = "weed_growtha_stage2", full = "weed_growtha_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant1.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant1.Stage.small, BikerWeedFarm.Plant1.Stage.medium, BikerWeedFarm.Plant1.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growtha_stage23_standard", upgrade = "light_growtha_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant1.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant1.Light.basic, BikerWeedFarm.Plant1.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hosea", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant1.Stage.Set(stage, false)
            BikerWeedFarm.Plant1.Light.Set(upgrade, false)
            BikerWeedFarm.Plant1.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant1.Stage.Clear()
            BikerWeedFarm.Plant1.Light.Clear()
            BikerWeedFarm.Plant1.Hose.Enable(false, true)
        end
    },
    Plant2 = {
        Stage = {
            small = "weed_growthb_stage1", medium = "weed_growthb_stage2", full = "weed_growthb_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant2.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant2.Stage.small, BikerWeedFarm.Plant2.Stage.medium, BikerWeedFarm.Plant2.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growthb_stage23_standard", upgrade = "light_growthb_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant2.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant2.Light.basic, BikerWeedFarm.Plant2.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hoseb", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant2.Stage.Set(stage, false)
            BikerWeedFarm.Plant2.Light.Set(upgrade, false)
            BikerWeedFarm.Plant2.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant2.Stage.Clear()
            BikerWeedFarm.Plant2.Light.Clear()
            BikerWeedFarm.Plant2.Hose.Enable(false, true)
        end
    },
    Plant3 = {
        Stage = {
            small = "weed_growthc_stage1", medium = "weed_growthc_stage2", full = "weed_growthc_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant3.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant3.Stage.small, BikerWeedFarm.Plant3.Stage.medium, BikerWeedFarm.Plant3.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growthc_stage23_standard", upgrade = "light_growthc_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant3.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant3.Light.basic, BikerWeedFarm.Plant3.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hosec", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant3.Stage.Set(stage, false)
            BikerWeedFarm.Plant3.Light.Set(upgrade, false)
            BikerWeedFarm.Plant3.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant3.Stage.Clear()
            BikerWeedFarm.Plant3.Light.Clear()
            BikerWeedFarm.Plant3.Hose.Enable(false, true)
        end
    },
    Plant4 = {
        Stage = {
            small = "weed_growthd_stage1", medium = "weed_growthd_stage2", full = "weed_growthd_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant4.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant4.Stage.small, BikerWeedFarm.Plant4.Stage.medium, BikerWeedFarm.Plant4.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growthd_stage23_standard", upgrade = "light_growthd_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant4.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant4.Light.basic, BikerWeedFarm.Plant4.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hosed", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant4.Stage.Set(stage, false)
            BikerWeedFarm.Plant4.Light.Set(upgrade, false)
            BikerWeedFarm.Plant4.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant4.Stage.Clear()
            BikerWeedFarm.Plant4.Light.Clear()
            BikerWeedFarm.Plant4.Hose.Enable(false, true)
        end
    },
    Plant5 = {
        Stage = {
            small = "weed_growthe_stage1", medium = "weed_growthe_stage2", full = "weed_growthe_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant5.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant5.Stage.small, BikerWeedFarm.Plant5.Stage.medium, BikerWeedFarm.Plant5.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growthe_stage23_standard", upgrade = "light_growthe_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant5.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant5.Light.basic, BikerWeedFarm.Plant5.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hosee", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant5.Stage.Set(stage, false)
            BikerWeedFarm.Plant5.Light.Set(upgrade, false)
            BikerWeedFarm.Plant5.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant5.Stage.Clear()
            BikerWeedFarm.Plant5.Light.Clear()
            BikerWeedFarm.Plant5.Hose.Enable(false, true)
        end
    },
    Plant6 = {
        Stage = {
            small = "weed_growthf_stage1", medium = "weed_growthf_stage2", full = "weed_growthf_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant6.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant6.Stage.small, BikerWeedFarm.Plant6.Stage.medium, BikerWeedFarm.Plant6.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growthf_stage23_standard", upgrade = "light_growthf_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant6.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant6.Light.basic, BikerWeedFarm.Plant6.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hosef", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant6.Stage.Set(stage, false)
            BikerWeedFarm.Plant6.Light.Set(upgrade, false)
            BikerWeedFarm.Plant6.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant6.Stage.Clear()
            BikerWeedFarm.Plant6.Light.Clear()
            BikerWeedFarm.Plant6.Hose.Enable(false, true)
        end
    },
    Plant7 = {
        Stage = {
            small = "weed_growthg_stage1", medium = "weed_growthg_stage2", full = "weed_growthg_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant7.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant7.Stage.small, BikerWeedFarm.Plant7.Stage.medium, BikerWeedFarm.Plant7.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growthg_stage23_standard", upgrade = "light_growthg_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant7.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant7.Light.basic, BikerWeedFarm.Plant7.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hoseg", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant7.Stage.Set(stage, false)
            BikerWeedFarm.Plant7.Light.Set(upgrade, false)
            BikerWeedFarm.Plant7.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant7.Stage.Clear()
            BikerWeedFarm.Plant7.Light.Clear()
            BikerWeedFarm.Plant7.Hose.Enable(false, true)
        end
    },
    Plant8 = {
        Stage = {
            small = "weed_growthh_stage1", medium = "weed_growthh_stage2", full = "weed_growthh_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant8.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant8.Stage.small, BikerWeedFarm.Plant8.Stage.medium, BikerWeedFarm.Plant8.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growthh_stage23_standard", upgrade = "light_growthh_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant8.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant8.Light.basic, BikerWeedFarm.Plant8.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hoseh", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant8.Stage.Set(stage, false)
            BikerWeedFarm.Plant8.Light.Set(upgrade, false)
            BikerWeedFarm.Plant8.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant8.Stage.Clear()
            BikerWeedFarm.Plant8.Light.Clear()
            BikerWeedFarm.Plant8.Hose.Enable(false, true)
        end
    },
    Plant9 = {
        Stage = {
            small = "weed_growthi_stage1", medium = "weed_growthi_stage2", full = "weed_growthi_stage3",
            Set = function(stage, refresh)
                BikerWeedFarm.Plant9.Stage.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, stage, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant9.Stage.small, BikerWeedFarm.Plant9.Stage.medium, BikerWeedFarm.Plant9.Stage.full}, false, refresh)
            end
        },
        Light = {
            basic = "light_growthi_stage23_standard", upgrade = "light_growthi_stage23_upgrade",
            Set = function(light, refresh)
                BikerWeedFarm.Plant9.Light.Clear(false)
                SetIplPropState(BikerWeedFarm.interiorId, light, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(BikerWeedFarm.interiorId, {BikerWeedFarm.Plant9.Light.basic, BikerWeedFarm.Plant9.Light.upgrade}, false, refresh)
            end
        },
        Hose = {
            Enable = function (state, refresh)
                SetIplPropState(BikerWeedFarm.interiorId, "weed_hosei", state, refresh)
            end
        },
        Set = function(stage, upgrade, refresh)
            BikerWeedFarm.Plant9.Stage.Set(stage, false)
            BikerWeedFarm.Plant9.Light.Set(upgrade, false)
            BikerWeedFarm.Plant9.Hose.Enable(true, true)
        end,
        Clear = function(refresh)
            BikerWeedFarm.Plant9.Stage.Clear()
            BikerWeedFarm.Plant9.Light.Clear()
            BikerWeedFarm.Plant9.Hose.Enable(false, true)
        end
    },
    Details = {
        production = "weed_production",		-- Weed on the tables
        fans = "weed_set_up",				-- Fans + mold buckets
        drying = "weed_drying",				-- Drying weed hooked to the ceiling
        chairs = "weed_chairs",				-- Chairs at the tables
        Enable = function (details, state, refresh)
            SetIplPropState(BikerWeedFarm.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        BikerWeedFarm.Ipl.Interior.Load()
        BikerWeedFarm.Style.Set(BikerWeedFarm.Style.upgrade)
        BikerWeedFarm.Security.Set(BikerWeedFarm.Security.basic)
        BikerWeedFarm.Details.Enable(BikerWeedFarm.Details.drying, false)
        BikerWeedFarm.Details.Enable(BikerWeedFarm.Details.chairs, false)
        BikerWeedFarm.Details.Enable(BikerWeedFarm.Details.production, false)

        BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.production, BikerWeedFarm.Details.chairs, BikerWeedFarm.Details.drying}, true)

        BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.medium, BikerWeedFarm.Plant1.Light.basic)
        BikerWeedFarm.Plant2.Set(BikerWeedFarm.Plant2.Stage.full, BikerWeedFarm.Plant2.Light.basic)
        BikerWeedFarm.Plant3.Set(BikerWeedFarm.Plant3.Stage.medium, BikerWeedFarm.Plant3.Light.basic)
        BikerWeedFarm.Plant4.Set(BikerWeedFarm.Plant4.Stage.full, BikerWeedFarm.Plant4.Light.basic)
        BikerWeedFarm.Plant5.Set(BikerWeedFarm.Plant5.Stage.medium, BikerWeedFarm.Plant5.Light.basic)
        BikerWeedFarm.Plant6.Set(BikerWeedFarm.Plant6.Stage.full, BikerWeedFarm.Plant6.Light.basic)
        BikerWeedFarm.Plant7.Set(BikerWeedFarm.Plant7.Stage.medium, BikerWeedFarm.Plant7.Light.basic)
        BikerWeedFarm.Plant8.Set(BikerWeedFarm.Plant8.Stage.full, BikerWeedFarm.Plant8.Light.basic)
        BikerWeedFarm.Plant9.Set(BikerWeedFarm.Plant9.Stage.full, BikerWeedFarm.Plant9.Light.basic)

        RefreshInterior(BikerWeedFarm.interiorId)
    end
}

    -- ====================================================================
    -- =------------------- [dlc_afterhours_roberto] ---------------------=
    -- ====================================================================

    -- Nightclub: -1604.664 -3012.583 -78.000

exports('GetAfterHoursNightclubsObject', function()
    return AfterHoursNightclubs
end)

AfterHoursNightclubs = {
    interiorId = 271617,

    Ipl = {
        Interior = {
            ipl = "ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_",
            Load = function() EnableIpl(AfterHoursNightclubs.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(AfterHoursNightclubs.Ipl.Interior.ipl, false) end
        },
    },

    Interior = {
        Name = {
            galaxy = "Int01_ba_clubname_01", studio = "Int01_ba_clubname_02", omega = "Int01_ba_clubname_03",
            technologie = "Int01_ba_clubname_04", gefangnis = "Int01_ba_clubname_05", maisonette = "Int01_ba_clubname_06",
            tony = "Int01_ba_clubname_07", palace = "Int01_ba_clubname_08", paradise = "Int01_ba_clubname_09",
            Set = function(name, refresh)
                AfterHoursNightclubs.Interior.Name.Clear(false)
                SetIplPropState(AfterHoursNightclubs.interiorId, name, true, refresh)
            end,
            Clear = function(refresh)
                for key, value in pairs(AfterHoursNightclubs.Interior.Name) do
                    if (type(value) == "string") then
                        SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                    end
                end
            end
        },
        Style = {
            trad = "Int01_ba_Style01", edgy = "Int01_ba_Style02", glam = "Int01_ba_Style03",
            Set = function(style, refresh)
                AfterHoursNightclubs.Interior.Style.Clear(false)
                SetIplPropState(AfterHoursNightclubs.interiorId, style, true, refresh)
            end,
            Clear = function(refresh)
                for key, value in pairs(AfterHoursNightclubs.Interior.Style) do
                    if (type(value) == "string") then
                        SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                    end
                end
            end
        },
        Podium = {
            none = "", trad = "Int01_ba_style01_podium", edgy = "Int01_ba_style02_podium", glam = "Int01_ba_style03_podium",
            Set = function(podium, refresh)
                AfterHoursNightclubs.Interior.Podium.Clear(false)
                SetIplPropState(AfterHoursNightclubs.interiorId, podium, true, refresh)
            end,
            Clear = function(refresh)
                for key, value in pairs(AfterHoursNightclubs.Interior.Podium) do
                    if (type(value) == "string") then
                        SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                    end
                end
            end
        },
        Speakers = {
            none = "", basic = "Int01_ba_equipment_setup", upgrade = {"Int01_ba_equipment_setup", "Int01_ba_equipment_upgrade"},
            Set = function(speakers, refresh)
                AfterHoursNightclubs.Interior.Speakers.Clear(false)
                SetIplPropState(AfterHoursNightclubs.interiorId, speakers, true, refresh)
            end,
            Clear = function(refresh)
                for key, value in pairs(AfterHoursNightclubs.Interior.Speakers) do
                    if (type(value) == "string") then
                        SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                    end
                end
            end
        },
        Security = {
            off = "", on = "Int01_ba_security_upgrade",
            Set = function(security, refresh)
                AfterHoursNightclubs.Interior.Security.Clear(false)
                SetIplPropState(AfterHoursNightclubs.interiorId, security, true, refresh)
            end,
            Clear = function(refresh)
                SetIplPropState(AfterHoursNightclubs.interiorId, AfterHoursNightclubs.Interior.Security.on, false, refresh)
            end
        },
        Turntables = {
            none = "", style01 = "Int01_ba_dj01", style02 = "Int01_ba_dj02", style03 = "Int01_ba_dj03", style04 = "Int01_ba_dj04",
            Set = function(turntables, refresh)
                AfterHoursNightclubs.Interior.Turntables.Clear(false)
                if turntables ~= "" then
                    SetIplPropState(AfterHoursNightclubs.interiorId, turntables, true, refresh)
                else
                    if (refresh) then RefreshInterior(AfterHoursNightclubs.interiorId) end
                end
            end,
            Clear = function(refresh)
                for key, value in pairs(AfterHoursNightclubs.Interior.Turntables) do
                    if (type(value) == "string") then
                        SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                    end
                end
            end
        },
        Lights = {
            Droplets = {
                yellow = "DJ_01_Lights_01", green = "DJ_02_Lights_01", white = "DJ_03_Lights_01", purple = "DJ_04_Lights_01",
                Set = function(light, refresh)
                    AfterHoursNightclubs.Interior.Lights.Droplets.Clear(false)
                    SetIplPropState(AfterHoursNightclubs.interiorId, light, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(AfterHoursNightclubs.Interior.Lights.Droplets) do
                        if (type(value) == "string") then
                            SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            Neons = {
                yellow = "DJ_01_Lights_02", white = "DJ_02_Lights_02", purple = "DJ_03_Lights_02", cyan = "DJ_04_Lights_02",
                Set = function(light, refresh)
                    AfterHoursNightclubs.Interior.Lights.Neons.Clear(false)
                    SetIplPropState(AfterHoursNightclubs.interiorId, light, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(AfterHoursNightclubs.Interior.Lights.Neons) do
                        if (type(value) == "string") then
                            SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            Bands = {
                yellow = "DJ_01_Lights_03", green = "DJ_02_Lights_03", white = "DJ_03_Lights_03", cyan = "DJ_04_Lights_03",
                Set = function(light, refresh)
                    AfterHoursNightclubs.Interior.Lights.Bands.Clear(false)
                    SetIplPropState(AfterHoursNightclubs.interiorId, light, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(AfterHoursNightclubs.Interior.Lights.Bands) do
                        if (type(value) == "string") then
                            SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            Lasers = {
                yellow = "DJ_01_Lights_04", green = "DJ_02_Lights_04", white = "DJ_03_Lights_04", purple = "DJ_04_Lights_04",
                Set = function(light, refresh)
                    AfterHoursNightclubs.Interior.Lights.Lasers.Clear(false)
                    SetIplPropState(AfterHoursNightclubs.interiorId, light, true, refresh)
                end,
                Clear = function(refresh)
                    for key, value in pairs(AfterHoursNightclubs.Interior.Lights.Lasers) do
                        if (type(value) == "string") then
                            SetIplPropState(AfterHoursNightclubs.interiorId, value, false, refresh)
                        end
                    end
                end
            },
            Clear = function()
                AfterHoursNightclubs.Interior.Lights.Droplets.Clear()
                AfterHoursNightclubs.Interior.Lights.Neons.Clear()
                AfterHoursNightclubs.Interior.Lights.Bands.Clear()
                AfterHoursNightclubs.Interior.Lights.Lasers.Clear()
            end
        },
        Bar = {
            Enable = function(state, refresh)
                SetIplPropState(AfterHoursNightclubs.interiorId, "Int01_ba_bar_content", state, refresh)
            end
        },
        Booze = {
            A = "Int01_ba_booze_01", B = "Int01_ba_booze_02", C = "Int01_ba_booze_03",
            Enable = function (booze, state, refresh)
                if (IsTable(booze)) then
                    for key, value in pairs(booze) do
                        if (type(value) == "string") then
                            SetIplPropState(AfterHoursNightclubs.interiorId, booze, state, refresh)
                        end
                    end
                else
                    SetIplPropState(AfterHoursNightclubs.interiorId, booze, state, refresh)
                end
            end
        },
        Trophy = {
            Color = {bronze = 0, silver = 1, gold = 2},
            number1 = "Int01_ba_trophy01",
            battler = "Int01_ba_trophy02",
            dancer = "Int01_ba_trophy03",
            Enable = function (trophy, state, color, refresh)
                SetIplPropState(AfterHoursNightclubs.interiorId, trophy, state, refresh)
                SetInteriorPropColor(AfterHoursNightclubs.interiorId, trophy, color)
            end
        },
        DryIce = {
            scale = 5.0,
            Emitters = {
                {pos = {x = -1602.932, y = -3019.1, z = -79.99}, rot = {x = 0.0, y = -10.0, z = 66.0}},
                {pos = {x = -1593.238, y = -3017.05, z = -79.99}, rot = {x = 0.0, y = -10.0, z = 110.0}},
                {pos = {x = -1597.134, y = -3008.2, z = -79.99}, rot = {x = 0.0, y = -10.0, z = -122.53}},
                {pos = {x = -1589.966, y = -3008.518, z = -79.99}, rot = {x = 0.0, y = -10.0, z = -166.97}}
            },
            Enable = function(state)
                if (state) then
                    RequestNamedPtfxAsset("scr_ba_club")
                    while not HasNamedPtfxAssetLoaded("scr_ba_club") do
                        Wait(0)
                    end
                    for key, emitter in pairs(AfterHoursNightclubs.Interior.DryIce.Emitters) do
                        UseParticleFxAssetNextCall("scr_ba_club")
                        StartParticleFxLoopedAtCoord("scr_ba_club_smoke_machine", emitter.pos.x, emitter.pos.y, emitter.pos.z, emitter.rot.x, emitter.rot.y, emitter.rot.z, AfterHoursNightclubs.Interior.DryIce.scale, false, false, false, true)
                    end
                else
                    local radius = 1.0
                    for key, emitter in pairs(AfterHoursNightclubs.Interior.DryIce.Emitters) do
                        RemoveParticleFxInRange(emitter.pos.x, emitter.pos.y, emitter.pos.z, radius)
                    end
                end
            end,
        },
        Details = {
            clutter = "Int01_ba_Clutter",               -- Clutter and graffitis
            worklamps = "Int01_ba_Worklamps",           -- Work lamps + trash
            truck = "Int01_ba_deliverytruck",           -- Truck parked in the garage
            dryIce = "Int01_ba_dry_ice",                -- Dry ice machines (no effects)
            lightRigsOff = "light_rigs_off",            -- All light rigs at once but turned off
            roofLightsOff = "Int01_ba_lightgrid_01",    -- Fake lights
            floorTradLights = "Int01_ba_trad_lights",   -- Floor lights meant to go with the trad style
            chest = "Int01_ba_trophy04",                -- Chest on the VIP desk
            vaultAmmunations = "Int01_ba_trophy05",     -- (inside vault) Ammunations
            vaultMeth = "Int01_ba_trophy07",            -- (inside vault) Meth bag
            vaultFakeID = "Int01_ba_trophy08",          -- (inside vault) Fake ID
            vaultWeed = "Int01_ba_trophy09",            -- (inside vault) Opened weed bag
            vaultCoke = "Int01_ba_trophy10",            -- (inside vault) Coke doll
            vaultCash = "Int01_ba_trophy11",            -- (inside vault) Scrunched fake money 
            Enable = function (details, state, refresh)
                SetIplPropState(AfterHoursNightclubs.interiorId, details, state, refresh)
            end
        }
    },

    -- 760, -1337, 27
    Mesa = { 
        id = 0,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.Mesa.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.Mesa.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.Mesa.id)
            end
        }
    },

    -- 348, -979, 30
    MissionRow = { 
        id = 1,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.MissionRow.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.MissionRow.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.MissionRow.id)
            end
        }
    },

    -- -118, -1260, 30
    Strawberry = { 
        id = 2,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.Strawberry.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.Strawberry.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.Strawberry.id)
            end
        }
    },

    -- 9, 221, 109
    VinewoodWest = { 
        id = 3,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.VinewoodWest.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.VinewoodWest.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.VinewoodWest.id)
            end
        }
    },

    -- 868, -2098, 31
    Cypress = { 
        id = 4,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.Cypress.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.Cypress.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.Cypress.id)
            end
        }
    },

    -- -1287, -647, 27
    DelPerro = { 
        id = 5,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.DelPerro.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.DelPerro.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.DelPerro.id)
            end
        }
    },

    -- -680, -2461, 14
    Airport = { 
        id = 6,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.Airport.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.Airport.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.Airport.id)
            end
        }
    },

    -- 192, -3168, 6
    Elysian = { 
        id = 7,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.Elysian.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.Elysian.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.Elysian.id)
            end
        }
    },

    -- 373, 254, 103
    Vinewood = { 
        id = 8,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.Vinewood.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.Vinewood.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.Vinewood.id)
            end
        }
    },

    -- -1171, -1150, 6
    Vespucci = { 
        id = 9,
        Barrier = {
            Enable = function(state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Barrier.Enable(AfterHoursNightclubs.Vespucci.id, state)
            end
        },
        Posters = {
            Enable = function(poster, state)
                if (state == nil) then state = true end
                AfterHoursNightclubs.Posters.Enable(AfterHoursNightclubs.Vespucci.id, poster, state)
            end,
            Clear = function()
                AfterHoursNightclubs.Posters.Clear(AfterHoursNightclubs.Vespucci.id)
            end
        }
    },

    Barrier = {
        barrier = "ba_barriers_caseX",
        Enable = function(clubId, state)
            value = AfterHoursNightclubs.Barrier.barrier:gsub("caseX", "case" .. tostring(clubId))
            EnableIpl(value, state)
        end
    },
    Posters = {
        forSale = "ba_caseX_forsale",
        dixon = "ba_caseX_dixon",
        madonna = "ba_caseX_madonna",
        solomun = "ba_caseX_solomun",
        taleOfUs = "ba_caseX_taleofus",

        Enable = function(clubId, poster, state)
            if (IsTable(poster)) then
                for key, value in pairs(poster) do
                    if (type(value) == "string") then
                        value = value:gsub("caseX", "case" .. tostring(clubId))
                        EnableIpl(value, state)
                    end
                end
            else
                poster = poster:gsub("caseX", "case" .. tostring(clubId))
                EnableIpl(poster, state)
            end
        end,
        Clear = function(clubId)
            for key, value in pairs(AfterHoursNightclubs.Posters) do
                if (type(value) == "string") then
                    value = value:gsub("caseX", "case" .. tostring(clubId))
                    EnableIpl(value, false)
                end
            end
        end
    },

    LoadDefault = function()
        -- Interior setup
        AfterHoursNightclubs.Ipl.Interior.Load()
        
        AfterHoursNightclubs.Interior.Name.Set(AfterHoursNightclubs.Interior.Name.galaxy)
        AfterHoursNightclubs.Interior.Style.Set(AfterHoursNightclubs.Interior.Style.edgy)

        AfterHoursNightclubs.Interior.Podium.Set(AfterHoursNightclubs.Interior.Podium.edgy)
        AfterHoursNightclubs.Interior.Speakers.Set(AfterHoursNightclubs.Interior.Speakers.upgrade)

        AfterHoursNightclubs.Interior.Security.Set(AfterHoursNightclubs.Interior.Security.on)
        
        AfterHoursNightclubs.Interior.Turntables.Set(AfterHoursNightclubs.Interior.Turntables.style01)
        AfterHoursNightclubs.Interior.Lights.Bands.Set(AfterHoursNightclubs.Interior.Lights.Bands.cyan)

        AfterHoursNightclubs.Interior.Bar.Enable(true)

        AfterHoursNightclubs.Interior.Booze.Enable(AfterHoursNightclubs.Interior.Booze, true)

        AfterHoursNightclubs.Interior.Trophy.Enable(AfterHoursNightclubs.Interior.Trophy.number1, true, AfterHoursNightclubs.Interior.Trophy.Color.gold)

        RefreshInterior(AfterHoursNightclubs.interiorId)


        -- Exterior IPL
        AfterHoursNightclubs.Mesa.Barrier.Enable(true)
        AfterHoursNightclubs.Mesa.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.Mesa.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)
        
        AfterHoursNightclubs.MissionRow.Barrier.Enable(true)
        AfterHoursNightclubs.MissionRow.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.MissionRow.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)

        AfterHoursNightclubs.Strawberry.Barrier.Enable(true)
        AfterHoursNightclubs.Strawberry.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.Strawberry.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)

        AfterHoursNightclubs.VinewoodWest.Barrier.Enable(true)
        AfterHoursNightclubs.VinewoodWest.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.VinewoodWest.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)

        AfterHoursNightclubs.Cypress.Barrier.Enable(true)
        AfterHoursNightclubs.Cypress.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.Cypress.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)

        AfterHoursNightclubs.DelPerro.Barrier.Enable(true)
        AfterHoursNightclubs.DelPerro.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.DelPerro.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)

        AfterHoursNightclubs.Airport.Barrier.Enable(true)
        AfterHoursNightclubs.Airport.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.Airport.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)

        AfterHoursNightclubs.Elysian.Barrier.Enable(true)
        AfterHoursNightclubs.Elysian.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.Elysian.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)

        AfterHoursNightclubs.Vinewood.Barrier.Enable(true)
        AfterHoursNightclubs.Vinewood.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.Vinewood.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)
        
        AfterHoursNightclubs.Vespucci.Barrier.Enable(true)
        AfterHoursNightclubs.Vespucci.Posters.Enable(AfterHoursNightclubs.Posters, true)
        AfterHoursNightclubs.Vespucci.Posters.Enable(AfterHoursNightclubs.Posters.forSale, false)
    end
}
