-- Do not touch. This sets the main table & tables for server, client and shared

---@type table
TRPCore = {}
---@type table
TRPCoreConfig = {}

TRPlib = exports["TRP_lib"]

lib = exports["ox_lib"]

-- Global Data Tables

if IsDuplicityVersion() then
    TRPCore.Server = {}
    TRPCoreConfig.Server = {}
    TRPCore.Server.Data = {}
    TRPCore.Server.Data.CadInfo = {}--CadInfo Data Table
    TRPCore.Server.Data.Divisions = {}--Divisions Data Table
    TRPCore.Server.Data.Civilians = {}
    TRPCore.Server.Data.Users = {}
    TRPCore.Server.Data.Files = {}

elseif not IsDuplicityVersion() then
    TRPCore.Client = {}
    TRPCoreConfig.Client = {}
end

TRPCore.Shared = {}
TRPCoreConfig.Shared = {}