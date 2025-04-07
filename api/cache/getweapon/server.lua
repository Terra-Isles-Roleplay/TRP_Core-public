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
---@alias weapons table
---@param key string
---@param value string
---@param returnArray boolean
---@return weapons
function TRP.Server.API.Cache.GetWeapon(key, value, returnArray)
    if not key or not value then return TRP.Server.API.Cache.Users end
    local keyTypes
    local weapons = {}
    if TRP.Server.Config.CADVersion == 'v1' then
        keyTypes = {id = "_id", registrationNumber = "Registration Number"}
    elseif TRP.Server.Config.CADVersion == 'v2' then
        --keyTypes = {id = "_id", CommunityName = "CommunityName", ShortName = "ShortName"}
    end
    local findBy = keyTypes[key]

    if findBy then
        for weapon, info in pairs(TRP.Server.API.Cache.CadInfo) do
            if info[findBy] == value then
                if returnArray then
                    weapons[#weapons+1] = info
                else
                    weapons[weapon] = info
                end
            else
                local response = TRP.APICall(TRP.Server.Config.CADWorkflowURL, 'getweapon', 'GET', '', {key = value})
                table.insert(TRP.Server.API.Cache.Users, response.response)
            end
        end
    else -- if users table is empty
        local response = TRP.APICall(TRP.Server.Config.CADWorkflowURL, 'getweapon', 'GET', '', {key = value})
        if response then
            table.insert(TRP.Server.API.Cache.Users, response.response)
        end
    end
    return weapons
end