addEventHandler ("onResourceStart", getRootElement(), 
function()
  local shipWomanPed = createPed (10,2001.26,1550.77,13.61)
  setPedRotation (shipWomanPed, 180)
  setElementFrozen (shipWomanPed, true)
  giveWeapon (shipWomanPed, 15, 1, true)
  local shipManPed = createPed (236,2000.07,1550.77,13.61)
  setPedRotation (shipManPed, 180)
  setElementFrozen (shipManPed, true)
  local medicPed = createPed (274,1623.29,1817.53,10.82)
  setPedRotation (medicPed, 0)
  setElementFrozen (medicPed, true)  
  local coureurPed = createPed (0,-2054.12,-397.87,35.53125)
  addPedClothes (coureurPed, "garageleg", "garagetr", 7)
  setPedRotation (coureurPed, 320)
  setElementFrozen (coureurPed, true)
    
  shipWomanChatMarker = createMarker (2001.26,1550.77,12.5,"cylinder",1.5,255,255,0,100,getRootElement())
  shipManChatMarker = createMarker (2000.07,1550.77,12.5,"cylinder",1.5,255,255,0,100,getRootElement())
  medicChatMarker = createMarker (1623.29,1817.53,9.52,"cylinder",1.5,255,255,0,100,getRootElement())
  coureurChatMarker = createMarker (-2054.12,-397.87,34.33125,"cylinder",1.5,255,255,0,100,getRootElement())
end)

addEventHandler ("onMarkerHit", getRootElement(), 
function(hitElement, matchingDimension)
  if (getElementType( hitElement ) == "player") then
    if (source == shipManChatMarker) then
      triggerClientEvent (hitElement, "viewInfoGUIWindow", hitElement, "Crazy old man.\n\nHEYHEY!\nWhat are you doing on my ship, \nI dont visit you!\nGo away you bastard!")
    elseif (source == shipWomanChatMarker) then
      triggerClientEvent (hitElement, "viewInfoGUIWindow", hitElement, "Old woman with big shoes.\n\nWelcome to our ship.\nPlease enjoy and dont \nlisten too much to my husband =D")
    elseif (source == medicChatMarker) then
      triggerClientEvent (hitElement, "viewInfoGUIWindow", hitElement, "Happy lifeless medic.\n\nWelcome to our hospital.\nIf you become wasted you'll get here!\n\nHope to see you again!\nBecause i like to cut open people >:]")
    elseif (source == coureurChatMarker) then
      triggerClientEvent (hitElement, "viewInfoGUIWindow", hitElement, "Mr. Iwan Nadie!\n\nWelcome to our stadium.\nYou can cross here! for each marker you hit you\nget 100$! Entry cots 500$!\n\nGood luck, i hope you die :]")
    end
  end
end)
