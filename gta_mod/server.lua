local arguments = {
    { name = 'greeting', help = 'Enter a greeting message' }
}

local argsRequired = true -- 引数が必須かどうか

QBCore.Commands.Add('hi', 'Send a greeting message', arguments, argsRequired, function(source, args)
    local greeting = args[1] or 'hi'  -- 引数がなければデフォルトで 'hi' を返す
    TriggerClientEvent('chat:addMessage', source, {
        args = { '^1Server', greeting }
    })
end, 'user')
