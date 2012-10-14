function resourceStart ()
  hayMarker = createMarker (-10,-10,0, "cylinder", 100, 0, 255, 0, 100, getRootElement())
end
addEventHandler("onResourceStart", getRootElement(), resourceStart)

function markerHit (hitPlayer, matchingDimension)
  if (source == hayMarker) then
    if (getElementType (hitPlayer) == "player") then
      toggleControl (hitPlayer, "fire", false)
      toggleControl (hitPlayer, "next_weapon", false)
      toggleControl (hitPlayer, "previous_weapon", false)
      toggleControl (hitPlayer, "aim_weapon", false)
      toggleControl (hitPlayer, "vehicle_fire", false)
      toggleControl (hitPlayer, "vehicle_secondarry_fire", false)
      toggleControl (hitPlayer, "vehicle_fire", false)
      showPlayerHudComponent (hitPlayer, "ammo", false)
      showPlayerHudComponent (hitPlayer, "weapon", false)
    elseif (getElementType (hitPlayer) == "vehicle") then
      destroyElement (hitPlayer)
    end
  end
end
addEventHandler ("onMarkerHit", getRootElement(), markerHit)

function markerLeave (leavePlayer, matchingDimension)
  if (source == hayMarker) then
    if (getElementType (leavePlayer) == "player") then
      toggleControl (leavePlayer, "fire", true)
      toggleControl (leavePlayer, "next_weapon", true)
      toggleControl (leavePlayer, "previous_weapon", true)
      toggleControl (leavePlayer, "aim_weapon", true)
      toggleControl (leavePlayer, "vehicle_fire", true)
      toggleControl (leavePlayer, "vehicle_secondarry_fire", true)
      toggleControl (leavePlayer, "vehicle_fire", true)
      showPlayerHudComponent (leavePlayer, "ammo", true)
      showPlayerHudComponent (leavePlayer, "weapon", true)
    end
  end
end
addEventHandler ("onMarkerLeave", getRootElement(), markerLeave)