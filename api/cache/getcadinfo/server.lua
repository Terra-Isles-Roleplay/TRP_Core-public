--[[                                                               
	TRPCore CadInfo Cache
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]

---@type function
---@param key string
---@param value string
---@param returnArray? boolean
---@alias communityInfo table -- Local table for Get Cad Information Function.
---@return communityInfo
function TRPCore.Server.GetCadInfo(key, value, returnArray)
    if not key or not value then return TRPCore.Server.API.Cache.CadInfo end
    local keyTypes = {}
    local communityInfo = {}
    if TRPCoreConfig.Server.CADVersion == 'v1' then
        keyTypes = {id = "_id", communityName = "communityName"}
    elseif TRPCoreConfig.Server.CADVersion == 'v2' then
        --keyTypes = {id = "_id", CommunityName = "CommunityName", ShortName = "ShortName"}
    end
    local findBy = keyTypes[key]

    if findBy then
        for community, info in pairs(TRPCore.Cache.CadInfo) do
            if info[findBy] == value then
                if returnArray then
                    communityInfo[#communityInfo+1] = info
                else
                    communityInfo[community] = info
                end
            else
                local response = TRPCore.APICall(TRPCoreConfig.Server.CADWorkflowURL, 'getcadinfo', 'GET', '', {key = value})
                table.insert(TRPCore.Server.API.Cache.CadInfo, response.response)
            end
        end
    else -- if users table is empty
        local response = TRPCore.APICall(TRPCoreConfig.Server.CADWorkflowURL, 'getcadinfo', 'GET', '', {key = value})
        if response then
            table.insert(TRPCore.Server.Data.CadInfo, response.response)
        end
    end
    return communityInfo
end

return TRPCore.GetCadInfo