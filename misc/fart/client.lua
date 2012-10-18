--[[*****************************************************************************
*
*  PROJECT:     Fart
*  LICENSE:     GNU GPLv3
*  FILE:        :Fart/cFart.lua
*  PURPOSE:     Clientside fart system 
*  DEVELOPERS:  John_Michael <queso1902@live.com>
*  
********************************************************************************]]
local lastTick, maxDistance, fartRequest, fartEvent = getTickCount(), 1, getResourceName(resource)..":onClientRequestFart", getResourceName(resource)..":onPedFart"

--This function is executed when the /fart command is used
local function submitFartRequest()
	--Antispam
	local thisTick = getTickCount()
	if thisTick - lastTick < 1500 then
		return
	end
	lastTick = thisTick
	
	--One in four chance of a huge fart.
	local fartType = math.random(0, 4)
	
	triggerServerEvent(fartRequest, localPlayer, fartType)
end
addCommandHandler("fart", submitFartRequest)

--Triggered when the server syncs a fart.
local function performFartRequest(playerWhoFarted, fartType)
	if playerWhoFarted == root then --For Maccer
		for i,v in ipairs(getElementsByType("player")) do
			makePedFart(v)
		end
		for i,v in ipairs(getElementsByType("ped")) do
			makePedFart(v)
		end
		return true
	end
	if isElementStreamedIn(playerWhoFarted) then
		makePedFart(playerWhoFarted, fartType)
	end
end
addEvent(fartEvent, true)
addEventHandler(fartEvent, resourceRoot, performFartRequest)

--This function makes a player fart. EXPORTED
function makePedFart(thePed, fartType)
	if not isElement(thePed) or not(getElementType(thePed) == "ped" or getElementType(thePed) == "player") then
		return false
	end
	
	outputDebugString("Fart type: "..fartType)
	if not fartType then fartType = 1 end
	
	local localX, localY, localZ = getElementPosition(localPlayer)
	local assX, assY, assZ = getPedBonePosition(thePed, 1)
	if getDistanceBetweenPoints3D(localX, localY, localZ, assX, assY, assZ) > 300 then
		return false
	end
	if assX then
		local _,_,rotation = getElementRotation(thePed)
		if rotation == 0 then 
			rotation = 180
		else
			rotation = rotation + 180
			if rotation > 360 then
				rotation = rotation - 360
			end
		end
		local driftX, driftY = getPointOnCircle(assX, assY, 3, rotation)
		driftX = driftX - assX
		driftY = driftY - assY
		
		--One in four chance of a huge fart.
		local volume = 0.6
		if fartType == 0 then
			fxAddTankFire(assX, assY, assZ, driftX, driftY, 0)
			volume = 1
		else
			fxAddTyreBurst(assX, assY, assZ, driftX, driftY, 0)
		end
		
		local sound = playSound3D("misc/fart/fart.wav", assX, assY, assZ, false)
		setSoundVolume(sound, volume)
		setSoundMaxDistance(sound, maxDistance)
		return true
	else
		return false
	end
end
		
function getPointOnCircle(centerX, centerY, radius, angle)
	angle = math.rad(angle)
	local dx = -radius * math.sin(angle)
	local dy = radius * math.cos(angle)
	
	return centerX + dx, centerY + dy
end