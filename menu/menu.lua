


--- Police Toolbox Menu



if TRPCore.Client.LeoRestrict then
    lib.registerMenu({
        id = 'police_toolbox',
        title = 'Police Toolbox',
        position = TRPCoreConfig.Client.menuPosition,
        options = {
            {label = 'Actions', menu = 'police_actions'}
        }
    })
    lib.registerMenu({
        id = 'police_actions',
        title = 'Police Actions',
        position = TRPCoreConfig.Client.menuPosition,
        onSelected = function() end,
        options = {
            {label = 'Restrain (Cuff)', icon = 'arrows-up-down-left-right', values={'Back', 'Front'}},
            {label = 'Restrain (Zip Tie)', icon = 'arrows-up-down-left-right', values={'Back', 'Front'}},
            {label = 'Drag Player', description = 'Drag/Undrag a player'},
            {label = 'Seat Player', description = 'Seat a player in a vehicle', values={'Rear Left', 'Rear Right', 'Front Passenger'}},
            {label = 'Un-seat Player', description = 'Un-seat player from a vehicle'},
            {label = 'CPR', description = 'Start/stop CPR to a player'},
            {label = 'CPR2', description = 'Start/stop mouth to mouth to a player'},
            onSelect = function(selected,scrollIndex,args)
                local player = TRPCore.Client.GetClosestPlayer()
                if not player then
                    lib.notify({title = 'No Player', description = 'No nearby player found.', type = 'error'})
                    return
                end
                if selected == 1 then
                    local action = (scrollIndex == 1 and 0 or 1)
                    TriggerServerEvent('TRPCore_Server:CuffHandler', GetPlayerPed(-1), player, action)
                elseif selected == 2 then
                    local action = (scrollIndex == 1 and 2 or 3) -- 2 = zip back, 3 = zip front
                    TriggerServerEvent('TRPCore_Server:CuffHandler', GetPlayerPed(-1), player, action)
                end
            end
        }
    })

end

RegisterCommand(TRPCoreConfig.Client.menuCommand, function()
    local options = {}
    if TRPCore.Client.LeoRestrict() then
        table.insert(options, { label = '👮‍♂️ Police Toolbox', menu = 'police_toolbox' })
    end
    if TRPCore.Client.FireRestrict() then
        table.insert(options, { label = '🚒 Fire/EMS Toolbox', menu = 'fireems_toolbox' })
    end
    lib.callback('trp:isAdmin', false, function(isAdmin)
        table.insert(options, { label = '🛠️ Admin Toolbox', menu = 'admin_toolbox' })
    end)

    table.insert(options, {
        { label = '👤 Civilian Toolbox', menu = 'civ_toolbox' },
        { label = '🚗 Vehicle Options', menu = 'vehicle_options' },
        { label = '❌ Exit', close = true }
    })

    lib.registerMenu({
        id = 'trp_menu',
        title = TRPCoreConfig.Client.menuTitle,
        position = TRPCoreConfig.Client.menuPosition,
        options = options
    })
    lib.showMenu('trp_menu')
end)