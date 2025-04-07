--[[
  _______ _____  _____         _____          _____   _______     ___   _  _____ 
 |__   __|  __ \|  __ \       / ____|   /\   |  __ \ / ____\ \   / / \ | |/ ____|
    | |  | |__) | |__) |_____| |       /  \  | |  | | (___  \ \_/ /|  \| | |     
    | |  |  _  /|  ___/______| |      / /\ \ | |  | |\___ \  \   / | . ` | |     
    | |  | | \ \| |          | |____ / ____ \| |__| |____) |  | |  | |\  | |____ 
    |_|  |_|  \_\_|           \_____/_/    \_\_____/|_____/   |_|  |_| \_|\_____|
                                                                                 
	TRPCore CAD DATA API
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]
Citizen.CreateThread(function()
    if TRPCore.Server.Config.SyncCadOnStart then
        local users = TRPCore.APICall(TRPCore.Server.Config.CADDataURL, 'user', 'GET', '')
        local data = users.response.results
        table.insert(TRPCore.Cache.Users, data)
    end
end)

-- Check resouce name

if GetCurrentResourceName() ~= 'TRPCore-CadSync' then
    TRPCore.Server.Function.Logging.Print('Resource has improper name. Please change to TRPCore-CadSync & restart', 'error')
end

local resourceName = 
[[
  _______ _____  _____         _____          _____   _______     ___   _  _____ 
 |__   __|  __ \|  __ \       / ____|   /\   |  __ \ / ____\ \   / / \ | |/ ____|
    | |  | |__) | |__) |_____| |       /  \  | |  | | (___  \ \_/ /|  \| | |     
    | |  |  _  /|  ___/______| |      / /\ \ | |  | |\___ \  \   / | . ` | |     
    | |  | | \ \| |          | |____ / ____ \| |__| |____) |  | |  | |\  | |____ 
    |_|  |_|  \_\_|           \_____/_/    \_\_____/|_____/   |_|  |_| \_|\_____|
                                                                                 
	Created By Terra Isles Development Team
]]

Citizen.CreateThread(function()
    TRPCore.Logging.S_Print(resourceName, 'normal')
    if TRPCore.Server.Config.CADAuthKey == 'Not Set' or TRPCore.Server.Config.CADAuthKey == nil or TRPCore.Server.Config.CADAuthKey == 'nil' then
        TRPCore.Logging.S_Print('[TRPCore] API KEY IS NOT SET, please set in Server Config.', 'error')
    end
    if TRPCore.Server.Config.CADURL == 'Not Set' or TRPCore.Server.Config.CADURL == nil or TRPCore.Server.Config.CADURL == 'nil' then
        TRPCore.Logging.S_Print('[TRPCore] API URL IS NOT SET, please set in Server Config.', 'error')
    end
    if TRPCore.Server.Config.CADServerID == 0 or TRPCore.Server.Config.CADServerID == nil then
        TRPCore.Logging.S_Print('[TRPCore] SERVER ID IS NOT SET, please set in Server Config.', 'error')
    end
end)
