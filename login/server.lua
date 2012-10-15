-- Login handling
function loginPlayer(username,password,enableKickPlayer,attemptedLogins,maxLoginAttempts)
	if (username == "") or (password == "") then
		outputChatBox ("#0000FF* #FFFFFFError! Please fill out all the boxes!",source,255,255,255,true)
	else
		local account = getAccount ( username, password )
		if ( account == true ) then
			logIn (source, account, password)
			outputChatBox ("#0000FF* #FFFFFFYou have sucessfully logged in!",source,255,255,255,true)
			setTimer(outputChatBox,700,1,"#0000FF* #FFFFFFTo enable auto-login, use #ABCDEF/enableauto#FFFFFF!",source,255,255,255,true)
			triggerClientEvent (source,"hideLoginWindow",getRootElement())
		else
			if enableKickPlayer == true then
				if (attemptedLogins >= maxLoginAttempts-1) then
					outputChatBox ("#0000FF* #FFFFFFError! Wrong username and/or password!",source,255,255,255,true)
					setTimer(outputChatBox,500,1,"#0000FF* #FFFFFFWarning! Maximum login attempts reached! [#008AFF"..attemptedLogins+1 .."/"..maxLoginAttempts.."#FFFFFF]",source,255,255,255,true)
					setTimer(outputChatBox,1000,1,"#0000FF* #FFFFFFYou will be kicked in #008AFF5 seconds#FFFFFF!",source,255,255,255,true)
					setTimer(kickPlayer,5000,1,source,"Failed to login")
				else
					outputChatBox ("#0000FF* #FFFFFFError! Wrong username and/or password!",source,255,255,255,true)
					setTimer(outputChatBox,500,1,"#0000FF* #FFFFFFLogin attempts: [#008AFF"..attemptedLogins+1 .."/"..maxLoginAttempts.."#FFFFFF]",source,255,255,255,true)
					triggerClientEvent(source,"onRequestIncreaseAttempts",source)
				end
			else
				outputChatBox ("#0000FF* #FFFFFFError! Wrong username and/or password!",source,255,255,255,true)
			end
		end
	end
end

-- Registration here
function registerPlayer(username,password,passwordConfirm)
	if (username == "") or (password == "") or (passwordConfirm == "") then
		outputChatBox ("#0000FF* #FFFFFFError! Please fill out all the boxes!",source,255,255,255,true)
	elseif password ~= passwordConfirm then
		outputChatBox ("#0000FF* #FFFFFFError! Passwords do not match!",source,255,255,255,true)
	else
		local account = getAccount (username,password)
		if (account == false) then
			local accountAdded = addAccount(tostring(username),tostring(password))
			if (accountAdded) then
				triggerClientEvent(source,"hideRegisterWindow",getRootElement())
				outputChatBox ("#0000FF* #FFFFFFYou have sucessfuly registered! [Username: #ABCDEF" .. username .. " #FF0000| #FFFFFFPassword: #ABCDEF******#FFFFFF]",source,255,255,255,true )
				setTimer(outputChatBox,800,1,"#0000FF* #FFFFFFYou can now login with your new account.",source,255,255,255,true )
				setAccountData (account, "rpg-money", "1000")
				setAccountData (account, "rpg-skin", "0")
			else
				outputChatBox ("#0000FF* #FFFFFFAn unknown error has occured! Please choose a different username and try again.",source,255,255,255,true )
			end
		else
			outputChatBox ("#0000FF* #FFFFFFError! An account with this username already exists!",source,255,255,255,true )
		end
	end
end

-- Auto-login handling
function autologinPlayer(username,password)
	if (username == "") or (password == "") then
		outputChatBox ("#FF0000* #FFFFFFAuto-login error - Failed to retrieve username or password",source,255,255,255,true)
	else
		local account = getAccount ( username, password )
		if not (account == false) then
			logIn (source, account, password)
			outputChatBox("#0000FF* #FFFFFFYou have been automatically logged in.",source,255,255,255,true)
			setTimer(outputChatBox,1000,1,"#0000FF* #FFFFFFTo disable auto-login, use #ABCDEF/disableauto.",source,255,255,255,true)
			triggerClientEvent ( source, "hideLoginWindow", getRootElement())
		else
			outputChatBox ("#FF0000* #FFFFFFAuto-login error - Username & password do not match",source,255,255,255,true)
		end
	end
end

-- When the player logs out, trigger the client event to check if the login panel will request them to login again
function logoutHandler()
	triggerClientEvent(source,"onRequestDisplayPanel",source)
end
addEventHandler("onPlayerLogout",getRootElement(),logoutHandler)

-- Get the server's name
function getData()
	local sName = md5(getServerName())
	local sName = string.sub(sName,0,15)
	triggerClientEvent(source,"onGetServerData",getRootElement(),sName)
end

addEvent("onRequestLogin",true)
addEvent("onRequestRegister",true)
addEvent("onRequestAutologin",true)
addEvent("onClientLoginLoaded",true)
addEventHandler("onRequestLogin",getRootElement(),loginPlayer)
addEventHandler("onRequestRegister",getRootElement(),registerPlayer)
addEventHandler("onRequestAutologin",getRootElement(),autologinPlayer)
addEventHandler("onClientLoginLoaded",getRootElement(),getData)