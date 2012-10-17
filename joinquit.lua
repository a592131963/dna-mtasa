g_Root = getRootElement()

addEventHandler('onPlayerLogin', g_Root,
	function(prev, cur, auto)
		outputChatBox('* ' .. getAccountName (cur) .. ' has joined the game', getRootElement(), 255, 100, 100)
	end
)

addEventHandler('onPlayerQuit', g_Root,
	function(reason)
		if not (isGuestAccount (getPlayerAccount(source))) then
			outputChatBox('* ' .. getAccountName (getPlayerAccount(source)) .. ' has left the game [' .. reason .. ']', getRootElement(), 255, 100, 100)
		end
	end
)

--crap
function displayLoadedRes ( res )
	outputChatBox ( "Resource " .. getResourceName(res) .. " loaded", getRootElement(), 255, 100, 255 )
end
addEventHandler ( "onResourceStart", getRootElement(), displayLoadedRes )

