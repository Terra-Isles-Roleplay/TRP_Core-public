function TRPCore.Server.LeoRestrict(source)
    local player = TRPCore.Server.Bridge.getPlayer(source)
    return player and isJobAllowed(player.job, TRPCoreConfig.Shared.PoliceJobs)
end

function TRPCore.Server.FireRestrict(source)
    local player = TRPCore.Server.Bridge.getPlayer(source)
    return player and isJobAllowed(player.job, TRPCoreConfig.Shared.FireJobs)
end

lib.callback.register('trp:isAdmin', function(source)
    return IsPlayerAceAllowed(source, 'trpcore.adminmenu')
end)