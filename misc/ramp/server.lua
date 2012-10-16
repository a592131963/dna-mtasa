addEvent("vehicleramps_PlayerSpawnedRamp", true)
addEventHandler("vehicleramps_PlayerSpawnedRamp", getRootElement(),
function(mode, returnedData)
	triggerClientEvent("vehicleramps_SpawnRamp", source, mode, returnedData)
end
)