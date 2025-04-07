--[[ 
    TRPCore Bubble API
    Created By Terra Isles Development Team
    © Terra Isles Roleplay Community 2017-2025
    Do not edit anything in this file unless you know what you are doing. Use Config Files!!!
]]

-- Bubble.io API Wrapper
---**`server`**
---@param APIType string 
---@param APIcallpoint string
---@param APIMethod string 
---@param APIData string Use json.encode(table) to turn table to string
---@param APIParams? table i.e [{key: value, key2: value2}]
---@return table|nil
---@nodiscard
function TRPCore.BubbleAPICall(APIType, APIcallpoint, APIMethod, APIData, APIParams)
    local response = {} -- Table to store the API response

    -- Construct the base URL for the API endpoint
    local url = TRPCoreConfig.Server.CADURL .. APIType .. APIcallpoint

    -- Check if `APIParams` is provided and construct the query string for multiple parameters
    if APIParams ~= nil then
        local queryString = {} --Local table to hold query parameters
        for key, value in pairs(APIParams) do
            table.insert(queryString, key .. "=" .. tostring(value)) -- Add each key-value pair
        end
        url = url .. "?" .. table.concat(queryString, "&") -- Combine all parameters with '&'
    end

    -- Set the headers required for the API request
    local headers = {
        ["Content-Type"] = "application/json", -- Specify the content type as JSON
        ["Authorization"] = "Bearer " .. TRPCoreConfig.Server.CADAuthKey -- Add authorization token
    }

    -- Make the HTTP request and capture the status code, response body, and headers
    local statusCode, responseBody, responseHeaders = PerformHttpRequestAwait(url, APIMethod, APIData, headers)

    -- Assign response data or a fallback message if the response body is empty
    response.data = responseBody or "No response body available."
    response.statuscode = statusCode -- Store the status code
    response.headers = responseHeaders -- Store the response headers

    -- Check if the API call was successful (status code 200)
    if response.statuscode == 200 then
        response.data = json.decode(response.data)
        return response.data
    else
        -- Log an error message if the API call was unsuccessful
        return TRPCore.Server.Logging.Print('[TRPCore-CADSYNC API] HTTP Status Code: ' .. tostring(response.statuscode) .. ' ' .. json.encode(response.data, {indent = true}), 'error')
    end
end

return TRPCore.BubbleAPICall