---@enum TileType

-- Terrain types
--                          32          96      160     224
--255, 0,   0     lava,     -montain    -lake   -forest -land
--0,   255, 0     grass,    -montain    -lake   -forest -land
--0,   0,   255   ice,      -montain    -lake   -forest -land
--0,   255, 255   swamp,    -montain    -lake   -forest -land
--255, 255, 0     desert,   -montain    -lake   -forest -land

local Biome = require("Enums.biome")
local TileSubType = require("Enums.tileSubType")

local TileType = {
  01 = { biome = Biome.LAVA, type = TileSubType.MOUNTAIN,   tileName = "volcanic-soil-dark",        entityName = ""},
  02 = { biome = Biome.LAVA, type = TileSubType.LAKE,       tileName = "lava",                      entityName = ""},
  03 = { biome = Biome.LAVA, type = TileSubType.FOREST,     tileName = "volcanic-soil-light",       entityName = ""},
  04 = { biome = Biome.LAVA, type = TileSubType.LAND,       tileName = "volcanic-smooth-stone",     entityName = ""},
  11 = { biome = Biome.GRASS, type = TileSubType.MOUNTAIN,  tileName = "grass-1",                   entityName = ""},
  12 = { biome = Biome.GRASS, type = TileSubType.LAKE,      tileName = "water",                     entityName = ""},
  13 = { biome = Biome.GRASS, type = TileSubType.FOREST,    tileName = "grass-3",                   entityName = ""},
  14 = { biome = Biome.GRASS, type = TileSubType.LAND,      tileName = "grass-4",                   entityName = ""},
  21 = { biome = Biome.ICE, type = TileSubType.MOUNTAIN,    tileName = "snow-lumpy",                entityName = ""},
  22 = { biome = Biome.ICE, type = TileSubType.LAKE,        tileName = "ice-rough",                 entityName = ""},
  23 = { biome = Biome.ICE, type = TileSubType.FOREST,      tileName = "snow-patchy",               entityName = ""},
  24 = { biome = Biome.ICE, type = TileSubType.LAND,        tileName = "snow-flat",                 entityName = ""},
  31 = { biome = Biome.SWAMP, type = TileSubType.MOUNTAIN,  tileName = "wetland-light-dead-skin",   entityName = ""},
  32 = { biome = Biome.SWAMP, type = TileSubType.LAKE,      tileName = "water-mud",                 entityName = ""},
  33 = { biome = Biome.SWAMP, type = TileSubType.FOREST,    tileName = "wetland-blue-slime",        entityName = ""},
  34 = { biome = Biome.SWAMP, type = TileSubType.LAND,      tileName = "wetland-light-green-slime", entityName = ""},
  41 = { biome = Biome.DESERT, type = TileSubType.MOUNTAIN, tileName = "dust-patchy",               entityName = ""},
  42 = { biome = Biome.DESERT, type = TileSubType.LAKE,     tileName = "water",                     entityName = ""},
  43 = { biome = Biome.DESERT, type = TileSubType.FOREST,   tileName = "red-desert-0",              entityName = ""},
  44 = { biome = Biome.DESERT, type = TileSubType.LAND,     tileName = "sand-1",                    entityName = ""},
}

return TileType