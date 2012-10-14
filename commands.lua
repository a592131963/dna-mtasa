function nogoto (thePlayer, command, endis)
  if not (isGuestAccount (getPlayerAccount (thePlayer))) then
    if (endis == "enabled") then
      setAccountData (getPlayerAccount (thePlayer), "nogoto", "enabled")
      outputChatBox ("Your nogoto-state is enabled, everybody can warp you!", thePlayer, 255, 0, 0, false)
    elseif (endis == "disabled") then
      setAccountData (getPlayerAccount (thePlayer), "nogoto", "disabled")
      outputChatBox ("Your nogoto-state is disabled, nobodybody can warp you!", thePlayer, 255, 0, 0, false)
    else
      outputChatBox ("Wrong parameters. Use /nogoto [enabled/disabled]", thePlayer, 255, 0, 0, false)
    end
  end
end
--addCommandHandler ("nogoto", nogoto)

function killcommand (thePlayer, command)
	killPed (thePlayer)
end
addCommandHandler ("kill", killcommand)
addCommandHandler ("suicide", killcommand)

function flipcommand (thePlayer, command)
  if  not (isGuestAccount (getPlayerAccount (thePlayer))) then
    local accountData = getAccountData (getPlayerAccount (thePlayer), "funmodev2-car")
    if (accountData == getElementModel (getPedOccupiedVehicle (thePlayer))) then
      theVehicle = getPedOccupiedVehicle (thePlayer)
      rx,ry,rz = getVehicleRotation (theVehicle)
      setVehicleRotation (theVehicle, rx, ry +180, rz)
    else
      outputChatBox ("This isn't your car.", thePlayer, 255, 0, 0, false)
    end
  end
end
addCommandHandler ("flip", flipcommand)

function gotocommand (thePlayer, command, warpPlayer)
	warpPlayerName = getPlayerFromName (warpPlayer)
	if not (isGuestAccount (getPlayerAccount (warpPlayerName))) and (warpPlayerName ~= nil) and (not (isElementWithinMarker (warpPlayerName, hayMarker))) then
    if (getAccountData (getPlayerAccount(warpPlayerName), "nogoto")) and (getAccountData (getPlayerAccount(warpPlayerName), "nogoto") == "enabled") then
      x,y,z = getElementPosition (warpPlayerName)
      inter = getElementInterior (warpPlayerName)
      interPlay = getElementInterior (thePlayer)
      if (interPlay == inter) then
        setElementPosition (thePlayer, x,y,z, true)
      else
        outputChatBox ("The person you want to warp don't have goto enabled, please ask him to do it!", thePlayer, 255, 0, 0, false)
      end
    else
      triggerClientEvent (thePlayer, "viewInfoGUIWindow", thePlayer, "The person you want to warp don't have goto enabled, \nplease ask him to do it!\nWith the following line you can turn it on!\n/nogoto [enabled/disabled]")
    end
  end
end
--addCommandHandler ("goto", gotocommand)

function commandscommand (thePlayer, command)
	outputChatBox ("#FF0000Commands:", thePlayer, 255, 0, 0, true)
	outputChatBox ("#FFFFFF/kill /suicide - kill youself!", thePlayer, 255, 0, 0, true)
	--outputChatBox ("#FFFFFF/goto [name to warp] - Warp anyone!", thePlayer, 255, 0, 0, true)
	outputChatBox ("#FFFFFF/flip - flips your car", thePlayer, 255, 0, 0, true)
end
addCommandHandler("commands", commandscommand)
