GUIEditor_Label = {}

theWindow = guiCreateWindow(8,136,149,220,"Funmode GUI",false)
guiWindowSetSizable(theWindow,false)
guiSetVisible (theWindow, false)
GUIEditor_Label[1] = guiCreateLabel(0.0671,0.1273,0.8255,0.0773,"Car",true,theWindow)
guiLabelSetColor(GUIEditor_Label[1],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
guiSetFont(GUIEditor_Label[1],"default-bold-small")
spawnBut = guiCreateButton(0.0604,0.2227,0.4161,0.0955,"Spawn",true,theWindow)
destroyBut = guiCreateButton(0.4966,0.2227,0.4161,0.0955,"Destroy",true,theWindow)
fixBut = guiCreateButton(0.0604,0.3227,0.4161,0.0955,"Fix $50",true,theWindow)
flipBut = guiCreateButton(0.5034,0.3227,0.4161,0.0955,"Flip",true,theWindow)
GUIEditor_Label[2] = guiCreateLabel(0.0537,0.4409,0.8591,0.0773,"Taxi",true,theWindow)
guiLabelSetColor(GUIEditor_Label[2],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
guiSetFont(GUIEditor_Label[2],"default-bold-small")
pirshipBut = guiCreateButton(0.0604,0.5273,0.8792,0.1,"Pirateship $25",true,theWindow)
ammuBut = guiCreateButton(0.0604,0.6364,0.8792,0.1,"Ammunation $50",true,theWindow)
carshopBut = guiCreateButton(0.0604,0.7455,0.8792,0.1,"Bank $50",true,theWindow)
clothBut = guiCreateButton(0.0604,0.8545,0.8792,0.1,"Clothesshop $50",true,theWindow)

function resourceStart ()
  bindKey ("m", "down", menuShow)
end
addEventHandler ("onClientResourceStart", getRootElement(), resourceStart)

function menuShow ()
	visableornot = guiGetVisible (theWindow)
	if (visableornot == true) then
		guiSetVisible (theWindow, false)
		showCursor (false)
	end
	if (visableornot == false) then
		guiSetVisible (theWindow, true)
		showCursor (true)
	end
end

addEvent ("carSpawn", true)
addEvent ("carDestroy", true)
addEvent ("carFix", true)
addEvent ("carFlip", true)
addEvent ("taxiShip", true)
addEvent ("taxiAmmu", true)
addEvent ("taxiCar", true)
addEvent ("taxiCloth", true)

function guiClick (button, state, absoluteX, absoluteY)
  if (source == spawnBut) then
    triggerServerEvent ("carSpawn", getLocalPlayer())
  elseif (source == destroyBut) then
    triggerServerEvent ("carDestroy", getLocalPlayer())
  elseif (source == fixBut) then
    triggerServerEvent ("carFix", getLocalPlayer())
  elseif (source == flipBut) then
    triggerServerEvent ("carFlip", getLocalPlayer())
  elseif (source == pirshipBut) then 
    triggerServerEvent ("taxiShip", getLocalPlayer())
  elseif (source == ammuBut) then
    triggerServerEvent ("taxiAmmu", getLocalPlayer())
  elseif (source == carshopBut) then
    triggerServerEvent ("taxiCar", getLocalPlayer())
  elseif (source == clothBut) then
    triggerServerEvent ("taxiCloth", getLocalPlayer())
  end
end
addEventHandler ("onClientGUIClick", getRootElement(), guiClick)