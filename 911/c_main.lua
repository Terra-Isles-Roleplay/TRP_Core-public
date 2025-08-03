RegisterNetEvent("TRPCAD:DispatchersCheck", function(response)
    --print("DispatchersCheck: " .. tostring(response))

    local ped = GetPlayerPed(-1)
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local zoneName = GetNameOfZone(x, y, z)
    local lastZone = GetLabelText(zoneName)
    local lastStreet, lastCross = GetStreetNameAtCoord(x, y, z)
    local lastStreetName = GetStreetNameFromHashKey(lastStreet)
    local lastCrossStreet = GetStreetNameFromHashKey(lastCross)
    local ped1 = GetPlayerServerId(PlayerId())

    -- Apply custom street name overrides
    if TRP911Config.streetNames[lastStreetName] then
        lastStreetName = TRP911Config.streetNames[lastStreetName]
    end
    if TRP911Config.streetNames[lastCrossStreet] then
        lastCrossStreet = TRP911Config.streetNames[lastCrossStreet]
    end
    if TRP911Config.zoneNames[lastZone] then
        lastZone = TRP911Config.zoneNames[lastZone]
    end

    if response == 0 then
        --print("No Dispatchers Available, Opening UI")

        SetNuiFocus(true, true)
        SendNUIMessage({ 
            type = "show",
            callTypes = TRP911Config.CallTypes,
            logo = TRP911Config.LogoUrl,
            street = lastStreetName,
            crossStreet = lastCrossStreet,
            zone = lastZone
        })
    elseif response >= 1 then
        --print("Dispatchers Available, Sending Alert")
        TriggerServerEvent("TRPCAD:911AlertDispatch", lastStreetName, lastCrossStreet, ped1, x, y)
    end
end)

RegisterCommand('911', function(args, raw)
    --print('911 Command Triggered') --Debug
    TriggerServerEvent("TRPCAD:availableDispatchers")
end, false)

RegisterCommand('setlocation', function(source, args)
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
    lastStreet, lastCross = GetStreetNameAtCoord(x, y, z)
    lastStreetName = GetStreetNameFromHashKey(lastStreet)
    lastCrossStreet = GetStreetNameFromHashKey(lastCross)
    local ped1 = GetPlayerServerId(PlayerId())
    TriggerServerEvent('TRPCAD:autolocationUpdate',  lastStreetName, lastCrossStreet, ped1, x, y)
end, false)
-- Used for Auto Location
Citizen.CreateThread(function()
    --[[
    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        print(('Player %s with id %i is in the server'):format(name, playerId))
        -- ('%s'):format('text') is same as string.format('%s', 'text)
    end
    ]] --Save for later
    while true do
        local ped = GetPlayerPed(-1)
        x, y, z = table.unpack(GetEntityCoords(ped, true))
        lastStreet, lastCross = GetStreetNameAtCoord(x, y, z)
        lastStreetName = GetStreetNameFromHashKey(lastStreet)
        lastCrossStreet = GetStreetNameFromHashKey(lastCross)
        local ped1 = GetPlayerServerId(PlayerId())
        TriggerServerEvent('TRPCAD:autolocationUpdate',  lastStreetName, lastCrossStreet, ped1, x, y)
        Citizen.Wait(300000)--Default: 300000
    end
end)
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/setlocation', 'Used to set your location to CAD/MDT')
    TriggerEvent('chat:addSuggestion', '/911', 'Open the 911 Reporting Menu')
    --TriggerEvent('chat:addSuggestion', '/911', '<postal> \"<Call Discription>\"', {
	--	{ name="postal", help="Postal Code" },
	--	{ name='"call details"', help='Call Discription (MUST BE IN QUOTATIONS)'}	
	--})
end)

RegisterNUICallback("submit911", function(data, cb)
    local ped = PlayerPedId()
    --local coords = GetEntityCoords(ped)


    TriggerServerEvent("TRPCAD:sendCall", {
        callType = data.callType,
        name = data.name,
        street = data.street,
        crossStreet = data.crossStreet,
        zone = data.zone,
        postal = data.postal,
        description = data.description,
        x = x,
        y = y,
        ped = ped
    })

    SetNuiFocus(false, false)
    SendNUIMessage({ type = "hideAndReset" })
    cb("ok")
end)

RegisterNUICallback("closeUI", function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ type = "hideAndReset" })
    cb("ok")
end)