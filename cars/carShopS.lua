carShopMarker = createMarker (1942.57, 2184.79, 9.82, "cylinder", 3, 255, 0, 0, 127)
carShopMarker2 = createMarker (-1953.68, 304.57, 34.46875, "cylinder", 1, 255, 0, 0, 127)

addEvent ("viewGUI", true)
function markerHit (hitPlayer, matchingDimension)
  if (source == carShopMarker) then
    triggerClientEvent ("viewGUI", hitPlayer)
    outputChatBox ("Welcome to the vehicleshop!", hitPlayer, 255, 0, 0)
  end
end
addEventHandler ("onMarkerHit", getRootElement(), markerHit)

addEvent ("carShopCarBuy", true)
addEventHandler ("carShopCarBuy", getRootElement(), 
function(id, cost, name)
  if (getPlayerMoney (source) >= tonumber(cost)) then
    outputChatBox ("Bought a " .. name, source, 255, 0, 0, false)
    outputChatBox ("ID: " .. id, source, 255, 0, 0, false)
    outputChatBox ("Cost: " .. cost, source, 255, 0, 0, false)
    takePlayerMoney (source, tonumber (cost))
    setAccountData (getPlayerAccount (source), "funmodev2-car", tonumber(id))
    setAccountData (getPlayerAccount (source), "funmodev2-paintjob", 3)
    setAccountData (getPlayerAccount (source), "funmodev2-carupg", 0)
  else
    outputChatBox ("You are too poor!", source, 255, 0, 0, false)
  end
end)
