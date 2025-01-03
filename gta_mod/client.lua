local playerNameVisibility = {}

RegisterNetEvent('toggleNames:update')
AddEventHandler('toggleNames:update', function(targetPlayer, visible)
    playerNameVisibility[targetPlayer] = visible

    CreateThread(function()
        while playerNameVisibility[targetPlayer] do
            Wait(0)
            local ped = GetPlayerPed(GetPlayerFromServerId(targetPlayer))
            if ped ~= PlayerPedId() then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + 1.0
                local playerName = GetPlayerName(GetPlayerFromServerId(targetPlayer))
                DrawText3D(x, y, z, playerName)
            end
        end
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))

    local scale = 1 / dist * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
