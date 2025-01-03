local QBCore = exports['qb-core']:GetCoreObject()
local playerNameVisibility = {}

QBCore.Commands.Add('toggleNames', 'プレイヤー名の表示/非表示を切り替える', {}, false, function(source, args)
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
end)

RegisterNetEvent('toggleNames:update')
AddEventHandler('toggleNames:update', function(src, visibility)
    playerNameVisibility[src] = visibility
end)

AddEventHandler('playerDropped', function()
    local src = source
    playerNameVisibility[src] = nil
end)
