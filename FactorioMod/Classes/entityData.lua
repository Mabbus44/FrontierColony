---@class EntityData

local EntityData = {
  data = {}
}

function EntityData:forEntity(entity)
	return self:forEntityId(entity.unit_number)
end

function EntityData:forSurface(surface)
	return self:forEntityId(surface.name)
end

function EntityData:forEntityId(entityId)
  if self.data[entityId] == nil then
    self.data[entityId] = {}
  end
  return self.data[entityId]
end

return EntityData