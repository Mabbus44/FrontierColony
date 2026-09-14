---@enum BiterType
local BiterType = {
  ICE = "ICE",
  EXPLOSIVE = "EXPLOSIVE",
  TOXIC = "TOXIC",
  ARACHNID = "ARACHNID"
}

BiterType.ordered = {
  BiterType.ICE,
  BiterType.EXPLOSIVE,
  BiterType.TOXIC,
  BiterType.ARACHNID
}

return BiterType
