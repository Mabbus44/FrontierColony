---@enum ResourceType
local ResourceType = {
  NONE = "NONE",
  FOOD = "FOOD",
  WOOD = "WOOD",
  STONE = "STONE",
  IRON = "IRON",
  COPPER = "COPPER",
  COAL = "COAL",
  OIL = "OIL",
  URANIUM = "URANIUM"
}

ResourceType.ordered = {
  ResourceType.NONE,
  ResourceType.FOOD,
  ResourceType.WOOD,
  ResourceType.STONE,
  ResourceType.IRON,
  ResourceType.COPPER,
  ResourceType.COAL,
  ResourceType.OIL,
  ResourceType.URANIUM
}

return ResourceType
