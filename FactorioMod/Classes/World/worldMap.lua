---@class WorldMap
---@field width number
---@field height number
---@field tiles table<number, table<number, WorldMapSquare>>

local WorldMapRaw = require("Assets.worldMapRaw")
local TileType = require("Enums.tileType")
local Constants = require("Classes.constants")
local WorldMapSquare = require("Classes.World.worldMapSquare")
local Settlement = require("Classes.Settlement.settlement")
local EntityData = require("Classes.entityData")

---This is a global static object, hence no "new" method and no metatable
local WorldMap = {}

function WorldMap:loadWorldMap()
  self.width = WorldMapRaw.width
  self.height = WorldMapRaw.height
  self.tiles = {}
  for y = 1, WorldMapRaw.height do
    self.tiles[y] = {}
    for x = 1, WorldMapRaw.width do
      self.tiles[y][x] = WorldMapSquare:new(TileType[WorldMapRaw.tiles[y][x]])
    end
  end
end

function WorldMap:getSurface()
  return game.surfaces[Constants.worldMapSurfaceName]
end

function WorldMap:setTiles(left_top, right_bottom)
  local middleX = math.floor(self.width / 2) + 1;	-- This will generate from -a to +a if odd, and -a to +(a-1) if even. This is the same as the built in generation does
  local middleY = math.floor(self.height / 2) + 1;
  local minX = 1 - middleX;
  local minY = 1 - middleY;
  local maxX = self.width - middleX;
  local maxY = self.height - middleY;
  local worldMapTiles = {};
  log("Setting (" .. left_top.x .. "," .. left_top.y .. ")-(" .. right_bottom.x - 1 .. "," .. right_bottom.y - 1 .. ")");
  for y = left_top.y, right_bottom.y - 1 do
    for x = left_top.x, right_bottom.x - 1 do
      if x >= minX and x <= maxX and y >= minY and y <= maxY then
				table.insert(worldMapTiles, {name = self.tiles[y + middleY][x + middleX].tileType.tileName, position = {x, y}});
			else
				table.insert(worldMapTiles, {name = 'out-of-map', position = {x, y}});
			end
    end
  end
  self:getSurface().set_tiles(worldMapTiles);
end

function WorldMap:addSettlement(x, y)
  log("Worldmap:addSettlement")
	self.tiles[y][x].settlement = Settlement:new(x, y, self.tiles[y][x].tileType.tileName)
  EntityData:forEntity(self.tiles[y][x].settlement.worldMapEntity).settlement = self.tiles[y][x].settlement
end

-- Load the map first time the file is loaded
WorldMap:loadWorldMap()
return WorldMap