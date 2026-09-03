---@class EntityData

local EntityData = {
  data = {}
}

function EntityData:forEntity(entity)
  if entity.unit_number ~= nil then
    return self:forEntityId(entity.unit_number)
  else
    return self:forEntityId(entity.name)
  end
end

function EntityData:forEntityId(entityId)
  if self.data[entityId] == nil then
    self.data[entityId] = {}
  end
  return self.data[entityId]
end

return EntityData