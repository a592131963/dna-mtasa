addEventHandler ("onResourceStart", getRootElement(), 
function()
	copPickup = createPickup (2252.75, 2491.309, 10.99, 3, 334, 100)
end)

addEventHandler ("onPickupUse", getRootElement(), 
function (playerWhoUses)
	if (source == copPickup) and (getPlayerWantedLevel (playerWhoUses) == 0) then
		giveWeapon (playerWhoUses, 3, 1, true)
		setPlayerNametagText (playerWhoUses, "[COP]" .. getPlayerName (playerWhoUses))
		setElementData (playerWhoUses, "job", "police")
		outputChatBox ( "* " .. getPlayerName(playerWhoUses) .. " is a cop now!", getRootElement(), 0, 0, 255, false)
		outputChatBox ("Arest wanted people with hitting your nightstick!", playerWhoUses, 0, 0, 255, false)
		outputChatBox ("Use /wanted to get the wanted list.", playerWhoUses, 0, 0, 255, false)
		outputChatBox ("Use /uncop don't be a cop no more.", playerWhoUses, 0, 0, 255, false)
	elseif not (getPlayerWantedLevel (playerWhoUses) == 0) and (source == copPickup) then
		outputChatBox ("You can't become cop with this wanted level!", playerWhoUses, 0, 0, 255, false)
	end
end)

addCommandHandler ("uncop", 
function (thePlayer, command)
	if (getPlayerNametagText (thePlayer) == "[COP]" .. getPlayerName (thePlayer)) then
		setPlayerNametagText (thePlayer, getPlayerName (thePlayer))
		takeWeapon (thePlayer, 3)
		outputChatBox ("* " .. getPlayerName(thePlayer) .. " is no cop any more!", getRootElement(), 0, 0, 255, false)
		outputChatBox ("You can't use your nightstick no more!", thePlayer, 0, 0, 255, false)
	end
end)

addEventHandler ("onPlayerWasted", getRootElement(), 
function (totalAmmo, killer, killerWeapon, bodypart, stealth)
	setPlayerWantedLevel (source, 0)
	if (getPlayerNametagText (source) == "[COP]" .. getPlayerName (source)) then
		outputChatBox ("* " .. getPlayerName (source) .. " is no cop any more.", getRootElement(), 0, 0, 255, false)
		setPlayerNametagText (source, getPlayerName (source))
	elseif (getElementType(killer) == "player") and (killer) and (killer ~= source) and not (getPlayerNametagText (source) == "[COP]" .. getPlayerName (source)) then
		setPlayerWantedLevel (killer, getPlayerWantedLevel (killer) +1)
	elseif (getElementType(killer) == "player") and (killer) and (killer ~= source) and (getPlayerNametagText (source) == "[COP]" .. getPlayerName (source)) then
		setPlayerWantedLevel (killer, getPlayerWantedLevel (killer) +2)
	end
end)

addCommandHandler ("wanted", 
function (thePlayer, command)
	if (getPlayerCount() > 1) then
		local players = getElementsByType ("player")
		outputChatBox ("---", thePlayer, 0, 0, 255, false)
		outputChatBox ("Wanted list.", thePlayer, 0, 0, 255, false)
		for i,v in ipairs (players) do
			local level = getPlayerWantedLevel (v)
			if (level > 0) then
				outputChatBox (getPlayerName (v) .. " - " .. level, thePlayer, 0, 0, 255, false)
			end
		end
		outputChatBox ("---", thePlayer, 0, 0, 255, false)
	else
		outputChatBox ("Theres nobody wanted.", thePlayer, 0, 0, 255, false)
	end
end)

addEventHandler ("onPlayerDamage", getRootElement(), 
function(attacker, weapon, bodypart, loss)
	if (attacker ~= source) and (attacker ~= nil) and (source ~= nil) and (weapon == 3) and (loss > 1) and (getElementType (attacker) == "player") and (getPlayerNametagText (attacker) == "[COP]" .. getPlayerName (attacker)) then
		if (getPlayerWantedLevel (source) == 0) then
			outputChatBox ("This one isn't wanted!", attacker, 0, 0, 255, false)
		else
			-- outputChatBox ("He is jailed for "..getPlayerWantedLevel (source).." minutes!", attacker, 0, 0, 255, false)
			-- outputChatBox ("You are jailed "..getPlayerWantedLevel (source).." minutes!", source, 0, 0, 255, false)
			outputChatBox ("You cought "..getPlayerName (source).." minutes!", attacker, 0, 0, 255, false)
			outputChatBox ("You have been caught by "..getPlayerName (attacker).." minutes!", source, 0, 0, 255, false)
			givePlayerMoney (attacker, getPlayerWantedLevel (source) * 1000)
			setElementPosition (source, 2304.88, 2451.79, -40.50)
			--setTimer (setElementPosition,  getPlayerWantedLevel (source) * 60000, 1, source, 2288.34, 2428.84, 10.82)
			setPlayerWantedLevel (source, 0)
		end
	end
end)