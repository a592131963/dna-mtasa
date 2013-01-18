-- node = xmlLoadFile ("users.xml")

function onStart ()
	spawnTeam = createTeam ("Citizens", 255, 255, 255)
	db = dbConnect( "sqlite", "database.db" )
end
addEventHandler ("onResourceStart", getRootElement(), onStart)

function playerLogin (thePreviousAccount, theCurrentAccount, autoLogin)
	if not (isGuestAccount (getPlayerAccount (source))) then
		local accountData = getAccountData (theCurrentAccount, "rpg-money")
		if (accountData) then
			local player = executeSQLQuery("SELECT * FROM `players` WHERE `user`=?", getAccountName(theCurrentAccount))
			local items = executeSQLQuery("SELECT * FROM `items` WHERE `user`=?", getAccountName(theCurrentAccount))

			if player["x"] ~= false
				spawnPlayer(source, player["x"], player["y"], player["z"] +1, 0, player["skin"], player["int"], player["dim"], spawnTeam)
				setTimer(setPlayerTeam, 500, 1, source, spawnTeam)
				setPlayerMoney(source, )player["money"]
				setTimer (setPlayerWantedLevel, 500, 1, source, player["wanted"])
				for key, row in ipairs(items) do
					if row["gun"] ~= false
						setTimer (giveWeapon, 500, 1, source, row["gun"], row["ammo"], true)
					end
				end
				setCameraTarget (source, source)
				fadeCamera(source, true, 2.0)
			else
				spawnPlayer (source, 2000.55, 1526.25, 14.6171875, 0, math.random (0, 288), 0, 0, spawnTeam)
				setTimer (setPlayerTeam, 500, 1, source, spawnTeam)
				setPlayerMoney (source, 5000)
				setCameraTarget (source, source)
				fadeCamera(source, true, 2.0) 
			end

			local playerMoney = getAccountData (theCurrentAccount, "rpg-money")
			local playerSkin = getAccountData (theCurrentAccount, "rpg-skin")
			local playerX = getAccountData (theCurrentAccount, "rpg-x")
			local playerY = getAccountData (theCurrentAccount, "rpg-y")
			local playerZ = getAccountData (theCurrentAccount, "rpg-z")
			local playerInt = getAccountData (theCurrentAccount, "rpg-int")
			local playerDim = getAccountData (theCurrentAccount, "rpg-dim")
			local playerWanted = getAccountData (theCurrentAccount, "rpg-wantedLevel")
			local playerWeaponID = getAccountData (theCurrentAccount, "rpg-weaponID")
			local playerWeaponAmmo = getAccountData (theCurrentAccount, "rpg-weaponAmmo")
			spawnPlayer (source, playerX, playerY, playerZ +1, 0, playerSkin, playerInt, playerDim, spawnTeam)
			setTimer (setPlayerTeam, 500, 1, source, spawnTeam)
			setPlayerMoney (source, playerMoney)
			setTimer (setPlayerWantedLevel, 500, 1, source, playerWanted)
			if playerWeaponID then
				setTimer (giveWeapon, 500, 1, source, playerWeaponID, playerWeaponAmmo, true)
			end
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
			setAccountData (account, "rpg-money", tostring (getPlayerMoney (source)))
			setAccountData (account, "rpg-skin", tostring (getPedSkin (source)))
			setAccountData (account, "rpg-x", x)
			setAccountData (account, "rpg-y", y)
			setAccountData (account, "rpg-z", z)
			setAccountData (account, "rpg-int", getElementInterior (source))
			setAccountData (account, "rpg-dim", getElementDimension (source))
			setAccountData (account, "rpg-wantedLevel", getPlayerWantedLevel (source))
			setAccountData (account, "rpg-wantedID", getPedWeapon (source))
			setAccountData (account, "rpg-wantedAmmo", getPedTotalAmmo (source))
		end
	end
end
addEventHandler ("onPlayerQuit", getRootElement(), onQuit)

function onWasted(totalAmmo, killer, killerWeapon, bodypart, stealth)
	if not( isGuestAccount (getPlayerAccount(source)) ) then
		local theWeapon = getPedWeapon (source)
		local weaponAmmo = getPedTotalAmmo (source)
		fadeCamera (source, false)
		setTimer (spawnPlayer, 1000, 1, source, 1607.35, 1816.54, 10.82, 0, getPedSkin (source), 0, 0, spawnTeam)
		setTimer (setPlayerTeam, 1500, 1, source, spawnTeam)
		setTimer (setCameraTarget, 1250, 1, source, source)
		setTimer (fadeCamera, 2000, 1, source, true)
		setTimer (giveWeapon, 2000, 1, source, theWeapon, weaponAmmo, true)
	end
end
addEventHandler ("onPlayerWasted", getRootElement(), onWasted)