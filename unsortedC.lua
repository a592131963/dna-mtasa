-- hospitalMarker1 = createMarker (1607.36, 1814.24, -10, "cylinder", 24, 0, 0, 0, 0)

-- stuntLabel = guiCreateLabel (0,0.8,1,0.2,"",true)
-- guiLabelSetHorizontalAlign (stuntLabel, "center")
-- guiLabelSetVerticalAlign (stuntLabel, "center")
-- guiSetFont (stuntLabel, "clear-normal")

-- addEventHandler( "onClientPlayerStuntFinish", getRootElement(),
-- 	function (stuntType, stuntTime, distance)
-- 		if (stuntTime > 1) then
-- 			local stuntSecTime = stuntTime/1000
-- 			guiSetText (stuntLabel, "Stunt: " .. stuntType ..", Time: " .. stuntSecTime ..", Distance: " .. tostring( distance ) .. "meter")
-- 			setTimer (guiSetText, 1500,1, stuntLabel, "")
-- 		end
-- 	end
-- );