-- This acts as a working Weather Report UI.  It's fairly pretty as it is, but it's
-- mainly here to show you how you could communicate with the resource
-- to send the weather data to your own resource in order to display it
-- in your own nicely designed server branded UI.  

-- Or I suppose you could just edit this script if you wanted to :)

DayWeatherIcons = {}
DayWeatherIcons[0] = "0"
DayWeatherIcons[1] = "1"
DayWeatherIcons[2] = "2"
DayWeatherIcons[3] = "2"
DayWeatherIcons[4] = "3"
DayWeatherIcons[5] = "2"
DayWeatherIcons[6] = "1"
DayWeatherIcons[7] = "4"
DayWeatherIcons[8] = "5"
DayWeatherIcons[9] = "6"
DayWeatherIcons[10] = "7"
DayWeatherIcons[11] = "8"
DayWeatherIcons[12] = "4"
DayWeatherIcons[13] = "4"
DayWeatherIcons[14] = "9"
DayWeatherIcons[15] = "4"
DayWeatherIcons[16] = "10"

NightWeatherIcons = {}
NightWeatherIcons[0] = "0"
NightWeatherIcons[1] = "0"
NightWeatherIcons[2] = "0"
NightWeatherIcons[3] = "1"
NightWeatherIcons[4] = "2"
NightWeatherIcons[5] = "1"
NightWeatherIcons[6] = "0"
NightWeatherIcons[7] = "2"
NightWeatherIcons[8] = "3"
NightWeatherIcons[9] = "4"
NightWeatherIcons[10] = "1"
NightWeatherIcons[11] = "0"
NightWeatherIcons[12] = "2"
NightWeatherIcons[13] = "5"
NightWeatherIcons[14] = "5"
NightWeatherIcons[15] = "6"
NightWeatherIcons[16] = "7"

function toggleWeatherReport()
		if (wdwWeather ~= nil) then
		-- Must be a better way of doing this clean up - originally I tried only clearing the tabs, rather than the whole window, 
		--but it either didn't delete the tabs, or crashed the game...not ideal, either way! This way works, but it could be improved, no doubt.
			guiSetVisible(wdwWeather, false) 
			showCursor(false)
			destroyElement(tabToday)
			destroyElement(tabTomorrow)
			destroyElement(tabDayAfter)
			destroyElement(tabPanel)
			destroyElement(wdwWeather)
			wdwWeather = nil
		else
			showCursor(true)
			triggerServerEvent("onUpdateWeather", getRootElement())			
		end
end

function updateWeatherAdvanced(WeatherOvernight, WeatherToday, WeatherTonight, WeatherTomorrowDay, WeatherTomorrowNight, WeatherDayAfterDay, WeatherDayAfterNight)

		-- Originally I would build the window outside of this update function, so that this function would just update the tabs themselves,
		--but I had issues doing it that way - so I made it recreate the window from scratch every time you open the weather report window
        local X = 0.40
        local Y = 0.40
        local Width = 0.40
        local Height = 0.40
        wdwWeather = guiCreateWindow(X, Y, Width, Height, "The Latest Weather Report", true)
		guiWindowSetSizable(wdwWeather,false)
		tabPanel = guiCreateTabPanel ( 0, 0.1, 1, 1, true, wdwWeather)
		guiSetVisible(wdwWeather, true)
		tabToday = guiCreateTab("Today", tabPanel)
		tabTomorrow = guiCreateTab("Tomorrow", tabPanel)
		tabDayAfter = guiCreateTab("Day After", tabPanel)

	--Note: WeatherOvernight and and WeatherToday can be nil, depending on the time of the day you're 
	--making the request, so we need to handle that in our code

	if (WeatherOvernight ~= nil) then
			overnightlabel = guiCreateLabel(0.05,0.1,0.3,0.2,"Overnight",true,tabToday)		
			guiCreateStaticImage(0.05,0.3,0.3,0.3, "img/Night/" .. NightWeatherIcons[WeatherOvernight] .. ".png", true, tabToday)
			overnightdesc = guiCreateLabel(0.05,0.7,0.3,0.2,GetNightWeatherDescription(WeatherOvernight),true,tabToday)
			guiLabelSetHorizontalAlign(overnightlabel, "center", true)
			guiLabelSetHorizontalAlign(overnightdesc, "center", true)	
			
			todaylabel = guiCreateLabel(0.35,0.1,0.3,0.2,"Today",true,tabToday)		
			guiCreateStaticImage(0.35,0.3,0.3,0.3, "img/Day/" .. DayWeatherIcons[WeatherToday] .. ".png", true, tabToday)
			todaydesc = guiCreateLabel(0.35,0.7,0.3,0.2,GetDayWeatherDescription(WeatherToday),true,tabToday)
			guiLabelSetHorizontalAlign(todaylabel, "center", true)
			guiLabelSetHorizontalAlign(todaydesc, "center", true)

			tonightlabel = guiCreateLabel(0.65,0.1,0.3,0.2,"Tonight",true,tabToday)		
			guiCreateStaticImage( 0.65, 0.3, 0.3, 0.3, "img/Night/" .. NightWeatherIcons[WeatherTonight]  .. ".png", true, tabToday)
			tonightdesc = guiCreateLabel(0.65,0.7,0.3,0.2, GetNightWeatherDescription(WeatherTonight),true,tabToday)		

	else
		if (WeatherToday ~= nil) then
			todaylabel = guiCreateLabel(0.05,0.1,0.3,0.2,"Today",true,tabToday)		
			guiCreateStaticImage( 0.05, 0.3,0.3, 0.3, "img/Day/" .. DayWeatherIcons[WeatherToday] .. ".png", true, tabToday)
			todaydesc = guiCreateLabel(0.05,0.7,0.3,0.1,GetDayWeatherDescription(WeatherToday),true,tabToday)
			guiLabelSetHorizontalAlign(todaylabel, "center", true)
			guiLabelSetHorizontalAlign(todaydesc, "center", true)
			
			tonightlabel = guiCreateLabel(0.65,0.1,0.3,0.2,"Tonight",true,tabToday)		
			guiCreateStaticImage( 0.65, 0.3, 0.3, 0.3, "img/Night/" .. NightWeatherIcons[WeatherTonight]  .. ".png", true, tabToday)
			tonightdesc = guiCreateLabel(0.65,0.7,0.3,0.2, GetNightWeatherDescription(WeatherTonight),true,tabToday)		

		else
		-- Only tonight's weather is to be shown, so we'll centre it.
			tonightlabel = guiCreateLabel(0.35,0.1,0.3,0.2,"Tonight",true,tabToday)		
			guiCreateStaticImage( 0.35, 0.3, 0.3, 0.3, "img/Night/" .. NightWeatherIcons[WeatherTonight]  .. ".png", true, tabToday)
			tonightdesc = guiCreateLabel(0.35,0.7,0.3,0.2, GetNightWeatherDescription(WeatherTonight),true,tabToday)		

		end
		
	end
	
	guiLabelSetHorizontalAlign(tonightlabel, "center", true)
	guiLabelSetHorizontalAlign(tonightdesc, "center", true)
	
	-- Tommorow Tab
	tomorrowlabel = guiCreateLabel(0.05,0.1,0.3,0.2,"Day",true,tabTomorrow)
	guiLabelSetHorizontalAlign(tomorrowlabel, "center", true)
	tomorrownightlabel = guiCreateLabel(0.65,0.1,0.3,0.2,"Night",true,tabTomorrow)		
	guiLabelSetHorizontalAlign(tomorrownightlabel, "center", true)
	guiCreateStaticImage( 0.05, 0.3,0.3, 0.3, "img/Day/" .. DayWeatherIcons[WeatherTomorrowDay] .. ".png", true, tabTomorrow)
	guiCreateStaticImage( 0.65, 0.3,0.3, 0.3, "img/Night/" .. NightWeatherIcons[WeatherTomorrowNight]  .. ".png", true, tabTomorrow)
	tomorrowdesc = guiCreateLabel(0.05,0.7,0.3,0.2, GetDayWeatherDescription(WeatherTomorrowDay),true,tabTomorrow)		
	tomorrownightdesc = guiCreateLabel(0.65,0.7,0.3,0.2, GetNightWeatherDescription(WeatherTomorrowNight),true,tabTomorrow)		
	guiLabelSetHorizontalAlign(tomorrowdesc, "center", true)
	guiLabelSetHorizontalAlign(tomorrownightdesc, "center", true)

	-- Day After Tab
	dayafterlabel = guiCreateLabel(0.05,0.1,0.3,0.2,"Day",true,tabDayAfter)		
	dayafternightlabel = guiCreateLabel(0.65,0.1,0.3,0.2,"Night",true,tabDayAfter)		
	guiLabelSetHorizontalAlign(dayafterlabel, "center", true)
	guiLabelSetHorizontalAlign(dayafternightlabel, "center", true)
	guiCreateStaticImage( 0.05, 0.3,0.3, 0.3, "img/Day/" .. DayWeatherIcons[WeatherDayAfterDay] .. ".png", true, tabDayAfter)
	guiCreateStaticImage( 0.65, 0.3, 0.3, 0.3, "img/Night/" .. NightWeatherIcons[WeatherDayAfterNight]  .. ".png", true, tabDayAfter)
	dayafterdesc = guiCreateLabel(0.05,0.7,0.3,0.2,GetDayWeatherDescription(WeatherDayAfterDay),true,tabDayAfter)		
	dayafternightdesc = guiCreateLabel(0.65,0.7,0.3,0.2, GetNightWeatherDescription(WeatherDayAfterNight),true,tabDayAfter)		
	guiLabelSetHorizontalAlign(dayafterdesc, "center", true)
	guiLabelSetHorizontalAlign(dayafternightdesc, "center", true)
	
end

function InitialiseWeatherReport()
	optional = xmlLoadFile("optional.xml")
	node = xmlFindChild(optional, "setting", 0)
	enabled = xmlNodeGetAttribute(node, "value")  
	node = xmlFindChild(optional, "setting", 1)
	keymap = xmlNodeGetAttribute(node, "value")
	helpTab = call(getResourceFromName("helpmanager"), "addHelpTab", getThisResource(), true)
	helpMsg = "We are running Churchill's BetterWeather system on this server.  We have no control over the weather."
	if (enabled == "true") then
		helpMsg = helpMsg .. "  You can view Weather Reports by pressing " .. keymap .. "."
		bindKey(keymap,"down",toggleWeatherReport)
	end
	guiCreateMemo (0.05, 0.05, 0.9, 0.9,helpMsg,true, helpTab)		
	xmlUnloadFile(optional)
end

-- on client load, create the window, bind the weather report to the key specified in the settings in meta.xml
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), InitialiseWeatherReport)

addEvent("onWeatherFetched",true)
addEventHandler("onWeatherFetched", getRootElement(), updateWeatherAdvanced)
--
		
