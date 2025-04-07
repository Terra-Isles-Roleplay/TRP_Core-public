--[[                                                       
	TRP_Core getdivision
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]

---@param key string
---@param value string
---@param returnArray boolean
---@alias divisions table
---@return divisions table
function TRPCore.Server.GetDivision(key, value, returnArray)
    if not key or not value then return TRPCore.Server.Data.Divisions end
    local keyTypes
    local divisions = {}
    if TRPCoreConfig.Server.CADVersion == 'v1' then
        keyTypes = {id = "_id", name = "Name", abbreviation = "Abbreviation"}
    elseif TRPCoreConfig.Server.CADVersion =='v2' then
        keyTypes = {id = "_id", name = "divName"}
    else
        -- You must add your own key types here
    end
    local findBy = keyTypes[key]

    if findBy then
        for subdiv, info in pairs(TRPCore.Server.Data.Divisions) do
            if info[findBy] == value then
                if returnArray then
                    divisions[#divisions+1] = info
                else
                    divisions[subdiv] = info
                end
            else
                local response = TRPCore.APICall(TRPCoreConfig.Server.CADWorkflowURL, 'getdivision', 'GET', '', {key = value})
                table.insert(TRPCore.Server.Data.Divisions, response.response)
            end
        end
    else -- if users table is empty
        local response = TRPCore.APICall(TRPCoreConfig.Server.CADWorkflowURL, 'getdivision', 'GET', '', {key = value})
        if response then
            table.insert(TRPCore.Server.Data.Divisions, response.response)
        end
    end
    return divisions
end

return TRPCore.GetDivision