addEvent ("carSpawn", true)
addEvent ("carDestroy", true)
addEvent ("carFix", true)
addEvent ("carFlip", true)
addEvent ("taxiShip", true)
addEvent ("taxiAmmu", true)
addEvent ("taxiCar", true)
addEvent ("taxiCloth", true)

function carSpawn ()
	if not (isGuestAccount (getPlayerAccount (source))) and not (isPedInVehicle(source)) then
		if (getElementData (source, "hisCar")) and (getElementData (source, "hisCar") ~= nil) and (getElementType(getElementData (source, "hisCar")) == "vehicle") then
			setElementVelocity (getElementData (source, "hisCar"), 0,0,0)
			local x,y,z = getElementPosition (source)
			setVehicleRotation (getElementData (source, "hisCar"), 0, 0, 0)
			setElementPosition (getElementData (source, "hisCar"), x+2,y,z +1)
			outputChatBox ("Car spawned.", source, 255, 0, 0)
		elseif not (getElementData (source, "hisCar")) then
			local accountData = getAccountData (getPlayerAccount (source), "rpg-car")
			if (accountData) then
				carID = getAccountData (getPlayerAccount (source), "rpg-car")
				x,y,z = getElementPosition (source)
				vehicle = createVehicle (carID, x +2, y, z +1)
				setElementID (vehicle, getAccountName (getPlayerAccount(source)))
				setElementData (source, "hisCar", vehicle)
				outputChatBox ("Car spawned.", source, 255, 0, 0)
				if (getAccountData (getPlayerAccount(source), "rpg-carUpgrades")) then
					local upgrades = nil
					local upgrades = {}
					local upgrades = getAccountData (getPlayerAccount(source), "rpg-carUpgrades")
					for i,v in ipairs (upgrades) do
						addVehicleUpgrade (vehicle, v)
					end
				end
				if (getAccountData (getPlayerAccount(source), "rpg-paintjob")) then
					local paintjob = getAccountData (getPlayerAccount(source), "rpg-paintjob")
					setVehiclePaintjob (vehicle, paintjob)
				end
				if (getAccountData (getPlayerAccount(source), "rpg-carcolor1")) and (getAccountData (getPlayerAccount(source), "rpg-carcolor2")) then
					local c1 = getAccountData (getPlayerAccount(source), "rpg-carcolor1")
					local c2 = getAccountData (getPlayerAccount(source), "rpg-carcolor2")
					setVehicleColor (vehicle, c1,c2,0,0)
				end
			else
				outputChatBox ("You haven't got a car.", source, 255, 0, 0)
			end
		else
			outputChatBox ("You're already in a car!", source, 255, 0, 0)
		end
	end
end
addEventHandler ("carSpawn", getRootElement(), carSpawn)

function carDestroy () 
	if	not (isGuestAccount (getPlayerAccount (source))) then
		if (isPedInVehicle (source)) then
			if (getElementID(getPedOccupiedVehicle(source)) == getAccountName (getPlayerAccount(source))) then
				setElementHealth (getElementData (source, "hisCar"), 0)
				destroyElement (getPedOccupiedVehicle (source))
				removeElementData (source, "hisCar")
				outputChatBox ("Car Destroyed.", source, 255, 0, 0)
			else
				outputChatBox ("This not your car!", source, 255, 0, 0)
			end
		elseif (not (isPedInVehicle (source))) and (getElementData (source, "hisCar")) and (getElementData (source, "hisCar") ~= nil) then
			setElementHealth (getElementData (source, "hisCar"), 0)
			outputChatBox ("Car Destroyed.", source, 255, 0, 0)
			removeElementData (source, "hisCar")
		end
	end
end
addEventHandler ("carDestroy", getRootElement(), carDestroy)

function carFix ()
	if (isPedInVehicle (source)) then
		if (getElementID(getPedOccupiedVehicle(source)) == getAccountName (getPlayerAccount(source))) then
			local upgrades = nil
			local upgrades = {}
			local upgrades = getVehicleUpgrades(getPedOccupiedVehicle(source))
			setAccountData (getPlayerAccount (source), "rpg-carUpgrades", upgrades)
			local c1 = nil
			local c2 = nil
			local c1,c2,c3,c4 = getVehicleColor (getPedOccupiedVehicle(source))
			setAccountData (getPlayerAccount (source), "rpg-carcolor1", c1)
			setAccountData (getPlayerAccount (source), "rpg-carcolor2", c2)
			if (getPlayerMoney (source) > 50) then
				fixVehicle (getPedOccupiedVehicle (source))
				takePlayerMoney (source, 50)
				outputChatBox ("Car fixed. 50$", source, 255, 0, 0)
			else
				outputChatBox ("You are too poor.", source, 255, 0, 0)
			end
			outputChatBox ("Upgrades saved.", source, 255, 0, 0)
		end
	else
		outputChatBox ("Repairing a car isn't easy without your car O,o", source, 255, 0, 0)
	end
end
addEventHandler ("carFix", getRootElement(), carFix)

function carFlip ()
	if (isPedInVehicle (source)) and (getElementID(getPedOccupiedVehicle(source)) == getAccountName (getPlayerAccount(source))) then
		rx, ry, rz = getVehicleRotation (getPedOccupiedVehicle(source))
		setVehicleRotation (getPedOccupiedVehicle(source), rx +180, ry, rz +180)
		outputChatBox ("Car flipped.", source, 255, 0, 0)
	else
		outputChatBox ("Flipping a car isn't easy without your car O,o", source, 255, 0, 0)
	end
end
addEventHandler ("carFlip", getRootElement(), carFlip)

function taxiShip ()
	if (not isPedInVehicle (source)) and (getElementInterior (source) == 0) then
		if ( getPlayerMoney( source ) >= 25 ) then
			takePlayerMoney( source, 25 )
			setTimer(setElementPosition,1000,1,source, 2018.20, 1544.8, 10.82 )
			fadeCamera(source,false,1 )
			setTimer(fadeCamera,1000,1,source,true,5 )
		else
			outputChatBox( "You cant take a taxi without having the money!", source, 255, 0, 0 )
		end
	end
end
addEventHandler ("taxiShip", getRootElement(), taxiShip)

function taxiAmmu ()
	if (not isPedInVehicle (source)) and (getElementInterior (source) == 0) then
		if ( getPlayerMoney( source ) >= 50 ) then
			takePlayerMoney( source, 50 )
			setTimer(setElementPosition,1000,1,source, 2154.39, 942.7, 10.8 )
			fadeCamera(source,false,1 )
			setTimer(fadeCamera,1000,1,source,true,5 )
		else
			outputChatBox( "You cant take a taxi without having the money!", source, 255, 0, 0 )
		end
	end
end
addEventHandler ("taxiAmmu", getRootElement(), taxiAmmu)

function taxiCar ()
	if (not isPedInVehicle (source)) and (getElementInterior (source) == 0) then
		if ( getPlayerMoney( source ) >= 50 ) then
			takePlayerMoney( source, 50 )
			setTimer(setElementPosition,1000,1,source, 2494.11, 2063.12, 10.82 )
			fadeCamera(source,false,1 )
			setTimer(fadeCamera,1000,1,source,true,5 )
		else
			outputChatBox( "You cant take a taxi without having the money!", source, 255, 0, 0 )
		end
	end
end
addEventHandler ("taxiCar", getRootElement(), taxiCar)

function taxiCloth ()
	if (not isPedInVehicle (source)) and (getElementInterior (source) == 0) then
		if ( getPlayerMoney( source ) >= 50 ) then
			takePlayerMoney( source, 50 )
			setTimer(setElementPosition,1000,1,source, 2110.9, 2262.3, 10.82 )
			fadeCamera(source,false,1 )
			setTimer(fadeCamera,1000,1,source,true,5 )
		else
			outputChatBox( "You cant take a taxi without having the money!", source, 255, 0, 0 )
		end
	end
end
addEventHandler ("taxiCloth", getRootElement(), taxiCloth)

--Data word verwijderd wanneer vehicle explodeert
addEventHandler ("onVehicleExplode", getRootElement(), 
function()
	local theOwner = getAccountName(getPlayerAccount(source))
	if (theOwner) then
		removeElementData (theOwner, "hisCar")
	end
end)

addEventHandler ("onPlayerQuit", getRootElement(), 
function(quitType, reason, responsibleElement)
	if (getElementData (source, "hisCar")) then
		blowVehicle (getElementData (source, "hisCar"))
		removeElementData (source, "hisCar")
	end
end)

-- anti bug on restart
addEventHandler( "onResourceStop", getResourceRootElement( getThisResource() ),
	function ()
		for i,v in ipairs (getElementsByType ("player")) do
			if (getElementData (v, "hisCar")) then
				setElementHealth (getElementData (v, "hisCar"), 0)
				removeElementData (v, "hisCar")
			end
		end
	end
)