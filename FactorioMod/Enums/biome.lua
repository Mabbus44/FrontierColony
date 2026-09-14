---@enum Biome

local Biome = {
  LAVA = "LAVA",
  GRASS = "GRASS",
  ICE = "ICE",
  SWAMP = "SWAMP",
  DESERT = "DESERT"
}

Biome.ordered = {
  Biome.LAVA,
  Biome.GRASS,
  Biome.ICE,
  Biome.SWAMP,
  Biome.DESERT
}

return Biome
