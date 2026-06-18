local SexOptions = {"Choisir", "Homme", "Femme"}

local fov = 70
local disabledControls = {
    30,     -- A and D (Character Movement)
    31,     -- W and S (Character Movement)
    21,     -- LEFT SHIFT
    36,     -- LEFT CTRL
    22,     -- SPACE
    44,     -- Q
    38,     -- E
    71,     -- W (Vehicle Movement)
    72,     -- S (Vehicle Movement)
    59,     -- A and D (Vehicle Movement)
    60,     -- LEFT SHIFT and LEFT CTRL (Vehicle Movement)
    85,     -- Q (Radio Wheel)
    86,     -- E (Vehicle Horn)
    37,     -- Controller R1 (PS) / RT (XBOX)
    80,     -- Controller O (PS) / B (XBOX)
    228,    -- 
    229,    -- 
    166,    -- F5
    167,    -- F6
    311,    -- K
    37,     -- 
    44,     -- 
    178,    -- 
    244,    -- 
}

letmeregister = false

local initialCam = { 
	posX = 313.88,
	posY = 826.46,
	posZ = 418.03,

	rotX = 0.0,
	rotY = 0.0,
	rotZ = -60.0
}

local camActive = false
local cam = nil
local inSkinCam = false

CreatorData = {
    Identity = {
        FirstName = "",
        LastName = "",
        DOB = "",
        Height = 0,
        Sex = ""
    },
    Skin = {}
}

IdentityValidated = false
SkinValidated = false

function OpenCreatorMenu(gotstart)
    PlayerCreatorMenu = {
        Base = { Title = "Creation", HeaderColor = {57, 57, 57}, Blocked = true},
        Data = { currentMenu = "creation" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
	if btn.action == 'infos' then
    if IdentityValidated then
      ESX.ShowNotification('⚠️ Vous ne pouvez pas modifier votre identité')
      return
  end
        OpenMenu('identite')
    elseif btn.action == 'skin' then
      if not IdentityValidated then
        ESX.ShowNotification('⚠️ Veuillez créer une identité')
        return
    end
        TriggerEvent('caruiskinchanger:getSkin', function(skin)
            LastSkin = skin
        end)
    
        TriggerEvent('caruiskinchanger:getData', function(components, maxVals)
            local elements    = {}
            local _components = {}

            PlayerCreatorMenu.Menu['perso'].b = {}
    
            -- Restrict menu
              for i=1, #components, 1 do
                _components[i] = components[i]
              end
    
            table.insert(PlayerCreatorMenu.Menu['perso'].b, {
                name     = '~g~Valider Mon Skin~s~',
                action = 'validerskin', 
                ask = "→", 
                askX = true
            })
    
            table.insert(PlayerCreatorMenu.Menu['perso'].b, {
                name     = '~r~Annuler~s~',
                action = 'cancelskin', 
                ask = "→", 
                askX = true
            })
    
            -- Insert elements
            for i=1, #_components, 1 do
                local value       = _components[i].value
                local componentId = _components[i].componentId
    
                if componentId == 0 then
                    value = GetPedPropIndex(playerPed, _components[i].componentId)
                end
    
                local data = {
                    name     = _components[i].label,
                    compname      = _components[i].name,
                    value     = value,
                    min       = _components[i].min,
                    textureof = _components[i].textureof,
                    zoomOffset= _components[i].zoomOffset,
                    camOffset = _components[i].camOffset,
                    type      = 'slider'
                }
    
                for k,v in pairs(maxVals) do
                    if k == _components[i].name then
                        data.slidemax = v
                        break
                    end
                end
    
                if data.compname ~= "sex" then
                table.insert(PlayerCreatorMenu.Menu['perso'].b, data)
                end
            end
            StopRegisterCamera()
            OpenMenu('perso')
            if CreatorData.Identity.Sex == "m" then
            TriggerEvent('caruiskinchanger:change', "sex", 0)	  
            elseif CreatorData.Identity.Sex == "f" then
              TriggerEvent('caruiskinchanger:change', "sex", 1)
            end
            zoomOffset = _components[1].zoomOffset
            camOffset = _components[1].camOffset	
            CreateSkinCam()	
            inSkinCam = true
        end)
    elseif btn.action == 'validerskin' then
            TriggerEvent('caruiskinchanger:getSkin', function(skin)
                CreatorData.Skin = skin
                SkinValidated = true
                CloseMenu(true)
                DeleteSkinCam()
                inSkinCam = false
                Wait(500)
                CreateMenu(PlayerCreatorMenu)
            end)
    elseif btn.action == 'cancelskin' then
            if ESX.PlayerData.skin == nil then
                TriggerEvent('caruiskinchanger:loadSkin', {sex = 0})
            else
                TriggerEvent('caruiskinchanger:loadSkin', ESX.PlayerData.skin)	
            end
            CloseMenu(true)
            DeleteSkinCam()
            inSkinCam = false
            Wait(500)
            CreateMenu(PlayerCreatorMenu)
    elseif btn.action == 'clothes' then
        OpenMenu('vetements')
    elseif btn.action == "firstname" then
      local text = KeyboardInput("IDENTITY_FIRSTNAME", "Votre prénom ?", "", 25)
      if text and text ~= "" then
          local reason = verifyName(text)
          if reason == "" then
              CreatorData.Identity.FirstName = text
              PlayerCreatorMenu.Menu["identite"].b[1].name = text
          else
              ESX.ShowNotification(reason)
          end
      else
          ESX.ShowNotification("Veuillez entrer un prénom valide.")
      end
      
		
	  elseif btn.action == "lastname" then
      local text = KeyboardInput("IDENTITY_LASTNAME", "Votre nom ?", "", 25)
      if text and text ~= "" then
          local reason = verifyName(text)
          if reason == "" then
              CreatorData.Identity.LastName = text
              PlayerCreatorMenu.Menu["identite"].b[2].name = text
          else
              ESX.ShowNotification(reason)
          end
      else
          ESX.ShowNotification("Veuillez entrer un nom valide.")
      end
      

	  elseif btn.action == "birthdays" then
      local text = KeyboardInput("IDENTITY_BIRTHDAYS", "Votre date de naissance ? (00/00/0000)", "", 12)
      if text and text ~= "" then
          -- Vérifier si la date est au format correct (DD/MM/YYYY)
          local isValidDate = text:match("^(%d%d)/(%d%d)/(%d%d%d%d)$") -- Vérifie le format 00/00/0000
          if isValidDate then
              CreatorData.Identity.DOB = text
              PlayerCreatorMenu.Menu["identite"].b[3].name = "Date de naissance: "..text
          else
              ESX.ShowNotification("Veuillez entrer une date de naissance valide au format (00/00/0000).")
          end
      else
          ESX.ShowNotification("Veuillez entrer une date de naissance.")
      end
      

	  elseif btn.action == "height" then
      local text = KeyboardInput("IDENTITY_HEIGHT", "Votre taille ? (entre 140 et 200 uniquement)", "", 3)
      local height = tonumber(text)
      
      if height and height >= 140 and height <= 200 then
          CreatorData.Identity.Height = height
          PlayerCreatorMenu.Menu["identite"].b[4].name = "Taille: "..height.." cm"
      else
          ESX.ShowNotification("⚠️ Taille entre 140cm et 200cm uniquement!")
      end
      

	  elseif btn.action == "sexe" then
		if btn.slidenum == 2 then
            PlayerCreatorMenu.Menu["identite"].b[5].name = "Sexe: Homme"
		  CreatorData.Identity.Sex = "m"
		elseif btn.slidenum == 3 then
            PlayerCreatorMenu.Menu["identite"].b[5].name = "Sexe: Femme"
		  CreatorData.Identity.Sex = "f"
		end
    elseif btn.action == 'validateinfos' then
        if checkIdentity() then
            IdentityValidated = true
            CloseMenu(true)
		    Citizen.Wait(500)
            CreateMenu(PlayerCreatorMenu)
        end
    elseif btn.action == 'validate' then
            if not IdentityValidated then
                ESX.ShowNotification('⚠️ Veuillez créer une identité')
                return
            end
            if not SkinValidated then
                ESX.ShowNotification('⚠️ Veuillez créer un personnage')
                return
            end
            if checkIdentity() then
            CloseMenu(true)
            TriggerServerEvent("creator:setIdentity", CreatorData.Identity)
            TriggerServerEvent('skin:save', CreatorData.Skin)
            SaveSkin()
            TriggerEvent('esx:UpdateSkin', CreatorData.Skin)
            if not gotstart then
              OpenStartPickerMenu()
            else 
              FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
            end
            letmeregister = false
            TriggerServerEvent("creator:putMeInBukket", false)
            end
      end
    end,
    onButtonSelected = function(currentaMenu, k, j, btn, self)
        if btn.zoomOffset and btn.camOffset then

        zoomOffset = btn.zoomOffset
        camOffset = btn.camOffset
        TriggerEvent('skin:ChangeOffset', btn.zoomOffset, btn.camOffset)
        end
    end,
    onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
        if btn.compname and btn.slidenum then
          TriggerEvent('caruiskinchanger:change', btn.compname, btn.slidenum-1)	
        end		
    end
  },

  Menu = {
    ["creation"] = {
      b = {
		{name = "Informations", action = "infos", ask = "→", askX = true},
	  {name = "Personnage", action = "skin", ask = "→", askX = true},
		{name = "~g~Valider mon identité et personnage~s~", action = "validate", ask = "→", askX = true},
      }
    },
    ["identite"] = {
        b = {
            {name = "Votre prénom", action = "firstname", ask = "→", askX = true},
            {name = "Votre nom", action = "lastname", ask = "→", askX = true},
            {name = "Date de naissance", action = "birthdays", ask = "→", askX = true},
            {name = "Taille", action = "height", ask = "→", askX = true},
            {name = "Sexe", action = "sexe", slidemax = SexOptions},
            {name = "~g~Valider mon Identité~s~", action = "validateinfos", ask = "→", askX = true},
        }
      },
    ["perso"] = {
        b = {
        }
    }
  }
}

CreateMenu(PlayerCreatorMenu)
end

 function StartRegisterCamera()
  TriggerEvent('esx:displayHud', false)

	camActive = true

	Citizen.CreateThread(function()
		while camActive do
		  Citizen.Wait(2)
				  DisableFirstPersonCamThisFrame()
				  BlockWeaponWheelThisFrame()
				  for k, v in pairs(disabledControls) do
				  DisableControlAction(0, v, true)
				  end
			HideHudAndRadarThisFrame()
		  end
	  end)

	ClearFocus()

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", initialCam.posX, initialCam.posY, initialCam.posZ, initialCam.rotX, initialCam.rotY, initialCam.rotZ, fov * 1.0)
	SetCamActive(cam, true)
	RenderScriptCams(true, false, 0, true, false)
    	
	SetCamAffectsAiming(cam, false)
	ShakeCam(introcam, "HAND_SHAKE", 0.50)
end

 function StopRegisterCamera()
  DoScreenFadeOut(100)
  Citizen.Wait(100)

	camActive = false

	ClearFocus()

	RenderScriptCams(false, false, 0, true, false)
	DestroyCam(cam, false)
	cam = nil
  SetEntityCoords(ESX.PlayerData.cache.playerped, -555.66, -626.33, 34.68)
  SetEntityHeading(ESX.PlayerData.cache.playerped, 181.82)
	SetEntityVisible(ESX.PlayerData.cache.playerped, true, true)
  DoScreenFadeIn(2500)
end


function DisplayRegister(gotstart)
      if DoesEntityExist(ESX.PlayerData.cache.playerped) and not IsEntityDead(ESX.PlayerData.cache.playerped) then
        IdentityValidated = false
        SkinValidated = false
        SetEntityVisible(ESX.PlayerData.cache.playerped, false)
        FreezeEntityPosition(ESX.PlayerData.cache.playerped, true)
        StartRegisterCamera()
        OpenCreatorMenu(gotstart)
        TriggerServerEvent("creator:putMeInBukket", true)
      end
end

RegisterCommand('register', function()
  if letmeregister or ESX.PlayerData.time < 60 then
  DisplayRegister(true)
  end
end)

Citizen.CreateThread(function()
    while not ESX.PlayerData.PassJoin do
      Citizen.Wait(1000)
    end
    if ESX.PlayerData.identity.firstname == nil or ESX.PlayerData.identity.lastname == nil then
      DisplayRegister()
    end
end)

RegisterNetEvent('esx:MakeMeRegister')
AddEventHandler('esx:MakeMeRegister', function()
  letmeregister = true
end)
