local phones = {'phone', 'blackberry', 'android', 'flipphone'}

function isPhoneItem(itemName)
    for _, phone in ipairs(TRPCoreConfig.Phones) do
        if phone == itemName then
            return true
        end
    end
    return false
end

function ensurePlayerHasPhone(character)
    local player = TRPCore.Server(character)
    local inventory = player.inventory
    local hasPhone = false
    for _, item in pairs(inventory) do
        if isPhoneItem(item.name) then
            hasPhone = true
            break
        end
    end
    if not hasPhone then
        Citizen.Wait(500)
        local success, response = exports.ox_inventory:AddItem(player.source, 'phone', 1)
        if not success then
            print(player.firstname .. ' ' .. player.lastname .. ' was not given a phone on join. Response:' .. response, 'info')
            return
        else
            print(player.firstname .. ' ' .. player.lastname .. ' was given a phone on join.', 'info')
            return
        end
    else
        print(player.firstname .. ' ' .. player.lastname ..  ' already has a phone on join.', 'info')
        return
    end
end