function syncRealTime(player)
    local realtime = getRealTime()
    triggerClientEvent(player, "doSyncRealTime", getRootElement(), realtime.hour, realtime.minute)
end
 
function resourceStart()
    local players = getElementsByType("player")
    for i,player in ipairs(players) do
        syncRealTime(player)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), resourceStart)
 
function playerJoin()
    syncRealTime(source)
end
addEventHandler("onPlayerJoin", getRootElement(), playerJoin)

function syncTime()
    local realTime = getRealTime()
    local hour = realTime.hour
    local minute = realTime.minute
    setTime( hour , minute )
end

setTimer ( syncTime, 60000, 0 )