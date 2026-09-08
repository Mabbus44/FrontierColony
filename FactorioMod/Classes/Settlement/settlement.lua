---@class Settlement
---@field id number
---@field worldMapEntity LuaEntity
---@field livingQuarters LuaEntity
---@field ghosts LuaEntity[]
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
  obj.ghosts = {}

  -- Set unique id
	obj.id = Globals.nextFreeSettlementId
	Globals.nextFreeSettlementId = Globals.nextFreeSettlementId + 1
  
	-- Create settlement entity on world map
	obj.worldMapEntity = game.surfaces[Constants.worldMapSurfaceName].create_entity{name = "settlement", position = {x, y}, force = game.forces.player}
  EntityData:forEntity(obj.worldMapEntity).settlement = obj

	-- Create settlement surface
	local settlementSurface = obj:createSurface()
	obj.livingQuarters = settlementSurface.create_entity{name = "living-quarters", position = {0, 0}, force = game.forces.player}  
  obj.livingQuarters.get_inventory(defines.inventory.chest).insert{ name = "stone", count = 100 }	
  
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
  return settlementSurface
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

function Settlement:teleportToSurface(player)
  log("Settlement:teleportToSurface()")
	local surface = self:getSurface()
  if surface and player and player.valid then
    player.teleport({0, 0}, surface)
  end
end

function Settlement:clicked(playerId)
  log("Settlement:clicked()")
  local player = game.players[playerId]
	player.opened = nil
  self:teleportToSurface(player)
end

function Settlement:tryBuildGhost(ghost)
  if not (self.livingQuarters and self.livingQuarters.valid) then return end
  if not (ghost and ghost.valid) then return false end

  local inventory = self.livingQuarters.get_inventory(defines.inventory.chest)
  local recipe = Globals.entityRecipes[ghost.ghost_name]
  if not recipe then return false end

  for _, ingredient in pairs(recipe.ingredients) do
    if inventory.get_item_count(ingredient.name) < ingredient.amount then
      return false
    end
  end

  local revived = ghost.revive()
  if revived then
    for _, ingredient in pairs(recipe.ingredients) do
      inventory.remove{
        name = ingredient.name,
        count = ingredient.amount
      }
    end
    return true
  end

  return false
end

function Settlement:tryBuildBlueprints()
  -- Iterate backwards since invalid and completed ghosts are removed.
  for i = #self.ghosts, 1, -1 do
    local ghost = self.ghosts[i]
    if not (ghost and ghost.valid) or self:tryBuildGhost(ghost) then
      table.remove(self.ghosts, i)
    end
  end
end

function Settlement:addGhost(ghost)
  if ghost and ghost.valid then
    if not self:tryBuildGhost(ghost) then
      table.insert(self.ghosts, ghost)
      log("Settlement:addGhost() list length: " .. #self.ghosts)
    end
  end
end

function Settlement:removeGhost(ghost)
  for i, candidate in pairs(self.ghosts) do
    if candidate == ghost then
      table.remove(self.ghosts, i)
      log("Settlement:removeGhost() list length: " .. #self.ghosts)  
      return
    end
  end
end

function Settlement:surfaceIsSettlement(surfaceName)
  return surfaceName:sub(1, #Constants.settlementSurfaceNameBase) == Constants.settlementSurfaceNameBase  
end

return Settlement