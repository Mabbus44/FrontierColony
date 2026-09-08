---@class EntityData

local function getData()
  storage.frontier_colony = storage.frontier_colony or {}
  storage.frontier_colony.entityData = storage.frontier_colony.entityData or {}
  return storage.frontier_colony.entityData
end

local EntityData = {}

function EntityData:forEntity(entity)
	return self:forEntityId(entity.unit_number)
end

function EntityData:forSurface(surface)
	return self:forEntityId(surface.name)
end

function EntityData:forEntityId(entityId)
  local data = getData()
  if data[entityId] == nil then
    data[entityId] = {}
  end
  return data[entityId]
end

return EntityData