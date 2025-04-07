--[[ 
  _______ _____  _____         _____          _____   _______     ___   _  _____ 
 |__   __|  __ \|  __ \       / ____|   /\   |  __ \ / ____\ \   / / \ | |/ ____|
    | |  | |__) | |__) |_____| |       /  \  | |  | | (___  \ \_/ /|  \| | |     
    | |  |  _  /|  ___/______| |      / /\ \ | |  | |\___ \  \   / | . ` | |     
    | |  | | \ \| |          | |____ / ____ \| |__| |____) |  | |  | |\  | |____ 
    |_|  |_|  \_\_|           \_____/_/    \_\_____/|_____/   |_|  |_| \_|\_____|
 
    TRP-CADSync CAD API
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]

---@param discordUserId string
---@return table|boolean
function TRPCore.Server.getDiscordInfo(discordUserId)
    if not discordUserId or not TRPCoreConfig.Server.DiscordEnabled or not TRPCoreConfig.Server.DiscordGuildID or not TRPCoreConfig.Server.DiscordBotToken then return false end

    local discordErrors = {
        [400] = "Improper HTTP request",
        [401] = "Discord bot token might be missing or incorrect",
        [404] = "User might not be in the server",
        [429] = "Discord bot rate limited"
    }
    local headers = {
        ["Content-Type"] = "application/json", -- Specify the content type as JSON
        ["Authorization"] = "bot " .. TRPCoreConfig.Server.DiscordBotToken -- Add authorization token
    }

    if type(discordUserId) == "string" and discordUserId:find("discord:") then discordUserId:gsub("discord:", "") end
---@param responseBody string? Must be a string
    local statusCode, responseBody, responseHeaders = PerformHttpRequestAwait('https://discord.com/api/guilds/'..TRPCoreConfig.Server.DiscordGuildID..'/members/'..discordUserId)
    if statusCode ~= 200 then
        TRPCore.Server.Logging.Print('[TRP-CadSync.Discord.API]: ' .. statusCode .. discordErrors[statusCode])
        return false
    end

    local result = json.decode(responseBody) or "name"
    

    local data = {
        nickname = result.nick or result.user.username,
        user = result.user,
        roles = result.roles
    }

    return data
end

---@param webhookUrl string
---@param webhookUsername? string
---@param webhookAvatarUrl? string
---@param webhookData table|string
---@return boolean
function TRPCore.Server.DiscordPostWebhook(webhookUrl, webhookData, webhookUsername, webhookAvatarUrl)
    if not webhookUrl then return false end
    local webhookInfo
    if webhookUsername then webhookInfo.username = webhookUsername end
    if webhookAvatarUrl then webhookInfo.avatar_url = webhookAvatarUrl end
    if type(webhookData) == 'table' then webhookInfo.embeds = webhookData end
    if type(webhookData) == 'string' then webhookInfo.content = webhookData end

    local statusCode, responseBody, responseHeaders = PerformHttpRequestAwait(webhookUrl, webhookInfo)
    if statusCode ~= 200 then
        TRPCore.Server.Logging.Print('[TRP-CadSync.Discord.API]: ' .. statusCode .. responseBody)
        return false
    end
    return false
end