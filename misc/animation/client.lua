AnimationWindow = guiCreateWindow(0.7337,0.2217,0.2288,0.3717,"Animations",true)
guiSetVisible (AnimationWindow, false)
guiWindowSetSizable (AnimationWindow, false)
AnimationGridList = guiCreateGridList(0.0492,0.1031,0.9016,0.704,true,AnimationWindow)
guiGridListSetSelectionMode (AnimationGridList, 1)
guiGridListSetSelectionMode(AnimationGridList,2)
guiGridListAddColumn(AnimationGridList,"Animation",0.5)
guiGridListAddColumn(AnimationGridList,"Command",0.4)

local animations = {{"Walk drunk","/drunk"},{"Piss :>","/piss"},{"sit","/sit1"},{"sit","/sit2"},{"sit","/sit3"},{"lay","/lay"},{"dance","/dance1"},{"show youself","/show"},{"stop animation","/stopani"}}
for i,v in ipairs (animations) do
  local row = guiGridListAddRow (AnimationGridList)
  guiGridListSetItemText (AnimationGridList, row, 1, v[1], false, true)
  guiGridListSetItemText (AnimationGridList, row, 2, v[2], false, true)
end


function resourceStart ()
  bindKey ("n", "down", animationMenuShow)
end
addEventHandler ("onClientResourceStart", getRootElement(), resourceStart)

function animationMenuShow ()
	visableornot = guiGetVisible (AnimationWindow)
	if (visableornot == true) then
		guiSetVisible (AnimationWindow, false)
		showCursor (false)
	else
		guiSetVisible (AnimationWindow, true)
		showCursor (true)
	end
end