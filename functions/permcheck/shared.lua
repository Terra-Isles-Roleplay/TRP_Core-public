function isJobAllowed(job, allowedList)
    for _, allowed in ipairs(allowedList) do
        if job == allowed then return true end
    end
    return false
end

