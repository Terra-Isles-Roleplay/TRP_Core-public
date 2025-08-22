local Bridge = {}
local NDCore = exports["ND_Core"]

-- EVENTS
RegisterNetEvent("ND:MoneyChange", function(source, account, newAmount)
    --print(("Player %s money updated (%s): %s"):format(source, account, newAmount))
end)

RegisterNetEvent("ND:characterUnloaded", function(source)
    --print("Character unloaded:", source)
end)

RegisterNetEvent("ND:characterLoaded", function(source,character)
    ensurePlayerHasPhone(character.source)
    --print("Character loaded:", source)
end)

RegisterNetEvent("ND:updateCharacter", function(source, character)
    --print("Character updated:", source, json.encode(character))
end)

-- FUNCTIONS

function Bridge.getPlayer(source)
    return NDCore.getPlayer(source)
end

function Bridge.getPlayers()
    return NDCore.getPlayers()
end

function Bridge.fetchCharacter(charId)
    return NDCore.fetchCharacter(charId)
end

function Bridge.fetchAllCharacters(license)
    return NDCore.fetchAllCharacters(license)
end

function Bridge.setActiveCharacter(source, characterId)
    return NDCore.setActiveCharacter(source, characterId)
end

function Bridge.getVehicleById(vehicleId)
    return NDCore.getVehicleById(vehicleId)
end

function Bridge.getVehicle(plate)
    return NDCore.getVehicle(plate)
end

function Bridge.getVehicles(ownerId)
    return NDCore.getVehicles(ownerId)
end

return Bridge