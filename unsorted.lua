--blips enzo
createBlip (1607.36, 1814.24, -10, 22)
createBlip (2102.18, 2257.44, 12, 45)
createBlip (2158.70, 943.07, 12, 18)
createBlip (2000.55, 1526.25, 14.6171875, 38)
createBlip (1942.57, 2184.79, 9.82, 55)
createBlip (2005.82, 2310.60, 9.82, 63)
createBlip (2355.89, -648.62, 127.05, 37)
createBlip (2489.96, 2064.51, 11.82, 52)
createBlip (1173.17, 1348.80, 9.92, 33)
createBlip (-10, -10, 0, 33)
createBlip (-2051.58,-407.77,37.73, 33)


--Teamtimer, automatisch in team (voor de no-teambug)
function TeamTimer ()
	local players = getElementsByType("player")
	for i,v in ipairs(players) do
		setPlayerTeam (v, spawnTeam)
	end
end
setTimer (TeamTimer, 10000, 0)

--areachat
local chatRadius = 25 --units
function sendMessageToNearbyPlayers( message, messageType )
		if messageType == 2 then
				local posX, posY, posZ = getElementPosition( source )
 
				local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
				local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
				destroyElement( chatSphere )
				for index, nearbyPlayer in ipairs( nearbyPlayers ) do
					local theName = getAccountName (getPlayerAccount (source))
					outputChatBox( "#FF0000[AREA] ".. theName ..": #FFFFFF" .. message, nearbyPlayer, 0, 0, 0, true )
				end
				cancelEvent()
		end
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )

--public chat
function sendMessageToNearbyPlayers( message, messageType )
		if messageType == 0 then
				for i,v in ipairs( getElementsByType ("player") ) do
					local theName = getAccountName (getPlayerAccount (source))
					outputChatBox( "#00FF00".. theName ..": #FFFFFF" .. message, v, 0, 0, 0, true )
				end
				cancelEvent()
		end
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )

-- /me chat
function sendMessageToNearbyPlayers( message, messageType )
		if messageType == 1 then
				for i,v in ipairs( getElementsByType ("player") ) do
					local theName = getAccountName (getPlayerAccount (source))
					outputChatBox( "* ".. theName .. "#FF00FF " .. message, v, 255, 0, 255, true )
				end
				cancelEvent()
		end
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )


--Vehicle upgraden voor 100$
upgradeMarker = createMarker (2005.82, 2310.60, 9.82, "cylinder", 5, 255, 255, 0, 127)
function vehicleUpgrades (hitPlayer, matchingDimension)
	if (source == upgradeMarker) and (getElementType (hitPlayer) == "player") then
		if (isPedInVehicle (hitPlayer)) and (getPlayerMoney (hitPlayer) >= 100) then
			takePlayerMoney (hitPlayer, 100)
			outputChatBox ("Spray, fix... OK !", hitPlayer, 255, 0, 0, false)
			local color = math.random (0,126)
			setVehicleColor (getPedOccupiedVehicle(hitPlayer), color, color, color, color)
			fixVehicle (getPedOccupiedVehicle(hitPlayer))
		end
	end
end
addEventHandler ("onMarkerHit", getRootElement(), vehicleUpgrades)

--invisibleshop
addEventHandler ("onResourceStart", getRootElement(), 
function ()
	invisibleShopMarker = createMarker (2355.89, -648.62, 127.05, "cylinder", 2, 255, 0, 255, 127, getRootElement())
	addCommandHandler ("visible", shopBuyVisibleCommand)
end)

function markerHitStartShop (hitPlayer, matchingdimension)
	if (source == invisibleShopMarker) then
		addCommandHandler ("invisible", shopBuyInvisibleCommand)
		outputChatBox ("Welcome to the Magic shop!", hitPlayer, 255, 0, 0, getRootElement())
		outputChatBox ("If you've got a card, then invisible costs 100$", hitPlayer, 255, 0, 0, getRootElement())
		outputChatBox ("Else you pay 50.000$", hitPlayer, 255, 0, 0, getRootElement())
		outputChatBox ("Use /invisible to pay for invisiblity!", hitPlayer, 255, 0, 0, getRootElement())
		outputChatBox ("Enough with being invisible? use /visible!", hitPlayer, 255, 0, 0, getRootElement())
	end
end
addEventHandler ("onMarkerHit", getRootElement(), markerHitStartShop)

function markerLeaveStartShop (leavePlayer, matchingdimension)
	if (source == invisibleShopMarker) then
		removeCommandHandler ("invisible", shopBuyInvisibleCommand)
		outputChatBox ("Come back later ;)", leavePlayer, 255, 0, 0, getRootElement())
	end
end
addEventHandler ("onMarkerLeave", getRootElement(), markerLeaveStartShop)

function shopBuyInvisibleCommand (thePlayer, command)
	if not (isGuestAccount (getPlayerAccount (thePlayer))) then
		if (isElementWithinMarker (thePlayer, invisibleShopMarker)) and (getPlayerMoney (thePlayer) >= 50000) then
			takePlayerMoney (thePlayer, 50000)
			setElementAlpha (thePlayer, 0)
			setPlayerNametagShowing (thePlayer, false)
			outputChatBox ("Invisiblity set, use /visible to be back to normal.", thePlayer, 255, 0, 0, getRootElement())
			outputChatBox ("This costs you 50000$.", thePlayer, 255, 0, 0, getRootElement())
		else
			outputChatBox ("You must be in the magicshop to get invisible or you are too poor (50000$).", thePlayer, 255, 0, 0, getRootElement())
		end
	end
end

function shopBuyVisibleCommand (thePlayer, command)
	setElementAlpha (thePlayer, 255)
	setPlayerNametagShowing (thePlayer, true)
	outputChatBox ("Visible reset.", thePlayer, 255, 0, 0, getRootElement())
end

-- Anti Hack
--addEventHandler ( "onPlayerWeaponSwitch", getRootElement(), 
--function ( prevID, curID )
--	if (curID == 35) then
--		kickHaxingNoob (source, curID)
--	elseif (curID == 36) then
--		kickHaxingNoob (source, curID)
--	elseif (curID == 37) then
--		kickHaxingNoob (source, curID)
--	elseif (curID == 38) then
--		kickHaxingNoob (source, curID)
--	end
--end)

-- function kickHaxingNoob (player, weapon)
-- 	takeWeapon (player, weapon)
-- 	outputChatBox ( getPlayerName (player) .. " USES HAAAAAX!", getRootElement(), 255, 0, 0, false)
-- 	kickPlayer (player, "HAAAAAAAAX!")	
-- end 