--[[                                                                           
	TRPCore Shared Configuration
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Only change theses values
]]


-- use TRPCoreConfig.Shared.Option = type <string/boolean>

local Config = {}

---------------------------------------------------------------
--                                                           --
--                   Fire & EMS Features                     --
--                                                           --
---------------------------------------------------------------

--- Fire Jobs
Config.RestrictFireAccess = false
Config.FireJobs = {
    'FRSA',
    'SAAS'
}

---------------------------------------------------------------
--                                                           --
--                     Police Features                       --
--                                                           --
---------------------------------------------------------------
--- WraithRS Radar
--- Disabled = false | Enabled = true
Config.Radar = 0

--- Police Jobs
--- Disabled = false | Enabled = true
Config.RestrictPoliceFeatures = false
Config.PoliceJobs = {
    'SASP'
}
--- Allows retsricting if a player can enter a vehicle while cuffed/zipped tied.
--- Disabled = false | Enabled = True
Config.VehicleEnterCuffed = false

--- Star chase (London Studios)
--- Disabled = false | Enabled = true
Config.ShowStarChase = 0
--- Disabled = false | Enabled = true
Config.StarChaseDevMode = 0

--This determines if the ai traffic manager will can accessible
Config.DisplayTrafficManager = false


TRPCoreConfig.Shared = Config

return TRPCoreConfig.Shared