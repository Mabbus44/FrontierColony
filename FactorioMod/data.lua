local settlement = table.deepcopy(data.raw["container"]["steel-chest"])
settlement.name = "settlement"

local assembler = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])
assembler.name = "fc-assembler"
assembler.energy_source = { type = "void" }

local inserter = table.deepcopy(data.raw["inserter"]["fast-inserter"])
inserter.name = "fc-inserter"
inserter.energy_source = { type = "void" }

local belt = table.deepcopy(data.raw["transport-belt"]["fast-transport-belt"])
belt.name = "fc-belt"

data:extend({
  settlement,
  assembler,
  inserter,
  belt
})