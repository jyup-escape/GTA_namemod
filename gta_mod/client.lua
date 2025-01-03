local playerNameVisibility = {}

AddEventHandler('playerConnecting', function()
    local src = source
    playerNameVisibility[src] = true
end)

RegisterCommand('toggleNames', function(source, args, rawCommand)
    local src = source

    if playerNameVisibility[src] == nil or playerNameVisibility[src] == false then
        playerNameVisibility[src] = true
        TriggerClientEvent('toggleNames:update', -1, src, true)
        TriggerClientEvent('chat:addMessage', src, { args = { "Server", "プレイヤー名の表示をオンにしました。" } })
    else
        playerNameVisibility[src] = false
        TriggerClientEvent('toggleNames:update', -1, src, false)
        TriggerClientEvent('chat:addMessage', src, { args = { "Server", "プレイヤー名の表示をオフにしました。" } })
    end
end, false)

RegisterNetEvent('toggleNames:update')
AddEventHandler('toggleNames:update', function(src, visibility)
    playerNameVisibility[src] = visibility
end)

AddEventHandler('playerDropped', function()
    local src = source
    playerNameVisibility[src] = nil
end)
