--[[
  _______ _____  _____         _____          _____   _______     ___   _  _____ 
 |__   __|  __ \|  __ \       / ____|   /\   |  __ \ / ____\ \   / / \ | |/ ____|
    | |  | |__) | |__) |_____| |       /  \  | |  | | (___  \ \_/ /|  \| | |     
    | |  |  _  /|  ___/______| |      / /\ \ | |  | |\___ \  \   / | . ` | |     
    | |  | | \ \| |          | |____ / ____ \| |__| |____) |  | |  | |\  | |____ 
    |_|  |_|  \_\_|           \_____/_/    \_\_____/|_____/   |_|  |_| \_|\_____|
                                                                                 
	TRP-CADSync FiveM API
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]

SetHttpHandler(function(req, res)
    if req.method == 'post' then

        req.setDataHandler(function(body)
        
            local data = json.decode(body)

            if data == nil then
                res.writeHead(400, { ['Content-Type'] = 'application/json' })
                res.send(json.encode({response="ERROR: No Data sent"}))
                TRP.Server.Function.Logging.Print('[TRP-CADSYNC] No Data found in API Call to Server.', 'error')
            end 
            if req.path == nil or req.path == '' then
                res.writeHead(400, { ['Content-Type'] = 'application/json' })
                res.send(json.encode({response="ERROR: Incorrect url submitted"}))
                TRP.Server.Function.Logging.Print('[TRP-CADSYNC] Incorrect URL used in API Call to Server.', 'error')
            else
                -- Add API Calls Here
            end
        
        end)
    elseif req.method == 'get' then
        req.setDataHandler(function(body)
        
            local data = json.decode(body)

            if data == nil then
                res.writeHead(400, { ['Content-Type'] = 'application/json' })
                res.send(json.encode({response="ERROR: No Data sent"}))
                TRP.Server.Function.Logging.Print('[TRP-CADSYNC] No Data found in API Call to Server.', 'error')
            end 
            if req.path == nil or req.path == '' then
                res.writeHead(400, { ['Content-Type'] = 'application/json' })
                res.send(json.encode({response="ERROR: Incorrect url submitted"}))
                TRP.Server.Function.Logging.Print('[TRP-CADSYNC] Incorrect URL used in API Call to Server.', 'error')
            else 
                -- Add API Calls here
            end
        
        end)
    else
        res.writehead(404, { ['Content-Type'] = 'application/json' })
        res.send(json.encode({response="ERROR: method not found."}))
        TRP.Server.Function.Logging.Print('[TRP-CADSYNC] Incorrect Method used in API Call to Server.', 'error')
    end
end)