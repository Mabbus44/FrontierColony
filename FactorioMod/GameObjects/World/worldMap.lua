---@class WorldMap
---@field settlements Settlement[]
---@field expeditions Expedition[]

local WorldMap = {}
WorldMap.__index = WorldMap

function WorldMap:new()
    local obj = setmetatable({}, self)
    
    obj.settlements = {}
    obj.expeditions = {}
    
    return obj
end

return WorldMap