--[[
	TRPCore Break Window Function
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Only change vaules in Configuration file.
]]

-- ========== HELPERS ==========

local function isWeaponAllowed(weapon)
    if TRPCoreConfig.Client.enableBreakWindowsWhitelistBlacklist then
        return TRPCoreConfig.Client.breakWindowWhitelistedWeapons[weapon] or false
    end

    if TRPCoreConfig.Client.breakWindowBlacklistedWeapons[weapon] then
        return false
    end

    return true
end

local function GetVehicleInFront()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    local target = coords + (forward * 2.0)

    local rayHandle = StartShapeTestRay(coords.x, coords.y, coords.z, target.x, target.y, target.z, 10, ped, 0)
    local _, hit, _, _, entity = GetShapeTestResult(rayHandle)

    if hit and IsEntityAVehicle(entity) then
        return entity
    end

    return nil
end

local function playBreakAnimation()
    local dict = "melee@large_wpn@streamed_core"
    local anim = "ground_attack_on_spot"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end

    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 1.0, 800, 48, 0, false, false, false)
end

local function playGlassSound(coords)
    PlaySoundFromCoord(-1, "Break_Window", coords.x, coords.y, coords.z, "DLC_HEIST_HACKING_SNAKE_SOUNDS", false, 0, false)
end

local function SmashNearestWindow(vehicle)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestWindow, minDist = -1, 1.5

    for i = 0, 7 do
        if IsVehicleWindowIntact(vehicle, i) then
            local boneName = "window_rf"
            if i == 0 then boneName = "window_lf"
            elseif i == 1 then boneName = "window_rf"
            elseif i == 2 then boneName = "window_lr"
            elseif i == 3 then boneName = "window_rr" end

            local boneIndex = GetEntityBoneIndexByName(vehicle, boneName)
            if boneIndex ~= -1 then
                local bonePos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
                local dist = #(pedCoords - bonePos)
                if dist < minDist then
                    closestWindow = i
                    minDist = dist
                end
            end
        end
    end

    if closestWindow ~= -1 then
        playBreakAnimation()
        Wait(400)

        local roll = math.random()
        local chance = TRPCoreConfig.Client.breakWindowChance or 1.0

        if roll <= chance then
            SmashVehicleWindow(vehicle, closestWindow)
            playGlassSound(GetEntityCoords(vehicle))
        else
            lib.notify({
                title = "Window Break",
                description = "You hit the glass, but it didn’t shatter!",
                type = "inform"
            })
        end
    else
        lib.notify({
            title = "Window Break",
            description = "No intact window nearby.",
            type = "error"
        })
    end
end

-- ========== COMMAND + KEYBIND ==========

local commandName = "breakwindow"

RegisterCommand(commandName, function()
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)

    if isWeaponAllowed(weapon) then
        local vehicle = GetVehicleInFront()
        if vehicle then
            SmashNearestWindow(vehicle)
        else
            lib.notify({
                title = "Window Break",
                description = "No vehicle in front of you.",
                type = "error"
            })
        end
    else
        lib.notify({
            title = "Window Break",
            description = "This weapon can't break windows.",
            type = "error"
        })
    end
end, false)

RegisterKeyMapping(commandName, "Break Vehicle Window", "keyboard", TRPCoreConfig.Client.Client.breakWindowKey)