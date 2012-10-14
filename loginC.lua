x,y = guiGetScreenSize()

LoginWin = guiCreateWindow(x/2 - 150,y/2 - 110,300,220,"Identify yourself",false)

TabPanel = guiCreateTabPanel(17,30,261,152,false,LoginWin)

TabLogin = guiCreateTab("Login",TabPanel)
LblUsername = guiCreateLabel(11,27,70,16,"Username",false,TabLogin)
LoginUsername = guiCreateEdit(76,26,171,21,"",false,TabLogin)
LblPassword = guiCreateLabel(11,60,70,16,"Password",false,TabLogin)
LoginPassword = guiCreateEdit(76,58,171,21,"",false,TabLogin)
guiEditSetMasked(LoginPassword,true)

TabRegister = guiCreateTab("Register",TabPanel)
LblRegisterUsername = guiCreateLabel(11,27,70,16,"Username",false,TabRegister)
EditRegisterUsername = guiCreateEdit(76,26,171,21,"",false,TabRegister)
LblRegisterPassword = guiCreateLabel(11,60,70,16,"Password",false,TabRegister)
EditRegisterPassword = guiCreateEdit(76,58,171,21,"",false,TabRegister)
guiEditSetMasked(EditRegisterPassword,true)
LblRegisterEmail = guiCreateLabel(35,92,35,16,"Email",false,TabRegister)
EditRegisterEmail = guiCreateEdit(76,90,171,21,"",false,TabRegister)

BtnAction = guiCreateButton(182,188,95,19,"Go",false,LoginWin)

guiSetVisible(LoginWin, false)

local localPlayer = getLocalPlayer()

function receiveVars( allow, email)

	local playername = getPlayerName(localPlayer)
	
	guiSetText(LoginUsername, "")
	guiSetText(EditRegisterUsername, "")
	
	if (email == "false") then
		guiSetVisible(LblRegisterEmail, false)
		guiSetVisible(EditRegisterEmail, false)
	end
	
	if (allow == "false") then
		guiDeleteTab(TabRegister, TabPanel)
	end
	
	guiSetSelectedTab(TabPanel, TabLogin)
	guiSetText(LoginUsername, playername)
	guiSetText(EditRegisterUsername, playername)

	guiSetVisible(LoginWin, true)
	guiBringToFront(LoginWin)
	
	guiSetInputEnabled(true)
	showCursor(true)
end
addEvent( "onSendVars", true )
addEventHandler( "onSendVars", getRootElement(), receiveVars )

function windowHandler()
	triggerServerEvent("onNeedVars", getLocalPlayer())
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), windowHandler)

function onClickBtn(button, state)
	if(button == "left" and state == "up") then
		if(source == BtnAction) then
			if(guiGetSelectedTab(TabPanel) == TabLogin) then
				triggerServerEvent("on4XLogin", getRootElement(), localPlayer, guiGetText(LoginUsername), guiGetText(LoginPassword))
			else
				triggerServerEvent("on4XRegister", getRootElement(), localPlayer, guiGetText(EditRegisterUsername), guiGetText(EditRegisterPassword), guiGetText(EditRegisterEmail))
			end
		end
	end
end
addEventHandler("onClientGUIClick", BtnAction, onClickBtn, false)

function hideLoginWindow()
	guiSetInputEnabled(false)
	guiSetVisible(LoginWin, false)
	showCursor(false)
end
addEvent("hideLoginWindow", true)
addEventHandler("hideLoginWindow", getRootElement(), hideLoginWindow)