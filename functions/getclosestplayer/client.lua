function TRPCore.Client.GetClosestPlayer()
    local Ped = PlayerPedId()

    for _, Player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(Player) ~= GetPlayerPed(-1) then
            local Ped2 = GetPlayerPed(Player)
            local x, y, z = table.unpack(GetEntityCoords(Ped))
            if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  2) then
                return GetPlayerServerId(Player)
            end
        end
    end

    TRPCore.Client.Bridge.notify('No Player Nearby!', 'error')
    return false
end