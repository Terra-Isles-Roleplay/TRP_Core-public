function TRPCore.Server.ToggleRadar()
    if TRPCoreConfig.Server.Radar ~= 0 then
        if IsPedInAnyVehicle(GetPlayerPed(-1)) then
            if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1))) == 18 then
                if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)) == -1) then
                    if TRPCoreConfig.Server.Radar == 1 then
                        TriggerEvent('wk:openRemote')
                    elseif TRPCoreConfig.Server.Radar == 2 then
                        TriggerEvent('wk:radarRC')
                    end
                else
                    TRPCore.Server.Bridge.Notify('~o~You need to be in the driver seat')
                end
            else
                TRPCore.Server.Bridge.Notify('~o~You need to be in a police vehicle')
            end
        else
            TRPCore.Server.Bridge.Notify('~o~You need to be in a vehicle')
        end
    end
end