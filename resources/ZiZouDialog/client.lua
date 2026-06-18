local debugMode = true -- Enables a command " /testdialog " to test the script

local dialogOpen = false
local currDialog = nil
local currFS = {}
local currFC = {}

function showDialog(name, label, input, help, submitFunc, cancelFunc, textarea)
	if not dialogOpen then
		currDialog = name
		currFS = submitFunc
		currFC = cancelFunc
		SetNuiFocus(true,true)
		if textarea == nil then
			textarea = false
		end
		SendNUIMessage({
			action = "showDialog",
			menuAction = name,
			label = label,
			defaultInput = input,
			helpText = help,
			textarea = textarea,
		})
		dialogOpen = true
	else
		print('^1dialog box already open!')
	end
end

RegisterNUICallback('exit', function(data)
	SetNuiFocus(false, false)
	dialogOpen = false
	currDialog = nil
	currFS = nil
	currFC = nil
end)

RegisterNUICallback('submit', function(data)
	SetNuiFocus(false, false)
	dialogOpen = false
	if data.currMA == currDialog then -- Cette ligne évite que le script soit déclenché par quelqu'un utilisant les outils de développement NUI de FiveM
		local doSubmitFunction = currFS
		currDialog = nil
		currFS = nil
		currFC = nil
		doSubmitFunction(data.text)
	else
		-- Si ce n'est pas le bon dialog, tu peux y mettre une action ici, si nécessaire
	end
end)


if debugMode then
	RegisterCommand('testdialog', function(src, args)
		showDialog('unique_dialog_name', 'Enter amount of cash:', '0', 'Hint!', testFuncSubmit, testFuncCancel, true)
	end)
	function testFuncSubmit(data)
		print('You submitted the following text: ^1'..data)
	end
	function testFuncCancel()
		print('CANCELED')
	end
end
