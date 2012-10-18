stuntLabel = guiCreateLabel (0,0.8,1,0.2,"",true)
guiLabelSetHorizontalAlign (stuntLabel, "center")
guiLabelSetVerticalAlign (stuntLabel, "center")
guiSetFont (stuntLabel, "sa-header")
guiSetAlpha(stuntLabel, 127)
addEvent("enableGodMode", true)
addEvent("disableGodMode", true)
addEventHandler ("enableGodMode", getRootElement(), 
function()
	addEventHandler ("onClientPlayerDamage", getRootElement(), cancelEventEvent)
	guiLabelSetColor(stuntLabel, 00, 255, 00)
	guiSetText (stuntLabel, "Greenzone")
	setTimer (guiSetText, 3000,1, stuntLabel, "")
end)

addEventHandler ("disableGodMode", getRootElement(), 
function()
	removeEventHandler ("onClientPlayerDamage", getRootElement(), cancelEventEvent)
	guiLabelSetColor(stuntLabel, 255, 00, 00)
	guiSetText (stuntLabel, "Real World")
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