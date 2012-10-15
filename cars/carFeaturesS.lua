--Car 4 all:D
function playerLoginGiveCar (thePreviousAccount, theCurrentAccount, autoLogin)
  if  not (isGuestAccount (theCurrentAccount)) then
    local accountData = getAccountData (theCurrentAccount, "rpg-car")
    if not (accountData) then
      carID = setAccountData (theCurrentAccount, "rpg-car", 481)
    end
  end
end
addEventHandler ("onPlayerLogin", getRootElement(), playerLoginGiveCar)

--autodestroyer als hij kapoet is
function destroyOnExplode ()
	setTimer (destroyElement, 2500, 1, source)
end
addEventHandler ("onVehicleExplode", getRootElement(), destroyOnExplode)


addEventHandler ("onResourceStart", getRootElement(), 
function()
  for i,v in ipairs (getElementsByType ("player")) do
    bindKey (v, "i", "down", engineSwitch, v)
    bindKey (v, "o", "down", lockSwitch, v)
  end
end)

addEventHandler ("onPlayerLogin", getRootElement(), 
function()
  bindKey (source, "i", "down", engineSwitch, source)
  bindKey (source, "o", "down", lockSwitch, source)
end)  

function engineSwitch (thePlayer)
  if (isPedInVehicle (thePlayer)) then
    if (getVehicleEngineState (getPedOccupiedVehicle (thePlayer)) == true) then
      setVehicleEngineState (getPedOccupiedVehicle (thePlayer), false)
      outputChatBox ("Vehicle shutted down.", thePlayer, 255, 0, 0)
    elseif (getVehicleEngineState (getPedOccupiedVehicle (thePlayer)) == false) then
      setVehicleEngineState (getPedOccupiedVehicle (thePlayer), true)
      outputChatBox ("Vehicle started.", thePlayer, 255, 0, 0)
    end
  else
    outputChatBox ("You aren't in a vehicle!", thePlayer, 255, 0, 0)
  end
end

function lockSwitch (thePlayer)
  if (isPedInVehicle (thePlayer)) then
    if not (isVehicleLocked (getPedOccupiedVehicle (thePlayer))) then
      setVehicleLocked (getPedOccupiedVehicle (thePlayer), true)
      setVehicleDoorsUndamageable (getPedOccupiedVehicle(thePlayer), true)
      setVehicleDoorState (getPedOccupiedVehicle(thePlayer), 0, 0)
      setVehicleDoorState (getPedOccupiedVehicle(thePlayer), 1, 0)
      setVehicleDoorState (getPedOccupiedVehicle(thePlayer), 2, 0)
      setVehicleDoorState (getPedOccupiedVehicle(thePlayer), 3, 0) 
      outputChatBox ("Vehicle locked.", thePlayer, 255, 0, 0)
    elseif (isVehicleLocked (getPedOccupiedVehicle (thePlayer))) then
      setVehicleLocked (getPedOccupiedVehicle (thePlayer), false)
      setVehicleDoorsUndamageable (getPedOccupiedVehicle(thePlayer), false)
      outputChatBox ("Vehicle unlocked.", thePlayer, 255, 0, 0)
    end
  else
    outputChatBox ("You aren't in a vehicle!", thePlayer, 255, 0, 0)
  end
end

-- locked check, if auto is van hem sta het toe!
addEventHandler ("onVehicleStartEnter", getRootElement(), 
function(player, seat, jacked, door)
  if (isVehicleLocked (source) == true) then
    local mannetjeNaam = getAccountName (getPlayerAccount (player))
    local autoNaam = getElementID (source)
    if (mannetjeNaam == autoNaam) then
      setVehicleLocked (source, false)
      outputChatBox ("Vehicle unlocked!", player, 255, 0, 0, false)
    end
  end
end)