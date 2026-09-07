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
solarAssembler.minable = nil
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
solarInserter.minable = nil
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
stoneBelt.minable = nil
stoneBelt.next_upgrade = nil
stoneBelt.related_underground_belt = nil
local stoneBeltItem = table.deepcopy(data.raw.item["transport-belt"])
stoneBeltItem.name = "stone-belt"
stoneBeltItem.place_result = "stone-belt"
local stoneBeltRecipe = table.deepcopy(data.raw.recipe["transport-belt"])
stoneBeltRecipe.name = "stone-belt"
stoneBeltRecipe.results = {{ type = "item", name = "stone-belt", amount = 1 }}
stoneBeltRecipe.ingredients = {{ amount = 1, name = "stone", type = "item" }}

local removeRecipes = {
	-- Logistics
	"wooden-chest", "iron-chest", "steel-chest", "storage-tank",
	"transport-belt", "fast-transport-belt", "express-transport-belt", "turbo-transport-belt",
	"underground-belt", "fast-underground-belt", "express-underground-belt", "turbo-underground-belt",
	"splitter", "fast-splitter", "express-splitter", "turbo-splitter",
	"burner-inserter", "inserter", "long-handed-inserter", "fast-inserter", "bulk-inserter", "stack-inserter",
	"small-electric-pole", "medium-electric-pole", "big-electric-pole", "substation", "pipe", "pipe-to-ground", "pump",
	"rail", "rail-ramp", "rail-support", "train-stop", "rail-signal", "rail-chain-signal", "locomotive", "cargo-wagon", "fluid-wagon", "artillery-wagon",
	"car", "tank", "spidertron",
	"logistic-robot", "construction-robot", "active-provider-chest", "passive-provider-chest", "storage-chest", "buffer-chest", "requester-chest", "robobort",
	"lamp", "aritmetic-combinator", "decider-combinator", "selector-combinator", "constant-combinator", "power-switch", "programmable-speaker", "display-panel",
	"stone-brick", "concrete", "hazard-concrete", "refined-concrete", "refined-hazard-concrete", "landfill", "artificial-yumako-soil", "overgrowth-yumako-soil", "artificial-jellynut-soil", "overgrowth-jellynut-soil", "ice-platform", "foundation", "cliff-explosives",
	-- Production
	"repair-pack",
	"boiler", "steam-engine", "solar-panel", "accumulator", "nuclear-reactor", "heat-pipe", "heat-exchanger", "steam-turbine", "fusion-reactor", "fusion-generator",
	"burner-mining-drill", "electric-mining-drill", "big electric-mining-drill", "offshore-pump", "pumpjack",
	"stone-furnace", "steel-furnace", "electric-furnace", "foundry", "recycler",
	"agricultural-tower", "biochamber",
	"assembling-machine-1", "assembling-machine-2", "assembling-machine-3", "oil-refinery", "chemical-plant", "centrifuge", "electromagnetic-plant", "cryogenic-plant", "lab", "biolab",
	"lightning-rod", "lightning-collector", "heating-tower",
	"beacon", "speed-module", "speed-module-2", "speed-module-3", "effectivity-module", "effectivity-module-2", "effectivity-module-3", "productivity-module", "productivity-module-2", "productivity-module-3", "quality-module", "quality-module-2", "quality-module-3",
	-- Intermediate
	"iron-plate", "copper-plate", "steel-plate", "plastic-bar", "sulfur", "battery", "explosives", "carbon",
}
local removeItems = {
	-- Logistics
	"spidertron-remote",
	"red-wire", "green-wire",
	-- Production
	"blueprint", "deconstruction-planner", "upgrade-planner", "blueprint-book",""
	"captive-biter-spawner",
	-- Intermediate
	"solid-fuel",
	"wood", "coal", "stone", "iron-ore", "copper-ore", "uranium-ore", "raw-fish", "ice",

}
for _,recipeName in ipairs(removeRecipes) do
	if data.raw.recipe[recipeName] == nil then
		log("error: recipe " .. recipeName .. " does not exist" )
	else
		if data.raw.recipe[recipeName]["results"] == nil then
			log("error: recipe " .. recipeName .. " has no results")
		else
			if data.raw.recipe[recipeName]["results"][2] ~= nil then
				log("warning: recipe " .. recipeName .. " has more than one result")
			end
			table.insert(removeItems, data.raw.recipe[recipeName]["results"][1].name)
			log("removed recipe " .. recipeName)
			log("added " .. data.raw.recipe[recipeName]["results"][1].name .. " to removeItems")
			data.raw.recipe[recipeName].hidden = true
			data.raw.recipe[recipeName].hidden_in_factoriopedia = true
		end
	end
end

for _, removedItemName in ipairs(removeItems) do
	if data.raw.item[removedItemName] == nil then
		log("error: item " .. removedItemName .. " does not exist")
	else
		log("removed item " .. removedItemName)
		data.raw.item[removedItemName].hidden = true
		data.raw.item[removedItemName].hidden_in_factoriopedia = true
	end
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