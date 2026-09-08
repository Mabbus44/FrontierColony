local settlement = table.deepcopy(data.raw["container"]["steel-chest"])
settlement.name = "settlement"
settlement.minable = nil

local fusionReactor = table.deepcopy(data.raw["fusion-reactor"]["fusion-reactor"])
local livingQuarters = table.deepcopy(data.raw["container"]["steel-chest"])
livingQuarters.name = "living-quarters"
livingQuarters.icon = fusionReactor.icon
livingQuarters.icon_size = fusionReactor.icon_size
livingQuarters.minable = nil
livingQuarters.picture = {
  layers = {
    table.deepcopy(fusionReactor.graphics_set.structure.layers[1]),
    table.deepcopy(fusionReactor.graphics_set.structure.layers[2]),
  }
}
livingQuarters.collision_box = fusionReactor.collision_box
livingQuarters.selection_box = fusionReactor.selection_box
livingQuarters.tile_width = fusionReactor.tile_width
livingQuarters.tile_height = fusionReactor.tile_height
livingQuarters.inventory_size = 100

local solarAssembler = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])
solarAssembler.name = "solar-assembler"
solarAssembler.energy_source = { type = "void" }
solarAssembler.minable = { mining_time = 0.1, result = "solar-assembler" }
solarAssembler.next_upgrade = nil
local solarAssemblerItem = table.deepcopy(data.raw.item["assembling-machine-1"])
solarAssemblerItem.name = "solar-assembler"
solarAssemblerItem.place_result = "solar-assembler"
local solarAssemblerRecipe = table.deepcopy(data.raw.recipe["assembling-machine-1"])
solarAssemblerRecipe.name = "solar-assembler"
solarAssemblerRecipe.results = {{ type = "item", name = "solar-assembler", amount = 1 }}
solarAssemblerRecipe.ingredients = {{ amount = 25, name = "stone", type = "item" }}

local solarInserter = table.deepcopy(data.raw["inserter"]["inserter"])
solarInserter.name = "solar-inserter"
solarInserter.energy_source = { type = "void" }
solarInserter.minable = { mining_time = 0.1, result = "solar-inserter" }
solarInserter.next_upgrade = nil
local solarInserterItem = table.deepcopy(data.raw.item["inserter"])
solarInserterItem.name = "solar-inserter"
solarInserterItem.place_result = "solar-inserter"
local solarInserterRecipe = table.deepcopy(data.raw.recipe["inserter"])
solarInserterRecipe.name = "solar-inserter"
solarInserterRecipe.results = {{ type = "item", name = "solar-inserter", amount = 1 }}
solarInserterRecipe.ingredients = {{ amount = 5, name = "stone", type = "item" }}

local stoneBelt = table.deepcopy(data.raw["transport-belt"]["transport-belt"])
stoneBelt.name = "stone-belt"
stoneBelt.minable = { mining_time = 0.1, result = "stone-belt" }
stoneBelt.next_upgrade = nil
stoneBelt.related_underground_belt = nil
local stoneBeltItem = table.deepcopy(data.raw.item["transport-belt"])
stoneBeltItem.name = "stone-belt"
stoneBeltItem.place_result = "stone-belt"
local stoneBeltRecipe = table.deepcopy(data.raw.recipe["transport-belt"])
stoneBeltRecipe.name = "stone-belt"
stoneBeltRecipe.results = {{ type = "item", name = "stone-belt", amount = 1 }}
stoneBeltRecipe.ingredients = {{ amount = 1, name = "stone", type = "item" }}

for categoryName, category in pairs(data.raw) do
	for prototypeName, prototype in pairs(category) do
		if prototype.next_upgrade ~= nil then
			prototype.next_upgrade = nil
		end
	end
end

local hiddenCategories = { "recipe", "item", "rail-planner", "item-with-entity-data", "capsule", "module", "gun", "ammo", "armor" }
for _, category in ipairs(hiddenCategories) do
	for prototypeName, prototype in pairs(data.raw[category]) do
		prototype.hidden = true
		prototype.hidden_in_factoriopedia = true
	end
end

local hiddenPrototypes = {
	{ "repair-tool", "repair-pack" },
	{ "blueprint", "blueprint" },
	{ "blueprint-book", "blueprint-book" },
	{ "deconstruction-item", "deconstruction-planner" },
	{ "upgrade-item", "upgrade-planner" },
	{ "space-platform-starter-pack", "space-platform-starter-pack" }
}
for _, prototype in ipairs(hiddenPrototypes) do
	data.raw[prototype[1]][prototype[2]].hidden = true
	data.raw[prototype[1]][prototype[2]].hidden_in_factoriopedia = true
end

data:extend({
  settlement,
  livingQuarters,
  solarAssembler,
	solarAssemblerItem,
	solarAssemblerRecipe,
  solarInserter,
	solarInserterItem,
	solarInserterRecipe,
  stoneBelt,
  stoneBeltItem,
  stoneBeltRecipe
})