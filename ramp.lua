local gRoot = getRootElement()
local g_Root = gRoot
local gMe = getLocalPlayer()
local gResourceRoot = getResourceRootElement(getThisResource())
local theRamps = {}

addEvent ( "vehicleramps_SpawnRamp", true )
addEventHandler ( "vehicleramps_SpawnRamp", gRoot,
	function ( mode, returnedData )
		--outputChatBox ( "A RAMP WAS MADE BY " .. getPlayerName(source) )
		
		if ( theRamps[source] ) then
			--outputChatBox ( "Destroying the ramps table" )
			destroyElement(theRamps[source])
			theRamps[source] = false
		end
	
		local parentUnit = createElement("myRamps" .. getPlayerID(source))
		theRamps[source] = parentUnit
		
		if ( mode == "1" ) then
			if ( #returnedData == 6 ) then
				spawnRamp ( source, returnedData[1], returnedData[2], returnedData[3], returnedData[4], returnedData[5], returnedData[6], 1632  )
			end
		elseif ( mode == "1s" ) then
			spawnRamp ( source, returnedData[1], returnedData[2], returnedData[3], 0, 0, 0, 1632  )
			spawnRamp ( source, returnedData[4], returnedData[5], returnedData[6], 0, 0, 90, 1632  )
			spawnRamp ( source, returnedData[7], returnedData[8], returnedData[9], 0, 0, 180, 1632  )
			spawnRamp ( source, returnedData[10], returnedData[11], returnedData[12], 0, 0, 270, 1632  )
		elseif ( mode == "2" ) then
			if ( #returnedData == 9 ) then
				spawnRamp ( source, returnedData[1], returnedData[2], returnedData[3], returnedData[7], returnedData[8], returnedData[9], 1632 )
				spawnRamp ( source, returnedData[4], returnedData[5], returnedData[6], returnedData[7], returnedData[8], returnedData[9], 1632  )
			end
		elseif ( mode == "3" ) then
			if ( #returnedData == 9 ) then
				local thisRamp = spawnRamp ( source, returnedData[1], returnedData[2], returnedData[3], returnedData[7], returnedData[8], returnedData[9], 1632 )
				local rx, ry, rz = getElementRotation ( thisRamp )
				spawnRamp ( source, returnedData[4], returnedData[5], returnedData[6], rx + 22, returnedData[8], returnedData[9], 1632  )
			end
		elseif ( mode == "5" ) then
			if ( #returnedData == 6 ) then
				spawnRamp ( source, returnedData[1], returnedData[2], returnedData[3], 0, 0, returnedData[6], 13592  )
			end
		elseif ( mode == "6" ) then
			if ( #returnedData == 6 ) then
				spawnRamp ( source, returnedData[1], returnedData[2], returnedData[3], 0, 0, returnedData[6], 13641  )
			end
		elseif ( mode == "custom" ) then
			if ( #returnedData == 7 ) then
				spawnRamp ( source, returnedData[1], returnedData[2], returnedData[3], 0, 0, returnedData[6], returnedData[7]  )
			end
		end
	end
)

addEventHandler ( "onClientResourceStart", gResourceRoot, function(name)
	--outputChatBox ( "Client Script Started" )
		outputChatBox ( "Client Script Started" )
		--bindKey ( "1", "down", workOutRamps, 1 )
		--bindKey ( "2", "down", workOutRamps, 2 )
		bindKey ( "3", "down", workOutRamps )
		--bindKey ( "5", "down", workOutRamps, 5 )
		--bindKey ( "6", "down", workOutRamps, 6 )

end)

function workOutRamps()
	local playerVehicle = getPedOccupiedVehicle(getLocalPlayer())
	if ( playerVehicle ) then
		local PV = getVehicleController(playerVehicle)
		if ( PV ~= getLocalPlayer() ) then
			outputChatBox ( "Your not the driver!" )
			return
		end 

		if ( theRamps[gMe] ) then
			--outputChatBox ( "Destroying the ramps table" )
			destroyElement(theRamps[gMe])
			theRamps[gMe] = false
		end
	
		local parentUnit = createElement("myRamps" .. getPlayerID(gMe))
		theRamps[gMe] = parentUnit
			
		local distance = 20
		local returnedData = {}
		local vehX, vehY, vZ = getElementPosition(playerVehicle)
		local rotX, rotY, rotZ = getElementRotation(playerVehicle)
	
		local ramp1X, ramp1Y = vehX + distance*math.cos(math.rad(rotZ+90)), vehY + distance*math.sin(math.rad(rotZ+90))
		local ramp2X, ramp2Y = vehX + (distance+5)*math.cos(math.rad(rotZ+90)), vehY + (distance+5)*math.sin(math.rad(rotZ+90))
		local ramp1Z = getGroundForCoords(ramp1X, ramp1Y, vZ)
		local ramp2Z = getGroundForCoords(ramp1X, ramp1Y, vZ)
		
		if ( doneOnce ) then
			if ( lastx == ramp1X ) then
				if ( lasty == ramp1Y ) then
					ramp1Z = ramp1Z - 0.78579690039
				end
			else
				doneOnce = false
			end
		else
			doneOnce = true
		end
		lastx = ramp1X
		lasty = ramp1Y
		
		returnedData[1] = ramp1X
		returnedData[2] = ramp1Y
		returnedData[3] = ramp1Z + 1
		returnedData[4] = ramp2X
		returnedData[5] = ramp2Y
		returnedData[6] = ramp2Z + 4.5
		returnedData[7] = rotX
		returnedData[8] = rotY
		returnedData[9] = rotZ
		local thisRamp = spawnRamp ( gMe, returnedData[1], returnedData[2], returnedData[3], returnedData[7], returnedData[8], returnedData[9], 1632 )
		local rx, ry, rz = getElementRotation ( thisRamp )
		spawnRamp ( gMe, returnedData[4], returnedData[5], returnedData[6], rx + 22, returnedData[8], returnedData[9], 1632  )
		triggerServerEvent ( "vehicleramps_PlayerSpawnedRamp", getLocalPlayer(), mode, returnedData )
	end
end

function spawnRamp ( player, x, y, z, rx, ry, rz, model )
	--outputDebugString ( "Attempting to create a ramp @ " .. tostring(x) .. " " .. tostring(y) .. " " .. tostring(z) .. " r @ " .. tostring(rx) .. " " .. tostring(ry) .. " " .. tostring(rz) )
	local dontCreateRamp = checkRampForObstructions(x, y, z)
	--outputChatBox ( "Ramps Table = " .. tostring(theRamps[player]) )
	if ( theRamps[player] ) then
		parentUnit = theRamps[player]
	end
	if ( dontCreateRamp == false ) then
		local thisRamp = createObject ( model, x, y, z, rx, 0, rz )
		setElementParent ( thisRamp, parentUnit )
		return thisRamp
	end
end

addEventHandler ( "onClientVehicleExit", g_Root,
	function ( player, seat )
		if ( theRamps[player] ) then
			destroyElement ( theRamps[player] )
		end
	end
)

addEventHandler ( "onClientPlayerQuit", g_Root,
	function ( reason )
		if ( theRamps[source] ) then
			destroyElement ( theRamps[source] )
		end
	end
)

function getPlayerID (player)
	for k,v in ipairs(getElementsByType("player")) do
		if ( v == player ) then
			return k
		end
	end
	return 0
end

function getGroundForCoords(x, y, z)
	local col, retx, rety, retz, element = processLineOfSight ( x, y, z, x, y, z-500 )
	if ( col ) then
		local watrPos = getWaterLevel ( x, y, z )
		if ( watrPos ~= false ) then
			if ( tonumber(watrPos) > tonumber(retz) ) then
				return watrPos + 0.1
			else
				return retz
			end
		else
			return retz
		end
	else
		local watrPos = getWaterLevel ( x, y, z )
		if ( watrPos ~= false ) then
			return watrPos + 0.1
		else
			return z
		end
	end
end

function checkRampForObstructions ( x, y, z )
	local dontCreate = false
	for k,v in ipairs(getElementsByType("player")) do
		if ( v ~= getLocalPlayer() ) then
			local thisX, thisY, thisZ = getElementPosition(v)
			local thisDistance = getDistanceBetweenPoints3D ( x, y, z, thisX, thisY, thisZ )
			if ( thisDistance < 8 ) then
				dontCreate = true
			end
		end
	end
	return dontCreate
end