local Globals = require("Classes.globals")

return function(Settlement)
function Settlement:tryBuildGhost(ghost)
  if not (self.livingQuarters and self.livingQuarters.valid) then return end
  if not (ghost and ghost.valid) then return false end

  local inventory = self.livingQuarters.get_inventory(defines.inventory.chest)
  local recipe = Globals:getEntityRecipe(ghost.ghost_name)
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

function Settlement:tryDeconstructEntity(entity)
  if not (self.livingQuarters and self.livingQuarters.valid) then return false end
  if not (entity and entity.valid) then return false end
  local recipe = Globals:getEntityRecipe(entity.name)
  if not recipe then return false end
  local inventory = self.livingQuarters.get_inventory(defines.inventory.chest)
  local insertedIngredients = {}
  for _, ingredient in pairs(recipe.ingredients) do
    local inserted = inventory.insert{
      name = ingredient.name,
      count = ingredient.amount
    }
    table.insert(insertedIngredients, {
      name = ingredient.name,
      count = inserted
    })
    if inserted ~= ingredient.amount then
      -- Roll back everything inserted so far.
      for _, insertedIngredient in pairs(insertedIngredients) do
        inventory.remove{
          name = insertedIngredient.name,
          count = insertedIngredient.count
        }
      end
      return false
    end
  end
  entity.destroy()
  return true
end

function Settlement:tryDeconstructEntities()
  for i = #self.deconstructionEntities, 1, -1 do
    local entity = self.deconstructionEntities[i]

    if not (entity and entity.valid) then
      table.remove(self.deconstructionEntities, i)

    elseif not entity.to_be_deconstructed() then
      table.remove(self.deconstructionEntities, i)

    elseif self:tryDeconstructEntity(entity) then
      table.remove(self.deconstructionEntities, i)
    end
  end
end

function Settlement:addDeconstructionEntity(entity)
  if entity and entity.valid then
    if not self:tryDeconstructEntity(entity) then
      table.insert(self.deconstructionEntities, entity)
      log("Settlement:addDeconstructionEntity() list length: " .. #self.deconstructionEntities)
    end
  end
end

function Settlement:removeDeconstructionEntity(entity)
  for i, candidate in pairs(self.deconstructionEntities) do
    if candidate == entity then
      table.remove(self.deconstructionEntities, i)
      log("Settlement:removeDeconstructionEntity() list length: " .. #self.deconstructionEntities)
      return
    end
  end
end
end