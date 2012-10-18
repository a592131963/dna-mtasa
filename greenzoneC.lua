stuntLabel = guiCreateLabel (0,0.8,1,0.2,"",true)
guiLabelSetHorizontalAlign (stuntLabel, "center")
guiLabelSetVerticalAlign (stuntLabel, "center")
guiSetFont (stuntLabel, "sa-header")

addEvent("enableGodMode", true)
addEvent("disableGodMode", true)
addEventHandler ("enableGodMode", getRootElement(), 
function()
	addEventHandler ("onClientPlayerDamage", getRootElement(), cancelEventEvent)
	guiSetText (stuntLabel, "#00FF007FGreenzone")
	setTimer (guiSetText, 3000,1, stuntLabel, "")
end)

addEventHandler ("disableGodMode", getRootElement(), 
function()
	removeEventHandler ("onClientPlayerDamage", getRootElement(), cancelEventEvent)
	guiSetText (stuntLabel, "#FF00007FReal World")
	setTimer (guiSetText, 3000,1, stuntLabel, "")
end)

function cancelEventEvent () cancelEvent() end 

-- Music in pirateship
pirShipMusicCol = createColCuboid (1997.58,1523.16,8,6,17.66,4)
addEventHandler ("onClientColShapeHit", getRootElement(), 
function(hitElement, matchingDimension)
	if (source == pirShipMusicCol) and (hitElement == getLocalPlayer()) then
		setRadioChannel (7)
	end
end)

addEventHandler ("onClientColShapeLeave", getRootElement(), 
function(leaveElement, matchingDimension)
	if (source == pirShipMusicCol) and (leaveElement == getLocalPlayer()) then
		setRadioChannel (0)
	end
end)