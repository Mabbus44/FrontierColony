---@class Globals
---@field nextFreeSettlementId number
---@field squadTemplates SquadTemplate[]

local Globals = {}
local entityRecipes

function Globals:get()
	storage.frontier_colony = storage.frontier_colony or {}
	storage.frontier_colony.globals = storage.frontier_colony.globals or {}

	local globals = storage.frontier_colony.globals
	globals.nextFreeSettlementId = globals.nextFreeSettlementId or 1
	globals.squadTemplates = globals.squadTemplates or {}
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

function Globals:getEntityRecipe(entityName)
  if not entityRecipes then
    entityRecipes = initEntityRecipeLookupTable()
  end
  return entityRecipes[entityName]
end

return Globals