--[[
  _______ _____  _____         _____          _____   _______     ___   _  _____ 
 |__   __|  __ \|  __ \       / ____|   /\   |  __ \ / ____\ \   / / \ | |/ ____|
    | |  | |__) | |__) |_____| |       /  \  | |  | | (___  \ \_/ /|  \| | |     
    | |  |  _  /|  ___/______| |      / /\ \ | |  | |\___ \  \   / | . ` | |     
    | |  | | \ \| |          | |____ / ____ \| |__| |____) |  | |  | |\  | |____ 
    |_|  |_|  \_\_|           \_____/_/    \_\_____/|_____/   |_|  |_| \_|\_____|
                                                                                 
	TRP-CADSync Cache API
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]
---@alias users table
---@param key string
---@param value string
---@param returnArray boolean
---@return users
function TRPCore.Server.GetUser(key, value, returnArray)
    if not key or not value then return TRPCore.Server.Data.Users end
    local users = {}
    local keyTypes = {id = "_id", name = "name", hex = "hex"}
    local findBy = keyTypes[key]

    if findBy and #TRPCore.Server.Data.Users ~= 0 then
        for src, info in pairs(TRPCore.Server.Data.Users) do
            if info[findBy] == value then
                if returnArray then
                    users[#users+1] = info
                else
                    users[src] = info
                end
            else -- is users table is not empty but dosn't include user
                local response = TRPlib.APICall(TRPCoreConfig.Server.CADWorkflowURL, 'getuser', 'GET', '', {key = value})
                table.insert(TRPCore.Server.Data.Users, response.response)
            end
        end
    else -- if table is empty
        local response = TRPlib.APICall(TRPCoreConfig.Server.CADWorkflowURL, 'getuser', 'GET', '', {key = value})
        if response then
            table.insert(TRPCore.Server.Data.Users, response.response)
        end
    end
    return users
end

-- Not sure if we are keeping this
---@alias unloaded boolean
---@param option string
---@return unloaded
function TRPCore.Server.UnloadUser(option)
    local unloaded = false
    if option ~= '' then
        unloaded = true
        TRPCore.Server.Data.Users[option] = nil
    end
    return unloaded
end

---@alias loaded boolean
---@param key string
---@param value string
---@return loaded
function TRPCore.Server.LoadUser(key, value)
    local loaded = false
    if key ~= '' or value ~= '' then
        local user = TRPCore.Server.GetUser(key, value, false)
        if user ~= nil then
            loaded = true
        end
    end
    return loaded
end