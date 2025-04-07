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

---@alias files table

---@param key string
---@param value string
---@param returnArray boolean
---@return files
function TRPCore.Server.GetFile(key, value, returnArray)
    if not key or not value then return TRPCore.Server.Data.Files end
    local keyTypes
    local files = {}
    if TRPCoreConfig.Server.CADVersion == 'v1' then
        keyTypes = {id = "_id", callNumber = "toString"}
    end
    local findBy = keyTypes[key]

    if findBy then
        for file, info in pairs(TRPCore.Server.Data.Files) do
            if info[findBy] == value then
                if returnArray then
                    files[#files+1] = info
                else
                    files[file] = info
                end
            else
                local response = TRPlib.APICall(TRPCoreConfig.Server.CADWorkflowURL, 'getfile', 'GET', '', {key = value})
                table.insert(TRPCore.Server.Data.Files, response.response)
            end
        end
    else -- if users table is empty
        local response = TRPlib.APICall(TRPCoreConfig.Server.CADWorkflowURL, 'getfile', 'GET', '', {key = value})
        if response then
            table.insert(TRPCore.Server.Data.Files, response.response)
        end
    end
    return files
end