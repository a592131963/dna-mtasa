addEventHandler ("onResourceStart", getRootElement(), 
function()
  setTimer (moneyZoneTimerFunction, 2500, 0)
  local allGreenzones = getElementsByType ("radararea")
  for i,v in ipairs (allGreenzones) do
    local r,g,b,a = getRadarAreaColor (v)
    if (r == 0) and (g == 255) and (b == 0) and (a == 127) then
      local x,y = getElementPosition (v)
      local sx,sy = getRadarAreaSize (v)
      local col = createColCuboid (x,y, -50, sx,sy, 7500)
      setElementID (col, "greenzoneColshape")
    end
  end
end)

addEventHandler ("onColShapeHit", getRootElement(), 
function(hitElement, matchingDimension)
  if (getElementType (hitElement) == "player") and (getElementID (source) == "greenzoneColshape") then
    outputChatBox ("You entered the greenzone", hitElement, 255, 0, 0, false)
    toggleControl (hitElement, "fire", false)
    toggleControl (hitElement, "next_weapon", false)
    toggleControl (hitElement, "previous_weapon", false)
    --toggleControl (hitElement, "sprint", false)
    toggleControl (hitElement, "aim_weapon", false)
    toggleControl (hitElement, "vehicle_fire", false)
    showPlayerHudComponent (hitElement, "ammo", false)
    showPlayerHudComponent (hitElement, "weapon", false)
    triggerClientEvent (hitElement, "enableGodMode", hitElement)
  end
  if (source == moneyZoneCol) and (getElementType (hitElement) == "vehicle") then
    setElementVelocity (hitElement, 0, 0, 0)
    setElementPosition (hitElement, 2018.33, 1534.77, 12.37)
    setVehicleRotation (hitElement, 0,0,270)
    if (getVehicleOccupant (hitElement, 0)) then
      outputChatBox ("You can't enter the moneyzone with your car!", getVehicleOccupant (hitElement, 0), 255, 0, 0, false)
    end
  end
end)

addEventHandler ("onColShapeLeave", getRootElement(), 
function(leaveElement, matchingDimension)
  if (getElementType (leaveElement) == "player") and (getElementID (source) == "greenzoneColshape") then
    outputChatBox ("You left the greenzone", leaveElement, 255, 0, 0, false)
    toggleControl (leaveElement, "fire", true)
    toggleControl (leaveElement, "next_weapon", true)
    toggleControl (leaveElement, "previous_weapon", true)
    --toggleControl (leaveElement, "sprint", true)
    toggleControl (leaveElement, "aim_weapon", true)
    toggleControl (leaveElement, "vehicle_fire", true)
    showPlayerHudComponent (leaveElement, "ammo", true)
    showPlayerHudComponent (leaveElement, "weapon", true)
    triggerClientEvent (leaveElement, "disableGodMode", leaveElement)
  end
end)

--money zone col
moneyZoneCol = createColCuboid (1993.12, 1519.14, -100, 17.43, 54.24, 117)
--stop moneyzone col

function moneyZoneTimerFunction ()
  local allPlayersInCol = getElementsWithinColShape (moneyZoneCol, "player")
  for i,v in ipairs (allPlayersInCol) do
    givePlayerMoney (v, 5)
  end
end

-- marker bij hospital
createMarker (1607.36, 1814.24, -10, "cylinder", 24, 0, 255, 0, 190, getRootElement())