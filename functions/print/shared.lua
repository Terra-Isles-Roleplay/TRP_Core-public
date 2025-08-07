---**Shared**
---@param data string
---@param printType? string [info|warn|error|debug]
---@return nil
function TRPCore.Shared.Print(data, printType)
    if data == nil or data == '' then return end
    if type(data) ~= 'string' then return end
    if printType == 'info' then
        print('^5[Info]: ^0' .. data)
    elseif printType == 'warn' then
        print('^3[Warn]: ^0' .. data)
    elseif printType == 'error' then
        print('^1[Error]: ^0' .. data)
    elseif printType == 'debug' then
        print('^0[Debug]: ' .. data)
    else
        print(data)
    end
end

return TRPCore.Shared.Print