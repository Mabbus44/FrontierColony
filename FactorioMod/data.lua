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

local allowedItems = {
	["stone"] = true,
	["stone-brick"] = true,
	["concrete"] = true,
	["hazard-concrete"] = true,
	["refined-concrete"] = true,
	["refined-hazard-concrete"] = true,
	["landfill"] = true,
	["space-platform-foundation"] = true,
	["foundation"] = true,
	["artificial-yumako-soil"] = true,
	["artificial-jellynut-soil"] = true,
	["overgrowth-yumako-soil"] = true,
	["overgrowth-jellynut-soil"] = true,
	["ice-platform"] = true,
	["metallic-asteroid-chunk"] = true,
	["oxide-asteroid-chunk"] = true,
	["carbonic-asteroid-chunk"] = true,
	["promethium-asteroid-chunk"] = true,
	["copper-wire"] = true,
	["red-wire"] = true,
	["green-wire"] = true,
	["pentapod-egg"] = true,
	["spoilage"] = true,
	["wood"] = true,
	["carbon"] = true,
	["spidertron"] = true,
	["rail-support"] = true,
	["rail-ramp"] = true
}
local allowedRecipes = {
	["stone"] = true
}
local allowedPrototypes = {
	["small-stomper-shell"] = true,
	["medium-stomper-shell"] = true,
	["big-stomper-shell"] = true,
	["spidertron"] = true
}
local allowedPrototypeGroups = {
	["tree"] = true,
	["tile"] = true,
	["asteroid-chunk"] = true,
	["asteroid"] = true,
	["character-corpse"] = true,
	["legacy-straight-rail"] = true,
	["legacy-curved-rail"] = true,
	["rail-remnants"] = true,
	["straight-rail"] = true,
	["half-diagonal-rail"] = true,
	["curved-rail-a"] = true,
	["curved-rail-b"] = true,
	["elevated-straight-rail"] = true,
	["elevated-half-diagonal-rail"] = true,
	["elevated-curved-rail-a"] = true,
	["elevated-curved-rail-b"] = true,
	["car"] = true,
	["locomotive"] = true,
	["cargo-wagon"] = true,
	["fluid-wagon"] = true,
	["artillery-wagon"] = true,
	["rail-support"] = true,
	["rail-ramp"] = true
}
  
-- Remove items
for name, item in pairs(data.raw.item) do
	if not allowedItems[name] then
		data.raw.item[name] = nil
	end
end

-- Remove recipes
for name, recipe in pairs(data.raw.recipe) do
	if not allowedRecipes[name] then
		data.raw.recipe[name] = nil
	end
end

-- Remove entities
for prototypeGroup, prototypes in pairs(data.raw) do
	if not allowedPrototypeGroups[prototypeGroup] then
		for name, prototype in pairs(prototypes) do
				if prototype.minable then
						if not allowedPrototypes[name] then
								data.raw[prototypeGroup][name] = nil
						end
				end
		end
	end
end
data.raw["assembling-machine"]["captive-biter-spawner"] = nil
data.raw["cargo-pod"] = nil
data.raw["rocket-silo-rocket"] = nil
data.raw["rocket-silo-rocket-shadow"] = nil
data.raw["unit-spawner"]["biter-spawner"]["captured_spawner_entity"] = nil
data.raw["unit-spawner"]["spitter-spawner"]["captured_spawner_entity"] = nil

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