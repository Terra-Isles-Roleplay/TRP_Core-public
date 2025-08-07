function TRPCore.Client.LeoRestrict()
    local player = TRPCore.Client.Bridge.getPlayer()
    return player and isJobAllowed(player.job, TRPCoreConfig.Server.PoliceJobs)
end
function TRPCore.Client.FireRestrict()
    local player = TRPCore.Client.Bridge.getPlayer()
    return player and isJobAllowed(player.job, TRPCoreConfig.Shared.FireJobs)
end