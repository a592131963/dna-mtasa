local leveltop = 0
local localPlayer = getLocalPlayer()
local localPlayerLevel = "-"

function updateStuff()
	x,y,z = getElementPosition( localPlayer )
	level = math.floor(z  / 3 - 0.5)
	localPlayerLevel = level
	if (z == 700) then
		setElementData ( localPlayer, "Current level", "-" )
		setElementData ( localPlayer, "Max level", leveltop[localPlayer] )
		setElementData ( localPlayer, "Health", "0%" )
	else
		if (level > leveltop) then
			leveltop = level
			setElementData ( localPlayer, "Max level", leveltop )
		end
		if getElementData ( localPlayer,"Current level" ) ~= level then
			setElementData ( localPlayer, "Current level", level )
		end
		local healthText = math.floor(getElementHealth(localPlayer) + 0.5).."%"
		if healthText ~= getElementData(localPlayer,"Health") then--save a bit of bw
			setElementData ( localPlayer, "Health", healthText )
		end
	end
end
setTimer ( updateStuff, 200, 0 )

function level(dataName)
	if getElementType(source) ~= "player" then return end--only the player's data is relevant
	if dataName ~= "Current level" then return end--only the player's data is relevant
		local players = getElementsByType( "player" )
		local maxLevelPlayers = {}
		local maxLevel = 0
		for k,v in ipairs(players) do
			level = tonumber(getElementData ( v, "Current level" )) or 0
			if level > maxLevel then
				maxLevel = level
				maxLevelPlayers = {}
				table.insert ( maxLevelPlayers, getPlayerName(v) )
			elseif level == maxLevel then
				table.insert ( maxLevelPlayers, getPlayerName(v) )
			end
		end
end
addEventHandler ( "onClientElementDataChange",getRootElement(),level )

addEventHandler ( "onClientResourceStart",getResourceRootElement(getThisResource()),
	function()
		setElementData ( localPlayer, "Current level", "-" )
		setElementData ( localPlayer, "Max level", leveltop )
		--
		setTimer ( destroyElement, 10000, 1, instructions )
		setCameraTarget ( localPlayer )
	end
)