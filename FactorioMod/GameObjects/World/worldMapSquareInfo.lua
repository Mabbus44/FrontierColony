---@class WorldMapSquareInfo
---@field 
---@field biterCount number
---@field biterMaxCount number
---@field biterEvolution number
---@field biterType BiterType
---@field pollution number
---@field resource ResourceSquare
---@field localArea Settlement

local WorldMapSquareInfo = {}
WorldMapSquareInfo.__index = WorldMapSquareInfo

function WorldMapSquareInfo:new()
    local obj = setmetatable({}, self)
    
    obj.prop1 = 0
    obj.prop2 = 0
    
    return obj
end

return WorldMapSquareInfo