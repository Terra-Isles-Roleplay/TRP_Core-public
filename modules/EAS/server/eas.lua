-- Jobs and grades allowed to run the command. Set to true to allow all grades to run command.
-- Example: "sasp = 3" means only job grade 3 and up can run the command. 
local AllowedJobs = {
  sasp = true,
  SASP = true,
  SAFS = true,
  SAAS = true,
  rms = true,
  RMS = true,
  frsa = true,
  FRSA = true,
  SASD = true,
  sasd = true,
  cssa = true,
  CSSA = true,
  LSRP = true,
  lsrp = true,
  TFP = true,
  tfp = true,
  TBF = true,
  tbf = true,
  police = true
}

-- ==== config: which actions are valid ====
local ValidActions = {
  amber = true,
  sasp = true,
  safs = true,
  saas = true,
  gov = true,
  -- add more: ["giveitem"]=true, ["heal"]=true, ...
}

local function trim(s) return (s and s:match("^%s*(.-)%s*$")) or "" end
local function isValidAction(a) return a and ValidActions[a:lower()] == true end

local function getJobInfo(xPlayer)
    local job = xPlayer.getData and xPlayer.getData("job") or nil
    local grade = xPlayer.getData and (xPlayer.getData("job_grade") or xPlayer.getData("grade")) or nil

    if type(job) == "table" then
        grade = grade or job.grade or job.rank or job.level
        job = job.name or job.id or job.label
    end
    if type(grade) == "string" then grade = tonumber(grade) or grade end
    return job, grade or 0
end

local function isAllowed(source)
    if source == 0 then return true end
    local xPlayer = exports['ND_Core']:getPlayer(source)
	print(("[EAS] Source: %s | Character ID: %s | Character Name: %s"):format(source, xPlayer.id, xPlayer.fullname)) 
    if not xPlayer then return false end
    local job, grade = getJobInfo(xPlayer)
	print(("[EAS] Job: %s | Grade: %s"):format(job, tonumber(grade)))
    local rule = job and AllowedJobs[job]
    if rule == nil then return false end
    if rule == true then return true end
    if type(rule) == "number" then return (tonumber(grade) or 0) >= rule end
    return false
end

-- Queue state
local playerQueue = {}
local processing = false
local currentTarget = nil
local STEP_DELAY_MS = 50

-- Your per-player server-side work
-- playerId = the player's server ID
-- args = table of arguments from the original /runforall command
-- done() MUST be called to continue the queue
local function doWorkForPlayer(playerId, args, done)
	local EASType = args[1] or ""
    local message = ""
	
	-- defensive check: if somehow invalid, cancel everything
    if not isValidAction(EASType) then
        print(("[queue] Invalid action '%s' — cancelling run."):format(tostring(action)))
        -- cancel whole queue
        playerQueue = {}
        processing = false
        currentTarget = nil
        return  -- do NOT call done(); we’re stopping the run
    end

    if #args > 1 then
        -- Join args[2] onwards into a single string
        message = table.concat(args, " ", 2)
    end

    -- Example logic:
    print(('[EAS] Player %s (%s) Type: %s | Message: %s | Identifier: %s'):format(
        playerId,
        GetPlayerName(playerId) or 'unknown',
        EASType,
        message,
		GetPlayerIdentifierByType(playerId, 'license')
    ))
	
	if EASType == 'amber' or 'AMBER' then
		alertNumber = '111'
	elseif EASType == 'sasp' or 'SASP' then
		alertNumber = '44444'
	elseif EASType == 'safs' or 'SAFS' then
		alertNumber = '5555'
	elseif EASType == 'saas' or 'SAAS' then
		alertNumber = '5556'
	elseif EASType == 'gov' or 'GOV' then
		alertNumber = '74711'
    elseif EASType == 'tfp' or 'TFP' then
        alertNumber = '9999'
    elseif EASType == 'tfb' or 'TFB' then
        alertNumber = '9989'
	end
	local pIdent = ('license:%s'):format(GetPlayerIdentifierByType(playerId, 'license'))
	local playerData = exports['ND_Core']:getPlayer(playerId)
    print(("Player Data for %s loaded. Their character id is %s"):format(playerId, playerData.id))
    MySQL.single('SELECT * FROM nd_characters WHERE charid = ?', { playerData.id }, function(result)
        if not result then
            print(("[queue] No nd_characters entry found for character ID %s"):format(playerData.id))
            done()
            return
        end

        local characterData = result

        local phone = tostring(characterData.phonenumber)

        -- Debug: show some info
        print(("[queue] Player %s (%s) - Action: %s | Message: %s | Character Name: %s %s | Phone Number: %s"):format(
            playerId,
            GetPlayerName(playerId) or 'unknown',
            EASType,
            message,
            characterData.firstname or "?",
            characterData.lastname or "?",
            characterData.phonenumber
        ))
        print(("[queue] Player %s (%s) | Alert Number: %s | Target Number: %s | Message: %s"):format(
            playerId,
            GetPlayerName(playerId) or 'unknown',
            alertNumber,
            phone,
            message
        ))
        exports.npwd:emitMessage({
                senderNumber = alertNumber,
                targetNumber = phone,
                message = message
            })
        done()
    end)
end

-- Queue machinery
local function popFront(tbl)
    if #tbl == 0 then return nil end
    return table.remove(tbl, 1)
end

local function processNext(args)
    if #playerQueue == 0 then
        processing = false
        currentTarget = nil
        print('[queue] Completed run for all players.')
        return
    end

    local pid = popFront(playerQueue)
    if not GetPlayerName(pid) then
        print(('[queue] Skipping %s (disconnected)'):format(tostring(pid)))
        SetTimeout(STEP_DELAY_MS, function() processNext(args) end)
        return
    end

    currentTarget = pid
    local ok, err = pcall(function()
        doWorkForPlayer(pid, args, function()
            SetTimeout(STEP_DELAY_MS, function() processNext(args) end)
        end)
    end)

    if not ok then
        print(('[queue] Error for %s: %s'):format(tostring(pid), tostring(err)))
        SetTimeout(STEP_DELAY_MS, function() processNext(args) end)
    end
end

local function buildQueueFromPlayers()
    playerQueue = {}
    for _, id in ipairs(GetPlayers()) do
        table.insert(playerQueue, tonumber(id))
    end
end

-- Commands
RegisterCommand('EAS', function(src, args, raw)
    if not isAllowed(src) then
        if src ~= 0 then
            TriggerClientEvent('chat:addMessage', src, { args = { '^1Queue', 'You are not authorized to run this.' } })
        else
            print('[queue] Not authorized.')
        end
        return
    end

    -- validate action BEFORE building/starting the queue
    local action = (args[1] or ""):lower()
    if not isValidAction(action) then
        local msg = ("Invalid action '%s'. Allowed: %s")
            :format(tostring(action), table.concat((function()
                local t={} for k in pairs(ValidActions) do t[#t+1]=k end
                table.sort(t); return t
            end)(), ", "))
        if src == 0 then print('[queue] ' .. msg)
        else TriggerClientEvent('chat:addMessage', src, { args = { '^1Queue', msg } }) end
        return
    end

    if processing then
        local msg = ('Already running. Remaining: %d (current: %s)'):format(#playerQueue, tostring(currentTarget))
        if src == 0 then print('[queue] ' .. msg) else TriggerClientEvent('chat:addMessage', src, { args = { '^3Queue', msg } }) end
        return
    end

    buildQueueFromPlayers()
    if #playerQueue == 0 then
        local msg = 'No players online.'
        if src == 0 then print('[queue] ' .. msg) else TriggerClientEvent('chat:addMessage', src, { args = { '^3Queue', msg } }) end
        return
    end

    processing = true
    currentTarget = nil
    local msg = ('Starting run for %d player(s). Action: %s | Message: %s')
        :format(#playerQueue, action, trim((#args > 1) and table.concat(args, " ", 2) or ""))
    if src == 0 then print('[queue] ' .. msg) else TriggerClientEvent('chat:addMessage', src, { args = { '^2Queue', msg } }) end

    processNext(args)
end, false)


RegisterCommand('EAS_cancel', function(src)
    if not isAllowed(src) then
        if src ~= 0 then
            TriggerClientEvent('chat:addMessage', src, { args = { '^1Queue', 'You are not authorized to run this.' } })
        else
            print('[queue] Not authorized.')
        end
        return
    end

    if not processing then
        local msg = 'Nothing is running.'
        if src == 0 then print('[queue] ' .. msg) else TriggerClientEvent('chat:addMessage', src, { args = { '^3Queue', msg } }) end
        return
    end

    playerQueue = {}
    processing = false
    local msg = ('Cancelled. Last target was %s.'):format(tostring(currentTarget))
    currentTarget = nil
    if src == 0 then print('[queue] ' .. msg) else TriggerClientEvent('chat:addMessage', src, { args = { '^3Queue', msg } }) end
end, false)

RegisterCommand('EAS_status', function(src)
    local msg
    if processing then
        msg = ('Running. Current: %s | Remaining: %d'):format(tostring(currentTarget), #playerQueue)
    else
        msg = 'Idle.'
    end
    if src == 0 then print('[queue] ' .. msg) else TriggerClientEvent('chat:addMessage', src, { args = { '^4Queue', msg } }) end
end, false)
