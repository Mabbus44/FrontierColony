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

function WorldMap:createSurface()
  local WorldMapSurfaceSettings = {
    width = WorldMap.width,
    height = WorldMap.height,
		default_enable_all_autoplace_controls = false,
		autoplace_controls = {}, 
		autoplace_settings = {
				["tile"] = {
						settings = {
								["out-of-map"] = { frequency = "normal", size = "normal", richness = "normal" }
						}
				}
		},
		starting_area = "none",
		cliffiness = 0
  }
  log("Surfaces before");
  for name, surface in pairs(game.surfaces) do
    log("Surface: " .. name);
  end
  game.create_surface(Constants.worldMapSurfaceName, WorldMapSurfaceSettings);
	log("Surfaces after");
	for name, surface in pairs(game.surfaces) do
		log("Surface: " .. name);
	end
end

function WorldMap:getSurface()
  return game.surfaces[Constants.worldMapSurfaceName]
end

function WorldMap:setTiles(left_top, right_bottom)
  local middleX = math.floor(self.width / 2) + 1;	-- This will generate from -a to +a if odd, and -a to +(a-1) if even. This is the same as the built in generation does
  local middleY = math.floor(self.height / 2) + 1;
  local minX = math.max(1 - middleX, left_top.x);
  local minY = math.max(1 - middleY, left_top.y);
  local maxX = math.min(self.width - middleX, right_bottom.x-1);
  local maxY = math.min(self.height - middleY, right_bottom.y-1);
  if minX > maxX or minY > maxY then
    log("Chunk outside map, skipping tile placement");
    return;
  end;
  local worldMapTiles = {};
  log("Setting (" .. minX .. "," .. minY .. ")-(" .. maxX .. "," .. maxY .. ")");
  for y = minY, maxY do
    for x = minX, maxX do
      table.insert(worldMapTiles, {name = self.tiles[y + middleY][x + middleX].tileType.tileName, position = {x, y}});
    end
  end
  self:getSurface().set_tiles(worldMapTiles);
end

function WorldMap:addSettlement(x, y)
  self.tiles[y][x].settlement = Settlement:new(x, y, self.tiles[y][x].tileType.tileName)
  EntityData:forEntity(self.tiles[y][x].settlement.worldMapEntity).settlement = self.tiles[y][x].settlement
end

-- Load the map first time the file is loaded
WorldMap:loadWorldMap()
return WorldMap