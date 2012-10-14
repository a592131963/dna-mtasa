--Modified by Ransom
players = getElementsByType ( "player" )
root = getRootElement ()

local options = {
	x = 4,
	y = 4,
	--z = 49, -- +1
	z = 40 - 1, -- +1
	--b = 245,
	b = 123,
	r = 4
}
-- Don't touch below!
local matrix = {}
local objects = {}
local moving = {}
local xy_speed
local z_speed
local root = getRootElement()
local barrier_x
local barrier_y
local barrier_r

function move ()
--outputDebugString("move entered")
	local rand
	repeat
		rand = math.random ( 1, options.b )
	until (moving[rand] ~= 1)
	local object = objects[ rand ]
	local move = math.random ( 0, 5 )
--outputDebugString("move: " .. move)
	local x,y,z
	local x2,y2,z2 = getElementPosition ( object )
	local free = {}
	copyTable(matrix,free)
	getFree(free)
	x = x2 / -4
	y = y2 / -4
	z = z2 / 3
	if (move == 0)  and (x ~= 1) and (free[x-1][y][z] == 0) then
		moving[rand] = 1
		local s = 4000 - xy_speed * z
		setTimer (done, s, 1, rand, x, y, z)
		x = x - 1
		matrix[x][y][z] = 1
--outputDebugString("moving obj")
		moveObject ( object, s, x2 + 4, y2, z2, 0, 0, 0 )
	elseif (move == 1) and (x ~= options.x) and (free[x+1][y][z] == 0) then
		moving[rand] = 1
		local s = 4000 - xy_speed * z
		setTimer (done, s, 1, rand, x, y, z)
		x = x + 1
		matrix[x][y][z] = 1
--outputDebugString("moving obj")
		moveObject ( object, s, x2 - 4, y2, z2, 0, 0, 0 )
	elseif (move == 2) and (y ~= 1) and (free[x][y-1][z] == 0) then
		moving[rand] = 1
		local s = 4000 - xy_speed * z
		setTimer (done, s, 1, rand, x, y, z)
		y = y - 1
		matrix[x][y][z] = 1
--outputDebugString("moving obj")
		moveObject ( object, s, x2, y2 + 4, z2, 0, 0, 0 )
	elseif (move == 3) and (y ~= options.y) and (free[x][y+1][z] == 0) then
		moving[rand] = 1
		local s = 4000 - xy_speed * z
		setTimer (done, s, 1, rand, x, y, z)
		y = y + 1
		matrix[x][y][z] = 1
--outputDebugString("moving obj")
		moveObject ( object, s, x2, y2 - 4, z2, 0, 0, 0 )
	elseif (move == 4) and (z ~= 1) and (free[x][y][z-1] == 0) then
		moving[rand] = 1
		local s = 3000 - z_speed * z
		setTimer (done, s, 1, rand, x, y, z)
		z = z - 1
		matrix[x][y][z] = 1
--outputDebugString("moving obj")
		moveObject ( object, s, x2, y2, z2 - 3, 0, 0, 0 )
	elseif (move == 5) and (z ~= options.z) and (free[x][y][z+1] == 0) then
		moving[rand] = 1
		local s = 3000 - z_speed * z
		setTimer (done, s, 1, rand, x, y, z)
		z = z + 1
		matrix[x][y][z] = 1
--outputDebugString("moving obj")
		moveObject ( object, s, x2, y2, z2 + 3, 0, 0, 0 )
	end
--	setTimer ("move", 100 )
end


function onThisResourceStart ( )
	--outputChatBox("* Haystack-em-up v1.43 by Aeron", root, 255, 100, 100)  --PFF meta is good enough :P
	--Calculate speed velocity
	xy_speed = 2000 / (options.z + 1)
	z_speed = 1500 / (options.z + 1)

	--Clean matrix
	for x = 1,options.x do
		matrix[x] = {}
		for y = 1,options.y do
			matrix[x][y] = {}
			for z = 1,options.z do
				matrix[x][y][z] = 0
			end
		end
	end

    --Place number of haybails in matrix
	local x,y,z
	for count = 1,options.b do
		repeat
			x = math.random ( 1, options.x )
			y = math.random ( 1, options.y )
			z = math.random ( 1, options.z )
		until (matrix[x][y][z] == 0)
		matrix[x][y][z] = 1
		objects[count] = createObject ( 3374, x * -4, y * -4, z * 3 ) --, math.random ( 0, 3 ) * 90, math.random ( 0, 1 ) * 180 , math.random ( 0, 1 ) * 180 )
	end

	--Place number of rocks in matrix
	for count = 1,options.r do
		repeat
			x = math.random ( 1, options.x )
			y = math.random ( 1, options.y )
			z = math.random ( 1, options.z )
		until (matrix[x][y][z] == 0)
		matrix[x][y][z] = 1
		createObject ( 1305, x * -4, y * -4, z * 3, math.random ( 0, 359 ), math.random ( 0, 359 ), math.random ( 0, 359 ) )
	end
	
	--Calculate tower center and barrier radius
	barrier_x = (options.x + 1) * -2
	barrier_y = (options.y + 1) * -2	
	if (options.x > options.y) then 
		barrier_r = options.x / 2 + 20 
	else
		barrier_r = options.y / 2 + 20 
	end
	
	--Place top-haybail + minigun
	createObject ( 3374, barrier_x, barrier_y, options.z * 3 + 3 )
	thePickup = createPickup ( barrier_x, barrier_y, options.z * 3 + 6, 3, 2880, 100 )
	setTimer ( move, 100, 0 )
	setTimer ( barrier, 1000, 1)
	fadeCamera ( getRootElement(), true )
end

function barrier ()
	local barrier = createColCircle ( barrier_x, barrier_y, barrier_r )
end

function onPickupHit ( player )
	if source == thePickup then
		outputChatBox( "* " .. getPlayerName ( player ) .. " have reached the top of the hay-stack and obtains 7500$!", root, 255, 0, 0, false )
    outputDebugString (getPlayerName (player) .. " have done hay. (MORE TIMES = CHEAT!)")
		givePlayerMoney (player, 7500)
		setElementPosition (player, -19.21, -30.34, 3.1171875)
	end
end

function done ( id, x, y, z )
	moving[id] = 0
	matrix[x][y][z] = 0
end

function getFree ( src )
	local x,y,z
	local players = getElementsByType( "player" )
	for k,v in ipairs(players) do
		x,y,z = getElementPosition( v )
		x = math.floor(x / -4 + 0.5)
		y = math.floor(y / -4 + 0.5)
		z = math.floor(z / 3 + 0.5)
		if (x >= 1) and (x <= options.x) and (y >= 1) and (y <= options.y) and (z >= 1) and (z <= options.z) then
			src[x][y][z] = 2
		end
	end
end

function copyTable ( src, des )
	for k,v in ipairs(src) do
		if (type(v) == "table") then
			des[k] = {}
			copyTable(src[k],des[k])
		else
			des[k] = v
		end
	end
end



--addEventHandler( "onResourceStart", root, function() onMapLoad() end)
--addEventHandler( "onPickupHit", root, function() onPickupHit() end)
--addEventHandler( "onPlayerJoin", root, function() onPlayerJoin() end)

addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()), onThisResourceStart)
addEventHandler( "onPickupHit", root, onPickupHit)


