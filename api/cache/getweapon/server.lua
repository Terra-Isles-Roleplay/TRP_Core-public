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
---@return weapons|boolean
function TRPCore.GetWeapon(key, value, returnArray)
    if not key or not value then return TRPCore.Server.Data.Weapons end
    local keyTypes
    local weapons = {}
    
    keyTypes = {id = "_id", registrationNumber = "Registration Number"}

    local findBy = keyTypes[key]

    if findBy then
        for weapon, info in pairs(TRPCore.Server.Data.Weapons) do
            if info[findBy] == value then
                if returnArray then
                    weapons[#weapons+1] = info
                else
                    weapons[weapon] = info
                end
            else
                local response = TRPlib.BubbleAPICall('GET', 'wf', 'getWeapon', '', {key = value})
                table.insert(TRPCore.Server.Data.Weapons, response.response)
            end
        end
    else -- if users table is empty
        local response = TRPlib.BubbleAPICall('GET', 'wf', 'getWeapon', '', {key = value})
        if response then
            table.insert(TRPCore.Server.Data.Weapons, response.response)
        end
    end
    return weapons
end