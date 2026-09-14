---@enum TileSubType

local TileSubType = {
  MOUNTAIN = "MOUNTAIN",
  LAKE = "LAKE",
  FOREST = "FOREST",
  LAND = "LAND"
}

TileSubType.ordered = {
  TileSubType.MOUNTAIN,
  TileSubType.LAKE,
  TileSubType.FOREST,
  TileSubType.LAND
}
 
return TileSubType
