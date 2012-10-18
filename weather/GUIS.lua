-- I could have added this server side code and event handler to the main BetterWeather.lua file
-- However, I wanted to keep this clean, essentially have a 3 tier approach, where BetterWeather.lua
-- acts like a Data Layer.  This file then becomes the Business Logic, providing a link
-- between the UI (client script) and the data layer.

-- It means that the main core of BetterWeather will work without the two optional files.
-- They can be removed (along with their entries in the meta file) if you plan to use your own UI
-- in another resource, using the export functions that this resource provides, rather than rely
-- on the basic weather interface I've included in this version.  (Update: I replaced the initial basic
-- version with a prettier interface so you're less likely to want to create your own front end to the report)

-- But as such, this file provides an idea of how you would include it in your own resource.
--get the weather into local variables (in your case, via the call function to hook in from another resource)
--then send it back as a nicely presented weather summary to your client UI, however you want it to look.

function GetWeatherBasic()
-- Note, this function isn't being called any more! - I was initially going to provide this as an example of how to send 
--the weather data back to the client, leaving it up to you to make a pretty UI for the weather reporting, and 
--possibly include a pretty one in a later version of the resource.

-- But then because I was going to need to create a nice fancy weather reporting UI for my own use anyway,
--I decided to just make the nicer one and include it in the v1 resource for people to use out of the box.

	WeatherReport = ""
	local WeatherOvernight, WeatherToday, WeatherTonight, WeatherTomorrowDay, WeatherTomorrowNight, WeatherDayAfter, WeatherDayAfterNight = GetAllWeatherDescriptions()
	--in your resource, you would do this instead:
	--local WeatherOvernight, WeatherToday, WeatherTonight, WeatherTomorrowDay, WeatherTomorrowNight, WeatherDayAfter, WeatherDayAfterNight = call(getResourceFromName("BetterWeather"), "GetAllWeatherDescriptions")
	
	--Now we build up our weather report string to send back to the client
	--Note: WeatherOvernight and and WeatherToday can be nil, depending on the time of the day you're 
	--making the request, so we need to handle that in our code
	if (WeatherOvernight ~= nil) then
		WeatherReport = "Overnight: " .. WeatherOvernight .. "\n"
	end
	if (WeatherToday ~= nil) then
		WeatherReport = WeatherReport .. "Today: " .. WeatherToday  .. "\n"		
	end

	WeatherReport = WeatherReport .. "Tonight: " .. WeatherTonight  .. "\n"		
	WeatherReport = WeatherReport .. "Tomorrow: " .. WeatherTomorrowDay  .. "\n"		
	WeatherReport = WeatherReport .. "Tomorrow Night: " .. WeatherTomorrowNight  .. "\n"		
	WeatherReport = WeatherReport .. "The Day After: " .. WeatherDayAfter  .. " with " .. WeatherDayAfterNight  .. " in the evening."		

	triggerClientEvent (client, "onWeatherFetched", getRootElement(), WeatherReport)
	-- Note: the original function that handled this trigger would just dump the contents of WeatherReport into a memo, inside a window

end

function GetWeatherPretty()
	--it'll be easier if we just retrieve the IDs rather than full descriptions.  We can work with the IDs in our client side script instead.

	local WeatherOvernight, WeatherToday, WeatherTonight, WeatherTomorrowDay, WeatherTomorrowNight, WeatherDayAfter, WeatherDayAfterNight = GetAllWeatherIDs()
	--in your resource, you would do this instead:
	--local WeatherOvernight, WeatherToday, WeatherTonight, WeatherTomorrowDay, WeatherTomorrowNight, WeatherDayAfter, WeatherDayAfterNight = call(getResourceFromName("BetterWeather"), "GetAllWeatherIDs")
	
	-- I'm now making the client script do the work of building the UI report, as it's a bit fancier now.  
	--Because of this, I'm just sending the retrieved data on to the client script.
	triggerClientEvent (client, "onWeatherFetched", getRootElement(), WeatherOvernight, WeatherToday, WeatherTonight, WeatherTomorrowDay, WeatherTomorrowNight, WeatherDayAfter, WeatherDayAfterNight)
end

addEvent('onUpdateWeather', true)
addEventHandler('onUpdateWeather', getRootElement(), GetWeatherPretty)



