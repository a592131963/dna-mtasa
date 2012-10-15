function syncRealTime(h, m)
    setTime(h, m)
    setMinuteDuration(60000)
end
addEvent("doSyncRealTime", true)
addEventHandler("doSyncRealTime", getRootElement(), syncRealTime)
addCommandHandler("hora",syncRealTime)

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

setTimer ( syncRealTime, 10000, 0 )

addEventHandler("onPlayerJoin", getRootElement(), playerJoin)

