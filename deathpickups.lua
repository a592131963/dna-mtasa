function playerDieLetFallPickup (totalammo, killer, killerweapon, bodypart, stealth)
  if (getPlayerMoney (source) >= 1000) and (getPlayerMoney (source) < 10000) then  
    local x,y,z = getElementPosition (source)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    takePlayerMoney (source, 1000)
  elseif (getPlayerMoney (source) >= 500) and (getPlayerMoney (source) < 1000) then  
    local x,y,z = getElementPosition (source)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1212)
    takePlayerMoney (source, 500)
  elseif (getPlayerMoney (source) >= 100) and (getPlayerMoney (source) < 500) then
    local x,y,z = getElementPosition (source)
    createPickup (x + math.random (-1,1),y + math.random (-1,1),z, 3, 1212)
    takePlayerMoney (source, 100)
  elseif (getPlayerMoney (source) >= 10000) then
    local x,y,z = getElementPosition (source)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1550)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1550)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1550)
    createPickup (x + math.random (0,3),y + math.random (0,3),z, 3, 1550)
    takePlayerMoney (source, 10000)
  end
end
addEventHandler("onPlayerWasted", getRootElement(), playerDieLetFallPickup)

function moneyPickupUse (PlayerWhoUses)
  if (getElementModel (source) == 1212) then
    givePlayerMoney (PlayerWhoUses, 100)
    outputChatBox ("You've picked up 100$!", PlayerWhoUses, 255, 0, 0, false)
    destroyElement (source)
  elseif (getElementModel (source) == 1550) then
    givePlayerMoney (PlayerWhoUses, 2500)
    outputChatBox ("You've picked up 2500$!", PlayerWhoUses, 255, 0, 0, false)
    destroyElement (source)
  end
end
addEventHandler ("onPickupUse", getRootElement(), moneyPickupUse)