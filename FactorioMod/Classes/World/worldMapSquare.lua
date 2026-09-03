---@class WorldMapSquare
---@field biterCount number
---@field biterMaxCount number
---@field biterEvolution number
---@field biterType BiterType
---@field pollution number
---@field resource ResourceSquare
---@field settlement Settlement
---@field tileType TileType

local TileType = require("Enums/tileType")

local WorldMapSquare = {}
WorldMapSquare.__index = WorldMapSquare

function WorldMapSquare:new(tileType)
  local obj = setmetatable({}, self)

  obj.biterCount = 0
  obj.biterMaxCount = 0
  obj.biterEvolution = 0
  obj.biterType = nil
  obj.pollution = 0
  obj.resource = nil
  obj.settlement = nil
  obj.tileType = tileType

  return obj
end

return WorldMapSquare