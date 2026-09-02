---@class ExpeditionBuilding
---@field prop1 number
---@field prop2 number

local ExpeditionBuilding = {}
ExpeditionBuilding.__index = ExpeditionBuilding

function ExpeditionBuilding:new()
    local obj = setmetatable({}, self)
    
    obj.prop1 = 0
    obj.prop2 = 0
    
    return obj
end

return ExpeditionBuilding