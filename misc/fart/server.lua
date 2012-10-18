--[[*****************************************************************************
*
*  PROJECT:     Fart
*  LICENSE:     GNU GPLv3
*  FILE:        :Fart/sFart.lua
*  PURPOSE:     Serverside fart sync
*  DEVELOPERS:  John_Michael <queso1902@live.com>
*  
********************************************************************************]]
local fartRequest, fartEvent = getResourceName(resource)..":onClientRequestFart", getResourceName(resource)..":onPedFart"

--Triggered when a client submits a fart request
local function syncFart(fartType)
	if client and source ~= client then return end
	
	triggerClientEvent(root, fartEvent, resourceRoot, source, fartType)
end
addEvent(fartRequest, true)
addEventHandler(fartRequest, root, syncFart)

--Exported function to make a player fart
function makePedFart(thePed, fartType)
	if thePed == root then --For Maccer
		triggerClientEvent(root, fartEvent, resourceRoot, root)
		return true
	end
	
	if not isElement(thePed) or (getElementType(thePed) == "ped" or getElementType(thePed) == "player") then
		outputDebugString("Invalid 'ped' pointer to makePedFart.", 1)
		return false
	end
	
	triggerClientEvent(root, fartEvent, resourceRoot, thePed, fartType)
	return true
end