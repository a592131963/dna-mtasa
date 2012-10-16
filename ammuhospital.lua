function weapons ()
	mp5 = createPickup (288.07, -76.97, 1001.51, 2, 29, 1000, 0)
	setElementInterior (mp5, 4)
	m4 = createPickup (288.24, -73.83, 1001.51, 2, 31, 1000, 0)
	setElementInterior (m4, 4)
	hospitalHealth = createPickup (2000.67, 1523.21, 17.06, 0, 0, 10)
	hospitalHealth2 = createPickup (1599.51, 1815.87, 10.82, 0, 0, 10)
	hospitalArmor = createPickup (1615.04, 1815.87, 10.82, 1, 0, 10)
end
addEventHandler ("onResourceStart", getRootElement(), weapons)

function weaponPayment (playerWhoUses)
	thePlayerMoney = getPlayerMoney (playerWhoUses)
	if (source == m4) then
		if (thePlayerMoney > 250) then
			takePlayerMoney (playerWhoUses, 250)
			outputChatBox ("Picked up a M4, this costs you $250", playerWhoUses, 255, 0, 0, false)
			giveWeapon (playerWhoUses, 31, 250, true)
		else
			outputChatBox ("You haven't got 250$ to buy this!", playerWhoUses, 255, 0, 0, false)
		end
	end
	if (source == mp5) then
		if (thePlayerMoney > 100) then
			takePlayerMoney (playerWhoUses, 100)
			outputChatBox ("Picked up a mp5, this costs you $100", playerWhoUses, 255, 0, 0, false)
			giveWeapon (playerWhoUses, 29, 100, true)
		else
			outputChatBox ("You haven't got 100$ to buy this!", playerWhoUses, 255, 0, 0, false)
		end
	end
	if (source == hospitalHealth) then
		theHealth = getElementHealth (playerWhoUses)
		healthMoney = 100-theHealth
		if (thePlayerMoney > healthMoney+1) then
			outputChatBox ("press Tab to pickup, 1$/x%.", playerWhoUses, 255, 0, 0, false)
			bindKey (playerWhoUses, "tab", "down", hospitalHealthPickup, playerWhoUses)
			setTimer (unbindKey, 1000, 1, playerWhoUses, "tab", "down", hospitalHealthPickup)
		else
			outputChatBox ("You haven't got enough money to take this!", playerWhoUses, 255, 0, 0, false)
		end
	end
	if (source == hospitalHealth2) then
		theHealth2 = getElementHealth (playerWhoUses)
		healthMoney2 = 100-theHealth2
		if (thePlayerMoney > healthMoney2+1) then
			outputChatBox ("press Tab to pickup, 1$/x%.", playerWhoUses, 255, 0, 0, false)
			bindKey (playerWhoUses, "tab", "down", hospitalHealthPickup, playerWhoUses)
			setTimer (unbindKey, 1000, 1, playerWhoUses, "tab", "down", hospitalHealthPickup)
		else
			outputChatBox ("You haven't got enough money to take this!", playerWhoUses, 255, 0, 0, false)
		end
	end
	if (source == hospitalArmor) then
		theHealth = getElementHealth (playerWhoUses)
		if (thePlayerMoney > 199) then
			outputChatBox ("press Tab to pickup, 200$/50%.", playerWhoUses, 255, 0, 0, false)
			bindKey (playerWhoUses, "tab", "down", hospitalArmorPickup, playerWhoUses)
			function hospitalArmorPickup (thePlayer)
				if (getPlayerMoney (thePlayer) > 119) then
					if (getPedArmor (thePlayer) < 100) then
						takePlayerMoney (thePlayer, 200)
						setPedArmor (thePlayer, getPedArmor (thePlayer) +50)
						outputChatBox ("Picked up a armorpickup, you have paid 50$", thePlayer, 255, 0, 0, false)
					end
					outputChatBox ("You have too much armor to take this!", thePlayer, 255, 0, 0, false)
				end
				outputChatBox ("You haven't got enough money to take this!", thePlayer, 255, 0, 0, false)
			end
			setTimer (unbindKey, 1000, 1, playerWhoUses, "tab", "down", hospitalArmorPickup)
		else
			outputChatBox ("You haven't got enough money to take this!", playerWhoUses, 255, 0, 0, false)
		end
	end
end
addEventHandler ("onPickupUse", getRootElement(), weaponPayment)

function hospitalHealthPickup (thePlayer)
	if (getPlayerMoney (thePlayer) > healthMoney) then
		takePlayerMoney (thePlayer, healthMoney)
		setElementHealth (thePlayer, 100)
		outputChatBox ("Picked up a healthpickup, you have paid 1$ for each %", thePlayer, 255, 0, 0, false)
	else
	outputChatBox ("You haven't got enough money to take this!", thePlayer, 255, 0, 0, false)
	end
end
