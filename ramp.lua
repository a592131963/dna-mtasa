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
				local rx, ry, rz = getObjectRotation ( thisRamp )
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
		bindKey ( "1", "down", workOutRamps, 1 )
		bindKey ( "2", "down", workOutRamps, 2 )
		bindKey ( "3", "down", workOutRamps, 3 )
		bindKey ( "5", "down", workOutRamps, 5 )
		bindKey ( "6", "down", workOutRamps, 6 )

end)

function workOutRamps(mode)
	local playerVehicle = getPlayerOccupiedVehicle(getLocalPlayer())
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
		local rotX, rotY, rotZ = getVehicleRotation(playerVehicle)
			
		if ( mode == "1" ) then
			if ( getKeyState("lshift") ) then
				local ramp1X, ramp1Y = vehX + distance*math.cos(math.rad(rotZ+90)), vehY + distance*math.sin(math.rad(rotZ+130))
				local ramp1Z = getGroundForCoords(ramp1X, ramp1Y, vZ)
				local ramp2X, ramp2Y = ramp1X+5.5, ramp1Y --vehX + distance*math.cos(math.rad(rotZ+74.5)), vehY + distance*math.sin(math.rad(rotZ+90))
				local ramp2Z = ramp1Z --getGroundForCoords(ramp2X, ramp2Y, vZ)
				local ramp3X, ramp3Y = ramp1X, ramp1Y+5.5 --vehX + distance*math.cos(math.rad(rotZ+90)), vehY + distance*math.sin(math.rad(rotZ+90)) + 5.5
				local ramp3Z = ramp1Z --getGroundForCoords(ramp3X, ramp3Y, vZ)
				local ramp4X, ramp4Y = ramp1X-5.5, ramp1Y --vehX + distance*math.cos(math.rad(rotZ+90)) - 5.5, vehY + distance*math.sin(math.rad(rotZ+90))
				local ramp4Z = ramp1Z --getGroundForCoords(ramp4X, ramp4Y, vZ)
				ramp1Y = ramp1Y - 5.5
				
				returnedData[1] = ramp1X
				returnedData[2] = ramp1Y
				returnedData[3] = ramp1Z + 1
				returnedData[4] = ramp2X
				returnedData[5] = ramp2Y
				returnedData[6] = ramp2Z + 1
				returnedData[7] = ramp3X
				returnedData[8] = ramp3Y
				returnedData[9] = ramp3Z + 1
				returnedData[10] = ramp4X
				returnedData[11] = ramp4Y
				returnedData[12] = ramp4Z + 1
				
				spawnRamp ( gMe, returnedData[1], returnedData[2], returnedData[3], 0, 0, 0, 1632  )
				spawnRamp ( gMe, returnedData[4], returnedData[5], returnedData[6], 0, 0, 90, 1632  )
				spawnRamp ( gMe, returnedData[7], returnedData[8], returnedData[9], 0, 0, 180, 1632  )
				spawnRamp ( gMe, returnedData[10], returnedData[11], returnedData[12], 0, 0, 270, 1632  )
				triggerServerEvent ( "vehicleramps_PlayerSpawnedRamp", getLocalPlayer(), mode .. "s", returnedData )
				setElementPosition ( playerVehicle, ramp1X, ramp1Y, ramp1Z+3 )
				setVehicleRotation ( playerVehicle, 0, 0, 0 )
				setElementVelocity ( playerVehicle, 0, 0, 0 )
				setElementVelocity ( playerVehicle, 0, 0, 0 )
			else
				local ramp1X, ramp1Y = vehX + distance*math.cos(math.rad(rotZ+90)), vehY + distance*math.sin(math.rad(rotZ+90))
				local ramp1Z = getGroundForCoords(ramp1X, ramp1Y, vZ)
				
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
				returnedData[4] = rotX
				returnedData[5] = rotY
				returnedData[6] = rotZ
				spawnRamp ( gMe, returnedData[1], returnedData[2], returnedData[3], returnedData[4], returnedData[5], returnedData[6], 1632  )
				triggerServerEvent ( "vehicleramps_PlayerSpawnedRamp", getLocalPlayer(), mode, returnedData )
			end
		elseif ( mode == "2" ) then
			local ramp1X, ramp1Y = vehX + distance*math.cos(math.rad(rotZ+83)), vehY + distance*math.sin(math.rad(rotZ+83))
			local ramp2X, ramp2Y = vehX + distance*math.cos(math.rad(rotZ+95)), vehY + distance*math.sin(math.rad(rotZ+95))
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
			returnedData[6] = ramp2Z + 1
			returnedData[7] = rotX
			returnedData[8] = rotY
			returnedData[9] = rotZ
			spawnRamp ( gMe, returnedData[1], returnedData[2], returnedData[3], returnedData[7], returnedData[8], returnedData[9], 1632 )
			spawnRamp ( gMe, returnedData[4], returnedData[5], returnedData[6], returnedData[7], returnedData[8], returnedData[9], 1632  )
			triggerServerEvent ( "vehicleramps_PlayerSpawnedRamp", getLocalPlayer(), mode, returnedData )
		elseif ( mode == "3" ) then
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
			local rx, ry, rz = getObjectRotation ( thisRamp )
			spawnRamp ( gMe, returnedData[4], returnedData[5], returnedData[6], rx + 22, returnedData[8], returnedData[9], 1632  )
			triggerServerEvent ( "vehicleramps_PlayerSpawnedRamp", getLocalPlayer(), mode, returnedData )
		elseif ( mode == "5" ) then
			local ramp1X, ramp1Y = vehX + distance*math.cos(math.rad(rotZ+90)), vehY + distance*math.sin(math.rad(rotZ+115))
			local ramp1Z = getGroundForCoords(ramp1X, ramp1Y, vZ)
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
			returnedData[3] = ramp1Z + 9
			returnedData[4] = rotX
			returnedData[5] = rotY
			returnedData[6] = rotZ - 90
			spawnRamp ( gMe, returnedData[1], returnedData[2], returnedData[3], 0, 0, returnedData[6], 13592  )
			triggerServerEvent ( "vehicleramps_PlayerSpawnedRamp", getLocalPlayer(), mode, returnedData )
		elseif ( mode == "6" ) then
			local ramp1X, ramp1Y = vehX + distance*math.cos(math.rad(rotZ+90)), vehY + distance*math.sin(math.rad(rotZ+90))
			local ramp1Z = getGroundForCoords(ramp1X, ramp1Y, vZ)
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
			returnedData[3] = ramp1Z +1
			returnedData[4] = rotX
			returnedData[5] = rotY
			returnedData[6] = rotZ + 90
			spawnRamp ( gMe, returnedData[1], returnedData[2], returnedData[3], 0, 0, returnedData[6], 13641  )
			triggerServerEvent ( "vehicleramps_PlayerSpawnedRamp", getLocalPlayer(), mode, returnedData )
		elseif ( mode == "custom" ) then
			local ramp1X, ramp1Y = vehX + distance*math.cos(math.rad(rotZ+90)), vehY + distance*math.sin(math.rad(rotZ+90))
			local ramp1Z = getGroundForCoords(ramp1X, ramp1Y, vZ)
			
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
			returnedData[3] = ramp1Z + 1 + zOffset
			returnedData[4] = rotX
			returnedData[5] = rotY
			returnedData[6] = rotZ
			returnedData[7] = modelID
			spawnRamp ( gMe, returnedData[1], returnedData[2], returnedData[3], 0, 0, returnedData[6], returnedData[7]  )
			triggerServerEvent ( "vehicleramps_PlayerSpawnedRamp", getLocalPlayer(), mode, returnedData )
		end
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