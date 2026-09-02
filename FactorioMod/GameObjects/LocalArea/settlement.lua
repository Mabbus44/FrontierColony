---@class Settlement
---@field prop1 number
---@field prop2 number

local Settlement = {}
Settlement.__index = Settlement

function Settlement:new()
    local obj = setmetatable({}, self)
    
    obj.prop1 = 0
    obj.prop2 = 0
    
    return obj
end

return Settlement