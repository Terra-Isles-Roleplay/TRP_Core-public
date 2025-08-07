--[[
	TRPCore Client Configuration
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Only change theses values
]]
local Config = {} -- Do Not Edit this line

--- Set Deafult key to open the menu
Config.menuKey = ''

--- Set the command used to open the menu
Config.menuCommand = 'trpmenu'

--- Set the Menu Header Title
Config.menuTitle = 'TRP Interaction Menu'

--- Config the Menu Position (options; top-left,top-right,top-center,bottom-left,bottom-right,bottom-center,left-center,right-center,center)
TRPCoreConfig.Client.menuPosition = 'top-right'

--- Disabled = 0 | Enabled = 1
Config.CommandDistanceChecked = 0
--- The Distance to check for commands when enabled.
Config.CommandDistance = 50

--- Disabled = false | Enabled = true
Config.enableBreakWindow = false

--- The deafult keybind. This can be changed per player in FiveM Keybind settings in-game.
Config.breakWindowKey = '' -- Leave blank if you don't want a deafult key set.

--- Set the command used as a alt for breaking a window (This must have an option for enabling custom keybind)
Config.breakWindowCommand = 'breakwindow'

-- Chance for window to break (0.0 to 1.0)
Config.breakWindowChance = 0.75 -- 75% success chance

--- Disabled = false | Enabled = true | Enable to set whitelisted/blacklisted weapons, otherwise any weapon can be used.
Config.enableBreakWindowsWhitelistBlacklist = false

--- Set Whitelisted weapons
Config.breakWindowWhitelistedWeapons = {
    [`WEAPON_NIGHTSTICK`] = true,
    [`WEAPON_CROWBAR`] = true,
    [`WEAPON_BAT`] = true,
    [`WEAPON_WRENCH`] = true,
    [`WEAPON_GOLFCLUB`] = true,
    [`WEAPON_HAMMER`] = true,
    [`WEAPON_BATTLEAXE`] = true
}

--- Set blacklisted weapons
Config.breakWindowBlacklistedWeapons = {
    [`WEAPON_EXAMPLE`] = false
}

--- Client Side Logging

---@class boolean
Config.Logging = false

---@class boolean
Config.debugMode = false -- Only enabled if you have to.

---@class boolean
Config.PrintInfo = false

---@class boolean
Config.PrintWarn = false

---@class boolean
Config.PrintError = false

--- DO NOT EDIT BELOW THIS LINE

TRPCoreConfig.Client = Config

return TRPCoreConfig.Client
