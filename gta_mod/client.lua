local displayNames = true -- 初期状態で名前を表示

-- 名前を描画する関数
local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))

    local scale = 1 / dist * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.5 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- 名前を描画するスレッド
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if displayNames then
            for _, playerId in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(playerId)
                if ped ~= PlayerPedId() then
                    local x, y, z = table.unpack(GetEntityCoords(ped))
                    z = z + 1.0 -- 名前をキャラの頭上に表示するため高さを調整
                    local playerName = GetPlayerName(playerId)

                    DrawText3D(x, y, z, playerName)
                end
            end
        end
    end
end)

-- メニューのコマンド
RegisterCommand("toggleNames", function()
    displayNames = not displayNames -- 表示状態を切り替える
    if displayNames then
        Notify("名前表示をオンにしました。")
    else
        Notify("名前表示をオフにしました。")
    end
end)

-- 通知関数
function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end
--[[
    © 2025 jyup
    Toggle player names display with a menu.
--]]
