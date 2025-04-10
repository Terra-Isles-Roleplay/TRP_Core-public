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
---@alias vehicles table
---@param key string
---@param value string
---@param returnArray boolean
---@return vehicles
function TRPCore.Server.GetVehicle(key, value, returnArray)
    if not key or not value then return TRPCore.Server.Data.Vehicles end
    local keyTypes
    local vehicles = {}
    if TRPCoreConfig.Server.CADVersion == 'v1' then
        keyTypes = {id = "_id", vinNumber = "vin", plate = "plate"}
    elseif TRPCoreConfig.Server.CADVersion == 'v2' then
        --keyTypes = {id = "_id", CommunityName = "CommunityName", ShortName = "ShortName"}
    else
        --keyTypes = {id = "_id", CommunityName = "CommunityName", ShortName = "ShortName"}
    end
    local findBy = keyTypes[key]

    if findBy then
        for veh, info in pairs(TRPCore.Server.Data.Vehicles) do
            if info[findBy] == value then
                if returnArray then
                    vehicles[#vehicles+1] = info
                else
                    vehicles[veh] = info
                end
            else
                local response = TRPlib.APICall('GET', '', {key = value})
                table.insert(TRPCore.Server.Data.Vehicles, response.response)
            end
        end
    else -- if users table is empty
        local response = TRPlib.BubbleAPICall('GET', '', {key = value})
        ---@diagnostic disable-next-line: undefined-field, need-check-nil
        local responseData = response.response
        table.insert(TRPCore.Server.Data.Vehicles, responseData)

    end
    return vehicles
end