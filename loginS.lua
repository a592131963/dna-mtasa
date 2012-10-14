function on4XLogin ( player, user, pass )
	local account = getAccount ( user, pass )
	if ( account ~= false ) then
		if ( not isGuestAccount ( account ) ) then -- For every player that's logged in....
			logOut ( player ) -- Log them out.
		end
		
		if (logIn ( player, account, pass ) == true) then
			triggerClientEvent ( player, "hideLoginWindow", getRootElement())
		else
			outputChatBox ( "Login error!", player, 255, 255, 0 ) -- Output they got the details wrong.
		end
	else
		outputChatBox ( "Wrong username or password!", player, 255, 255, 0 ) -- Output they got the details wrong.
	end
end
addEvent( "on4XLogin", true )
addEventHandler( "on4XLogin", getRootElement(), on4XLogin )

function on4XRegister ( player, user, pass, email )
	local account = getAccount ( user, pass )
	if ( account ~= false ) then
		if (logIn ( player, account, pass ) == true) then
			triggerClientEvent ( player, "hideLoginWindow", getRootElement())
		else
			outputChatBox ( "Login error!", player, 255, 255, 0 ) -- Output they got the details wrong.
		end
	else
		account = addAccount ( user, pass )
		setAccountData ( account, "email", email)
		if (logIn ( player, account, pass ) == true) then
			triggerClientEvent ( player, "hideLoginWindow", getRootElement())
		else
			outputChatBox ( "Register/Login error!", player, 255, 255, 0 ) -- Output they got the details wrong.
		end
	end
end
addEvent( "on4XRegister", true )
addEventHandler( "on4XRegister", getRootElement(), on4XRegister )

function needVars()
	local allow_register = get("allow_register")
	local email_on_register = get("email_on_register")
	triggerClientEvent(source, "onSendVars", getRootElement(), allow_register, email_on_register)
end
addEvent("onNeedVars", true)
addEventHandler("onNeedVars", getRootElement(), needVars)