--Initialise our weather variables with some random weather
WeatherOverNight = math.random(0,16)
WeatherTodayDayTime = math.random(0,16)
WeatherTodayNightTime = math.random(0,16)
WeatherTomorrowDayTime = math.random(0,16)
WeatherTomorrowNightTime = math.random(0,16)
WeatherDayAfterDayTime = math.random(0,16)
WeatherDayAfterNightTime = math.random(0,16)

--Set up some weather descriptions for the numbers - trying to make them a bit more descriptive
DayWeatherDescriptions = {}
DayWeatherDescriptions[0] = "Light Clouds"
DayWeatherDescriptions[1] = "Scattered Clouds"
DayWeatherDescriptions[2] = "Cloudy"
DayWeatherDescriptions[3] = "Cloudy"
DayWeatherDescriptions[4] = "Heavy Clouds"
DayWeatherDescriptions[5] = "Cloudy"
DayWeatherDescriptions[6] = "Low Clouds"
DayWeatherDescriptions[7] = "Hazy/Overcast"
DayWeatherDescriptions[8] = "Thunderstorms"
DayWeatherDescriptions[9] = "Heavy Fog"
DayWeatherDescriptions[10] = "Clear"
DayWeatherDescriptions[11] = "Hot"
DayWeatherDescriptions[12] = "Clouds"
DayWeatherDescriptions[13] = "Dark Skies"
DayWeatherDescriptions[14] = "Light Clouds"
DayWeatherDescriptions[15] = "Heavy Clouds"
DayWeatherDescriptions[16] = "Rain"

NightWeatherDescriptions = {}
NightWeatherDescriptions[0] = "Clear"
NightWeatherDescriptions[1] = "Clear"
NightWeatherDescriptions[2] = "Clear"
NightWeatherDescriptions[3] = "Light Clouds"
NightWeatherDescriptions[4] = "Heavy Clouds"
NightWeatherDescriptions[5] = "Light Clouds"
NightWeatherDescriptions[6] = "Clear"
NightWeatherDescriptions[7] = "Heavy Clouds"
NightWeatherDescriptions[8] = "Thunderstorms"
NightWeatherDescriptions[9] = "Heavy Fog"
NightWeatherDescriptions[10] = "Light Clouds"
NightWeatherDescriptions[11] = "Clear"
NightWeatherDescriptions[12] = "Heavy Clouds"
NightWeatherDescriptions[13] = "Light Clouds"
NightWeatherDescriptions[14] = "Scattered Clouds"
NightWeatherDescriptions[15] = "Heavy Clouds"
NightWeatherDescriptions[16] = "Rain"

function UpdateWeather()
setTime(getTime()) -- stuck this in because I noticed that the client time seems to be slower than  server time and drifts out of sync eventually.  this keeps it closer together.
-- updates weather at midnight every day
-- keep a note of the current night time weather, so that we can show an "overnight" weather when needed
WeatherOverNight = WeatherTodayNightTime

	-- Set Today's Daytime weather
	local rndInt = math.random( 1,100)
	if (rndInt < 70) then
		--  Weather is following the reports,  so today’s weather is now as predicted.
		WeatherTodayDayTime = WeatherTomorrowDayTime
	elseif (rndInt > 69 and rndInt < 90) then
		-- Weather has moved a bit quicker than expected, Today's weather is now what should have been tonight's weather
		WeatherTodayDayTime = WeatherTomorrowNightTime
	else
		--Weather moved even quicker than expected, so the weather today will now be what was originally going to be tomorrow's daytime weather
		WeatherTodayDayTime = WeatherDayAfterDayTime
	end

	--now set today's Evening weather
	if (WeatherTodayDayTime == WeatherTomorrowDayTime) then
		--- Weather is still on track, so the odds are that the weather will continue to follow predicted weather pattern
		rndInt = math.random( 1,100)
		if (rndInt < 70) then
		--  Weather is following the reports,  so tonight's weather is now as predicted it would be
			WeatherTodayNightTime = WeatherTomorrowNightTime
		elseif (rndInt > 69 and rndInt < 90) then
		-- Weather is moving a bit quicker than expected, so tomorrow's day time weather is arriving tonight.
			WeatherTodayNightTime = WeatherDayAfterDayTime
		else
		--Weather is moving even quicker, tomorrow night's weather is now coming tonight.
			WeatherTodayPM = WeatherDayAfterNightTime
		end
	elseif(WeatherTodayDayTime == WeatherTommorowPM) then
	-- If today's weather is already ahead of the schedule, then we need to adjust the rest of the schedule
		rndInt = math.random( 1,100)
		if (rndInt < 70) then
			WeatherTodayNightTime = WeatherDayAfterDayTime
		elseif (rndInt > 69 and rndInt < 90) then
			WeatherTodayNightTime = WeatherDayAfterNightTime
		else
		-- Weather moved so quickly, today's nighttime weather is now going to be something we didn't predict
			WeatherTodayNightTime = math.random(0,16)
		end		
	elseif(WeatherTodayDayTime == WeatherDayAfterDayTime) then
		rndInt = math.random( 1,100)
		if (rndInt < 70) then
		--  Weather is following the reports,  so today’s weather is now as predicted.
			WeatherTodayNightTime = WeatherDayAfterNightTime
		else
			WeatherTodayNightTime = math.random(0,16)
		end		
	end
	
	-- now set tomorrow’s  weather
	if (WeatherTodayNightTime == WeatherTomorrowNightTime) then
		-- weather for today didn't change from the predicted weather
		-- so, there's a high percentage it won't change tomorrow either
		rndInt = math.random(0,100)
		if (rndInt < 70) then
			-- weather will be as it was predicted yesterday.
			WeatherTomorrowDayTime = WeatherDayAfterDayTime
			rndInt = math.random(0,100)
			if (rndInt < 70) then
				WeatherTomorrowNightTime = WeatherDayAfterNightTime
			else
				WeatherTomorrowNightTime = math.random(0,16)
			end

		elseif (rndInt > 69 and rndInt < 90) then
			WeatherTomorrowDayTime = WeatherDayAfterNightTime
			WeatherTomorrowNightTime = math.random(0,16)
		else
			WeatherTomorrowDayTime = math.random(0,16)
			WeatherTomorrowNightTime = math.random(0,16)
		end
	elseif(WeatherTodayNightTime == WeatherDayAfterDayTime) then
		-- weather has changed,..arrived ahead of schedule
		rndInt = math.random(0,100)
		if (rndInt < 70) then
			WeatherTomorrowDayTime = WeatherDayAfterNightTime
			WeatherTomorrowNightTime = math.random(0,16)
		else
			WeatherTomorrowDayTime = math.random(0,16)
			WeatherTomorrowNightTime = math.random(0,16)			
		end
	else
		WeatherTomorrowDayTime = math.random(0,16)
		WeatherTomorrowNightTime = math.random(0,16)	
	end
	
	-- Finally, pick new random weather for WeatherDayAfterDayTime and WeatherDayAfterNightTime
	WeatherDayAfterDayTime = math.random(0,16)
	WeatherDayAfterNightTime = math.random(0,16)
	
	-- set up a timer to call the daytimeweather event, morning weather updates between 6am and 11am
	local hour, mins = getTime()
	if (hour <6) then
	-- Should always come into here if following the planned schedule - e.g. just after midnight
		HoursToMorningUpdate = (6-hour)- 1	
		MinutesToMorningUpdate = (60-mins)		
		HoursToMorningUpdate = HoursToMorningUpdate * 60
		HoursToMorningUpdate = (HoursToMorningUpdate + (60 * math.random(0,5))) * 1000 
		setTimer(DoDayTimeWeather, HoursToMorningUpdate, 1)
	elseif (hour > 5 and hour <19) then -- should only get here if resource is started between 5am and 7pm
		setWeatherBlended(WeatherTodayDayTime)
		HoursToEveningUpdate = (19-hour)- 1	
		MinutesToEveningUpdate = (60-mins)		
		HoursToEveningUpdate = HoursToEveningUpdate * 60
		HoursToEveningUpdate = HoursToEveningUpdate + MinutesToEveningUpdate
		HoursToEveningUpdate = (HoursToEveningUpdate + (60 * math.random(0,4))) * 1000 
		setTimer(DoEveningWeather, HoursToEveningUpdate, 1)
	else -- Will only  get in here on the first execution if the resource is started beween 7pm and midnight.
		setWeatherBlended(WeatherTodayNightTime)
		HoursToMidnightUpdate = (24-hour)-1	
		MinutesToMorningUpdate = (60-mins)		
		HoursToMidnightUpdate = HoursToMidnightUpdate * 60
		HoursToMidnightUpdate = HoursToMidnightUpdate + MinutesToMorningUpdate + 5
		HoursToMidnightUpdate = HoursToMidnightUpdate * 1000
		setTimer(UpdateWeather, HoursToMidnightUpdate, 1)
	end
end

function DoDayTimeWeather()
	setTime(getTime()) -- stuck this in because I noticed that the client time seems to be slower than  server time and drifts out of sync eventually.  this keeps it closer together.
	setWeatherBlended(WeatherTodayDayTime)	
	--Evening Weather updates between 7pm and 11pm
	local hour, mins = getTime()
	HoursToEveningUpdate = (19-hour)- 1	
	MinutesToEveningUpdate = (60-mins)		
	HoursToEveningUpdate = HoursToEveningUpdate * 60
	HoursToEveningUpdate = HoursToEveningUpdate + MinutesToEveningUpdate
	HoursToEveningUpdate = (HoursToEveningUpdate + (60 * math.random(0,4))) * 1000 
	setTimer(DoEveningWeather, HoursToEveningUpdate, 1)
end

function DoEveningWeather()
	setTime(getTime()) -- stuck this in because I noticed that the client time seems to be slower than  server time and drifts out of sync eventually.  this keeps it closer together.
	setWeatherBlended(WeatherTodayNightTime)
	--Work out how minutes/seconds until the midnight update
	local hour, mins = getTime()
	HoursToMidnightUpdate = (24-hour)-1	
	MinutesToMorningUpdate = (60-mins)		
	HoursToMidnightUpdate = HoursToMidnightUpdate * 60
	HoursToMidnightUpdate = HoursToMidnightUpdate + MinutesToMorningUpdate
	HoursToMidnightUpdate = HoursToMidnightUpdate * 1000
	setTimer(UpdateWeather, HoursToMidnightUpdate, 1)
end

function InitialiseWeather()
	UpdateWeather()
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), InitialiseWeather)

-- Export functions

function GetTodaysWeatherDescriptions() 
	local hour, mins = getTime()
	if(hour > 19) then 
		return nil, nil, NightWeatherDescriptions[WeatherTodayNightTime]
	elseif(hour < 7) then
		return NightWeatherDescriptions[WeatherOverNight], DayWeatherDescriptions[WeatherTodayDayTime], NightWeatherDescriptions[WeatherTodayNightTime]
	else
		return nil, DayWeatherDescriptions[WeatherTodayDayTime], NightWeatherDescriptions[WeatherTodayNightTime]
	end
end

function GetTodaysWeatherIDs() 
	local hour, mins = getTime()
	if(hour > 19) then 
		return nil, nil, WeatherTodayNightTime
	elseif(hour < 7) then
		return WeatherOverNight, WeatherTodayDayTime, WeatherTodayNightTime
	else
		return nil, WeatherTodayDayTime, WeatherTodayNightTime
	end
end

function GetAllWeatherDescriptions()
	local hour, mins = getTime()
	if(hour > 19) then 
		return nil,nil,NightWeatherDescriptions[WeatherTodayNightTime], DayWeatherDescriptions[WeatherTomorrowDayTime], NightWeatherDescriptions[WeatherTomorrowNightTime],  DayWeatherDescriptions[WeatherDayAfterDayTime], NightWeatherDescriptions[WeatherDayAfterNightTime]
	elseif(hour < 7) then
		return NightWeatherDescriptions[WeatherOverNight],DayWeatherDescriptions[WeatherTodayDayTime],NightWeatherDescriptions[WeatherTodayNightTime], DayWeatherDescriptions[WeatherTomorrowDayTime], NightWeatherDescriptions[WeatherTomorrowNightTime],  DayWeatherDescriptions[WeatherDayAfterDayTime], NightWeatherDescriptions[WeatherDayAfterNightTime]
	else
		return nil, DayWeatherDescriptions[WeatherTodayDayTime],NightWeatherDescriptions[WeatherTodayNightTime], DayWeatherDescriptions[WeatherTomorrowDayTime], NightWeatherDescriptions[WeatherTomorrowNightTime],  DayWeatherDescriptions[WeatherDayAfterDayTime], NightWeatherDescriptions[WeatherDayAfterNightTime]
	end
end

function GetAllWeatherIDs() 
	local hour, mins = getTime()
	if(hour > 19) then 
		return nil,nil,WeatherTodayNightTime, WeatherTomorrowDayTime, WeatherTomorrowNightTime,  WeatherDayAfterDayTime, WeatherDayAfterNightTime
	elseif(hour < 7) then
		return WeatherOverNight,WeatherTodayDayTime,WeatherTodayNightTime, WeatherTomorrowDayTime, WeatherTomorrowNightTime,  WeatherDayAfterDayTime, WeatherDayAfterNightTime
	else
		return nil, WeatherTodayDayTime,WeatherTodayNightTime, WeatherTomorrowDayTime, WeatherTomorrowNightTime,  WeatherDayAfterDayTime, WeatherDayAfterNightTime
	end
end

function GetDayWeatherDescription(id)
	return DayWeatherDescriptions[id]
end

function GetNightWeatherDescription(id)
	return NightWeatherDescriptions[id]
end

