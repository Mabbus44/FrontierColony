---@class Globals
---@field nextFreeSettlementId number
---@field squadTemplates SquadTemplate[]
---@field nextFreeSquadTemplateId number
---@field nextFreeSquadId number

local Globals = {}
local entityRecipes

function Globals:get()
	storage.frontier_colony = storage.frontier_colony or {}
	storage.frontier_colony.globals = storage.frontier_colony.globals or {}

	local globals = storage.frontier_colony.globals
	globals.nextFreeSettlementId = globals.nextFreeSettlementId or 1
	globals.squadTemplates = globals.squadTemplates or {}
	globals.nextFreeSquadTemplateId = globals.nextFreeSquadTemplateId or 1
	globals.nextFreeSquadId = globals.nextFreeSquadId or 1
	return globals
end

local function initEntityRecipeLookupTable()
	local entityRecipes = {}
	for _, recipe in pairs(game.forces.player.recipes) do
    if #recipe.products == 1 then
			local item = prototypes.item[recipe.products[1].name]
			if item and item.place_result then
				entityRecipes[item.place_result.name] = recipe
			end
    end
	end
	log("recipe lookup table:")
	for entityName, recipe in pairs(entityRecipes) do
		log(entityName .. " -> " .. recipe.name)
	end
	return entityRecipes
end

function Globals.getEntityRecipe(entityName)
  if not entityRecipes then
    entityRecipes = initEntityRecipeLookupTable()
  end
  return entityRecipes[entityName]
end

function Globals.getIndex(value, values)
  for index, currentValue in ipairs(values) do
    if currentValue == value then
      return index
    end
  end
  log("Error: could not find value " .. tostring(value) .. " in the provided list.")
end

-- These "ById" functions can be called for any list of objects where the element has a "id" parameter
function Globals.deleteById(list, id)
	for i, item in ipairs(list) do
		if item.id == id then
			table.remove(list, i)
			return
		end
	end
end

function Globals.saveById(list, item)
	for i, currentItem in ipairs(list) do
		if currentItem.id == item.id then
			list[i] = item
			return
		end
	end
	table.insert(list, item)
end

function Globals.getById(list, id)
	for i, item in ipairs(list) do
		if item.id == id then
			return item
		end
	end
	return nil
end

return Globals