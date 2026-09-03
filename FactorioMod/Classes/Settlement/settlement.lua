---@class Settlement
---@field id number
---@field worldMapEntity LuaEntity
---@field tileName string
---@field width number
---@field height number

local Globals = require("Classes.globals")
local Constants = require("Classes.constants")
local EntityData = require("Classes.entityData")

local Settlement = {}
Settlement.__index = Settlement

function Settlement:new(x, y, tileName)
  log("Settlement:new()")
	local obj = setmetatable({}, self)
  obj.tileName = tileName
	obj.width = 100
	obj.height = 100

  -- Set unique id
	obj.id = Globals.nextFreeSettlementId
	Globals.nextFreeSettlementId = Globals.nextFreeSettlementId + 1
  
	-- Create settlement entity on world map
	obj.worldMapEntity = game.surfaces[Constants.worldMapSurfaceName].create_entity{name = "settlement", position = {x, y}, force = game.forces.player}
  EntityData:forEntity(obj.worldMapEntity).settlement = obj

	-- Create settlement surface
	obj:createSurface()
	
  return obj
end

function Settlement:createSurface()
  log("Settlement:createSurface()")
  local settlementSurface = game.create_surface(Constants.settlementSurfaceNameBase .. tostring(self.id), {
    width = self.width,
    height = self.height,
    default_enable_all_autoplace_controls = false,
    autoplace_controls = {},
    starting_area = "none",
    cliffiness = 0
  })
  EntityData:forSurface(settlementSurface).settlement = self
end

function Settlement:setTiles(left_top, right_bottom)
  local middleX = math.floor(self.width / 2) + 1;
  local middleY = math.floor(self.height / 2) + 1;
  local minX = math.max(1 - middleX, left_top.x);
  local minY = math.max(1 - middleY, left_top.y);
  local maxX = math.min(self.width - middleX, right_bottom.x-1);
  local maxY = math.min(self.height - middleY, right_bottom.y-1);
  if minX > maxX or minY > maxY then
    log("Chunk outside map, skipping tile placement");
    return;
  end;
  local newTiles = {};
  log("Setting (" .. minX .. "," .. minY .. ")-(" .. maxX .. "," .. maxY .. ")");
  for y = minY, maxY do
    for x = minX, maxX do
      table.insert(newTiles, {name = self.tileName, position = {x, y}});
    end
  end
  self:getSurface().set_tiles(newTiles);
end

function Settlement:getSurface()
  return game.surfaces[Constants.settlementSurfaceNameBase .. tostring(self.id)]
end

function Settlement:teleportToSurface(playerId)
  log("Settlement:teleportToSurface()")
	local surface = self:getSurface()
  if surface then
    local player = game.players[playerId]
    player.teleport({0, 0}, surface)
  end
end

function Settlement:clicked(playerId)
  log("Settlement:clicked()")
  self:teleportToSurface(playerId)
end

return Settlement