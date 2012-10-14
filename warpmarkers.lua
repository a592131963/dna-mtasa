addEventHandler ("onResourceStart", getRootElement(), 
function ()
	ammuA = createMarker (2158.99, 943.23, 11.8, "arrow", 1.5, 255, 255, 0, getRootElement())
	ammuB = createMarker (285.49, -85.94, 1002.52, "arrow", 1.5, 255, 255, 0 ,getRootElement())
	setElementInterior (ammuB, 4)
	
	clothesA = createMarker (2102.51, 2257.50, 12.02, "arrow", 1.5, 255, 255, 0, getRootElement())
	clothesB = createMarker (207.65, -110.74, 1006.13, "arrow", 1.5, 255, 255, 0, getRootElement())
	setElementInterior (clothesB, 15)
	
	bankA = createMarker (2489.96, 2064.51, 11.82, "arrow", 1.5, 255, 255, 0, getRootElement())
	bankB = createMarker (-2029.69, -110.41, 1036.17, "arrow", 1.5, 255, 255, 0, getRootElement())
	setElementInterior (bankB, 3)
	
	korting = createMarker (1024.40, -313.23, 75, "arrow", 1.5, 255, 255, 0, getRootElement())
	
	pirA = createMarker (2001.98,1538.22,14.58, "arrow", 1.5, 255, 255, 0, getRootElement())
	pirB = createMarker (2002.02,1538.71,10.88, "arrow", 1.5, 255, 255, 0, getRootElement())
end)

addEventHandler ("onMarkerHit", getRootElement(), 
function (hitPlayer, matchingDimension)
	if (getElementType (hitPlayer) == "player") then
    if (source == ammuA) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, the door is too small for your vehicle.", hitPlayer, 255, 0, 0, false)
      else
        setElementInterior (hitPlayer, 4, 289.73, -84.04, 1001.51)
      end
    elseif (source == ammuB) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, the door is too small for your vehicle.", hitPlayer, 255, 0, 0, false)
      else
        setElementInterior (hitPlayer, 0, 2152.81, 942.98, 10.82)
      end
    elseif (source == clothesA) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, the door is too small for your vehicle.", hitPlayer, 255, 0, 0, false)
      else
        setElementInterior (hitPlayer, 15, 207.543, -109.004, 1005.133)
      end
    elseif (source == clothesB) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, the door is too small for your vehicle.", hitPlayer, 255, 0, 0, false)
      else
        setElementInterior (hitPlayer, 0, 2105.999, 2257.359, 11.023)
      end
    elseif (source == bankA) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, the door is too small for your vehicle.", hitPlayer, 255, 0, 0, false)
      else
        setElementInterior (hitPlayer, 3, -2029.75, -113.73, 1035.17)
      end
    elseif (source == bankB) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, the door is too small for your vehicle.", hitPlayer, 255, 0, 0, false)
      else
        setElementInterior (hitPlayer, 0, 2490.34, 2061.63, 10.82)
      end
    elseif (source == korting) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, The maze is only for people on foot.", hitPlayer, 255, 0, 0, false)
      else
        setElementPosition (hitPlayer, 1045.67, -313.90, 77.47)
      end
    elseif (source == pirA) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, the door is too small for your vehicle.", hitPlayer, 255, 0, 0, false)
      else
        setElementPosition (hitPlayer, 2001.94,1536.32,9.88)
      end
    elseif (source == pirB) then
      if (isPedInVehicle (hitPlayer)) then
        outputChatBox ("Sorry, the door is too small for your vehicle.", hitPlayer, 255, 0, 0, false)
      else
        setElementPosition (hitPlayer, 2002.28,1539.34,13.58)
      end
		end
	end
end)