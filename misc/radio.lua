local textRadio = ""
local currentRadio = ""
local currentIndex = 1
local localPlayer = getLocalPlayer()
local sx,sy = guiGetScreenSize ()
local loltimer = nil
local templol = false

local radios = {"Radio off",
	"Playback FM",
	"K-Rose",
	"K-DST",
	"Bounce FM",
	"SF-UR",
	"Radio Los Santos",
	"Radio X",
	"CSR 103.9",
	"K-Jah West",
	"Master Sounds 98.3",
	"WCTR",
	"User Track Player",
	"Di.fm Dubstep",
	"Di.fm Electro House",
	"RMF Dance",
	"Sky.fm Alternative",
	"Sky.fm Roots Reggae",
	"Sky.fm Classic Rap",
	"Sky.fm Top Hits",
}

local radioPaths = {0,1,2,3,4,5,6,7,8,9,10,11,12,
	"http://80.94.69.106:6374/",
	"http://scfire-ntc-aa02.stream.aol.com:80/stream/1025",
	"http://files.kusmierz.be/rmf/rmfdance-3.mp3",
	"http://u12.sky.fm:80/sky_altrock_aacplus",
	"http://u16b.sky.fm:80/sky_rootsreggae_aacplus",
	"http://u17.sky.fm:80/sky_classicrap_aacplus",
	"http://u12b.sky.fm:80/sky_tophits_aacplus"
}

local playRadioThing = nil

function resetTimer ()
	textRadio = ""
end

addEventHandler("onClientResourceStart",getResourceRootElement(),
function()
	outputChatBox ("Radio system by JasperNL=D Started,")
	showPlayerHudComponent ("radio",false)
	setRadioChannel (0)
	
	bindKey ("radio_next","down",
		function(key,state)
			local nextIndex = ((currentIndex)%(#radioPaths)) +1
			currentIndex = nextIndex
			local radio = radioPaths[nextIndex]
			textRadio = radios[nextIndex]
			if loltimer and isTimer (loltimer) then
				killTimer (loltimer)
			end
			loltimer = setTimer (resetTimer,1000,1)
			if type (radio) == "number" then
				setRadioChannel (radio)
				if playRadioThing then
					stopSound (playRadioThing)
				end
			else
				setRadioChannel (0)
				if playRadioThing then 
					stopSound (playRadioThing)
				end
				playRadioThing = playSound (radio)
			end
		end
	)
	
	bindKey ("radio_previous","down",
		function(key,state)
			local nextIndex = ((currentIndex -2)%(#radioPaths)) +1
			currentIndex = nextIndex
			local radio = radioPaths[nextIndex]
			textRadio = radios[nextIndex]
			if loltimer and isTimer (loltimer) then
				killTimer (loltimer)
			end
			loltimer = setTimer (resetTimer,1000,1)
			if type (radio) == "number" then
				setRadioChannel (radio)
				if playRadioThing then
					stopSound (playRadioThing)
				end
			else
				setRadioChannel (0)
				if playRadioThing then 
					stopSound (playRadioThing)
				end
				playRadioThing = playSound (radio)
			end
		end
	)
	
end)

function renderRadio ()
	dxDrawText (textRadio,0,0,sx,96,-922761116,2,"sans","center","center",false,false,true)
end
addEventHandler ("onClientRender",getRootElement(),renderRadio)

addEventHandler ("onClientVehicleStartExit",getRootElement(),
function(player)
	if localPlayer == player then
		if playRadioThing then
			stopSound (playRadioThing)
		end
		setRadioChannel (0)
		textRadio = ""
	end
end)

addEventHandler ("onClientVehicleExit",getRootElement(),
function(player)
	if localPlayer == player then
		if playRadioThing then
			stopSound (playRadioThing)
		end
		setRadioChannel (0)
		textRadio = ""
	end
end)

addEventHandler ("onClientVehicleEnter",getRootElement(),
function(player)
	if localPlayer == player then
		local radio = radioPaths[currentIndex]
		textRadio = radios[currentIndex]
		if loltimer and isTimer (loltimer) then
			killTimer (loltimer)
		end
		loltimer = setTimer (resetTimer,1000,1)
		if type (radio) == "number" then
			setRadioChannel (radio)
			if playRadioThing then
				stopSound (playRadioThing)
			end
		else
			setRadioChannel (0)
			if playRadioThing then 
				stopSound (playRadioThing)
			end
			playRadioThing = playSound (radio)
		end
	end
end)

_setRadioChannel = setRadioChannel

function setRadioChannel (index)
	templol = true
	_setRadioChannel (index)
end

addEventHandler ("onClientPlayerRadioSwitch",getRootElement(),
function()
	if templol == true then
		if not isPedInVehicle (localPlayer) then
			setRadioChannel (0)
		end
		templol = false
	else
		cancelEvent (true)
		if not isPedInVehicle (localPlayer) then
			setRadioChannel (0)
		end
	end
end)

addEventHandler("onClientElementDestroy",getRootElement(),
function()
	if source and getElementType (source) == "vehicle" then
		if source == getPedOccupiedVehicle (localPlayer) then
			if playRadioThing then
				stopSound (playRadioThing)
			end
			setRadioChannel (0)
			textRadio = ""
		end
	end
end)

addEventHandler("onClientVehicleExplode",getRootElement(),
function()
	if source and getElementType (source) == "vehicle" then
		if source == getPedOccupiedVehicle (localPlayer) then
			if playRadioThing then
				stopSound (playRadioThing)
			end
			setRadioChannel (0)
			textRadio = ""
		end
	end
end)