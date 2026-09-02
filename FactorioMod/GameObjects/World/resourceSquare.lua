---@class ResourceSquare
---@field resourceCount number
---@field resourceMaxCount number
---@field resourceType ResourceTypes

local ResourceSquare = {}
ResourceSquare.__index = ResourceSquare

function ResourceSquare:new()
    local obj = setmetatable({}, self)
    
    obj.resourceCount = 0
    obj.resourceMaxCount = 0
    obj.resourceType = nil
    
    return obj
end

return ResourceSquare