--[[
  _______ _____  _____         _____          _____   _______     ___   _  _____ 
 |__   __|  __ \|  __ \       / ____|   /\   |  __ \ / ____\ \   / / \ | |/ ____|
    | |  | |__) | |__) |_____| |       /  \  | |  | | (___  \ \_/ /|  \| | |     
    | |  |  _  /|  ___/______| |      / /\ \ | |  | |\___ \  \   / | . ` | |     
    | |  | | \ \| |          | |____ / ____ \| |__| |____) |  | |  | |\  | |____ 
    |_|  |_|  \_\_|           \_____/_/    \_\_____/|_____/   |_|  |_| \_|\_____|
                                                                                 
	TRPCore Cache API
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]


---@param key string
---@param value string
---@param returnArray boolean
---@alias civilians table
---@return civilians table
function TRPCore.Server.GetCivilian(key, value, returnArray)
    local civilians = {}
    if not key or not value then return TRPCore.Server.API.Cache.Civilians end
    local keyTypes
    if TRPCore.Server.Config.CADVersion == 'v1' then
        keyTypes = {id = "_id", name = "full name"}
    end
    local findBy = keyTypes[key]

    if findBy then
        for civ, info in pairs(TRPCore.Cache.CadInfo) do
            if info[findBy] == value then
                if returnArray then
                    civilians[#civilians+1] = info
                else
                    civilians[civ] = info
                end
            else
                local response = TRPCore.APICall(TRPCore.Server.Config.CADWorkflowURL, 'getcivilian', 'GET', '', {key = value})
                table.insert(TRPCore.Server.Data.Civilians, response.response)
            end
        end
    else -- if users table is empty
        local response = TRPCore.APICall(TRPCore.Server.Config.CADWorkflowURL, 'getcivilian', 'GET', '', {key = value})
        if response then
            table.insert(TRPCore.Server.API.Cache.Civilians, response.response)
        end
    end
    return civilians
end

return TRPCore.Server.GetCivilian