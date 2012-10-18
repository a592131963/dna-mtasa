--Duplicated here from BetterWeather so that you can retrieve weather description names client side

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

--export functions
function GetDayWeatherDescription(id)
	return DayWeatherDescriptions[id]
end

function GetNightWeatherDescription(id)
	return NightWeatherDescriptions[id]
end