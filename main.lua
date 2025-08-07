-- Do not touch. This sets the main table & tables for server, client and shared

---@type table
TRPCore = {}
---@type table
TRPCoreConfig = {}

--TRPlib = exports["TRP_lib"]

lib = exports["ox_lib"]

-- Global Data Tables

if IsDuplicityVersion() then
    TRPCore.Server = {}
    TRPCore.Server.Bridge = {}
    TRPCoreConfig.Server = {}
    TRPCore.Server.Data = {}
elseif not IsDuplicityVersion() then
    TRPCore.Client = {}
    TRPCore.Client.Bridge = {}
    TRPCoreConfig.Client = {}
end

TRPCore.Shared = {}
TRPCoreConfig.Shared = {}