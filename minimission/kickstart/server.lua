crossMissionStartMarker =  createMarker (-2051.58,-407.77,37.73,"cylinder",5,0,255,255)

addEventHandler ("onMarkerHit", getRootElement(),
function(player)
  if (source == crossMissionStartMarker) and (getElementType (player) == "player") then
    outputChatBox ("Cross minigame.", player, 127, 0, 255, false)
    outputChatBox (" Welcome to the minigame!", player, 255, 255, 255, false)
    outputChatBox (" You'll pay 500$ for entering!", player, 255, 255, 255, false)
    outputChatBox (" In you get a sanchez, and must get points!", player, 255, 255, 255, false)
    outputChatBox (" For every point you get 100$", player, 255, 255, 255, false)
    outputChatBox (" By exit vehicle or after 2 minutes the mission is over!", player, 255, 255, 255, false)
    outputChatBox (" start with /startminigame", player, 255, 255, 255, false)
  end
end)

addEventHandler ("onMarkerLeave", getRootElement(),
function(player)
  if (source == crossMissionStartMarker) and (getElementType (player) == "player") then
    outputChatBox ("Hope to see you again later at our cross minigame!", player, 127, 0, 255, false)
  end
end)

addCommandHandler ("startminigame", 
function(player, command)
  if (isElementWithinMarker (player, crossMissionStartMarker)) and (getPlayerMoney (player) >= 500) then
    takePlayerMoney (player, 500)
    outputChatBox ("Mission started!", player, 255, 0, 0, false)
    local missionVehicle = createVehicle (468,-1440.82,1562.28,1052.58)
    setElementInterior (missionVehicle, 14)
    setElementDimension (missionVehicle, 10)
    setElementInterior (player, 14)
    setElementDimension (player, 10)
    warpPedIntoVehicle (player, missionVehicle)
    showPlayerHudComponent (player, "ammo", false)
    showPlayerHudComponent (player, "area_name", false)
    showPlayerHudComponent (player, "armour", false)
    showPlayerHudComponent (player, "breath", false)
    showPlayerHudComponent (player, "clock", false)
    showPlayerHudComponent (player, "health", false)
    showPlayerHudComponent (player, "money", false)
    showPlayerHudComponent (player, "radar", false)
    showPlayerHudComponent (player, "vehicle_name", false)
    showPlayerHudComponent (player, "weapon", false)
    setTimer (onEndMission, 120000, 1, player, getPedOccupiedVehicle (player))
  end
end)

function onEndMission (player, vehicle)
  if (getElementDimension (player) == 10) and (getElementInterior (player) == 14) and (getElementModel (vehicle) == 468) then
    destroyElement (vehicle)
    showPlayerHudComponent (player, "ammo", true)
    showPlayerHudComponent (player, "area_name", true)
    showPlayerHudComponent (player, "armour", true)
    showPlayerHudComponent (player, "breath", true)
    showPlayerHudComponent (player, "clock", true)
    showPlayerHudComponent (player, "health", true)
    showPlayerHudComponent (player, "money", true)
    showPlayerHudComponent (player, "radar", true)
    showPlayerHudComponent (player, "vehicle_name", true)
    showPlayerHudComponent (player, "weapon", true)
    setElementDimension (player, 0)
    setTimer (setElementInterior, 500, 1, player, 0)
    setTimer (setElementPosition, 1500, 1, player, -2051.52,-397.25,35.53125)
    setTimer (setPedRotation, 500, 1, player, 0)
    outputChatBox ("Time over! come back later :D", player, 255, 0, 0, false)
  end
end

addEventHandler ("onVehicleExit", getRootElement(),
function(player, seat, jacked)
  if (getElementDimension (player) == 10) and (getElementInterior (player) == 14) and (getElementModel (source) == 468) then
    setTimer (warpPedIntoVehicle, 500, 1, player, source)
    outputChatBox ("Oops! you fall off!", player, 255, 0, 0, false)
  end
end)

addEventHandler ("onMarkerHit", getRootElement(), 
function(hitElement, matchingDimension)
  if (getElementType (hitElement) == "player") and (matchingDimension == true) and (getElementDimension (hitElement) == 10) and (getElementInterior (hitElement) == 14) and (getElementDimension (hitElement) == 10) then
    givePlayerMoney (hitElement, 100)
    playSoundFrontEnd (hitElement, 43)
    local x,y,z = getElementPosition (source)
    setTimer (createNewStuntMarker, 20000, 1, x,y,z)
    destroyElement(source)
  end
end)

function createNewStuntMarker(x,y,z)
  local coolMarker = createMarker (x,y,z,"corona",0.5,101,0,254,255,getRootElement())
  setElementInterior (coolMarker, 14)
  setElementDimension (coolMarker, 10)
end

addEventHandler ("onPlayerQuit", getRootElement(), 
function()
  if (getElementDimension (source) == 10) then
    setElementInterior (player, 0)
    setElementPosition (player, -2051.52,-397.25,35.53125)
  end
end)