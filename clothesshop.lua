function clothesshopmarkeronStartup ()
	clothesshopChangeMarker = createMarker (217.47, -97.75, 1003.25, "cylinder", 4.5, 255, 0, 0, 128, getRootElement())
	setElementInterior (clothesshopChangeMarker, 15)
end
addEventHandler("onResourceStart", getRootElement(), clothesshopmarkeronStartup)

function clothesshopmarker (hitPlayer, matchingDimension)
	if (source == clothesshopChangeMarker) then
		outputChatBox ("Use the arrows to select a skin.", hitPlayer, 255, 0, 0, false)
		outputChatBox ("Use [ and ] to select a skin fast.", hitPlayer, 255, 0, 0, false)
		outputChatBox ("And press 'enter' when you have found the good one.", hitPlayer, 255, 0, 0, false)
		toggleAllControls (hitPlayer, false, true, false)
		bindKey (hitPlayer, "arrow_l", "down", clothesshopChangeMarkerBindKeys)
		bindKey (hitPlayer, "arrow_r", "down", clothesshopChangeMarkerBindKeys)
		bindKey (hitPlayer, "[", "down", clothesshopChangeMarkerBindKeys)
		bindKey (hitPlayer, "]", "down", clothesshopChangeMarkerBindKeys)
		bindKey (hitPlayer, "enter", "down", clothesshopChangeMarkerBindKeys)   
	end
end
addEventHandler("onMarkerHit", getRootElement(), clothesshopmarker)

function clothesshopChangeMarkerBindKeys (thePlayer, key, keystate)
	if (key == "arrow_l") and (keystate == "down") then
		local currentSkin = getPedSkin (thePlayer)
		setPedSkin (thePlayer, currentSkin -1)
	end
	if (key == "[") and (keystate == "down") then
		local currentSkin = getPedSkin (thePlayer)
		setPedSkin (thePlayer, currentSkin -3)
	end
	if (key == "arrow_r") and (keystate == "down") then
		local currentSkin = getPedSkin (thePlayer)
		setPedSkin (thePlayer, currentSkin +1)
	end
	if (key == "]") and (keystate == "down") then
		local currentSkin = getPedSkin (thePlayer)
		setPedSkin (thePlayer, currentSkin +3)
	end
	if (key == "enter") and (keystate == "down") then
		toggleAllControls (thePlayer, true, true, true)
		unbindKey (thePlayer, "arrow_l", "down", clothesshopChangeMarkerBindKeys)
		unbindKey (thePlayer, "arrow_r", "down", clothesshopChangeMarkerBindKeys)
		unbindKey (thePlayer, "[", "down", clothesshopChangeMarkerBindKeys)
		unbindKey (thePlayer, "]", "down", clothesshopChangeMarkerBindKeys)
		unbindKey (thePlayer, "enter", "down", clothesshopChangeMarkerBindKeys)
	end
end