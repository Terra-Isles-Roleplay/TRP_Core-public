--[[
  _______ _____  _____         _____          _____   _______     ___   _  _____ 
 |__   __|  __ \|  __ \       / ____|   /\   |  __ \ / ____\ \   / / \ | |/ ____|
    | |  | |__) | |__) |_____| |       /  \  | |  | | (___  \ \_/ /|  \| | |     
    | |  |  _  /|  ___/______| |      / /\ \ | |  | |\___ \  \   / | . ` | |     
    | |  | | \ \| |          | |____ / ____ \| |__| |____) |  | |  | |\  | |____ 
    |_|  |_|  \_\_|           \_____/_/    \_\_____/|_____/   |_|  |_| \_|\_____|
                                                                                 
	TRP-CADSync ND Client Intergration
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]

local Bridge = {}
local NDCore = exports["ND_Core"]

-- EVENTS
RegisterNetEvent("ND:updateMoney", function(account, newAmount)
    --print(("Money updated: %s = %s"):format(account, newAmount))
end)

RegisterNetEvent("ND:characterUnloaded", function()
    --print("Character has been unloaded")
end)

RegisterNetEvent("ND:characterLoaded", function(Character)
    local data = NDCore:getPlayer()
    --print(("Character Loaded: %s %s"):format(data.firstname, data.lastname))
end)

RegisterNetEvent("ND:updateCharacter", function(charData)
    --print("Character updated:", json.encode(charData))
end)

-- FUNCTIONS

function Bridge.getPlayer()
    return NDCore:getPlayer()
end

function Bridge.getPlayersFromCoords(distance, coords)
    return NDCore:getPlayersFromCoords(distance, coords)
end

function Bridge.notify(message, type)
    NDCore:notify(message, type or "info")
end

TRPCore.Client.Bridge = Bridge

return TRPCore.Client.Bridge