local settlement = table.deepcopy(data.raw["container"]["steel-chest"])

settlement.name = "settlement"

data:extend({
  settlement
})