---@enum TileType
    -- Terrain types
    --                          32          96      160     224
    --255, 0,   0     lava,     -montain    -lake   -forest -land
    --0,   255, 0     grass,    -montain    -lake   -forest -land
    --0,   0,   255   ice,      -montain    -lake   -forest -land
    --0,   255, 255   swamp,    -montain    -lake   -forest -land
    --255, 255, 0     desert,   -montain    -lake   -forest -land

local TileType = {
    MOUNTAIN = "MOUNTAIN",
    LAKE = "LAKE",
    FOREST = "FOREST",
    LAND = "LAND"
}

return Biome, TileType
