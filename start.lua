node = xmlLoadFile ("users.xml")

function onStart ()
	spawnTeam = createTeam ("Funners", 0, 255, 0)
end
addEventHandler ("onResourceStart", getRootElement(), onStart)

function playerLogin (thePreviousAccount, theCurrentAccount, autoLogin)
  if  not (isGuestAccount (getPlayerAccount (source))) then
    local accountData = getAccountData (theCurrentAccount, "funmodev2-money")
    if (accountData) then
      local playerMoney = getAccountData (theCurrentAccount, "funmodev2-money")
      local playerSkin = getAccountData (theCurrentAccount, "funmodev2-skin")
      local playerX = getAccountData (theCurrentAccount, "funmodev2-x")
      local playerY = getAccountData (theCurrentAccount, "funmodev2-y")
      local playerZ = getAccountData (theCurrentAccount, "funmodev2-z")
      local playerInt = getAccountData (theCurrentAccount, "funmodev2-int")
      local playerDim = getAccountData (theCurrentAccount, "funmodev2-dim")
      local playerWanted = getAccountData (theCurrentAccount, "funmodev2-wantedlevel")
      local playerWeaponID = getAccountData (theCurrentAccount, "funmodev2-weaponID")
      local playerWeaponAmmo = getAccountData (theCurrentAccount, "funmodev2-weaponAmmo")
      spawnPlayer (source, playerX, playerY, playerZ +1, 0, playerSkin, playerInt, playerDim, spawnTeam)
      setTimer (setPlayerTeam, 500, 1, source, spawnTeam)
      setPlayerMoney (source, playerMoney)
      setTimer (setPlayerWantedLevel, 500, 1, source, playerWanted)
      setTimer (giveWeapon, 500, 1, source, playerWeaponID, playerWeaponAmmo, true)
      setCameraTarget (source, source)
      fadeCamera(source, true, 2.0)
    else
      spawnPlayer (source, 2000.55, 1526.25, 14.6171875, 0, math.random (0, 288), 0, 0, spawnTeam)
      setTimer (setPlayerTeam, 500, 1, source, spawnTeam)
      setPlayerMoney (source, 5000)
      setCameraTarget (source, source)
      fadeCamera(source, true, 2.0) 
    end   
  end
end
addEventHandler ("onPlayerLogin", getRootElement(), playerLogin)

function onLogout ()
	kickPlayer (source, nil, "Logging out is disallowed.")
end
addEventHandler ("onPlayerLogout", getRootElement(), onLogout)

function onQuit (quitType, reason, responsibleElement)
  if not (isGuestAccount (getPlayerAccount (source))) then
    account = getPlayerAccount (source)
    if (account) then
      local x,y,z = getElementPosition (source)
      setAccountData (account, "funmodev2-money", tostring (getPlayerMoney (source)))
      setAccountData (account, "funmodev2-skin", tostring (getPedSkin (source)))
      setAccountData (account, "funmodev2-x", x)
      setAccountData (account, "funmodev2-y", y)
      setAccountData (account, "funmodev2-z", z)
      setAccountData (account, "funmodev2-int", getElementInterior (source))
      setAccountData (account, "funmodev2-dim", getElementDimension (source))
      setAccountData (account, "funmodev2-wantedlevel", getPlayerWantedLevel (source))
      setAccountData (account, "funmodev2-wantedID", getPlayerWeapon (source))
      setAccountData (account, "funmodev2-wantedAmmo", getPlayerTotalAmmo (source))
    end
  end
end
addEventHandler ("onPlayerQuit", getRootElement(), onQuit)

function onWasted(totalAmmo, killer, killerWeapon, bodypart, stealth)
  if not( isGuestAccount (getPlayerAccount(source)) ) then
    local theWeapon = getPlayerWeapon (source)
    local weaponAmmo = getPlayerTotalAmmo (source)
    fadeCamera (source, false)
    setTimer (spawnPlayer, 1000, 1, source, 1607.35, 1816.54, 10.82, 0, getPedSkin (source), 0, 0, spawnTeam)
    setTimer (setPlayerTeam, 1500, 1, source, spawnTeam)
    setTimer (setCameraTarget, 1250, 1, source, source)
    setTimer (fadeCamera, 2000, 1, source, true)
    setTimer (giveWeapon, 2000, 1, source, theWeapon, weaponAmmo, true)
  end
end
addEventHandler ("onPlayerWasted", getRootElement(), onWasted)