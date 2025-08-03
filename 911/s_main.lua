-- Change URL depending on if its Dev or Live
local cadapi = 'https://cad.terra-isles.com'
--local cadapi = 'https://cad.terra-isles.com/version-test/'
--local scannedplate = ''
--local camCapitalized = ''
--local alprstatus = ''
--local serverconfig = ServerConfig
local debugmode = false
local serverid = 1 -- change depending on server ID in CAD
--lastplatessearch = {}

--[[RegisterNetEvent("TRPalpr:alpron")
AddEventHandler("TRPalpr:alpron", function(status)
    if status == 'on' then
        alprstatus = 'off'
        print('ALPR Status ON: '..alprstatus)
    elseif status == 'off' then
        alprstatus = 'on'
        print('ALPR Status Off: '..alprstatus)
    end
    print('ALPR Status Check: '..alprstatus)
end)

RegisterNetEvent("wk:onPlateScanned")
AddEventHandler("wk:onPlateScanned", function(cam, vehicle, plate, index)
    if cam == 'front' then
        camCapitalized = 'Front'
    elseif cam == 'rear' then
        camCapitalized = 'Rear'
    end

    local plate = plate
    scannedplate = plate:match('^%s*(.-)%s*$')
    TriggerEvent("TRPALPR:ALPR", scannedplate, camCapitalized, cam, source)
end)

RegisterNetEvent("TRPALPR:ALPR")
AddEventHandler("TRPALPR:ALPR", function(plate, cam, cam2, source)
    local steamIdentifier
    steamIdentifier = PlayerIdentifier('steam', source)
    local playerData
    playerData = GetPlayerALPRAllowed(steamIdentifier, source)
    --playerData = GetPlayerALPRAllowed(steamIdentifier)
    local plateReturn
    plateReturn = PlateCheck(plate, source)
    local platereturn = json.decode(plateReturn)
    --print("Plate Return: "..platereturn)
	if platereturn == 404 then
		return
    elseif playerData == 'Allowed' then
        if plateReturn ~= nil then
            local platetablesearch = containsplate(lastplatessearch, plate)
            if not platetablesearch then
                table.insert(lastplatessearch, {lastplate=plate})
                TriggerEvent('TRPALPR:SendReturn', source, plate, cam, cam2, platereturn.response.vehicledestroyed, platereturn.response.vehicleImpounded, platereturn.response.vehiclerevoked, platereturn.response.vehiclestolen, platereturn.response.vehicleinsurance, platereturn.response.VehicleExpired, platereturn.response.vehiclewanted, platereturn.response.vehiclewantedreason, platereturn.response.vehicleownerwanted, platereturn.response.vehicleownerwantedreason, platereturn.response.vehicleOwnerSuspended, platereturn.response.VehicleOwnerName, platereturn.response.VehicleOwnerDOB, platereturn.response.VehicleOwnerIDNum, platereturn.response.VehModel, platereturn.response.VehMake, platereturn.response.VehicleColor)
            end
        end
    elseif playerData == 'Not Allowed' then
        return
    else
        return
    end

    if #lastplatessearch > 10 then
        table.remove(lastplatessearch)
    end
end)

RegisterNetEvent("TRPALPR:SendReturn")
AddEventHandler("TRPALPR:SendReturn", function(source,plate, cam, cam2, vehdest, vehimp, vehrev, vehstol, vehins, vehexp, vehwant, vehwantr, vehrowant, vehrowantr, vehrosusp, vehroname, vehrodob, vehroid, vehmodel, vehmake, vehcolor)
    vehflags = {}
    vehbolo = {}
    roflags = {}
    robolo = {}
    if vehdest then table.insert(vehflags, 'Destroyed') end
    if vehimp then table.insert(vehflags, 'Impounded') end
    if vehrev then table.insert(vehflags, 'Revoked') end
    if vehstol then table.insert(vehbolo, 'Stolen') end
    if not vehins then table.insert(vehflags, 'Invaild Insurance') end
    if vehexp then table.insert(vehflags, 'Registration Expired') end
    if vehwant then table.insert(vehbolo, 'Wanted') end
    if vehwant and vehwantr ~= nil then table.insert(vehbolo, 'Reason: '..vehwantr) end
    if vehrowant then table.insert(robolo, 'Wanted') end
    if vehrowant and vehrowantr ~= nil then table.insert(robolo, 'Reason: '..vehrowantr) end
    if vehrosusp then table.insert(roflags, 'DL Suspended') end
    if vehroexp then table.insert(roflags, 'DL Expired') end
    
    if #vehflags > 0 or #vehbolo > 0 or #roflags > 0 or #robolo > 0 then
        TriggerClientEvent('pNotify:SendNotification', source, {text = ('<b style=\'color:white\'>ALPR HIT</b><br/>%s ALPR Camera Triggered<br/>Plate: %s<br/>Model: %s<br/>Make: %s<br/>Color: %s<br/>Owner: %s'):format(cam, plate, vehmodel, vehmake, vehcolor, vehroname), type = 'success', queue = 'alpr', timeout = 10000, layout = 'centerLeft'})
    end
    if #vehflags > 0 or #vehbolo > 0 then
        if #vehflags < 1 then table.insert(vehflags, 'No Flags') end
        if #vehbolo < 1 then table.insert(vehbolo, 'No Bolos returned') end
        if #vehflags > 0 and #vehbolo > 0 then
            local vehflagslist = table.concat(vehflags, ',<br/>')
            local vehbololist = table.concat(vehbolo, ',<br/>')
            TriggerClientEvent('pNotify:SendNotification', source, {text = ('<b style=\'color:white\'>MDT Vehicle Return</b><br/><br/><b style=\'color:yellow\'>FLAGS</b><br/> %s<br/><br/><b style=\'color:red\'> BOLO ALERT</b><br/>%s'):format(vehflagslist,vehbololist), type = 'error', queue = 'bolo',timeout = 10000, layout = 'centerLeft'})
        end
    end

    if #roflags > 0 or #robolo > 0 then
        if #roflags < 1 then table.insert(roflags, 'No Flags') end
        if #robolo < 1 then table.insert(robolo, 'No Bolos returned') end
        if #roflags > 0 and #robolo > 0 then
            local roflagslist = table.concat(roflags, ',<br/>')
            local robololist = table.concat(robolo, ',<br/>')
            TriggerClientEvent('pNotify:SendNotification', source, {text = ('<b style=\'color:white\'>MDT Owner Return</b><br/><br/><b style=\'color:yellow\'>FLAGS</b><br/> %s<br/><br/><b style=\'color:red\'> BOLO ALERT</b><br/>%s'):format(roflagslist,robololist), type = 'error', queue = 'bolo',timeout = 10000, layout = 'centerLeft'})
        end
    end

    local vehnobolo = table.concat(vehbolo, '')
    local ronobolo = table.concat(robolo, '')

    if vehnobolo ~= 'No Bolos returned' then
        exports.wk_wars2x:TogglePlateLock( source, cam2, true, true )
    end

    if ronobolo ~= 'No Bolos returned' then
        exports.wk_wars2x:TogglePlateLock( source, cam2, true, true )
    end
end)

RegisterServerEvent("panicPress")
AddEventHandler("panicPress", function(street, cross, x, y, pedin, serverid, apikey)
    local steamIdentifier
    steamIdentifier = PlayerIdentifier('steam', pedin)
    local name = GetPlayerName(pedin)
    PerformHttpRequest(cadapi.."/api/1.1/wf/panic/", function(err, text, headers)
        if text then
            infoLog("Successful Panic alert! " .. name .. " at " .. street .. "\n")
        elseif err then
            errorLog("Panic Error " .. err .. "\n")
        end
    end, 'POST', json.encode({Name = name, Hex = steamIdentifier, callX = x, callY = y, Street = street, Cross = cross, ServerID = serverid}), { ["Content-Type"] = 'application/json' })
    CancelEvent()
end)

RegisterServerEvent("TRPCAD:autolocationUpdate")
AddEventHandler("TRPCAD:autolocationUpdate", function(street, cross, pedin, x, y)
    local steamIdentifier
    steamIdentifier = PlayerIdentifier('steam', pedin)
	--infoLog(steamIdentifier)
	--infoLog('Player X: '..x..' Player Y: '..y)
    PerformHttpRequest(cadapi.."/api/1.1/wf/setunitlocation/", function(err, text, headers)
        if text then
            return
        elseif err then
            errorLog('Location Ping User: '..steamIdentifier..' Error ' .. err)
        end
    end, 'POST', json.encode({street = street, crossStreet = cross, hex = steamIdentifier, xCord = x, yCord = y, apiKey = 'TRPCADKEY23'}), { ["Content-Type"] = 'application/json' })
    CancelEvent()
end)
]]--
--Sends 911 alert to dispatcher(s)
RegisterServerEvent("TRPCAD:911AlertDispatch")
AddEventHandler("TRPCAD:911AlertDispatch", function(street, cross, pedin, x, y)
    local name = GetPlayerName(pedin)
    local steamIdentifier
    steamIdentifier = PlayerIdentifier('steam', pedin)
    local name = GetPlayerName(pedin)
    PerformHttpRequest(cadapi.."/api/1.1/wf/911/", function(err, text, headers)
        if text then
            infoLog("Successful 911 alert! " .. name .. " at " .. street .. "\n")
            TriggerClientEvent('pNotify:SendNotification', pedin, {text = '<b style=\'color:white\'>Operational Communications Centre</b><br/>911 has received your call.', type = 'info', queue = 'global', timeout = 10000, layout = 'centerLeft'})
        elseif err then
            TriggerClientEvent('pNotify:SendNotification', pedin, {text = ('<b style=\'color:white\'>Operational Communications Centre</b><br/><br/>ERROR: %s'):format(err), type = 'error', queue = '911',timeout = 10000, layout = 'centerLeft'})
            errorLog("911 alert Error: " .. err)
        end
    end, 'POST', json.encode({callerName = name, street = street, cross = cross, xCord = x, yCord = y, server = 1}), { ["Content-Type"] = 'application/json' })
    CancelEvent()
end)

--Sends data to CAD API to create a new 911 call
RegisterServerEvent("TRPCAD:sendCall")
AddEventHandler("TRPCAD:sendCall", function(data)
--Creates data for API Call
    local payload = {
        callType = data.callType,
        callerName = data.name,
        street = data.street,
        cross = data.crossStreet,
        postal = data.postal,
        zone = data.zone,
        report = data.description,
        --player = playerInfo.steamID,
        xCord = data.x,
        yCord = data.y,
        server = ServerConfig.ServerID
    }
--Sends Payload to API
    PerformHttpRequest(cadapi.."/api/1.1/wf/911/", function(err, text, headers) 
        if text then
            infoLog("Successful 911 alert! " .. data.name .. " at " .. data.street .. '('..data.postal..')' .. "\n"..'Report: '..data.description)
            --Sends 911 Received Notification
	    TriggerClientEvent('pNotify:SendNotification', -1, {text = '<b style=\'color:white\'>Operational Communications Centre</b><br/>911 has been recived please check in MDT', type = 'info', queue = 'global', timeout = 20000, layout = 'centerLeft'})
            --Sends confirmation that 911 was received
	    TriggerClientEvent('pNotify:SendNotification', data.ped, {text = '<b style=\'color:white\'>Operational Communications Centre</b><br/>911 has recived your call.', type = 'success', queue = 'global', timeout = 9000, layout = 'centerLeft'})
        elseif err then
	    --Error reporting
            errorLog("911 alert Error: " .. err)
            TriggerClientEvent('pNotify:SendNotification', data.ped, {text = ('<b style=\'color:white\'>Operational Communications Centre</b><br/>Error occured please try again.</br> Error Code: %s').format(err), type = 'error', queue = 'global', timeout = 9000, layout = 'centerLeft'})
        end
    end, 'POST', json.encode(payload), {
        ['Content-Type'] = 'application/json'
    })
    CancelEvent()
end)

RegisterServerEvent("TRPCAD:availableDispatchers")
AddEventHandler("TRPCAD:availableDispatchers", function()
    local src = source
    --print("Received request from: " .. src)
    PerformHttpRequest(cadapi.."/api/1.1/wf/availableDispatchers", function(err, text, headers)
        --print("HTTP request completed")
        if text then
            --print("Raw response: " .. text)
            local data = json.decode(text)
            --print("Decoded response: " .. json.encode(data))
            --print("Dispatchers: " .. tostring(data.response.availableDispatchers))
            TriggerClientEvent("TRPCAD:DispatchersCheck", src, data.response.availableDispatchers)
        elseif err then
            errorLog("Available Dispatchers Error: " .. err)
        end
    end, 'POST', json.encode({apikey = 'TRPCADKEY23'}), { ["Content-Type"] = 'application/json' })
    --CancelEvent()
end)
--[[
-- FUNCTIONS
function PlateCheck(plate, user)
    local user = GetPlayerName(user)
    local p = promise.new()
    local p2 = promise.new()
    PerformHttpRequest(cadapi.."/api/1.1/wf/alprsearch/", function(err, text, headers, errdata)
		--print(cadapi.."/api/1.1/wf/alprsearch/")
        if text then
            p:resolve(text)
        end
        if err then
            p2:resolve(errdata)
        end
    end, 'POST', json.encode({plate = plate, apiKey='TRPCADKEY23'}), {["Content-Type"] = "application/json"})
    local result = Citizen.Await(p)
    local error = Citizen.Await(p2)
    if result then
        local vehdata = json.decode(result)
        local StatusCode = vehdata.response.statusCode
        if StatusCode == '200' then
            return result
        else 
            return '404: Not Found'
        end
    elseif err then
        errorLog('Plate Check Error: '..err..'Triggered by: '..user)
        return 'Error'
    end
    CancelEvent()
end

function GetPlayerALPRAllowed(hex, user)
    local p = promise.new()
    local p2 = promise.new()
    local user = GetPlayerName(user)
    PerformHttpRequest(cadapi.."/api/1.1/wf/getuserbyhex", function(err, text, headers, errdata)
        if text then
            p:resolve(text)
        end
        if err then
            p2:resolve(errdata)
        end
    end, 'POST', json.encode({hex=hex, apiKey='TRPCADKEY23'}), {["Content-Type"] = "application/json"})
    local result = Citizen.Await(p)
    local error = Citizen.Await(p2)
    if error then
        return error
    end
    if result then
        --print(result)
        local data = json.decode(result)
        local StatusCode = data.response.statusCode
        local playerDivison = data.response.userActiveDivison
        local playerSupervisor = data.response.userSupervisor
        local playerMangement = data.response.userMangement
        local playerAdmin = data.response.userAdmin
        if StatusCode == '200' then
            local ApprovedDivisons = {'TRF', 'TAG', 'ALPR'}
            if contains(ApprovedDivisons, playerDivison) or playerSupervisor or playerMangement or playerAdmin then
                infoLog('ALPR Search check was allowed. Triggered by: '..user)
                return 'Allowed'
            else
                return 'Not Allowed'
            end
        else
            errorLog('ALPR Search ERROR: '..err..' Triggered by: '..user)
            return StatusCode
        end
    end
    CancelEvent()
end

function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)
 
    for a = 0, numIdentifiers do
       table.insert(identifiers, GetPlayerIdentifier(id, a))
    end
 
    for b = 1, #identifiers do
       if string.find(identifiers[b], type, 1) then
            return identifiers[b]
       end
    end
    return false
end

function contains(table, val)
    for i=1,#table do
       if table[i] == val then 
          return true
       end
    end
    return false
end

function containsplate(table, key)
    for k, v in pairs(table) do
        plate = v["lastplate"]
        if (plate == key) then
            return true
        end
    end
end
]]--
--- Start Reource Stuff
local resourceName = 
[[^3
_______ _____  _____  
|__   __|  __ \|  __ \ 
   | |  | |__) | |__) |
   | |  |  _  /|  ___/ 
   | |  | | \ \| |     
   |_|  |_|  \_\_|^7
    CAD Sync
	Created By Tristian F., Erving Q., & TRP Dev Team
]]
print(resourceName)

-- Error/warn/info logging
function errorLog(message)
    print("^1[ERROR]:^7 "..message)
end
function warnLog(message)
    print("^3[WARNING]:^7 "..message)
end
function infoLog(message)
    print("^5[INFO]:^7 "..message)
end
-- CAD Connection to FIVEM
----------------------------

SetHttpHandler(function(req,res)
    
    if req.method=='POST'then
        req.setDataHandler(function(body)
            local decomp=json.decode(body)
            if decomp == nil then
                res.writeHead(400, { ['Content-Type'] = 'application/json' })
                res.send(json.encode({response="ERROR: Incorrect format"}))
            else
                local hex = decomp.hex;
                if GetNumPlayerIndices() == 0 then
                    res.writeHead(410, { ['Content-Type'] = 'application/json' })
                    res.send(json.encode({response="ERROR: No Online Players"}))
                else
                    local foundPed = nil
                    foundPed = PlayerIdentifier('steam', hex)
            
                    if foundPed == nil then
                        res.writeHead(404, { ['Content-Type'] = 'application/json' })
                        res.send(json.encode({response="ERROR: Player Hex Not Found"}))
                    else
                        if req.path == "/alert1" then
                            res.writeHead(200, { ['Content-Type'] = 'application/json' })
                            res.send(json.encode({response="Sent Alert 1 to player"}))
                            --TriggerClientEvent("alert1", foundPed);
                        end
                        if req.path == "/alert2" then
                            res.writeHead(200, { ['Content-Type'] = 'application/json' })
                            res.send(json.encode({response="Sent Alert 2 to player"}))
                            --TriggerClientEvent("alert2", foundPed);
                        end
                        if req.path == "/panicalert" then
                            res.writeHead(200, { ['Content-Type'] = 'application/json' })
                            res.send(json.encode({response="Sent Panic ALert"}))
                            --TriggerClientEvent("alert2", foundPed);
                        end
                        if req.path == "/callalert" then
                            res.writeHead(200, { ['Content-Type'] = 'application/json' })
                            res.send(json.encode({response="Sent Call Notifcation"}))
                            --TriggerClientEvent("alert2", foundPed);
                        end
                        --[[
                        --local x = decomp.callX
                        --local y = decomp.callY
                        --local number = decomp.Number
                        --local call = decomp.Call
                        if req.path == "/call" then
                            if foundPed then
                                res.writeHead(200, { ['Content-Type'] = 'application/json' })
                                res.send(json.encode({response="Sent new call to player"}))
                                --TriggerClientEvent("notify", foundPed, call, number);
                                --TriggerClientEvent("drawRoute", foundPed, x, y);
                            end
                        end
                        if req.path == "/panic" then
                            if foundPed then
                                res.writeHead(200, { ['Content-Type'] = 'application/json' })
                                res.send(json.encode({response="Sent panic to player"}))
                                --TriggerClientEvent("notifyPanic", foundPed, call, number);
                                --TriggerClientEvent("drawRoutePanic", foundPed, x, y);
                            end
                        end
                        ]]
                    end
                end
            end
        end)
    end
end)


SetHttpHandler(function(request, response)
    if request.method == 'GET' and request.path == '/ping' then -- if a GET request was sent to the `/ping` path
        response.writeHead(200, { ['Content-Type'] = 'text/plain' }) -- set the response status code to `200 OK` and the body content type to plain text
        response.send('pong') -- respond to the request with `pong`
    else -- otherwise
        response.writeHead(404) -- set the response status code to `404 Not Found`
        response.send() -- respond to the request with no data
    end
  end)

