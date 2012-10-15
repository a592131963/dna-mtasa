function playerDieLetFallPickup (totalammo, killer, killerweapon, bodypart, stealth)
	local x,y,z = getElementPosition (source)
	if (getPlayerMoney (source) >= 1000) and (getPlayerMoney (source) < 10000) then	
		for i=1, 10 do
			createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
		end
		takePlayerMoney (source, 1000)
	elseif (getPlayerMoney (source) >= 500) and (getPlayerMoney (source) < 1000) then
		for i=1, 5 do
			createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
		end
		takePlayerMoney (source, 500)
	elseif (getPlayerMoney (source) >= 100) and (getPlayerMoney (source) < 500) then
		createPickup (x + math.random (-1,1),y + math.random (-1,1),z, 3, 1212)
		takePlayerMoney (source, 100)
	elseif (getPlayerMoney (source) >= 10000) then
		for i=1, 4 do
			createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1550)
		end
		takePlayerMoney (source, 10000)
	end
end
addEventHandler("onPlayerWasted", getRootElement(), playerDieLetFallPickup)

function moneyPickupUse (PlayerWhoUses)
	if (getElementModel (source) == 1212) then
		givePlayerMoney (PlayerWhoUses, 100)
		--outputChatBox ("You've picked up 100$!", PlayerWhoUses, 255, 0, 0, false)
		destroyElement (source)
	elseif (getElementModel (source) == 1550) then
		givePlayerMoney (PlayerWhoUses, 2500)
		--outputChatBox ("You've picked up 2500$!", PlayerWhoUses, 255, 0, 0, false)
		destroyElement (source)
	end
end
addEventHandler ("onPickupUse", getRootElement(), moneyPickupUse)