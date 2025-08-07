--[[
	TRPCore Server Configuration
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Only change theses values
]]

local Config = {}
local CadDataTypes = {}
local CadWfTypes = {}
-- Cad Sync Configuration
Config.SyncCadOnStart = false -- Syncs CAD data on start
Config.SyncCadInterval = 3600000 --Time in ms to sync from CAD.<br> Default is 1 hour.

Config.Logging = {
    Enabled = false,
    LevelsEnabled = {
        info = false,
        warn = false,
        error = false,
        debug = false
    }
}


-- Discord Configurations

Config.Discord = {
    Enabled = false, -- Enable Discord Options
    LoggingEnable = false, -- Enable logging to Discord via webhook. Must have the webhook enabled.
    GuildId = '', -- Your server ID.
    BotToken = '', -- Your Bot token
    -- Add Custom Events here or call webhook Event in your own script. Leave blank if you don't want to use them.
    Webhooks = {
        Logging = '',
        ApiCall = '',
        Vmenu = '',
    },
    Events = { -- Enable Discord Features
        getMember = false, --Get a user of a discord server
        getGuild = false, --Get a Discord server
        getRoles = false --Get a users roles in a discord server
    },
    Whitelist = { -- Disable if not wanting to use Discord whitelist.
        Enabled = false, -- Must have all Discord features enabled.
        Roles = {"put id here", "second id"} --String table of the roles you want to be whitelisted. Not currently setup.
    }
}

---------------------------------------------------------------
--                                                           --
--                     General Features                      --
--                                                           --
---------------------------------------------------------------
--- Verison Checking
--- Disabled = 0 | Full = 1 [Default] | Simple = 2
Config.VersionCheck = 0

--- Disabled = 0 | Enabled = 1
Config.PropsEnabled = 0

Config.Props = {
    --[[
        EXAMPLE: 
		{name = 'a', spawncode = 'b'},
        ────────────────────────────────────────────────────────────────
        'a' is the title that shows in the menu
        'b' is the spawn code for prop that will be spawned
    ]]
    {name = 'Police Barrier', spawncode = 'prop_barrier_work05'},
    {name = 'Barrier', spawncode = 'prop_barrier_work06a'},
    {name = 'Traffic Cone', spawncode = 'prop_roadcone01a'},
    {name = 'Cone', spawncode = 'prop_roadcone02b'},
    {name = 'Work Barrier', spawncode = 'prop_mp_barrier_02b'},
    {name = 'Work Barrier 2', spawncode = 'prop_barrier_work01a'},
    {name = 'Lighting', spawncode = 'prop_worklight_03b'},
    {name = 'Tent', spawncode = 'prop_gazebo_02'},
    { name = "Evidence Marker #1", spawncode = "prop_marker_01" },
	{ name = "Evidence Marker #2", spawncode = "prop_marker_02" },
	{ name = "Evidence Marker #3", spawncode = "prop_marker_03" },
	{ name = "Evidence Marker #4", spawncode = "prop_marker_04" },
	{ name = "Evidence Marker #5", spawncode = "prop_marker_05" },
	{ name = "Evidence Marker #6", spawncode = "prop_marker_06" },
	{ name = "Evidence Marker #7", spawncode = "prop_marker_07" },
	{ name = "Evidence Marker #8", spawncode = "prop_marker_08" },
	{ name = "Evidence Marker #9", spawncode = "prop_marker_09" },
	{ name = "Evidence Marker #10", spawncode = "prop_marker_10" },
	{ name = "Evidence Marker #11", spawncode = "prop_marker_11" },
	{ name = "Evidence Marker #12", spawncode = "prop_marker_12" },
	{ name = "Evidence Marker #13", spawncode = "prop_marker_13" },
	{ name = "Evidence Marker #14", spawncode = "prop_marker_14" },
	{ name = "Evidence Marker #15", spawncode = "prop_marker_15" },
	{ name = "Evidence Marker #16", spawncode = "prop_marker_16" },
	{ name = "Evidence Marker #17", spawncode = "prop_marker_17" },
	{ name = "Evidence Marker #18", spawncode = "prop_marker_18" },
	{ name = "Evidence Marker #19", spawncode = "prop_marker_19" },
	{ name = "Evidence Marker #20", spawncode = "prop_marker_20" },
	{ name = "Road Work Ahead Barrier", spawncode = "prop_barrier_sign_01" },
	{ name = "Right Lane Closed Barrier", spawncode = "prop_barrier_sign_02" },
	{ name = "Left Lane Closed Barrier", spawncode = "prop_barrier_sign_03" },
	{ name = "Right Lane Ends Barrier", spawncode = "prop_barrier_sign_04" },
	{ name = "Left Lane Ends Barrier", spawncode = "prop_barrier_sign_05" },
	{ name = "Flagger Barrier", spawncode = "prop_barrier_sign_06" },
	{ name = "Prep To Stop Barrier", spawncode = "prop_barrier_sign_07" },
	{ name = "Flagger Ahead Barrier", spawncode = "prop_barrier_sign_08" },
	{ name = "Road Closed Barrier", spawncode = "prop_barrier_sign_09" },
	{ name = "Road Closed Ahead Barrier", spawncode = "prop_barrier_sign_10" },
	{ name = "Traffic Incident Ahead Barrier", spawncode = "prop_barrier_sign_11" },
	{ name = "Check Point Ahead Barrier", spawncode = "prop_barrier_sign_12" },
	{ name = "Keep Left Barrier", spawncode = "prop_barrier_sign_13" },
	{ name = "Keep Right Barrier", spawncode = "prop_barrier_sign_14" },
	{ name = "Road Flooded Barrier", spawncode = "prop_barrier_sign_15" },
	{ name = "Fire Activity Barrier", spawncode = "prop_barrier_sign_16" },
	{ name = "Tow Truck Barrier", spawncode = "prop_barrier_sign_17" },
	{ name = "Utility Work Barrier", spawncode = "prop_barrier_sign_18" },
	{ name = "Shoulder Work Barrier", spawncode = "prop_barrier_sign_19" },
	{ name = "Mower Ahead Barrier", spawncode = "prop_barrier_sign_20" },
	{ name = "Work Crew Ahead Barrier", spawncode = "prop_barrier_sign_21" },
	{ name = "Emer. Scene Ahead Barrier", spawncode = "prop_barrier_sign_22" },
	{ name = "Wait 4 Pilot Car Barrier", spawncode = "prop_barrier_sign_23" },
	{ name = "Fines Doubled WZ Barrier", spawncode = "prop_barrier_sign_24" },
	{ name = "Detour Ahead Barrier", spawncode = "prop_barrier_sign_25" },
	{ name = "Detour L/R Barrier", spawncode = "prop_barrier_sign_26" },
	{ name = "Detour Left Barrier", spawncode = "prop_barrier_sign_27" },
	{ name = "Detour Right Barrier", spawncode = "prop_barrier_sign_28" },
	{ name = "Detour Forward Barrier", spawncode = "prop_barrier_sign_29" },
	{ name = "Slow Barrier", spawncode = "prop_barrier_sign_30" },
	{ name = "Plastic Stop Barrier", spawncode = "prop_barrier_sign_stop" },
	{ name = "Plastic Detour Barrier", spawncode = "prop_barrier_sign_detour" },
	{ name = "Plastic Barrier", spawncode = "prop_barrier_work01b" },
	{ name = "Steel Barrier", spawncode = "prop_barrier_work02a" },
	{ name = "Large Barrier", spawncode = "prop_barrier_work04b" },
	{ name = "Large Barrier 2", spawncode = "prop_barrier_work04br" },
	{ name = "Lg Barrier w/ Lights", spawncode = "prop_barrier_work04c" },
	{ name = "Lg Barrier w/ Lights 2", spawncode = "prop_barrier_work04cr" },
	{ name = "Lg Road Closed Barrier", spawncode = "prop_barrier_work04d" },
	{ name = "Lg Road Closed Barrier 2", spawncode = "prop_barrier_work04dr" },
	{ name = "Lg Road Closed Barrier 3", spawncode = "prop_barrier_work04drx" },
	{ name = "Lg Road Closed Barrier 4", spawncode = "prop_barrier_work04dx" },
	{ name = "Road Closed Detour Barrier", spawncode = "prop_barrier_work04e" },
	{ name = "Road Closed Detour Barrier 2", spawncode = "prop_barrier_work04er" },
	{ name = "Road Closed Detour Barrier 3", spawncode = "prop_barrier_work04erx" },
	{ name = "Road Closed Detour Barrier 4", spawncode = "prop_barrier_work04ex" },
	{ name = "Med Road Wrk Ahd Barrier", spawncode = "prop_barrier_work06b" },
	{ name = "Med St. Closed Barrier", spawncode = "prop_barrier_work06c" },
	{ name = "Sidewalk Closed Barrier", spawncode = "prop_barrier_work06d" },
	{ name = "Road Work Ahead Sign", spawncode = "prop_consign_flag_01" },
	{ name = "Right Lane Closed Sign", spawncode = "prop_consign_flag_02" },
	{ name = "Left Lane Closed Sign", spawncode = "prop_consign_flag_03" },
	{ name = "Right Lane Ends Sign", spawncode = "prop_consign_flag_04" },
	{ name = "Left Lane Ends Sign", spawncode = "prop_consign_flag_05" },
	{ name = "Flagger Sign", spawncode = "prop_consign_flag_06" },
	{ name = "Prep To Stop Sign", spawncode = "prop_consign_flag_07" },
	{ name = "Flagger Ahead Sign", spawncode = "prop_consign_flag_08" },
	{ name = "Road Closed Sign", spawncode = "prop_consign_flag_09" },
	{ name = "Road Closed Ahead Sign", spawncode = "prop_consign_flag_10" },
	{ name = "Traffic Incident Ahead Sign", spawncode = "prop_consign_flag_11" },
	{ name = "Check Point Ahead Sign", spawncode = "prop_consign_flag_12" },
	{ name = "Keep Left Sign", spawncode = "prop_consign_flag_13" },
	{ name = "Keep Right Sign", spawncode = "prop_consign_flag_14" },
	{ name = "Road Flooded Sign", spawncode = "prop_consign_flag_15" },
	{ name = "Fire Activity Sign", spawncode = "prop_consign_flag_16" },
	{ name = "Tow Truck Sign", spawncode = "prop_consign_flag_17" },
	{ name = "Utility Work Sign", spawncode = "prop_consign_flag_18" },
	{ name = "Shoulder Work Sign", spawncode = "prop_consign_flag_19" },
	{ name = "Mower Ahead Sign", spawncode = "prop_consign_flag_20" },
	{ name = "Work Crew Ahead Sign", spawncode = "prop_consign_flag_21" },
	{ name = "Emer. Scene Ahead Sign", spawncode = "prop_consign_flag_22" },
	{ name = "Wait 4 Pilot Car Sign", spawncode = "prop_consign_flag_23" },
	{ name = "Fines Doubled WZ Sign", spawncode = "prop_consign_flag_24" },
	{ name = "Detour Ahead Sign", spawncode = "prop_consign_flag_25" },
	{ name = "Detour L/R Sign", spawncode = "prop_consign_flag_26" },
	{ name = "Detour Left Sign", spawncode = "prop_consign_flag_27" },
	{ name = "Detour Right Sign", spawncode = "prop_consign_flag_28" },
	{ name = "Detour Forward Sign", spawncode = "prop_consign_flag_29" },
	{ name = "Slow Sign", spawncode = "prop_consign_flag_30" },
}
--- Disabled = false | Enabled = true (Everyone has access)
Config.CivAccess = true

--This determines if the civilian adverts sections of the menu if visible
--NOTE: When someone sends an advert it will display the company name and then "Advertisement ##", this is the Server ID of the person that sent the advert
Config.ShowCivAdverts = true

--These are the adverts that are avaiable via the ads menu
--NOTE: You can add additional adverts from https://wiki.gtanet.work/index.php?title=Notification_Pictures
Config.CivAdverts = {
    --[[
        EXAMPLE: 
		{name = 'a', loc = 'b', file = 'c'},
        ────────────────────────────────────────────────────────────────
        'a' is the title of the Adverts
        'b' is the location for the Advert's Image
		'c' is the file name for the Advert's Image
    ]]

    --  !!!!! Wouldn't Recommend Changing These Unless You Know What You're Doing !!!!!
	{name = '24/7', loc = 'CHAR_FLOYD', file = '247'},
    {name = 'Ammunation', loc = 'CHAR_AMMUNATION', file = 'CHAR_AMMUNATION'},
    {name = 'Bugstars', loc = 'CHAR_BUGSTARS', file = 'CHAR_BUGSTARS'},
    {name = 'Cluckin\' Bell', loc = 'CHAR_FLOYD', file = 'BELL'},
    {name = 'Downtown Cab Co.', loc = 'CHAR_TAXI', file = 'CHAR_TAXI'},
    {name = 'Dynasty 8', loc = 'CHAR_FLOYD', file = 'D8'},
    {name = 'Fleeca Bank', loc = 'CHAR_BANK_FLEECA', file = 'CHAR_BANK_FLEECA'},
    {name = 'Gruppe6', loc = 'CHAR_FLOYD', file = 'GRUPPE6'},
    {name = 'Merry Weather', loc = 'CHAR_MP_MERRYWEATHER', file = 'CHAR_MP_MERRYWEATHER'},
    {name = 'Limited Gasoline', loc = 'CHAR_FLOYD', file = 'LTD'},
    {name = 'Liquor Ace', loc = 'CHAR_FLOYD', file = 'ACE'},
    {name = 'Smoke on the Water', loc = 'CHAR_FLOYD', file = 'SOTW'},
    {name = 'Pegasus', loc = 'CHAR_PEGASUS_DELIVERY', file = 'CHAR_PEGASUS_DELIVERY'},
    {name = 'Los Santos Customs', loc = 'CHAR_LS_CUSTOMS', file = 'CHAR_LS_CUSTOMS'},
    {name = 'Los Santos Traffic Info', loc = 'CHAR_LS_TOURIST_BOARD', file = 'CHAR_LS_TOURIST_BOARD'},
    {name = 'Los Santos Water and Power', loc = 'CHAR_FLOYD', file = 'LSWP'},
    {name = 'Mors Mutual Insurance', loc = 'CHAR_MP_MORS_MUTUAL', file = 'CHAR_MP_MORS_MUTUAL'},
    {name = 'PostOP', loc = 'CHAR_FLOYD', file = 'OP'},
    {name = 'Vanilla Unicorn', loc = 'CHAR_MP_STRIPCLUB_PR', file = 'CHAR_MP_STRIPCLUB_PR'},
    {name = 'Weazel News', loc = 'CHAR_FLOYD', file = 'NEWS'},
    {name = 'Facebook', loc = 'CHAR_FACEBOOK', file = 'CHAR_FACEBOOK'},
    {name = 'Life Invader', loc = 'CHAR_LIFEINVADER', file = 'CHAR_LIFEINVADER'},
    {name = 'YouTube', loc = 'CHAR_YOUTUBE', file = 'CHAR_YOUTUBE'},
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

--================================--
--          GASMASK v2.5          --
--          by JellyJam           --
--      License: GNU GPL 3.0      --
--================================--

Config.Mask = 46 --- EUP Number for the Mask
Config.Mask2 = true

---------------------------------------------------------------
--                                                           --
--                   Fire & EMS Features                     --
--                                                           --
---------------------------------------------------------------



---------------------------------------------------------------
--                                                           --
--                     Radio Features                        --
--                                                           --
---------------------------------------------------------------

-- Set to true if you use SCNP25 Radio Script.
-- You can find this Radio script on their website. https://scncomms.app/
-- Disabled = 0 | Enabled = 1
Config.Radio = 1
-- Radio Code Plug Names
Config.RadioChannels = {
    {
        name = 'San Andreas State Police',
        plug = 'sasp',
        itemname = 'saspradio',
        job = 'SASP'
    },
    {
        name = 'San Andreas State Police v2',
        plug = 'nextsasp',
        itemname = 'nextsaspradio',
        job = 'SASP'
    },
    {
        name = 'Training Radio - SASP/SAAS/FRSA',
        plug = 'training',
        itemname = 'trainingradio',
        job = {'SASP','SAAS','FRSA'}
    },
    {
        name = 'San Andreas Ambluance Service',
        plug = 'saas',
        itemname = 'saasradio',
        job = 'SAAS'
    },
    {
        name = 'Fire Rescue San Andreas',
        plug = 'frsa',
        itemname = 'frsaradio',
        job = 'FRSA'
    },
    {
        name = 'Civilian',
        plug = 'civ',
        itemname = 'civradio'
    },
}

Config.RadioChannelItems = {
    'sasp',
    'saas',
    'frsa',
    'civ'
}


---------------------------------------------------------------
--                                                           --
--                       Error Messages                      --
--                                                           --
---------------------------------------------------------------

--Error Message for invalid ID
Config.ErrorList = {
	{code = 1, text = '~r~Error: Invalid Server ID'},
	{code = 2, text = '~r~Error: Suspect is currently restrained from the front!'},
	{code = 3, text = '~r~Error: Suspect is currently restrained from the back!'},
	{code = 4, text = '~r~Error: You do not have a suitable knife equipped!'},
}

-- CAD API Configuration

Config.Cad = {
    Type = 'TRP', -- Options: TRP, Bubble
    ApiUrl = '', -- Base Url for API (i.e. https://example.com/api/1.1/)
    BubbleWfUrl = 'wf/', --Only use if using a bubblecad (should be wf/)
    BubbleDataUrl = 'obj/', --Only use if using a bubblecad (should be obj/)
    TRPCadVerison = 'v1', --Only used when using TRP's Cad. (Currently private)
    ApiKeyHeader = '',
    ApiKeyQuerry = '',

}

-- Cad Data Types <br>
-- If you cad dosn't use a type then replace with nil <br> Example: calls = 'call' or calls = nil

CadDataTypes.calls = '' --Also sometimes called files
CadDataTypes.civilians = ''
CadDataTypes.departments = ''
CadDataTypes.info = '' --Community information from CAD (Name, settings, etc.) Mainly used for TRP Cad or Bubble Cad
CadDataTypes.subdivisions = ''
CadDataTypes.users = ''
CadDataTypes.vehicles = ''
CadDataTypes.weapons = ''
-- Add custom Data Types here.

-- Cad Workflow Types (Only used for TRP & Bubble)

CadWfTypes.getCall = '' --Get Single call
CadWfTypes.getCivilian = '' --Get Single Civilian
CadWfTypes.getDepartment = '' --Get Single Department
CadWfTypes.getInfo = '' -- Get Single information
CadWfTypes.getSubdivision = '' --Get Single Subdivision
CadWfTypes.getUser = '' --Get Single user
CadWfTypes.getVehicle = '' --Get Single vehicle
CadWfTypes.getWeapon = '' --Get Single vehicle
-- Add custom Get Workflows here.

CadWfTypes.setCall = '' --Set Single call
CadWfTypes.setCivilian = '' --Set Single Civilian
CadWfTypes.setDepartment = '' --Set Single Department
CadWfTypes.setSubdivision = '' --Set Single Subdivision
CadWfTypes.setVehicle = '' --Set Single vehicle
CadWfTypes.setWeapon = '' --Set Single vehicle
-- Add custom Set Workflow type here.

CadWfTypes.getCalls = ''
CadWfTypes.getCivilians = ''
CadWfTypes.getDepartments = ''
CadWfTypes.getSubdivisions = ''
CadWfTypes.getUsers = ''
CadWfTypes.getVehicles = ''
CadWfTypes.getWeapons = ''

-- Add custom Get Workflow types here. - muti-item

-- DO NOT EDIT

Config.DataTypes = CadDataTypes
Config.WfTypes = CadWfTypes

TRPCoreConfig.Server = Config

return TRPCoreConfig.Server