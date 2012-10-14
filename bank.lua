function resourceStart ()
  bankMarker = createMarker (-2033.2, -117.52, 1034.17, "cylinder", 1.5, 255, 255, 0, 127, getRootElement())
  setElementInterior (bankMarker, 3)
end
addEventHandler ("onResourceStart", getRootElement (), resourceStart)

function markerHit (hitPlayer, matchingDimension)
  if (source == bankMarker) then
    outputChatBox ("Use /store [amount] to store your money", hitPlayer, 255, 0, 0, false)
    outputChatBox ("Use /withdraw [amount] to take your money", hitPlayer, 255, 0, 0, false)
    addCommandHandler ("store", storeCommand)
    addCommandHandler ("withdraw", withdrawCommand)
  end
end
addEventHandler ("onMarkerHit", getRootElement(), markerHit)

function markerHit (leavePlayer, matchingDimension)
  if (source == bankMarker) then
    outputChatBox ("Good bye.", leavePlayer, 255, 0, 0, false)
    removeCommandHandler ("store", storeCommand)
    removeCommandHandler ("withdraw", withdrawCommand)
  end
end
addEventHandler ("onMarkerLeave", getRootElement(), markerHit)

function storeCommand (thePlayer, command, amount)
  if (isElementWithinMarker (thePlayer, bankMarker)) then
    if not (isGuestAccount (getPlayerAccount (thePlayer))) then
      if (getAccountData (getPlayerAccount (thePlayer), "funmodev2-bank")) then
        if (getPlayerMoney (thePlayer) >= tonumber (amount)) and (tonumber (amount) > 0) then
          local money = (tonumber(getAccountData (getPlayerAccount (thePlayer), "funmodev2-bank")) + tonumber (amount))
          setAccountData (getPlayerAccount (thePlayer), "funmodev2-bank", tonumber(money))
          takePlayerMoney (thePlayer, tonumber(amount))
          outputChatBox ( tostring (amount) .. "$ stored to the bank.", thePlayer, 255, 0, 0, false)
        else
          outputChatBox ("You cannot store more money than you have!", thePlayer, 255, 0, 0, false)
        end
      else
        outputChatBox ("Account Bank created!", thePlayer, 255, 0, 0, false)
        outputChatBox ("The bank gives you 250$ for free!", thePlayer, 255, 0, 0, false)
        setAccountData (getPlayerAccount (thePlayer), "funmodev2-bank", 250)
      end
    end
  end
end

function withdrawCommand (thePlayer, command, amount)
  if (isElementWithinMarker (thePlayer, bankMarker)) then
    if not (isGuestAccount (getPlayerAccount (thePlayer))) then
      if (getAccountData (getPlayerAccount (thePlayer), "funmodev2-bank")) then
        if (getAccountData (getPlayerAccount (thePlayer), "funmodev2-bank") >= tonumber (amount)) and (tonumber (amount) > 0) then
          local money = (tonumber(getAccountData (getPlayerAccount (thePlayer), "funmodev2-bank")) - tonumber (amount))
          setAccountData (getPlayerAccount (thePlayer), "funmodev2-bank", tonumber(money))
          givePlayerMoney (thePlayer, tonumber(amount))
          outputChatBox ( tostring (amount) .. "$ withdrawed from the bank.", thePlayer, 255, 0, 0, false)
        else
          outputChatBox ("You cannot withdraw more money than you have!", thePlayer, 255, 0, 0, false)
        end
      else
        outputChatBox ("Account Bank created!", thePlayer, 255, 0, 0, false)
        outputChatBox ("The bank gives you 250$ for free!", thePlayer, 255, 0, 0, false)
        setAccountData (getPlayerAccount (thePlayer), "funmodev2-bank", 250)
      end
    end
  end
end

function bankSay (thePlayer, command)
  bankSayAmount = getAccountData (getPlayerAccount (thePlayer), "funmodev2-bank")
  if (bankSayAmount) then
    outputChatBox (tostring(getPlayerName (thePlayer)) .. " #FFFF00have got " .. tostring(bankSayAmount) .. "$ on his bank.", getRootElement(), 255, 255, 0, true)
  else
    outputChatBox (tostring(getPlayerName (thePlayer)) .. " #FFFF00haven't got a bank.", getRootElement(), 255, 255, 0, true)
  end
end
addCommandHandler ("bank", bankSay)